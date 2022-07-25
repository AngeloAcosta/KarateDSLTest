package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {

    static Faker faker = new Faker();

    public static String getRandomEmail() {

        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@test.com";
        return email;
    }

    public static String getRandomUsername() {
        String username = faker.name().username();
        return username;
    }
    
}
