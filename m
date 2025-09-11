Return-Path: <linux-iio+bounces-23997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE9B53DFB
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6CB17D5F1
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4A2E11C7;
	Thu, 11 Sep 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rcowWmnK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913C2DFA5B
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626977; cv=none; b=QCLppCBvixzgX9unCNMvQk7QkLIOc3DXwyyo6pDCYXIabyejspLz98GzI4IqR0YMfVs6zWp/mGigtFIEnJrZnkbGfRoNhOmDNAcc30nCpTcKN2Em8KFjnh6QBgFjiDVysD5q7bCkjfOmdFs/UjwsiBMqkk9YLndCDu2Mse76db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626977; c=relaxed/simple;
	bh=Mv7NRoKazrA+jxppM7YWklFA4jjQpodozntDXuzzUWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkBwOVJO1RiviZC/LNxSOAjjA+4HK0TKyyzVJdclgHUxhdS/EBNU8lrFBTTrumtyQhE+Xl2+5764qRjXKC6wBk3bq1XiAGYvYrAuWLXPDfMnSA4eknUClkOCzfc8Fr7JN0UYeTS3cXtP6WTJVLOTS6xgIwdVJkMehYKKE/i39QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rcowWmnK; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381e2079fso1297143a34.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626974; x=1758231774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlaCxILklmP/mn2TGXOLlTmpiGYpiaIzM7ZwwksGtoQ=;
        b=rcowWmnK25hx5GNrWW5tdEPRvQ8Xsfl6z+Q/VbUw0We3y0xmwL1GWua1pdXvr+DG0+
         PV/2/UdAVIYAFXtLmwfym7IKiDxrWZ0jwsgPeZskmwJ1vBg+L06xpt+3MyzNhc+IO6Bm
         Cwbp4Rb3pZWpooq1vkrHEMCt6tQrd9Co63VDT6mbApc67nTYz/QA4G5yDVnJgJzCSyYi
         T6H86m1pGXQmJR23x9Dc2DAskmAacFSkmqwKmqny2Z6xTXrddj0UY0Q0ghhwJD6rQ1c8
         cqEh1xTo7ON/e8SNz4hR07OwvJj1Frb+fG6rvGe29cg3PotHtW+Kx1yMrP3+F7/i2+uY
         0Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626974; x=1758231774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlaCxILklmP/mn2TGXOLlTmpiGYpiaIzM7ZwwksGtoQ=;
        b=CwUsMAgacWtwutZGMRvEluenBcEgFkEwcMscBPxiBkVqv5iDRfj5CAI1QPgYzn0uf3
         t8aiILEHtx93xH/GiWrRMHfKyYZrPzqJ59jp/jFvYSP28IJGAROjQQs6Pic8RFRHS3YV
         JGRc60dFTNj9U/g6y1SrUk9o6L2L8bvmAr5A6bYjE0PtBSdtSRuDHs9Eg/DKuc8mnULa
         ATMiH5Gp+8bsue86LZFL1C1PmKf7qXcHwsasQx8taPNt0o9sLpq9GYGTGGhb4kLb6qAA
         jFn8rv2GCszHHDm4ie4T4d9+xFLfK97boJSOy0fYyt/plkY7wouSjHXZqv0YGShlGtXW
         ptmQ==
X-Gm-Message-State: AOJu0YzBHytQ9iZEC5KmCshf4oXI6vweZ5I3IPqZE1P4h7sb6FFxjQ3Y
	f89FOOFVg/66ndmTHJHwtkNh9Ji2nuCaR+KJU6td3C7KjRmOk/ClAFwhqLNh8Z5ztHCY7L+IsqA
	Sgs1dQn8=
X-Gm-Gg: ASbGncuASkUTBZPJhVMM2vRwbikXadt63ePXypCLb1sj+EGPot09SaLVYS6Tpks5wOL
	HOW65prot++LNiUbdDbcV1WMA8hf696oN5Jh18p58xhAEwjhnLXcLE7y8Svt4T4FMGNYMcuEpC/
	X8h9imcA+VjLtjGYaWEYXYcMj4HOTCGzWa5RVhR4kt1fY66pn60HRmLzL0uawK5fn1Au8wDXk2c
	1cFNT7QqisFEqwGskGAAH2I0hNcgF3X53nPIct0KwIZ4CrH76N4d8WXukHsbjPAk6A8xf7wSJPp
	8wM4Pd6qOgN1I0oZnJXAIW+cDzwAHrPaGoF45QjhQJ2zASNErFC/61OkH3fT0ceYVSq8maU3mJA
	GFgbGsB+/bawOpk2QRLd/ObxIOQr+hJObTkXV9cg=
X-Google-Smtp-Source: AGHT+IEQdZRxetaxarIpdJQRQAL4Jy1BPvFg6uhxGgeo323h8KWN3bLShNlheY91A2GrPIr25YAfOQ==
X-Received: by 2002:a05:6830:920:b0:745:a220:155c with SMTP id 46e09a7af769-75353e5eaaamr590342a34.16.1757626974337;
        Thu, 11 Sep 2025 14:42:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:01 -0500
Subject: [PATCH v2 2/6] iio: adc: ad7124: use read_avail() for
 scale_available
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-2-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Mv7NRoKazrA+jxppM7YWklFA4jjQpodozntDXuzzUWQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0I548qg/Y0Q+grQU4jHpD889qfkAbWg+zU5F
 lBmVRdaAIeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCOQAKCRDCzCAB/wGP
 wC/EB/4yLP8om2BoNqj+q226cUR2Eprk2uT61JPkmYat+prl7guoeU+zdRvlMrvLbnZdgIvnJR/
 4HMbbQqXhAxQXGy6/g6jHT6jyLNSWzBJXeoKiB+3owEkMVPU+joun/y7adqD3dwLU/ilPSlBwRu
 Zt8/3O+PLH41rR2XgMCnD1N/oSZS1wWheBJphC9iZnWBcAtsm8BtZdOm7cye2w1gmoQDmOCtBfh
 Xn2M/3wxrbSCpLUEX2WjA++NRMu6+qqrw95EWTa5lj5YdeCj8tJ1PLL69AAo/LipOUY2mXZgJ+q
 noeOlyWDfiWiE7px71Hryq8uhaAIJFGAbhg0fao65G+4N37G
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace custom attribute with the standard IIO read_avail() callback
to provide in_voltage_scale_available attribute.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8f6ca33d0c902be4ada103a32f37855c82a5f2fc..97d601b3387524fe411cc0afc736618e32759880 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -621,6 +621,33 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
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
@@ -775,18 +802,6 @@ static int ad7124_reg_access(struct iio_dev *indio_dev,
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
@@ -816,12 +831,12 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
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
@@ -1011,6 +1026,7 @@ static const struct iio_chan_spec ad7124_channel_template = {
 		BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,

-- 
2.43.0


