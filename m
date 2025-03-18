Return-Path: <linux-iio+bounces-17047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67019A6800C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0156217E2A4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F60213E76;
	Tue, 18 Mar 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fqDcqFyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF0211A24
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338342; cv=none; b=FxyAqeO2vjcccQaz+D3A9qg0KcaaRdhg+ZVBI5qRrC9gNvlgDy5L0QdbZTRU94u0ryqUixqQAOCGgGbVA+jWi0u7lffHMwmPbIyeqn6Cc/yAgY7lRI4Z07BfimNYQ5gYE+Wjv2lVNK1/Eh/bAEnRVvtlqdtaRjF71+/2pzUHT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338342; c=relaxed/simple;
	bh=LyuroMMaoBOSZoSyrYLJnH+E1sJ+Nbe2Lk4N0E1CWv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuXPmVwdYSSywkM4nGhbQqFAjCcmCxo407ulv5OGjmrTN29/TB7Gap7CcSi8xyusCtyPD8fJBWg2XKuRv1TZ0a4xS0eAEgcnEJxrEgGL4ayp/6yp4YCNpt173RiwMWHeSNIawO3GJzxb/9U8W20TEmn/6MdrfW9skRxrnOXX0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fqDcqFyN; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-726819aa3fcso3679591a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338339; x=1742943139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skjEj2e09DYqSz2/zCPCOzbg5imEtc5g7h25ppNmi3U=;
        b=fqDcqFyNMQ3FaCSeq/+9/CJp3n+vrznRllIOOEOfVH2bWpdxiMRI9J9qZ5BtU+e1lO
         SfFXRu8ka5CIuab7qQQr35WYckv3BKw77u9OJmR/YFbr1ztEGPnWGJRC9h2h+T91eVsL
         Q3y9YmyXgxPzYcoI8C9mu/N3qBtijvTp4pLxp0JyvDHv3ucqGMm2glK77rXqkhdWJ112
         w5AENNG0qW/Bu4o7cedlp2Y5KQ/5NKHTkJKU5tqKBvvTQZLsgIP9C+ZG+LkO1fZWlTPu
         QF3IHVQehJzwmCf2jPgzwZsVsII/ONDYiYFxARV23JPNqbT+eP6Cke2CtNaTs5sdSMBK
         Ttqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338339; x=1742943139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skjEj2e09DYqSz2/zCPCOzbg5imEtc5g7h25ppNmi3U=;
        b=PKESKnPXYabziuJKllbf89MgPNN/imD6pwep129vbRyYD1puzW8wOiujMT43HwxIVw
         WSiLqJd7LRTqxoyn2OUb7rKDUggdrhksfupqD6oRM7WxYEj9Ps5ozkaT6d/g96lv/9Yu
         WWZ8o+F+f5Jjy1oYKT5VcoxoWWfNF/QsTshhi2CSXkxHGWpJtmRzwETRWRyBYLMoe3Yv
         KGbQmxmUf6j48Z0vZlqGMfviInl8UMc9IeavIswCNB1Bh1gTa/eplN1psX2qx9+C17zQ
         fJ7b+cjs11GKEVoq1yPeehWIefvXVMVYMdBmW4SGlROz9Dxg6j69DMSGBOjWPmU2AZtS
         pxOg==
X-Forwarded-Encrypted: i=1; AJvYcCXFWUQirlMmiV+U3i5yu6kcrfeKQYpJqQMYllDsAEeubOqWcyeaEwb32pBXemMyldyzql3Jw/59XhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVP4LZtalHVCeRL2hquTHd0D4fBuZkmyw8LxKZZxJeLZ5c5Va
	Dm9BybTTGIKbozZ0MZnBPpIBz/3zae/MNJqk4i+dFWhkEF04ISh8YkaGlfeA1wE=
X-Gm-Gg: ASbGnctDEd3Jr58RnLzBa05s84WAy3IJ0MlrIsAs9VxZ1XAobJYN5Ll5VjQ+58bQqm6
	n2LQQp0d6nI3uR1RYuSK8GYYvm+t8nV8MDb2AFCZbX5kE1Ycwhkqd+bzddOnmksscEWy9JjeVNW
	to3WlkUktcF6h7jA24q5RySqN1cc8pdf/JiFydLD0LYukJefG5Z/78aa8rVkR3Z3lKtvvWQKOD8
	ddiq0POkqddbTaN5yw9d+F3jE76dfpRKprKV96fTKfFAT/GtgtJk5UdS9QCFUL9nWfoYibbyFiL
	NRILqokMG6Z6ox6jwu90RD9O8+87xB/02ShvaKd4w/3uPLe731UbDqr9xdxzXJ6on1RsmrrMT1i
	B
