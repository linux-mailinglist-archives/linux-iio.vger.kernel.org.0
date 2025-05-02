Return-Path: <linux-iio+bounces-19005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E813BAA764A
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7189846EE
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF782586EF;
	Fri,  2 May 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZwrtYEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE3257AD8
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200558; cv=none; b=ZGn8SJXEMFiEBaPHBVxuEzxGiSWd9mlAzKT6kjkTis0+l9e4S6CYQocEfcl2OBchBLITtVnWUnL0CMJ5d7tnyMu5VMo8G65WmM8MDcHf2kD2DV+AZrlGjLpy3sf5r014MNmYUkmKOeTYW6uKDr5MX4ONSOC1YmZ8qNKSg2BEt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200558; c=relaxed/simple;
	bh=QAJSt6rKKZp+7sJ7azwvwLPtYc9N4CHc3g0ulN45n1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jxagQ5k5+7XThj3mRnF+/0XAWdlg5bNL24JOGcZhhN5rY3dVPg51HOPSp8VR2lSYn689oX+aYyHfo/rSITvcxLKXwsY4D7eJulOzjb7+GHq0Zuhi02etANV6XiGWjx2aPbuAyPiB09bOXtTrlv/NFDXYLxhcf05CVx3KM1Lnrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mZwrtYEK; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7311a8bb581so1731546a34.0
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746200554; x=1746805354; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSUCe1/D8mQxVmxIYOBMFbvuysALwG3zBMpMWpILAzw=;
        b=mZwrtYEK0cqqk22BGKKQk6/rZhOdvSmvuklFWMuqd+W19cccwsAwp3mWrlU0JNxHfm
         7a9sEiE+lFUN9SUyESzfnSEkVjuVeDm1qexyxT8CLQQiyBsM8kwWEqCQNtZTuQO3Kztl
         fATW81Vext5MuIUr61Fm9cOIiUtnqG5FHl+mz1FCBsRZTbZ0DQyDvg+bPD7sYahLhaHL
         fp/GZ5dqHWCpHhgDAAKiBH92t4E7Nf4C6Ljpb+ImUSvKbxXAzYXwKetsUROKwivBFGeq
         KTNdVSdafqjpaCYuLrwIIQ2QKk0nxQC0M2w2cy1pB2Q5trVA/Tr1gkNI48tB+cpqU3ue
         Qpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200554; x=1746805354;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSUCe1/D8mQxVmxIYOBMFbvuysALwG3zBMpMWpILAzw=;
        b=FBVidmn09cej/jKALZq55p1gchtv2JLw/y98TntomTpcrC/YILoxFthERI9+bQ4cuX
         y9Uro8iiCuU+GpLRTpEQjLZvDvYqcKW/un/BPV1UQgJdPLMaR3YAuqH6SQ5oUNA86ODt
         rWBgxHk6zbrTcapSIcHLnoQs/4x0YR86j5rMPw5IUrldpp8ACpr6Ed9tPusLYUd9j1fF
         v/BWBidqiun2OUlCnQ2LIArPi0ThNdVhfXSL9fTJd4ptuG7SrX8Fk9aG10iEfmBIlyn/
         xE8XaTEybda9iVidsrpa9Y/DnXgsB+F+6kYq9U6tYyI2fmuLSbySUVPGqmvi4md8qBWe
         oTsA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXIc8yc4s5yK6Lf/VXPmo6ysIJhBvoQar97MPuxWUI55x/bKKi8KW+mSYdNXvCCKfjRe6Npa6f00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuaynQH2TMerzMF5FDf6t0zOp4ogk3GAdMMlOVABH5LD1TXc3
	qvDkluM9/K2wmXSpMwD+gvkH5yIMUxclzRXJ3ceYy2JdJKpeeFD3WdA39MK8HbTr7zMzSGFcdU/
	0
X-Gm-Gg: ASbGnctNjI+1gmfdgYQQA1/5RT15MGlW/BACKN0ikdgGFg71ZzoiONgxK5AncuQa8Nr
	pF9/fqqtFqPXdKDeAnxCY3efWcK8TgJeNfuz4+huZ9LRPFEE6rr/uDKNd8oi1P1uaiFWtKNnD2m
	xPHhX7r4Uujii9IRD5EFylmDwHhnfpUeb5mM4q0X26y4d1hNqri1gGf30h8zVQRKa2WS4mGeJzC
	0ZiBo3qE6Qgv8QnsTj6TPwLLn+0ngJgG52uJro5TGCtweI4m5hvMw3Mtxg60tBgcCLX7qJq+1N/
	cBD5grU90oyQUHkhCQ0GrkGk0mk430+fUg+xn5u9B+f1dpI=
