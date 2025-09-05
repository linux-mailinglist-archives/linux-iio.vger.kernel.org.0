Return-Path: <linux-iio+bounces-23800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8CB461EA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E06016A2CB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9B31C584;
	Fri,  5 Sep 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cn5NjbNb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07D31C577
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095969; cv=none; b=sf3FGa4VeUptLTFL7EQ77sQTS2WuJP2OoTlc6Uu1DcT/tCbp8Qa8LmpKAomeXZikrVEjd1UGwXDcR+WjrB8/NHUiL6FZ4gB/QYCGGI3rxJy+3Jdc+b11sH0DYqnVjJ2tr/i0nAIHH2xF5DF0JH4kQ6EIYqdnq7gjE4LL9qesRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095969; c=relaxed/simple;
	bh=bEX5lsWv42f0P9lxFUEB4JGiSJnlYwccISSJPVPgnW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+07LwRkacFAmD5emecBi0d4vlwJ9FtfaFsY9y/0qynKULB8Y9rCAImM18WmR53z0TXAp00ngGWImNS6fOkw6+Vt0VkfpM/zVHkwV5BcDxofITEKe8lpoeWP/0EpORfVKJJgW9kVX1nQqV5bdfpedKf9AylT12qdh43QUFGYUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cn5NjbNb; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-315a297f9a3so2143717fac.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095967; x=1757700767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwGy0PMkLWc/SggMpjeM/SSxNiNG4AhknUu9JH7miSw=;
        b=Cn5NjbNbkVUoViAp3lnYXE9wiWSYv80utUPv5YPd1VFezZFG5N2BfwwILOu5WR05RM
         zgOR+UuDyXCJLVBZd8vUpNyHObId7s6RWXpqF26y2VMNVFoCInK0KDT38FH5ElxVbnNS
         4evAbihzhL0fdgg3+okkPH7QgEW0Dq94NYvCmkLV+evi6CZjQGS2XvG9qF3XgBGTxs1z
         x3ASOuOFIcIGIFRCw1ysD6RCDtAPQKYzDpm3v7kPIZ3Ks/ZOoqC0T1piupqgxLaSiMtl
         BD232y1x+xrFme1ybzLq/vk9bYkM3WLfAR8tbSX9vM0R01ZjlXk/tUIjTaGkH50OVTMD
         6o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095967; x=1757700767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwGy0PMkLWc/SggMpjeM/SSxNiNG4AhknUu9JH7miSw=;
        b=a++pCAn5UHvUCSvPkoU45KPacRJzaG176D/1PU+dvLHK5Qnc4v1Oow2HjHbAXM0tzA
         obgzhWSzKHD2YiEv+xpyXXuy9XbfctBQ4fV6/7DN1GmDkbcIHwzNPOdQMgvXdNtITyVr
         UIpu4LByyUfMtI+9O1cAr1MNgRpjMcw13cQx5OSlMDxX/G3uL5mVjvZsapFDvj04LTMy
         QZ4biHHTAoXSvYLDhnQ1jzvGZqPQx4dBgA7CbFYh/DrIhdDDC/K5UOP8GOjt7myzgV8o
         8ZqugXoCV4e59b+RqEwEvNywvMNliO8rD9xLcCY/s3gHzpPie0J5PGo6An1ei4cbA1jG
         K5rg==
X-Gm-Message-State: AOJu0Yzc4QnNhFSR2YX2ac0V1c7dwyO2zM0yotdRQjwn9CZQbypF0WWO
	SqJTrcxSCz+JbgRKbzQe8Und9C03N61pEWgnoFuEzM9YH1zjaOt21Y04JWM729VSzL4=
