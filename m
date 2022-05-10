Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB25210C9
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiEJJ2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiEJJ2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 05:28:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9379927E688
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2022 02:24:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so14190805pga.0
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2022 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssNs7z392o+zozv5+tUCfSoc6GobUrIGXCyICxsJ6jI=;
        b=ejIjF24Us1NcVOI6EDa1B+3U1RBw2bBcFXgdvtM4c9fFCyw1FSR/wLxMVHDP9y42qK
         xwsLeLP8PE2sXIxpeOZ99jhCbDYj2HvldvBJM3Q2b2MuTLPf8IxULe4AGPLrBn0VZH00
         W7tDhhK0466LNtH4fGSu6YtoW74maqo4fVrV/tfqHSKDbLP23D5MFibmU+gNAcAHMweu
         srrwa/7oah/Crt7SEmo/9KLAjwmor8f2em2bInAz04wuzrZSmMVmJxmWFp0gfR6wy6sQ
         oTYKyanLKVZHRAZ67TGE75uQYfBXq9qbLsmifJeOn3Lg8GrXy38Et4nyxva1hbQD7SfH
         BeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssNs7z392o+zozv5+tUCfSoc6GobUrIGXCyICxsJ6jI=;
        b=AIIQpdseH5syqw9KGrdBj00NUNQ+TMlZizpvtQSh09ykgBQyDVWTHeo4bHr3UsWIUq
         xKUlG0c+LeXn1P+3mPqkE4+5H5u9qqAhv0LtvGmN9fN0sJP3fp2Q9zgKql+EvC/Sxenf
         qAO6dmMlKu9bUwevnTY7+Z7qBHYk6pIixuDnv0CbZSrS1g4YZOpEVvWQbZX2386WgbFK
         WBNAYvk/HVogcIJHXhlknH2UltW3lTHt0qMu/+LhvXuvUYlnxEbsqKz1ABO+xYuWWmB/
         xng2fbeHU6nho5EzlLqyhGUfc/Nj01A65Z7JDIZWJB4OvBrbGxroGBWPtDL+M6S4Qfpk
         qq2g==
X-Gm-Message-State: AOAM5303+VZ0nzVcmhuvIwm1aS5itDpqrXHPT4Kq/yiumzXprRddb7oy
        ag7/OtmYMqLYR3RHkDft9w==
X-Google-Smtp-Source: ABdhPJzIquJtbz8Qsuv0zvyzuYYCRb4KDhXa+JaCdLi17k90wQPFmWDrzLA+Y0NHcolKLYZAJUkNDQ==
X-Received: by 2002:a05:6a00:1ad1:b0:50d:f07a:3eb8 with SMTP id f17-20020a056a001ad100b0050df07a3eb8mr19623599pfv.25.1652174684157;
        Tue, 10 May 2022 02:24:44 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902c2c200b0015ec71f2d7dsm1460046pla.239.2022.05.10.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:24:43 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()
Date:   Tue, 10 May 2022 17:24:31 +0800
Message-Id: <20220510092431.1711284-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver should disable regulators when fails at regmap_update_bits().

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 4f19dc7ffe57..5908a96ca8af 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -875,6 +875,7 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
 	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
 				 MPU3050_PWR_MGM_SLEEP, 0);
 	if (ret) {
+		regulator_bulk_disable(ARRAY_SIZE(mpu3050->regs), mpu3050->regs);
 		dev_err(mpu3050->dev, "error setting power mode\n");
 		return ret;
 	}
-- 
2.25.1

