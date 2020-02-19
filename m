Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB25164C3F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSRkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 12:40:37 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34357 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSRkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 12:40:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so828142qtq.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2020 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmB6PI8cZhVKQcnmKrjtjB13j2yxSKrWna0Hj4xx+Zk=;
        b=R9qIjZVsw0h1Ul4E20Rju+jTTK67CeTB+PtQlMnTi5BLsoKvXljFlK8FbOB6Fqjs7t
         E4ztyX94ilM9/DamueX2yFxWQ/x+ZoR/VByHBSqU0tFtTcfDXTtXdOQWR5Y/qnGVlTo5
         /Chag0UH2xMT7uPr5Kh1kRaC2KfOvjWoNt/2OOa/CXogPGscaZ0RPky8m873QrGiQoae
         iQtaWVrmh5djdxFqoXPHz+/W0DzZBgCwaJj/1jk5YbBvglVm4vQl14bMBBjgXUkwF3Za
         28BHlu6atauLSEp5NQJAnvH2u9BmuTt8ekEqHwJUKXCUYeam25bzRLCZMyXUwfCG0rYM
         wq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmB6PI8cZhVKQcnmKrjtjB13j2yxSKrWna0Hj4xx+Zk=;
        b=OD+6zZkv4VoDbndQTMXaa9fRoJZ4HHs+UJ6WsNob4Lpnm9SR7GTtt5rPzlPzdyLG8G
         LsCaaKvp1fasThhjO5BQ2RXmsQspIRoM8fDR/YjoK9Bcc0dHKtwPG3gmpKPQaVtjypfp
         /WHDX3WrtuTtBX4+igOek7+Hnv839sDAemeB8XTxjn+E7WpgORkeuRXFf4rumfVZW5lq
         t3yeuXV7w9rNZOnhSWOCUFh1kbYrn8jQBnI5a5btGp6etdQwm152Y8d9rA6ncnW6rNM8
         dIKk/u3j7fWJKA3Q86wRfervMfIt53P1aEVNwhlOFQEGP/3auw2rEr9WXu4cEuD6SHtk
         u08w==
X-Gm-Message-State: APjAAAWAV/+7AIMGjyD6rxiYwKjWBYQRiyRnjq9xqjqYnd9rAcqII0FI
        HvB3Lzr14nJJinzRzpMte4M4H1OHmSn5Tw==
X-Google-Smtp-Source: APXvYqySQvFz32rKMUFK1pLTqEFWjsDHE7ffgLh8brqI6bNEZvlilE8yotzVMi+8Kj4FNx6mJYA/rw==
X-Received: by 2002:ac8:405a:: with SMTP id j26mr22808040qtl.88.1582134033685;
        Wed, 19 Feb 2020 09:40:33 -0800 (PST)
Received: from mbedesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id b35sm346518qtc.9.2020.02.19.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:40:33 -0800 (PST)
From:   =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Simon Goyette <simon.goyette@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2] iio: si1133: read 24-bit signed integer for measurement
Date:   Wed, 19 Feb 2020 12:40:08 -0500
Message-Id: <20200219174008.21429-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chip is configured in 24 bit mode. The values read from
it must always be treated as is. This fixes the issue by
replacing the previous 16 bits value by a 24 bits buffer.

This changes affects the value output by previous version of
the driver, since the least significant byte was missing.
The upper half of 16 bit values previously output are now
the upper half of a 24 bit value.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")

Reported-by: Simon Goyette <simon.goyette@gmail.com>
Co-authored-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
Changes in v2:
	* Add missing `Fixes` tag
	* Add Reported-by
	* Add missing signed-off-by from co-author.

drivers/iio/light/si1133.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 777b1a0848c9..509af982e185 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -102,6 +102,9 @@
 #define SI1133_INPUT_FRACTION_LOW	15
 #define SI1133_LUX_OUTPUT_FRACTION	12
 #define SI1133_LUX_BUFFER_SIZE		9
