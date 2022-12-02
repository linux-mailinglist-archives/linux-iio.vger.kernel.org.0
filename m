Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C76641087
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 23:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiLBWXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 17:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLBWX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 17:23:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC8DF32
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 14:23:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a16so8183255edb.9
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2022 14:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KACC2wb4YSXVmXT9nu2/vCZI4XSAmso5RQgBjgls7w=;
        b=D+0zSnsIkMCL9J4sPx9wuQmglhGUIP4IITACCEVdKytq+js065y276zeOZStBGOSKg
         4ILn2NwbdYLQ0hAja89nu3nylujBZwONtY4zckTi6fgHdakuWvf4Shk2wH8Rwsh82GBp
         ved6O352gRusEEAV34nYpHLi5LKOZVIiiPB2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KACC2wb4YSXVmXT9nu2/vCZI4XSAmso5RQgBjgls7w=;
        b=I/agywh5V24bMHMAVmROeh5ryBGS5+dZjleawdwdqtzXdy8yCNmI1rk7qi9/CLk6DM
         sz5NOr2XmCiqK2fsXJdl/HKo6FTDeKyvV19bwZg7KHnobMhowve5ddIPPERi2pNeqCB1
         kPSTKDK/+oWoI4IZDf+rGaPrmqu5UHFMUkuaH0Czrx2rj8t9UYFpOvzvGN6iSYQL/Wrf
         C9M59D+c+3tqrbFvKBDozZN3eBMyFDbuv3ZKCM0fdq3Mnpbrgn8Cfow+RuwJY+rFIYZ1
         8KOOeXXIQUletly0dfPse0xkJlO/UkKRhdwA/gBcXQ/e18/4b1cK710H3OT1e2Z/IFqN
         vL8g==
X-Gm-Message-State: ANoB5pnn0wuYphYyKjqGLQZ6RnJILIRxoBRBA8ubBDUWsaW2MRKuTpsc
        gCaytSHSfBFwHJHOCoWDDNJ3X6cuslRHT4jDDcTaoQ==
X-Google-Smtp-Source: AA0mqf7iIL4FAWs3J32GY6U2hxRzkQn7sF/G4BpJDrUZXSm+Eclepdm1ujIseoKj1wesyH59qXm7Kg==
X-Received: by 2002:a05:6402:4512:b0:461:4c59:12d6 with SMTP id ez18-20020a056402451200b004614c5912d6mr66054292edb.250.1670019807226;
        Fri, 02 Dec 2022 14:23:27 -0800 (PST)
Received: from localhost.localdomain (b9c17ea8.host.njalla.net. [185.193.126.168])
        by smtp.gmail.com with ESMTPSA id e23-20020a1709062c1700b007305d408b3dsm3458613ejh.78.2022.12.02.14.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:23:26 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-ezo-sensor: refactor IIO_CHAN_INFO_SCALE checks
Date:   Fri,  2 Dec 2022 14:23:05 -0800
Message-Id: <20221202222305.8828-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Additional modifiers in IIO_CHAN_INFO_SCALE check will mostly have a ppm
unit and the switch statement is more confusing, and adds unneeded code.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 307c3488f4bd..5fae1c4087ee 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -165,17 +165,19 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		/* IIO_CONCENTRATION modifiers */
-		switch (chan->channel2) {
-		case IIO_MOD_CO2:
-			*val = 0;
-			*val2 = 100; /* 0.0001 */
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_MOD_O2:
+		if (chan->channel2 == IIO_NO_MOD)
+			return -EINVAL;
+
+		// IIO_CONCENTRATION modifier for percent
+		if (chan->channel2 == IIO_MOD_O2) {
 			*val = 100;
 			return IIO_VAL_INT;
 		}
-		return -EINVAL;
+
+		// IIO_CONCENTRATION modifier for PPM - 0.0001
+		*val = 0;
+		*val2 = 100;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return 0;
-- 
2.30.2

