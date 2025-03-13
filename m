Return-Path: <linux-iio+bounces-16761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA85A5E95B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71FF3A7E0C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD11DDC23;
	Thu, 13 Mar 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5gl1zhW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F471D7E4C
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828600; cv=none; b=G10r01qO5OJ7qqGEFvlKTx7/vmHbpsAbbQ68leve1r635VXZSgI+O3Okk34qbbxJc2rYEZXSp1yweFLhsTj8HhG5ONrUV1oeXDqdGksgAI39gy9BdNaTNPYisuDr8VdrKtJyVYe3VzjywiA1j+dP88O3N7JyTzdMWLDAep4PotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828600; c=relaxed/simple;
	bh=53ONRiOABCptcxL3WGaLlWT6fl3RdJ2bBnZWG9HzvuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+b+1FCg2HcznQIccLlstK7lxGxCpAo/+cxlEpTdKAZvnJ1XVUP7zbnxmoksQwSjNdSdtsDEn8i90aYQVfk+rs8Cw78jtuCVhju0vdj6P7pGyh3OLsaSFA78N1CIBCasYbLHvfhSxSXalixvRDxViV8eORRftoHe83DYvNP8r5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5gl1zhW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7272f3477e9so121898a34.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828598; x=1742433398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv9hPIQLpYDvfh5yD5dclx8jxi1p8xrXy5GO73MBJkE=;
        b=P5gl1zhW/NmnbENrD6+UN7UHgZnD5pHZUrcYanZlb5OatTIJ9wLugWrRm26gH7LZ1q
         EIsNaacY2NBdeYc9/jUsCmPwqRDE7CBWidNxCErWCiRJ3Pdu+IvxOmYwBTtUghIuToSc
         XgyHrWj+xd928WqPF1MJcAn/O/XiXxIXg0UNgkIsw+H8FWoW5Clna8yQdFKDXZMG41lG
         /rjlCuqZFq0TZ/Dsiipn6B+GpGHkkviq8KTWw/OsWqf8Y86EIlrGE4JFQEt38XL2oEQX
         ze+KDr3BDoxKT18jcWj0KjtNcx7Es8qaRMc/c3fKWAZfepXo7yrR4nI5jGDleVFPZrmP
         HBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828598; x=1742433398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv9hPIQLpYDvfh5yD5dclx8jxi1p8xrXy5GO73MBJkE=;
        b=eiKHVmezTWUDUCYYpdcw4cgScXpNytgX63fsTH+iLBObZzE2WA9fcykG57bpnl45jv
         /tUX9hOl80d2dyRfyUKeOr8tZTN8QGYjjoulzIuMnopb1VUO7kXgUKmUNkchCsEhs2Cq
         1RI/toKLQA2zGjvK1ZM/xmu6o3w8r1gWteUHtInigmoyl+IPaYF0GN8FiF2fJGjusHQ3
         NrbiK155mWtF+Spof88Mt0YgcT3WTI896dRnDZOFYev4dyycZp8W9+LZKEumO+7ftD+J
         LD+jRXakWrwjaTX0jkhVdx06t/h5BVF+uPWIV6hcdopsNkx3MSPFj4NqoeRotEqcq+A9
         gY6g==
X-Forwarded-Encrypted: i=1; AJvYcCVU7lCWNgNxo0U7limENX1K/9qzXMvCUhJbrXliP6EOtNdubiuV46dvBFc5HsY6BW7JmJ9hUHoZ1Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb2Eq8uQYucmpt1kHPdBGRHMuH/ox1hmJ5ABEf3zO3nOmi01Q
	jVlZn9grTlW8lmpNHl82hkNTASJyvbklzPeA1k4lyuFiVsvEppxFqWbXiUrgvUowCi77WclKzu/
	Ktkg=
X-Gm-Gg: ASbGncvZjn1gwldNxM2ZMaqpakYaLY46iyXjZPYsFFoxZuOgafq5YV6J++6TQsZt4co
	JCtUqN4hTAC2sSZL3jeTGTV1L/wdT86nnqOi1hmRYd59XYHd6k1MOYFQlxoR6lJrQ6kjavMCKQd
	x3s4xxl3bksOTzGqGCCFMvNgrpT/EYp+ohI8X3mmVOJyOF0HUdK3p62VoVc8tmwGFNUGCw2J29+
	Ng9B17htFE97MlaueMwPZluJXFE2GnskUg3I/GBGWFdnesFFVG6oQVNDBbnhm703b3NdfL1Xhfo
	AP6sFRRnTitWjqpeMB/dAgY/af4Zw3ADrDGZZ027iSsq2bQ1nOYZ4D3gy2Is20YxZKcnweN7jTD
	E
