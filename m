Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9704D27C6E
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 14:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfEWMHu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 08:07:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38539 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWMHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 08:07:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so8911668edl.5
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2019 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwpqBvUvQ7B6ZiyzTKltDeeKnuWuXceO5lficTnBOYw=;
        b=JmfgAnEOcsfLJUDuWAJnzfm5g80apqdTiRbyy2RDNEWay6r84DLl3BsrbRgKbaUjl1
         VwMQTxlAuecyrSlsj4nuL3WrVuiHaRzHoiOYZv/jR4z7QANtkad5Q3fNJIg/06eIt7KL
         GLpgpIO8zXBAU63bAEYHV+w8ZzrejiCoPwNmih2CsXm5IImlGGiTtOs3tCw1FqcRnjPR
         yrp4T6wN3xYf3JAXquagom6oBrmN/ZusXx59aoFhD1h9/wYD2z1uxI+81R5vWNlHwm1J
         MIWl/NcJxlPOxiiJc3i/0OzUbtAazycqvB3dwOfPCgXKpWJWyDvXKDoSfVg2PjmEqMt+
         1R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwpqBvUvQ7B6ZiyzTKltDeeKnuWuXceO5lficTnBOYw=;
        b=GIEDKdvHFqrQpUxppFGtNXpU9FQwSyoOS/r2VipBb19RT1w3I2tzzvWWqkfgeGt6lf
         AqlsRPH7LlR+6OjThk0SufUhk/Jf/xDFBEGTa+ri1Hgt/lIX6Uz3mKblPPd0A7S3YM93
         tbYTyGHB4RP1FdNyiQJjGfxezmEsETsuYUbdoRO2HO/G+RPrp3kjQCwHdaQpIf7/W1T3
         n684AQV9i3lEQY+iwWfIIkY/rjdAU1CWG9kKL+YzfzHDdB/yAIIUas3K+3RwMTOhbudA
         rzj1zekifAVVUNhmTHlK74boyP8ZC0lagHRfBFTgGXO4Y2Cm5fdKvqaD33Tc6VreMfhW
         eRMw==
X-Gm-Message-State: APjAAAVRbx92UgvmvzHhq5yQqBiQiPE7zhPuKyjo3fJW9SjQsfBH3Bzf
        +vMKFsmDNEnpkTRZvh3RIVrSHw==
X-Google-Smtp-Source: APXvYqwbvr5Bt8IStL4p9bP/5AI+y+unBkssZm7LM4G8l2RmaGpWYzPXDqDHurnxlmkURV5pZ6NPTg==
X-Received: by 2002:a50:a4f7:: with SMTP id x52mr96800051edb.86.1558613268083;
        Thu, 23 May 2019 05:07:48 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywuohpvdjfehzo.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b379:ebaf:d35f:7d94])
        by smtp.gmail.com with ESMTPSA id x49sm7928408edm.25.2019.05.23.05.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:07:47 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio: temperature: mlx90632 Relax the compatibility check
Date:   Thu, 23 May 2019 14:07:22 +0200
Message-Id: <20190523120722.25848-1-cmo@melexis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Register EE_VERSION contains mixture of calibration information and DSP
version. So far, because calibrations were definite, the driver
compatibility depended on whole contents, but in the newer production
process the calibration part changes. Because of that, value in EE_VERSION
will be changed and to avoid that calibration value is same as DSP version
the MSB in calibration part was fixed to 1.
That means existing calibrations (medical and consumer) will now have
hex values (bits 8 to 15) of 83 and 84 respectively. Driver compatibility
should be based only on DSP version part of the EE_VERSION (bits 0 to 7)
register.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 2243e8057ffc..2d54d9cac61d 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -81,6 +81,8 @@
 /* Magic constants */
 #define MLX90632_ID_MEDICAL	0x0105 /* EEPROM DSPv5 Medical device id */
 #define MLX90632_ID_CONSUMER	0x0205 /* EEPROM DSPv5 Consumer device id */
+#define MLX90632_DSP_VERSION	5 /* DSP version */
+#define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
 #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
 #define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
 #define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
@@ -666,10 +668,13 @@ static int mlx90632_probe(struct i2c_client *client,
 	} else if (read == MLX90632_ID_CONSUMER) {
 		dev_dbg(&client->dev,
 			"Detected Consumer EEPROM calibration %x\n", read);
+	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
+		dev_dbg(&client->dev,
+			"Detected Unknown EEPROM calibration %x\n", read);
 	} else {
 		dev_err(&client->dev,
-			"Wrong DSP version %x (expected %x or %x)\n",
-			read, MLX90632_DSPv5);
+			"Wrong DSP version %x (expected %x)\n",
+			read, MLX90632_DSP_VERSION);
 		return -EPROTONOSUPPORT;
 	}
 
-- 
2.20.1

