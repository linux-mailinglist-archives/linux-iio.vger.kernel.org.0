Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC46B5AF1
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCKLRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCKLQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 06:16:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32CB7D92
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y4so1273808edo.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ioe8ZckxjU6ZpVzZshacUS/R7WK/EtFfWhV8AADv5Wg=;
        b=Qv3harmSc0C7cxjkUe4JkVM0K/zqBD/g5+YAM2euRlrw8xX9TtFYm1YF4TxtMuZUkS
         KddiDQs4AxZ4oNSKk/hCwv/2HPLrXqTeYIHKxTpmLs3P0VxQQ2KBSkBvJndHyrn2cbPv
         Yq/Bw/XCnaq41hxusKGD2fSxsTGLVFjW4B7ePAXQwuYIRMRjao2jwTMuMNeLXqmul8ZQ
         HcNALQGblX05u6BQOZhavjAJaRdg16ZsoPlDFz/Q1rxBieqBFQQCmkqscDVJa9xSOEoE
         XmZ84y/i2Vgi0jpcgFp86RQtE4uvcAmfwRng1/zFlGATzAiWuIDmYztx8wsbEHidWywD
         wnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ioe8ZckxjU6ZpVzZshacUS/R7WK/EtFfWhV8AADv5Wg=;
        b=iqrj5V6SywvXYY+L06a3yyzKAaBuWu0lBCteqtgy1jvQ90pZxIKEy7XuMylbWE3LYj
         mSdJ7TD9JG4+VM2gS57eZ+hKypX1MdANnyKqQZmor/D0tvP68W/rq90o+B/CZqfrBpZH
         YpXjDr5TrJMLxGUrswu/EnNbYApc+cqpml7J3vB9AL0iSScssdUk77MMor26O+DtzWLJ
         q8Augq11fQ1m0hX8NNhITJq4JJbOMDa67kv/j6TB6VvVdPoqL4LFuSQjPz6Fxx7zJ2DP
         ztgrcIZYtip+35YuYwp46yeruPLPK6ui7KqxOs8pO5jBDrWeZYcx2Mq4h/4O7LXu+WUr
         9KTg==
X-Gm-Message-State: AO0yUKV3E3+DmcqL1KEEaPJrxFTNGzxhDFjDMByGhK/0DYGgSrGkleuW
        ap8TVjdtg3dHJMfQBSNz0VadtA==
X-Google-Smtp-Source: AK7set9KXK3WwLIZBF8yLLjllA+Ij/w+p8024nzo/7ze3PwqULG7UodI6iA2HWhh7v2qxVqVtuujPg==
X-Received: by 2002:aa7:d60b:0:b0:4c1:a7fa:99dd with SMTP id c11-20020aa7d60b000000b004c1a7fa99ddmr22806738edr.38.1678533303506;
        Sat, 11 Mar 2023 03:15:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] iio: light: max44009: add missing OF device matching
Date:   Sat, 11 Mar 2023 12:14:56 +0100
Message-Id: <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver currently matches only via i2c_device_id, but also has
of_device_id table:

  drivers/iio/light/max44009.c:545:34: error: ‘max44009_of_match’ defined but not used [-Werror=unused-const-variable=]

Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/light/max44009.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 3dadace09fe2..274e0b679ca2 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -527,6 +527,12 @@ static int max44009_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] __maybe_unused = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
 static const struct i2c_device_id max44009_id[] = {
 	{ "max44009", 0 },
 	{ }
@@ -536,18 +542,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
 static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
+		.of_match_table = of_match_ptr(max44009_of_match),
 	},
 	.probe_new = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
 
-static const struct of_device_id max44009_of_match[] = {
-	{ .compatible = "maxim,max44009" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max44009_of_match);
-
 MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
-- 
2.34.1