X-Google-Smtp-Source: AGHT+IFa7ER/28ouws3j877IMwPaDN8EaWbEoMu5qoYoLPWpIthuQR+VxoPZcZGOZc+4wZgZGTbP6Q==
X-Received: by 2002:a05:6830:349f:b0:72b:87f8:4935 with SMTP id 46e09a7af769-731da0dbd2bmr1986090a34.4.1746200554243;
        Fri, 02 May 2025 08:42:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4489:d382:ca90:f531])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d350a8e1sm520709a34.64.2025.05.02.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:42:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 02 May 2025 10:42:16 -0500
Subject: [PATCH v2] iio: adc: ad7606_spi: add offload scan mask check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANfnFGgC/52NSw6DMAxEr4KyriuHT/pZ9R4VqoJjikUhKKlQE
 eLuTTlCF7N4o9G8VUUOwlFds1UFniWKHxPkh0xRZ8cng7jEKse8wrJAEPFgHaWcDJpHnARa+YB
 v25e3DiLZEQYbe6COqQftigJLREJdqnQ6BU7zXXivE3cS3z4su3/Wv/Zv1axBw7nRpnIXZwj51
 tjlJU3gI/lB1du2fQF5SMJP7wAAAA==
X-Change-ID: 20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-1d330400c014
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4325; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QAJSt6rKKZp+7sJ7azwvwLPtYc9N4CHc3g0ulN45n1E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoFOfiRVXRvcNnCImEFkU2BueL0PIMiO/M6+MVB
 TfmXnM6Kc6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBTn4gAKCRDCzCAB/wGP
 wBHWB/4/Dwsx7aT3gL4Lh9bjJl/h6DZeqHuGrC0LN+5RBvXPez/KW/jw7+8ELm4Iy/uC6QxN3Cx
 2RkccxOGK95u5TaqXPQd98NuiFHPW1ZHkEDuHOyI4JaakOcPdOigEduujcUNruogia0JsVLwfww
 /C6UxiXwsEhZDI70eBMjRrn3qO2r6OANCYmqOcFGniADu5CGrc2DwhcAzwCjCsUFhAxlsAR+560
 LUq92Zzp9EmHcHpu9GTNL0Grkf3/JaQ5Xcwq9T7GszV8dwh73A/gNI9VBVE6G6Q9Z+/HWE1JiIh
 9sftsiG1K6u4peOfFAURQ4ksf1zNcQcpmXiWRBauWOhVlWXC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Validate the scan mask when SPI offloading is being used.

Since this family of ADCs is simultaneous sampling, there isn't a way
to selectively disable channels when reading sample data. (Technically,
AD7616 has a sequencer so could have some control, but that is for
another day).

For "regular" IIO triggered buffer reads, this isn't a problem and the
IIO core will demux the data and ignore data from disabled channels.
However, since SPI offloading is done completely in hardware, we don't
have a way to do the same. So before this patch, if less than all
channels were enabled, the data would be misplaced in the buffer.

By adding a check in update_scan_mode, we can fail to enable the buffer
instead of having bad data returned to userspace.

Fixes: e96d35faf357 ("iio: adc: ad7606: add SPI offload support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Use bitmap_weight() instead of bitmap_equal().
- Link to v1: https://lore.kernel.org/r/20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v1-1-8b165d9d6c0e@baylibre.com

And in case it isn't obvious, the patch this fixes is fairly recent, so
this goes in togreg rather than fixes-togreg.
---
 drivers/iio/adc/ad7606_spi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 997be483ebb93293481b922e13ece4edb47e940a..5b5b4677273b15956f1da73da41b16c5ee64e818 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -329,19 +330,44 @@ static int ad7606_spi_offload_probe(struct device *dev,
 	return 0;
 }
 
+static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
+				       const unsigned long *scan_mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->offload_en) {
+		unsigned int num_adc_ch = st->chip_info->num_adc_channels;
+
+		/*
+		 * SPI offload requires that all channels are enabled since
+		 * there isn't a way to selectively disable channels that get
+		 * read (this is simultaneous sampling ADC) and the DMA buffer
+		 * has no way of demuxing the data to filter out unwanted
+		 * channels.
+		 */
+		if (bitmap_weight(scan_mask, num_adc_ch) != num_adc_ch)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7607_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block14to16,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7608_spi_bops = {
 	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block18to32,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7616_spi_bops = {
@@ -350,6 +376,7 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7606b_spi_bops = {
@@ -359,6 +386,7 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606b_sw_mode_config,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
@@ -368,6 +396,7 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606b_sw_mode_config,
+	.update_scan_mode = ad7606_spi_update_scan_mode,
 };
 
 static const struct ad7606_bus_info ad7605_4_bus_info = {

---
base-commit: a9b169746d2e299159d4dde190552ae620982bbd
change-id: 20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-1d330400c014

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