X-Gm-Gg: ASbGncvZU30Y2MwLnPxb0ROtUh38j3UCKtFbo0v98YCbWtG08KEe4PIyvCQ1iuxK01p
	9Ip+EQhbdZMGkvuEj+hLVA1NtiyZLZwRC+I5KILeQxs0L7F5yo7ETogmo4pwE7XvOrURy1eejb6
	dKKm1sFUnGDI0cb2hDwpUWZp17Jf8Ncq59r4rph0m/eUWQ7lxqOPutiUz01lKrFe/WpSq4zYcxN
	sijkh78354H46JSnU8ozd9sJlkWgOb2VHydf2xvaqPyF9qbgD2mX8pRh0C6J3OszJDZ8itihwus
	F0uP8aSwDAHxflaT6bzF3m9LsSa11i1S9pUvcGUToynaPjFEUhdX/nkWQipbWda0lYFa3SnuVLe
	bmNOJHFhCo/1H4JuHA1WWN50uu0w=
X-Google-Smtp-Source: AGHT+IFETfk0c+71/rfkIaAQhcqoeN1xx7VWTTqo+tvrfNONZp00cKycE9KjbXq9WSp0xYJv4+MG8A==
X-Received: by 2002:a05:6871:68f:b0:315:2d27:447f with SMTP id 586e51a60fabf-3196334533fmr11887579fac.31.1757095966853;
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:57 -0500
Subject: [PATCH 2/6] iio: adc: ad7124: use read_avail() for scale_available
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-2-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bEX5lsWv42f0P9lxFUEB4JGiSJnlYwccISSJPVPgnW4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouyf6FwzYUArfE6hzEym3sg1jjyRs2aRZ+M3OM
 ELov7al7wmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsn+gAKCRDCzCAB/wGP
 wMbFB/9xwjR38TbZF6CmFhGtV3N5s6jTnohNEv9mkCf/3XKhGiFOW0ffGffJBWnMwrL3xKW+6Hn
 9X3Vbk6ykG4oxmlqdm/k5rRGTRrbwel5DLrTurCHxKPAWm/tboz/GmJdmwqa9k5Ej2jHvulFfPx
 qRA0qDDJj8ekUqHzZxQY2dhVjYeQXrnJ2CEsjTNNlcJMxpbmdQ6HybGhOmDwR4baH8eAVDJzXYu
 4it5IX81dcNA32DskJMHMKJbxrx9qf9yKPmW4F4YnKnJMJIpfEzohgiwn3cD6dXmx7EQrml2Txq
 35WLJFRb5Rwf229E59rXoE0GkYKk7tbQKiat6FG+ScQG7nYR
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace custom attribute with the standard IIO read_avail() callback
to provide in_voltage_scale_available attribute.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 117777fc8ad05b773da09c113cf84927c75d6b7b..6c17cc59f33c6ddc241e94d1b0f43bceced1e719 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -623,6 +623,33 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.num_resetclks = 64,
 };
 
+static const int ad7124_voltage_scales[][2] = {
+	{ 0, 1164 },
+	{ 0, 2328 },
+	{ 0, 4656 },
+	{ 0, 9313 },
+	{ 0, 18626 },
+	{ 0, 37252 },
+	{ 0, 74505 },
+	{ 0, 149011 },
+	{ 0, 298023 },
+};
+
+static int ad7124_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)ad7124_voltage_scales;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(ad7124_voltage_scales) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7124_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -777,18 +804,6 @@ static int ad7124_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_CONST_ATTR(in_voltage_scale_available,
-	"0.000001164 0.000002328 0.000004656 0.000009313 0.000018626 0.000037252 0.000074505 0.000149011 0.000298023");
-
-static struct attribute *ad7124_attributes[] = {
-	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7124_attrs_group = {
-	.attrs = ad7124_attributes,
-};
-
 static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -818,12 +833,12 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7124_info = {
+	.read_avail = ad7124_read_avail,
 	.read_raw = ad7124_read_raw,
 	.write_raw = ad7124_write_raw,
 	.debugfs_reg_access = &ad7124_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7124_update_scan_mode,
-	.attrs = &ad7124_attrs_group,
 };
 
 /* Only called during probe, so dev_err_probe() can be used */
@@ -1013,6 +1028,7 @@ static const struct iio_chan_spec ad7124_channel_template = {
 		BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,

-- 
2.43.0


