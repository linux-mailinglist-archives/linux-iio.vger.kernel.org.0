Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175C623F8E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Nov 2022 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKJKNH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Nov 2022 05:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKJKNG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2022 05:13:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49A1098
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 02:13:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3963261wmb.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vixtechnology.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74dqQiWyLQjEOzWoO3Lrynyy+auSFuDxVLH1zUULTMU=;
        b=T8GSEQH6ZHbWd8QVqxqpQ9ZUWHItXnpymEf1Jnd82S9OK467+z7t4NXF54DstpL3XI
         IxrLCrxuIVO1Q2MKKEcBmPcC63l+Mn9G7O6+ka6M/gZIdtIrx9nV2bquketNx/5NC17R
         rypjBAI6UrignKil62TaixvnOCsUerzq3FoFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74dqQiWyLQjEOzWoO3Lrynyy+auSFuDxVLH1zUULTMU=;
        b=SVY+zN67muSC9hfKjClv38AGJ3Pn5gRzL31Gd0uWhxvLlWc6O9OwmR8g/T5yu82aqK
         DhLJF0mDRBAtGhp7/0ZnrzHnGvItA8Vn0P0RA1vVrDF78b+q4juXEwhNuH6roz6o8ChV
         ItcHgnszXXLptJL2vRgVA1Ztagyodh0UTF1P62Qw1lRov1TR+/hJWHrNjuR8gyXwIsI5
         VAxPIKMyzI7StEmbPKBWvKZ1ggrTgbd60zWjWPh3G3J7IyxGRapP887psa7zFcVrk1ZN
         bCXaCkjMSaDWZDHpxqTGeSrp6Q04L1MRNMTyAgyvYzfxqQrV3onM7/XAQ2kfBxdI0P4T
         6wzw==
X-Gm-Message-State: ACrzQf3h+j/zWuntF/xAwI498pOGY0HJpI0TNweuOKI2Zw7YYZXE1nTQ
        NF8iEh0JXyZnO7/o98FdaO7ZOpEugld9TV7PMEYlFgm+D0UJxR7hwM/B99URHEqJl2Gpiv0W/5u
        /t4NFMwGOwNuL
X-Google-Smtp-Source: AMsMyM4ZJ8wKE8SSgPV1NSa71XMzLhL8b22sywS/8GyeAeVf8ahRtnHSDvVBPbqHUlBYKuzGlOr6Ig==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id bg2-20020a05600c3c8200b003b560a6c80fmr43691567wmb.199.1668075180017;
        Thu, 10 Nov 2022 02:13:00 -0800 (PST)
Received: from subhajit-ThinkPad-Yoga-370.vix.local ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id f17-20020a056000129100b002368a6deaf8sm15574055wrx.57.2022.11.10.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:12:59 -0800 (PST)
From:   Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
To:     matt.ranostay@konsulko.com, jic23@kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
Subject: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
Date:   Thu, 10 Nov 2022 18:12:41 +0800
Message-Id: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is only one interrupt enable option for both ALS low and high
thresholds, and one for both Proximity low and high thresholds.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
---
 drivers/iio/light/apds9960.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 4141c0fa7bc4..df9ccbcf0ffe 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -223,14 +223,16 @@ static const struct iio_event_spec apds9960_pxs_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	},
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 	},
 };
 
@@ -238,14 +240,16 @@ static const struct iio_event_spec apds9960_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	},
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 	},
 };
 
-- 
2.34.1


-- 
This email is confidential. If you have received this email in error please 
notify us immediately by return email and delete this email and any 
attachments. Vix accepts no liability for any damage caused by this email 
or any attachments due to viruses, interference, interception, corruption 
or unauthorised access.
