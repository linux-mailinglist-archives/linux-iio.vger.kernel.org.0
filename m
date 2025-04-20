Return-Path: <linux-iio+bounces-18379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19DA948A4
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111C8188DB6F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0520E005;
	Sun, 20 Apr 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXXGOdFB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17520CCDF;
	Sun, 20 Apr 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171665; cv=none; b=RJ9QIor6D12bW2St6lzCL43Sf4rWEbQImIIGp3qgAplifv+8AfX5472fNgomQ3mvsLnl+srgReQBW0oMLkhlPNssdLqvOFPGeMyLFdmEgl+TxohjJMI5meJhsipQiNzI3t2Rp2N0DhNJ5/nnMUBaQek7YU4nOdfJmfg70a8um40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171665; c=relaxed/simple;
	bh=2Vf/9v9oV3MQq5OTBU53RUwRdOhIL5//2e1Ab5etr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSTTLfIELHsOj2qm/sC7qSQvPz34odTFkV8Tfv1ajYYw9wx5XSv569v/r/nMP4Hb1Z1LWKSLZg/62vOP5Qnrnrf35M6pz0gGp8prFmeb/vsbnyy0GsnlpItoVs5de2qjqJLaC0fudo8vhbjn0QNey32LT6cm7MDbPuCYEtUdbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXXGOdFB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecf0e07947so33442106d6.0;
        Sun, 20 Apr 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171663; x=1745776463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24RgFyCcH7lzHlvjgR3evkgjumfAagNsNMPftg8pkw=;
        b=fXXGOdFBYJWODlF9aM0vdnIzIWRdTwww0jpez9ZSdSRurHT/RtbhLfSXZhY1LClrmp
         sAtVEHWMyG211X47qW23q897yaMitoH6s6IUS/0xCSkH1juAfBAdMqzGB+Z2DNe48FuU
         E9UDiD5Z6qYJq7PUAKcbQf2kc+kYB0Yf4vZKKoweqrM360jBx/hbK6YOijr67JlqxnMv
         1U5lB8svpd5GtFln1n/hTz8ZUuZJldGNRTs1gxpVZoKkgxLmRIZED5kI70NNnH6xscR9
         PRiAazZyniJLz6iIV6077KjYUnybffHAbZgpKUpAQYV6A+rOSbt29kGtlaDfNLikbC4m
         tveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171663; x=1745776463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h24RgFyCcH7lzHlvjgR3evkgjumfAagNsNMPftg8pkw=;
        b=NCE6vAJiRDhBiWC8TUMTZnc8hYjFYbhd3yHg+ftzNfZrdvAP/Ks6PEgtrbs1vBWF/o
         TIZkCafNIDlAcO/KdMMunBAzU0E7aOGgMJVBqs3ajUMBuH9k6hSQLuj4qRlmUmxgnKJj
         USJOZ1IINVG+bzMtP2LuOiwqlgHosy+HWbbWldT4HchRsf7DUxggbt8ae6Ro3ZQ7cwfx
         k7J950+YvcmYh4FTRsJ40RRmIki0mxiAFLlA7MLUl0H/wL2mxA7pdo0T31XVM58drZzV
         N8aybgb229qTASL05E59m9TABgKV0o5AoI+34dMzxkGSLard2vJFAwMd3xT9y73MIzRv
         CCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTEVkk+j4/G4MmYqvN4sylj1F2RivhJmEHNzgh4yZyTIobIM3D1Qzt5YZJsaiLJh6fTiIkbo6AaH8=@vger.kernel.org, AJvYcCW6Lcf8SW9BYY1IBGnYGcOV8Qg19igK7Lh01QTc3Ir8mUPN2P8Usjhp/N31MQ5DTOHbjq9FIIooIISAXTiA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//M+yXg+mV6YfWoKqkLhFhYWTXQJ08YDfVkqeyKhrVH8BzhA2
	OmboCEJYvfJaRrmU9zKsQeNhD1l1O7HD1d7q1oAHmQuuc8yOPMWc
X-Gm-Gg: ASbGncsJ8WeUWP6XiBiq1F8mOe57WJ3HUNeYEc1I7XJTC6JVBzm6OBjsfaNfbaZAbCP
	6iZ362cPzDNQLMSFEcaczC6NM1yx1Z6M0qor4N1GMEGwn45PVpc/YD036TaPY/+fQbi7NYdIkA9
	sjuiT+d68pMFe0IPi7dg2BxJAwXaDkBAgcJ5IYRKPVWh477Pd9drP6kVmE185LJABxncqT+/NRL
	tAVw8vn+YDt2mKhhpZh3ZIkreqa0SnvSMqu0FK/uiMtsPyabCKYfWsPtTx0Bu5BCN5uGWQqDEI5
	kJ3+RPkB/PT+fht938C9qMFyELVmQgPvL4bLCitOcsFORDHU5LH95zQ=
X-Google-Smtp-Source: AGHT+IHL6GPjHZhPOvVwBwkyUv2IPgNtiGrMl108lh5c8K9FjJIX/sgeA87cxOW4bmHk+/oux5sNlw==
X-Received: by 2002:a05:6214:1243:b0:6f0:e2e1:3f7b with SMTP id 6a1803df08f44-6f2c4d6a401mr122624846d6.3.1745171663104;
        Sun, 20 Apr 2025 10:54:23 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0c1bcsm34801286d6.26.2025.04.20.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:54:22 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 2/3] staging: iio: ad9832: Refactor powerdown control
Date: Sun, 20 Apr 2025 13:54:18 -0400
Message-ID: <20250420175419.889544-3-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420175419.889544-1-gshahrouzi@gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom implementation with out_altvoltage_powerdown ABI. The
attribute's logic is inverted (1 now enables powerdown) to match the
standard. Modernize driver by using the standard IIO interface.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 44 ++++++++++++++++++--------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 0872ff4ec4896..a8fc20379efed 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -167,6 +167,34 @@ static int ad9832_write_phase(struct ad9832_state *st,
 	return spi_sync(st->spi, &st->phase_msg);
 }
 
+static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad9832_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned long val;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+
+	mutex_lock(&st->lock);
+	if (val)
+		st->ctrl_src |= AD9832_SLEEP;
+	else
+		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
+				 AD9832_CLR);
+
+	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+				st->ctrl_src);
+	ret = spi_sync(st->spi, &st->msg);
+	mutex_unlock(&st->lock);
+
+error_ret:
+	return ret ? ret : len;
+}
+
 static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -227,17 +255,6 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
-	case AD9832_OUTPUT_EN:
-		if (val)
-			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
-					AD9832_CLR);
-		else
-			st->ctrl_src |= AD9832_SLEEP;
-
-		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
-					st->ctrl_src);
-		ret = spi_sync(st->spi, &st->msg);
-		break;
 	default:
 		ret = -ENODEV;
 	}
@@ -266,8 +283,7 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altvoltage_powerdown, 0200, NULL, ad9832_write_powerdown, 0);
 
 static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
@@ -281,7 +297,7 @@ static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_powerdown.dev_attr.attr,
 	NULL,
 };
 
-- 
2.43.0


