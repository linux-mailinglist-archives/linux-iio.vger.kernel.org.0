Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA5155B66
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGQHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 11:07:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39261 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQHw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 11:07:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so2687902qkf.6
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2020 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+h7eckpgK4R3EFDaakIigwALpM/dcTzSWeobZQNuTXg=;
        b=KXgooSYGo8I6Xq7t6WgrV4xeJF4hrtnBGFZ8w5Zp04Kcbc5Mn9z2yJyNrL4QNuUjQX
         uySk6/dLJPVQoIMBRcSuahqXLZh5fqkZlSl191K+ii+lBpJrz4h8AxBRCykVrpTKs3n2
         lsMV0v/oIkxtO9BEiGWmwHWVTRM+aj63nTh7N0nBZre/GqcNYEsC/Sg+8NAtdQbpkY64
         G41MnBdC5F8A74wwtygcFvlXy+JrXPXUUUFomo2/ZeA4gv79UPUs6A8ZAwPnTo6a0kT2
         4BFfJOq9slsVNJAV4nm/zDVOPZlqnnZnhGqGqVwvDQfSY3akPtfVzdbB8o4eUgfzEYQA
         QT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+h7eckpgK4R3EFDaakIigwALpM/dcTzSWeobZQNuTXg=;
        b=cWF+Eyu1XD168ryRgev4fAJ0mH1h068HTWz5Zo7LROOUxfPoZczuSj+YanV4PMl+I4
         k8ncId2NTBKjehmWTxUIo4qv01gVbb/0/tbwNDvlNI1DaJLoRWaYmtiWEpTVg/kzSipO
         sy1gXfKmOeWw0t+B0eUlBRJpGX7sjkP42rvm0zQSDj/TNjy5dHwjnKLuw0EgPypcJItY
         oQRwjb8ddft44n7Dhbm3NbnknDQvr9kdDqPQie/iHy3w/Gp+PraVf9ETLtMxuLUpcRV4
         lmVIj97lbhFLoKAevVUF+BepPV82uZZtTIuzG7PsjdkXsPJwPPZD1Ukp8zbEy97eKCvB
         JwVg==
X-Gm-Message-State: APjAAAXxAViHzgSE7q1HpF42xoeCkDi2HsasLCQD/Vs3YdjPZpN6Iv6f
        R9M02E0y9KKXhPNf4iNInI2GOVr/QQq6AQ==
X-Google-Smtp-Source: APXvYqzofM3GaXxo67NCZTnrmPENAc3Y2Yx5ujB2nwRqlPow7IwOX1VtiOqJ9oxorK0xfoqFEdv+Mw==
X-Received: by 2002:a37:a08b:: with SMTP id j133mr7702318qke.424.1581091671218;
        Fri, 07 Feb 2020 08:07:51 -0800 (PST)
Received: from mbedesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id v10sm1597074qtj.26.2020.02.07.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:07:50 -0800 (PST)
From:   =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH] iio: si1133: read 24 signed integer for measurement
Date:   Fri,  7 Feb 2020 11:07:40 -0500
Message-Id: <20200207160740.29508-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chip is configured in 24 bit mode. The values read from it must
always be treated as is. This fixes the issue by replacing the previous
16 bits value by a 24 bits buffer.

This changes affects the value output by previous version of the driver,
since the least significant byte was missing. The upper half of 16
bit values previously output are now the upper half of a 24 bit value.

Co-authored-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
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

