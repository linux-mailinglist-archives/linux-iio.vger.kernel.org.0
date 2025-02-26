Return-Path: <linux-iio+bounces-16095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA57A463A5
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BA416D227
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FB2222D5;
	Wed, 26 Feb 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IbfhcDJ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4D221F02
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581427; cv=none; b=uif5mFHxWA5b8MhxYqCzZ8Jr6Uk0RroApRWdQCAFXujNqHbBYdMcrMzzFgn8Qia5NGmQe8x4D830Dtp/rrqfdhnRHTQHNM2NLbvxkxnDzcD4/8rhHtFWPN/uuPQO0Iu+PsUTtKICMpymc2BrPUngLqTvOzXDoM0WUJ1pIgCqSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581427; c=relaxed/simple;
	bh=Lzx3CAaQiC8wlZS9M5mT2Yt2uq9rPwqTrQ3zqkOC5JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sq6XL04cDrWUc1t3z8McEmq0pv5TEXD+tqWS5iQRmVatQZls/Hewpl44yN+vkfTOmExyr5ca6xJat6qNHBUej4u5UyqS0jyh4PMb31/1u3arMrd0sztSEN9mbwTAO58YfGQhLWEV92MV+ijFbia8dtebM6h8VR7Cub058CDoR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IbfhcDJ3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399ca9d338so43201505e9.3
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581423; x=1741186223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPdx7XAkaj1yG9dpdBhO/1wk2oAfUm8FihdFBSOr8GE=;
        b=IbfhcDJ3DVOhiipZTDMrODB8tBq3ufnSau4UAtMAkMeSowrlL5CFYWcReo2byYrn2U
         VqCUf3TkChTqpoAsgRBdJnoz4xS9Lb96eRfyZNRTLaYhyMfIRaYYSELLoeTNOWnALTEF
         VgmkXoQDIk0O3TCpN+jZHXF6WrfXaC4VjeqPxGXOT3Km9h0sa924LBSlXwldAz+Ng4D8
         V1AhOu0RL1OwNiazXqLDCHcTtAeEQnXS98q4DW0MvTpcmDvWX3e9QcF9AF+0YpfJtBks
         SF9gcvd23eTmlYI4m0Q3uMeSfOQI551jHeD71xY3WVNftaKS/sE2CNPpS9gXw1IHBzvW
         79tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581423; x=1741186223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPdx7XAkaj1yG9dpdBhO/1wk2oAfUm8FihdFBSOr8GE=;
        b=KK07QqyKUf3F9W1fudBvQGWM0zzXgpLOAKX6EIgx8/97+VujUUtAYumeRoLH7lsA2p
         LG5uLPw12BBXXXr8OwWhihdohDvCZWMGhhTcja1pBqMIkINGDaPJYrcC1kiv0TWXzNwG
         8JTv3GhxQtOKOi1vI8Tr+M9X8zyozPNHJzRvMf/eK1RcFhkzrgqszeVArToewZ0YTz9Z
         xhWOq3iizeLPSLl/awD2p/SslQKU2yfUpx+Nj9DVpF6tM1IW+pLCMbDze3FOdIhVpU8j
         Ist6ZEQbu0UabGNTuHbizPHkfq7EYQg4xufm0zHc+c4ifQwXlxO3ZqxwjoZcUoOMd4AX
         nZhA==
X-Gm-Message-State: AOJu0YxW7LAEV/eeI5X8sSmOuxzMzYMDDK9DHT1eO1gPJNBllAgt56tO
	+I5mmxMzKvcB7XzHZXL8sFFVcTRcCtD+F50bhKIhtTYyYKujt2n5kX42V6VYaXG/zlZ0fO/3iFP
	M
X-Gm-Gg: ASbGncvHrhQZjIfyq4FeFgavGHWJsCXWEe0554glCscZy4ADcbXqPOAYzw4wUGrrSNd
	ITrlnOvICNUsdadI9OBVq6SDjVNZxrc2gY3f1qT0y4wIsX3Yu6irpUouXDZfFnY/D67qchjejG4
	ZmPhBUVuMWbsZZSq5gAf4oQU+Yrx9cLKiNA4Al2346D80BRNfweuj8UhDXnGfukXvNpR4z6y6v2
	GoRnHk9V+m1Il2vIfv4LXV6SOcZLv6zDDMP3n71vv+FIDpjOpsF7W+OZ31hjb+Caqw+GM7SsCO3
	cZIqRShQMuxRfINImPShb2pwGP1/ItoyqFqgob2BLzVyf1+y34z5JwfGxIpZGKwmSQqBVMlJAHY
	UPY7YMkrBwTUS+E+cFkSWi1Q=
X-Google-Smtp-Source: AGHT+IGvJMtPWFu7X3FYb/KUfGdGrzxdvYsV3KXmwMuSWdG1U/6djg+AF57pmGPwqA4QzHENbBngYg==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43ab0f2887dmr73969585e9.5.1740581423465;
        Wed, 26 Feb 2025 06:50:23 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm23747965e9.36.2025.02.26.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:50:22 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Feb 2025 15:50:03 +0100
Subject: [PATCH 1/3] iio: adc: ad7380: add adaq4381-4 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-ad7380-add-adaq4381-4-support-v1-1-f350ab872d37@baylibre.com>
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

adaq4381-4 is the 14 bits version of adaq4380-1 chip. Add support for
it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f232ad1a49634baeedc655916bc7a967604a1206..407930f1f5dd107154a6c34c6afd4429ebb69826 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -15,6 +15,7 @@
  * ad7386/7/8-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7386-4-7387-4-7388-4.pdf
  * adaq4370-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4370-4.pdf
  * adaq4380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4380-4.pdf
+ * adaq4381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4381-4.pdf
  */
 
 #include <linux/align.h>
@@ -287,6 +288,7 @@ DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1, s);
 DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1, s);
 DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1, s);
 DEFINE_ADAQ4380_4_CHANNEL(adaq4380_4_channels, 16, 1, s);
+DEFINE_ADAQ4380_4_CHANNEL(adaq4381_4_channels, 14, 1, s);
 /* pseudo differential */
 DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0, s);
 DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0, s);
@@ -599,6 +601,19 @@ static const struct ad7380_chip_info adaq4380_4_chip_info = {
 	.timing_specs = &ad7380_4_timing,
 };
 
+static const struct ad7380_chip_info adaq4381_4_chip_info = {
+	.name = "adaq4381-4",
+	.channels = adaq4381_4_channels,
+	.num_channels = ARRAY_SIZE(adaq4381_4_channels),
+	.num_simult_channels = 4,
+	.supplies = adaq4380_supplies,
+	.num_supplies = ARRAY_SIZE(adaq4380_supplies),
+	.adaq_internal_ref_only = true,
+	.has_hardware_gain = true,
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
@@ -1582,6 +1597,7 @@ static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7388-4", .data = &ad7388_4_chip_info },
 	{ .compatible = "adi,adaq4370-4", .data = &adaq4370_4_chip_info },
 	{ .compatible = "adi,adaq4380-4", .data = &adaq4380_4_chip_info },
+	{ .compatible = "adi,adaq4381-4", .data = &adaq4381_4_chip_info },
 	{ }
 };
 
@@ -1602,6 +1618,7 @@ static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7388-4", (kernel_ulong_t)&ad7388_4_chip_info },
 	{ "adaq4370-4", (kernel_ulong_t)&adaq4370_4_chip_info },
 	{ "adaq4380-4", (kernel_ulong_t)&adaq4380_4_chip_info },
+	{ "adaq4381-4", (kernel_ulong_t)&adaq4381_4_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.47.1


