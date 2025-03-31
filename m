Return-Path: <linux-iio+bounces-17490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B4A76D35
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A6188D051
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B5421B8F2;
	Mon, 31 Mar 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w5UZosCU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FA21ABA2
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447851; cv=none; b=CTTvLPeUUWGTHEa0xyczbyVZ7T6jzd44TsRTmNBUnzzudXOVgRKCJF5xXQlriiPVVvzMxVznaIKYInA4GZkKMM3/JsXp0f7VpfUY4hoqR1nYD8ZeKhpZPQbJYGJN+dSkC2GlF33/E2kHOaxoZrJ7DLxALKVh/NCk9ckiCrxOH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447851; c=relaxed/simple;
	bh=OCoJU5I3KSv266Dud9GYmsHSuvkY/G/QdJ0ymA0kyLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbszU2iCWD32axWcnFufUVPKagX6WpRHXq0f9xmT1JFLqLhdhv0mlXydOxOhGAt+KA9Kl1XN8DwzFao3iVVQatczzAZFfNs/o3hT90pJhFJJkn5Q/8V5I0+c7f5WfmJc28AdcUTSb0eU5E6hHmTDVFFB8QdUEqSRl8nzHrBHnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w5UZosCU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso916095766b.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743447847; x=1744052647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHYg6gWg3qo6Q8O/SnNRE8XUeJskhJduG/oZ7vBh458=;
        b=w5UZosCUMziBchXY+n7I+u74YZPlU/9HCaoXURepJbq7In5x808M/RXzw9gGSz19EZ
         l6CZ9NeICfUVX+MBi4EixP4aiNbbOgwp5dCXuLBt6kP79LTL7Z2nVpT3hlHZzoZtxiLB
         +9dOf7uEBWR/tBWuysQQl/ea4Q7eI3SFRv60OjvlS0LrMdXSQb1WHOgzgUiGM+SMtFJA
         eoKe0yG/c/ssJLQeYsOJSIoAWdaUiTDR4Aa6HNB7lZ+tA1EZcxmGcOjAQEg8pKiZvyFt
         /CZrNOfj1Yr/gTU+MeGG/dyfFKaLkEdichhvtSHs5PSgSf2l92ZXmFWzwqKwGSZ0Zsmo
         CxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447847; x=1744052647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHYg6gWg3qo6Q8O/SnNRE8XUeJskhJduG/oZ7vBh458=;
        b=VV0E3acH91IaINGlbFRg84zBc9TaSDXiy700YD72k6v5xRh7LPx4CoibQbbAIcQ6bp
         iEzfPt6o2uS9KhNZfIz9Q023aYnPpOxZBfR+eKngUZKCXzZBvsKv7vxVQt60ZfLITL2N
         DK63PSpILwgArMG+8csEMeBohbQGjEUys1v0ZG7Ztc6m/RFDDRwOEyCF3H+kTXPU+BAP
         aLB8r5FZYsu67PhMVXQXl40P+s4FM4QkUEwlurPt4p54iMA1KqSGl7SuAb3Pcee3Vot7
         J883Re+vbrYKyoZR7AzXL9QnksOy5rg4MP4DJP2jtM54DFQTVD09Y1DsDzKsguz66RLl
         9ciw==
X-Gm-Message-State: AOJu0YxdHyvjwcL66uO4xN+Lty579BSFLsTJOfkqeOgYfTKybnRtcIdT
	CoySQwHs7z9L2dPJ/MBa3jFaK0tXvbI65hSdKrAMTkpgebRTNHGtdS9hUpHw4Uw=
X-Gm-Gg: ASbGncs6K7EAl5St9/xALkYFqWJqFNFdw/rVW7kqTodiJk1liBw7YzvyXG77N6inNuS
	/+OeVnwAX3dHHlIpJIqHIoTivzaaGqbsU2WpjN2Pu6P1EZ5VuFkIS+Ig0rTY/JIo5UwC7tYBSym
	qU0ZgmCeKu49oDyfoifP/34yHxK6C0L9Pkr/l/0gx0GrX3O9TH8J078X6EX5MJ1H0C/yb2MGCk5
	vFIOtcvjuIVSIl/ZjtUa6QEySE8hhru3x8Rd80K6UlYHjtCIb6omqqNqtdoBXNuwUdeGfanOrr/
	+xnxT2WTY9EBZbOMF3zJ6Jo8lIaopp8Lp0ouHwm04/1NzVkD9CGlUU1/Hswg2YfWU+5NKa2ukcn
	dn/TMEQY4Lo12d4CF5/dNx58xbU/Y
X-Google-Smtp-Source: AGHT+IH1ajlqE2F024lPljZdCaIQapi1TL3tf/zcfKCmohRAxM4jAC9APTecsk7fMbkihoBrWTAcOQ==
X-Received: by 2002:a17:907:3f26:b0:abf:8f56:fe76 with SMTP id a640c23a62f3a-ac782bcd3b6mr32947166b.25.1743447847104;
        Mon, 31 Mar 2025 12:04:07 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-172.pool80116.interbusiness.it. [80.116.51.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f9cfsm652288566b.122.2025.03.31.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:04:06 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 31 Mar 2025 21:02:47 +0200
Subject: [PATCH v2 4/5] iio: dac: adi-axi-dac: add data source get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-wip-bl-ad3552r-fixes-v2-4-cdedb430497e@baylibre.com>
References: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
In-Reply-To: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=DrKX9r5j3TjlenOHNRW1uPlJC2BhLVb8vPawrBK+mKo=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkh/9ezWRN8TLR++uPmLB+cUv+Na/5jn4YOdP5qZXbI1p
 XlS1ree6ShlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCRy6wMfzgSXGZn2flX37OU
 cPrzc2JkpoFfH7+YpB7nAuUy5UBjFob/aQZ9G9Ubowx3Zz10Cvv17tD8hY2nY+dv/p9646G/wF4
 tXgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add data source getter.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index f86acb98b0cffb09bf4d4626f932bf1edc911e2b..8ed5ad1fa24cef649056bc5f4ca80abbf28b9323 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -536,6 +536,35 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	}
 }
 
+static int axi_dac_data_source_get(struct iio_backend *back, unsigned int chan,
+				   enum iio_backend_data_source *data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AXI_DAC_CHAN_CNTRL_7_REG(chan), &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case AXI_DAC_DATA_INTERNAL_TONE:
+		*data = IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE;
+		return 0;
+	case AXI_DAC_DATA_DMA:
+		*data = IIO_BACKEND_EXTERNAL;
+		return 0;
+	case AXI_DAC_DATA_INTERNAL_RAMP_16BIT:
+		*data = IIO_BACKEND_INTERNAL_RAMP_16BIT;
+		return 0;
+	default:
+		return -EIO;
+	}
+}
+
 static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 				   u64 sample_rate)
 {
@@ -818,6 +847,7 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.data_source_set = axi_dac_data_source_set,
+	.data_source_get = axi_dac_data_source_get,
 	.ddr_enable = axi_dac_ddr_enable,
 	.ddr_disable = axi_dac_ddr_disable,
 	.data_stream_enable = axi_dac_data_stream_enable,

-- 
2.49.0


