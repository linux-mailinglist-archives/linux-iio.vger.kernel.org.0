Return-Path: <linux-iio+bounces-10425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3F99942A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817061F27486
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D31EC012;
	Thu, 10 Oct 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4TCImyp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF91EB9F8;
	Thu, 10 Oct 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594054; cv=none; b=kCZ5MjlPwMABN8ZrDqe2KUm4YCmFsGsA7zwBIrdjT6rxM6yQmvdJv83CMujk1Z/qAcQ/RxEM5ONwx7lpWSd9JX8UpmYR+LFY7DclU26BqOZdeDybh+DpLBRZKVYLLC6LjV8PpJpVl5hfkuORfBDNdAoeLrTsLHxVAFrjBJnd5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594054; c=relaxed/simple;
	bh=uh8NVnp9Ihq+FgmzA1DwT2r7T+ZgJqDWYmeKPcCtfUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxPzvesqJ5CPSmHyuFSs8Ui0f85z4N033nw0QzaTV9BKjBL7aYwhs/5zxihD5p/tmuum2L+OBaYEs1Q2VN/NnIGQClvREf0Xk/7OfMDFxGa+Bw5/4CPotvSVqm/7LGSXkgwcutvihgmz32LwgfjDGGCxPA8fP/jCK6a6PYHWYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4TCImyp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso1418817a12.0;
        Thu, 10 Oct 2024 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594051; x=1729198851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N9aizlh41CXZ4byNCDj3AnGL9jqT8nuJlmW3/5gIfU=;
        b=S4TCImypkWgoM0HSKNEl6KJDEYLMrsJJl2MRImR5Jz9P5x35IEsXkiNrxIGSxYxH0x
         d3VEalJsJpm9FdYn2cmj7scVabxWzi4A3nSK5bsnUanWIu0BZcWbZO52uwpTY3m69eql
         GkqwA1YSVxVGM9S7MS/tk+qu7REF0A3QTP1uLrOqeEog1tKM3yXIjybWBtqRY4QJeb8z
         05t4WMq2AGCpvXkJDH+jR6hGMpDBZ/BMLZILNpTtwQLxg4EGqdVw+xjFeg4ImdEtkGjO
         oqL5BhSIhuT4UVfrQVWTArkZm27AdKsyzZ/MeCVklZaHM20Kng8kla92n3M5E/9jyEfY
         GI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594051; x=1729198851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N9aizlh41CXZ4byNCDj3AnGL9jqT8nuJlmW3/5gIfU=;
        b=jls5nDn+6P5O7t/7CCk3L1yf15R1UMwnBAEm9cZ5sMTw5PRdM+tDLEk+xFA2O4m3tL
         yXTjQ+Mt2Nb/DLwKe8JGWyDkQpkkXtg8+MwJAQDxAEQfCvoOeEzIZPaiqysi7VzvBBY6
         /PCw4sSyBMcSEyLIeudVHpWPhdIzZnoUn74YR8gRBmNznZhAYsTnjufJeBPfaPZMVh27
         p/U/+XAMLZ/HGNlOQ/mARWqazQXY7Ur95h/Tb9c6qAnKnT8kXlch3rmgY1w/hT+QGyNN
         ebic+vr59MS2AApeH7nqusaBoTl48Thj+7EiEG9cCBYYmolsAZ6ZIWdEXMRipnVtyTQ8
         wVhA==
X-Forwarded-Encrypted: i=1; AJvYcCUOJoYJE8Obwh8mqywetgNG3PysMFTlC3pS5C2YRSyw65t6s4zGD0tOGzffzvcJ+qMZPQLfrDLFItVCJAsF@vger.kernel.org, AJvYcCVc6A47Mx0YVJD/2OAoazQIdzb97AE06rl9TWyXYGzr1XPqa0GU4u77evioYXnNIVqENDtDPVs1+0wM@vger.kernel.org, AJvYcCVwFH4+XL3xgtEAoPPcXzdiNB0qGvNxB/Ayg4XT2dp22iNEPLP9+J91HSaxOIsEHDIvNlQMPvrreLzt@vger.kernel.org
X-Gm-Message-State: AOJu0YyttOJ58Gp2yQrsPT1+92skao69Rls9GojBCUuzn3mitxKeqJLD
	FdO7MBUv9rJndE/ODDe2Jx/5xSdB9twne/ACENyQi9IaPNwsc5F+
X-Google-Smtp-Source: AGHT+IFchXI6GpNj3shGEtlnTjxkiGv7lzRcgDZUxwca9Xsl9OIuZ2W3a/v8iPADiYiFAC314TOYvA==
X-Received: by 2002:a17:907:7e87:b0:a99:57c3:1fbb with SMTP id a640c23a62f3a-a99a10ed84dmr450015766b.9.1728594051159;
        Thu, 10 Oct 2024 14:00:51 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:50 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature to attributes
Date: Thu, 10 Oct 2024 23:00:26 +0200
Message-ID: <20241010210030.33309-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Remove the ambient temperature from being a macro and implement it as
an attribute. This way, it is possible to dynamically configure the
ambient temperature of the environment to improve the accuracy of the
measurements.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  1 -
 drivers/iio/chemical/bme680_core.c | 35 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e9e3e08fa366..95d39c154d59 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -45,7 +45,6 @@
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES			GENMASK(15, 6)
-#define BME680_AMB_TEMP				25
 
 #define BME680_REG_CTRL_GAS_1			0x71
 #define   BME680_RUN_GAS_MASK			BIT(4)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5fd5740bb7fe..0979c8f0afcf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -120,6 +120,7 @@ struct bme680_data {
 	u16 heater_temp;
 
 	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
+	int ambient_temp;
 
 	union {
 		u8 buf[3];
@@ -483,7 +484,7 @@ static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
 	if (temp > 400) /* Cap temperature */
 		temp = 400;
 
-	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
+	var1 = (((s32)data->ambient_temp * calib->par_gh3) / 1000) * 256;
 	var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
 						temp * 5) / 100)
 						+ 3276800) / 10);
@@ -878,6 +879,37 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static ssize_t ambient_temp_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int vals[2];
+
+	vals[0] = data->ambient_temp;
+	vals[1] = 1;
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, vals);
+}
+
+static ssize_t ambient_temp_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret, val_int, val_fract;
+
+	ret = iio_str_to_fixpoint(buf, 1, &val_int, &val_fract);
+	if (ret)
+		return ret;
+
+	data->ambient_temp = val_int;
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(ambient_temp, 0);
+
 static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
@@ -885,6 +917,7 @@ static IIO_CONST_ATTR(oversampling_ratio_available,
 
 static struct attribute *bme680_attributes[] = {
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	&iio_dev_attr_ambient_temp.dev_attr.attr,
 	NULL,
 };
 
-- 
2.43.0