+#define SI1133_MEASURE_BUFFER_SIZE	3
+
+#define SI1133_SIGN_BIT_INDEX 23
 
 static const int si1133_scale_available[] = {
 	1, 2, 4, 8, 16, 32, 64, 128};
@@ -234,13 +237,13 @@ static const struct si1133_lux_coeff lux_coeff = {
 	}
 };
 
-static int si1133_calculate_polynomial_inner(u32 input, u8 fraction, u16 mag,
+static int si1133_calculate_polynomial_inner(s32 input, u8 fraction, u16 mag,
 					     s8 shift)
 {
 	return ((input << fraction) / mag) << shift;
 }
 
-static int si1133_calculate_output(u32 x, u32 y, u8 x_order, u8 y_order,
+static int si1133_calculate_output(s32 x, s32 y, u8 x_order, u8 y_order,
 				   u8 input_fraction, s8 sign,
 				   const struct si1133_coeff *coeffs)
 {
@@ -276,7 +279,7 @@ static int si1133_calculate_output(u32 x, u32 y, u8 x_order, u8 y_order,
  * The algorithm is from:
  * https://siliconlabs.github.io/Gecko_SDK_Doc/efm32zg/html/si1133_8c_source.html#l00716
  */
-static int si1133_calc_polynomial(u32 x, u32 y, u8 input_fraction, u8 num_coeff,
+static int si1133_calc_polynomial(s32 x, s32 y, u8 input_fraction, u8 num_coeff,
 				  const struct si1133_coeff *coeffs)
 {
 	u8 x_order, y_order;
@@ -614,23 +617,24 @@ static int si1133_measure(struct si1133_data *data,
 {
 	int err;
 
-	__be16 resp;
+	u8 buffer[SI1133_MEASURE_BUFFER_SIZE];
 
 	err = si1133_set_adcmux(data, 0, chan->channel);
 	if (err)
 		return err;
 
 	/* Deactivate lux measurements if they were active */
 	err = si1133_set_chlist(data, BIT(0));
 	if (err)
 		return err;
 
-	err = si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), sizeof(resp),
-			       (u8 *)&resp);
+	err = si1133_bulk_read(data, SI1133_REG_HOSTOUT(0), sizeof(buffer),
+			       buffer);
 	if (err)
 		return err;
 
-	*val = be16_to_cpu(resp);
+	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
+			     SI1133_SIGN_BIT_INDEX);
 
 	return err;
 }
@@ -704,9 +708,9 @@ static int si1133_get_lux(struct si1133_data *data, int *val)
 {
 	int err;
 	int lux;
-	u32 high_vis;
-	u32 low_vis;
-	u32 ir;
+	s32 high_vis;
+	s32 low_vis;
+	s32 ir;
 	u8 buffer[SI1133_LUX_BUFFER_SIZE];
 
 	/* Activate lux channels */
@@ -719,9 +723,16 @@ static int si1133_get_lux(struct si1133_data *data, int *val)
 	if (err)
 		return err;
 
-	high_vis = (buffer[0] << 16) | (buffer[1] << 8) | buffer[2];
-	low_vis = (buffer[3] << 16) | (buffer[4] << 8) | buffer[5];
-	ir = (buffer[6] << 16) | (buffer[7] << 8) | buffer[8];
+	high_vis =
+		sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
+			      SI1133_SIGN_BIT_INDEX);
+
+	low_vis =
+		sign_extend32((buffer[3] << 16) | (buffer[4] << 8) | buffer[5],
+			      SI1133_SIGN_BIT_INDEX);
+
+	ir = sign_extend32((buffer[6] << 16) | (buffer[7] << 8) | buffer[8],
+			   SI1133_SIGN_BIT_INDEX);
 
 	if (high_vis > SI1133_ADC_THRESHOLD || ir > SI1133_ADC_THRESHOLD)
 		lux = si1133_calc_polynomial(high_vis, ir,
-- 
2.20.1

