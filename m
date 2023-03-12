Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBCE6B6787
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCLPeh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCLPeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 11:34:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0E6EA9
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 08:34:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd5so5376796edb.7
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678635274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kvgcMUGd07Xd3eyILFDk+DeCEWHO2H7A73K4YH9RZs=;
        b=sckQnzxqcVD2P6n4wKlXn+PAO+hZd6wQwdAXljCJPORmWzShV8Qd5/kZDRX1renVoL
         fnBpY7NEDz/8oI5+i4ueiTdw1ognJLr9nbZt+uEKQb5x+pW6nuNjLiYE3KT0DgH4x4cU
         vxeZ6pzIiEtUZE0VpBj75JnCEiEhuDDZSMEQ4HRU9cY126iixAzAyPG5l+Dg3traNquP
         0o7gY3znMx2YHGO6VTIxRSPnj6p+wYhXbVMHbiXlM4aNjbW2OJwYd/kqXSNWIOz23BEf
         JyS9th1vnVGmxr/W6A1YNu+S3EsKc/KjNRxlGGU65YaIo7p1lk4K382W2V6eV1bAvXAf
         AvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678635274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kvgcMUGd07Xd3eyILFDk+DeCEWHO2H7A73K4YH9RZs=;
        b=zv0PHKxqM0vNdbmfulA7nzJuzED6E5KqxDzOUcUZMaNdqDGDeYt57X0PEAmt6RjHna
         l/oSDxdOY32T+Cv2D4WmQYr+yN7Y3pZrT1Ffrqasu9GBrPuQw2uVn8Q0OJhYuGp4WSnV
         z/t+QsWOXkGcA821yb+4QZyLrstiQJOg58MluTjg59jwT+TSjhtG+GVudguqH8lqqquj
         wzn/pMXFmEZ3U458MRrOTwfV8ibxkvtYgV0y98kUXz0L/c6Ko5MK12Va/7O91GyLDcTu
         39+I5qlEoSEkx4GoXMs4jXqH+Kk/EhWgtDJVJKCQxFQ2MwIL1Xr3EUC81hlDpxlTaeYq
         zEzA==
X-Gm-Message-State: AO0yUKUluUY79I8mZaVlRWRW3kO21Wr57TWnq1LknA+LnoS1IRkuQgUQ
        dMAsdxWmmQBkvsgWPqpphr3idg==
X-Google-Smtp-Source: AK7set+LW7wkF4ML14NRWahSG6NXgm3FnETJtwxNWw/Eb52r2gCC8Ln8bspgvhbKuB5L4mMzSPF+5Q==
X-Received: by 2002:a17:907:94ce:b0:907:183f:328a with SMTP id dn14-20020a17090794ce00b00907183f328amr39131550ejc.65.1678635273802;
        Sun, 12 Mar 2023 08:34:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906668200b008e0bb004976sm2312723ejo.134.2023.03.12.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 08:34:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] iio: proximity: sx9500: Reference ACPI and OF ID data
Date:   Sun, 12 Mar 2023 16:34:29 +0100
Message-Id: <20230312153429.371702-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
References: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Always reference acpi_device_id and of_device_id tables, as they is
little benefit of conditional compiling and OF table could be used also
for ACPI matching via PRP0001.  This fixes warning:

  drivers/iio/proximity/sx9500.c:1039:34: error: ‘sx9500_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop of_match_ptr and ACPI_PTR
---
 drivers/iio/proximity/sx9500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 8794e75e5bf9..9b2cfcade6a4 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1051,8 +1051,8 @@ MODULE_DEVICE_TABLE(i2c, sx9500_id);
 static struct i2c_driver sx9500_driver = {
 	.driver = {
 		.name	= SX9500_DRIVER_NAME,
-		.acpi_match_table = ACPI_PTR(sx9500_acpi_match),
-		.of_match_table = of_match_ptr(sx9500_of_match),
+		.acpi_match_table = sx9500_acpi_match,
+		.of_match_table = sx9500_of_match,
 		.pm = pm_sleep_ptr(&sx9500_pm_ops),
 	},
 	.probe_new	= sx9500_probe,
-- 
2.34.1