X-Google-Smtp-Source: AGHT+IEV69HY5VNUjdgasp5RyTvYJGHiBK9Q8etypNphuhRoELCRTehmlHf3J3TG1MXjj3gzgiMimA==
X-Received: by 2002:a05:6830:6f44:b0:72b:89ca:5120 with SMTP id 46e09a7af769-72b89caa394mr9660712a34.8.1741828598072;
        Wed, 12 Mar 2025 18:16:38 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:49 -0500
Subject: [PATCH 11/11] iio: adc: ad7606_par: add ad7606c chips
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-11-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=53ONRiOABCptcxL3WGaLlWT6fl3RdJ2bBnZWG9HzvuU=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbxvaCQrQgNIs++uwe1E8a2NdIiz0yfeW/J
 VX1pGFeYqqJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMKRA/9GgURgGtjoCiunTTxdXpNNrj/BWmhaluRQC2X9fJ
 eaD752dGW+GSfsw9umBPkUTCEE6GgpVcEOBVbbftRobMlU0bBrD13J/QyscQY5P8mohhfcDWwWH
 tkS3bzAMrQXyjq/NneMV/0r8ydQcfueVycvsHi5iTtAtrv2Pr7RRRohfdNrGz6Pb75LyZZ5YJBR
 bfwqq/rtGK4GH3Ad2PjeLWrg18yAH3tvEPX00CrX/x5ljYryow4ab+QLtnAHAYyyBaM+1b+F1XD
 63ZRvtiYoHc/018xFi0C83Zj13YkNQ5k2C8/Ly3iTwa36S7Lvpk3+fionGJeDC5AWA3cXL1kvAu
 rpSr9kqYcdTKZjXzFYBemcB0OZ1LF1MJbACZsEWAU1KjvS0dXHYBl/xdcEt4cn4I7aFN1cslGCU
 fy2UVV5WmfF7o2Zwzwmle0L9G7J6lpw29aL5wCjq628HLmqNTi3bqWbyCmgxxHNcmHVJEYv79aj
 DOEqXkbvCvucEUwTty8hl0l40EeVKRi3NDKagkTGtSQw/bDWhBx/fKnN29MXvLRJ4LMi3JYaEaX
 B5l4g/TwJA0eeRucX31+nmU2I9ztJ00RLA8Xg6z7vBApDdxIUVmCjbLk/WoK1uKW1dk1t7MxyQ2
 2+LoVhzdXZFbTxxMGPKxD/bTblF/RxNAVIFju5gXhvJM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add lookup table entries for ad7606c-16 and ad7606c-18 chips.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_par.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index e33b07ab5eace4b78e7cf39ee7e8d9379c9f73e7..634852c4bbd2c531d6c0e02d2f1e62db9008cad9 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -222,6 +222,8 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
 	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
+	{ .name = "ad7606c-16", .driver_data = (kernel_ulong_t)&ad7606c_16_info },
+	{ .name = "ad7606c-18", .driver_data = (kernel_ulong_t)&ad7606c_18_info },
 	{ .name	= "ad7607", .driver_data = (kernel_ulong_t)&ad7607_info, },
 	{ .name	= "ad7608", .driver_data = (kernel_ulong_t)&ad7608_info, },
 	{ .name	= "ad7609", .driver_data = (kernel_ulong_t)&ad7609_info, },
@@ -235,6 +237,8 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
 	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
+	{ .compatible = "adi,ad7606c-16", .data = &ad7606c_16_info },
+	{ .compatible = "adi,ad7606c-18", .data = &ad7606c_18_info },
 	{ .compatible = "adi,ad7607", .data = &ad7607_info },
 	{ .compatible = "adi,ad7608", .data = &ad7608_info },
 	{ .compatible = "adi,ad7609", .data = &ad7609_info },

-- 
2.43.0