X-Google-Smtp-Source: AGHT+IHgvI37efNsDPVr70hktMvOHfxddpFtDY2vRfZhBxu+mNCPsMyi7ZOBEQVQMiDM1Lz755vrpA==
X-Received: by 2002:a05:6830:4112:b0:72b:9674:93ed with SMTP id 46e09a7af769-72bfbf55ee8mr408614a34.24.1742338339637;
        Tue, 18 Mar 2025 15:52:19 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:11 -0500
Subject: [PATCH v2 03/10] iio: adc: ad7606: add missing max sample rates
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-3-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=LyuroMMaoBOSZoSyrYLJnH+E1sJ+Nbe2Lk4N0E1CWv4=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkc2jgcSfYYh2iOa+W0CrFifyYpr5JhXhE1O
 o6vrZfRf9OJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANlgw//VE9xzpCzdkLlxKXkwZaBwDsznYwHrMybeGEyMej
 e5ls7VpFjKjUeuqVtpLPNYC7gtXpncMdUk6QLo698srTv6g+qEN1Z8UOWxR/HiEZJ7UpS7JCKA2
 gE4bWLFWL/Dg/Nj8u1V2cpkjG5uOdwmr5tCnHrhJotI7IwcejaNXfCdJogyAAPtGqgUozpGJBNX
 MiZwAZch0pFBj6eVaEATGU3giCTwMbH93Pv5ddy8grT4+mZt0zLLZHlktDFgcb1jHEIJMpQlNS7
 qHoncMaN5NBjvz1xUp83M/cGN+4ZSikmyV8C/V80Enm+jRVpfTirYk/5G44b+oqM0pox+q5W884
 zaSHWJ1YLCcq2axdGcuy3845LBw7TXP/kKJn9+PHWUsdkpGTtx2qa3LXALfI/f+nsjiMrpp4v5e
 og+h6c4BBdYTXJgX0PicAFw9ujFvR5Tkjj4LDleJA5LC/Kib1NyWJpc22ijUIrl6oo5KXmYIXqQ
 9YriOTN8cK6lf7Od6RXRxuhGV6doSpVMdY8RzMij5ZXGWT65bIxC5nwirTf5uXJ8tZ0GswxCq7C
 i8HGeUQbZ/SNoofC3kYgGilK+FK0Mk2EqNcJ/gjgkbYlwmkJXDh4spc6ox9qDgY03xoGXdIpZUT
 ASSbZdVYOkFVXmaep4lu5kTdddQsOrOjSCEMxE1BS0hg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add max sample rates for all of the chips. Previously, only one chip had
this field populated. The fallback value for the initial sampling
frequency can be removed now that all chips have a max sample rate
defined.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 703556eb7257ea0647135c4b268a8ead93115c6f..f9b5ce0a8fa72974b918912e2388501919175653 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -196,6 +196,7 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
+	.max_samplerate = 300 * KILO,
 	.channels = ad7605_channels,
 	.name = "ad7605-4",
 	.num_adc_channels = 4,
@@ -205,6 +206,7 @@ const struct ad7606_chip_info ad7605_4_info = {
 EXPORT_SYMBOL_NS_GPL(ad7605_4_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_8_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-8",
 	.num_adc_channels = 8,
@@ -216,6 +218,7 @@ const struct ad7606_chip_info ad7606_8_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_8_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_6_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-6",
 	.num_adc_channels = 6,
@@ -227,6 +230,7 @@ const struct ad7606_chip_info ad7606_6_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_6_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_4_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-4",
 	.num_adc_channels = 4,
@@ -251,6 +255,7 @@ const struct ad7606_chip_info ad7606b_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_16_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606c16",
 	.num_adc_channels = 8,
@@ -263,6 +268,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7607_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7607_channels,
 	.name = "ad7607",
 	.num_adc_channels = 8,
@@ -274,6 +280,7 @@ const struct ad7606_chip_info ad7607_info = {
 EXPORT_SYMBOL_NS_GPL(ad7607_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7608_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7608",
 	.num_adc_channels = 8,
@@ -285,6 +292,7 @@ const struct ad7606_chip_info ad7608_info = {
 EXPORT_SYMBOL_NS_GPL(ad7608_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7609_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7609",
 	.num_adc_channels = 8,
@@ -296,6 +304,7 @@ const struct ad7606_chip_info ad7609_info = {
 EXPORT_SYMBOL_NS_GPL(ad7609_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_18_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
 	.num_adc_channels = 8,
@@ -308,6 +317,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7616_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7616_channels,
 	.init_delay_ms = 15,
 	.name = "ad7616",
@@ -1401,8 +1411,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 * If there is a backend, the PWM should not overpass the maximum sampling
 		 * frequency the chip supports.
 		 */
-		ret = ad7606_set_sampling_freq(st,
-					       chip_info->max_samplerate ? : 2 * KILO);
+		ret = ad7606_set_sampling_freq(st, chip_info->max_samplerate);
 		if (ret)
 			return ret;
 

-- 
2.43.0


