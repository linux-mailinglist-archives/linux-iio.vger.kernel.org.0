Return-Path: <linux-iio+bounces-13948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31EA03A20
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F4A165515
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8221E32CA;
	Tue,  7 Jan 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZR106Kv8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822133CA
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239713; cv=none; b=PaoGYMIUFOAUi8B60ZvszydobmIr3skK8pBjbNLWN4orp1dT/+1DOrRNhlkF1orM9DMbWr3/CluwiBFrcIe7jxAyBq9J/Hs2UFg5cGVQ6u1XXkyQSv89ukx9V9Ll9kNgWpyZLG46ncjFozogFg2esW1ADQwwpoS1sDnXcgld2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239713; c=relaxed/simple;
	bh=7qCtycerJ0E7BO6irPTIjHbz+5YMM8ZJmtF+i0cqt8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN1xIGOGAdaww+hcSCrp8gsaDhIP19pBUX7Gc5nLH1VeYyteUCRz7h83Zm0RRlYPxaUrHocZOWPoYHwSKKb+xHhzl1pLkSkOjVdnDqY2ErGP0olPNz9MBQkVCRIozwBzjSyLi/mlnD2Ie+3wSXY+5bGTCSyatAHWBPmdfl2Gmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZR106Kv8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862df95f92so6678293f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239708; x=1736844508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mmx4+6G+rkiZk9IxH+TiIsFUVQG9SU6UNwMqQ7on0Oo=;
        b=ZR106Kv8wgxYSKSLM4LdCIFmQ7uwulcqF3r/8DUqXXPhmXYSguZUiWVeiu6LvA6fdT
         5RyqvLrIpqHxA6UlTeVBkdy4sENXjXJ3miKrOWelWbltTCx6gMrxoLqV2IidlUqhdlOu
         jq1ipV+2PJ7L6+hJvYInHw14OaXhsL98bqnS5iGc2T4rzSBLukfLi7ccJofbkM5oCoya
         oXvlEUnoymC1Veqc6gfF5Qe8iBa//jvFID3r8kI6CIk29L0suILQCgE0IFBDObMktjeZ
         9xnnUDRPmbcRtupDQoYvGmM96KjwPk8CceqqxVclc58Mf+Gf+bmW+AghBkMdrsJCJtWv
         42Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239708; x=1736844508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmx4+6G+rkiZk9IxH+TiIsFUVQG9SU6UNwMqQ7on0Oo=;
        b=HPs9pifdN7wOFwKO+57adw9sPmlJQYsQlkufMxdENZkF0JM5zcGhlhKK7PeeY0v7yU
         9jEvC8zEw7NO2HKNgKkD4lVjPFmunUjLjwMQ2yc+jcVmJUcYHOlDbsS3GRyLqX8iOtfI
         kzoN8Sm2d6j+iOfKtOqt6DxNwseC5GPHJcBlfN/BxAQV9chD3VIdAIX0jRxuch8diAEJ
         IEW5/cqij4bEIB5nntxd6b0Emlmu5ysymme4h2IAN9RsXdCXi1p//uMErCXe+VQ5UmR1
         nNtjI2wOokb9FW7SXHRBEikS7dpbHdCl2pXVthigdD2UcuhgB8xt7WtsN735rSHWmcGE
         8cSg==
X-Gm-Message-State: AOJu0Yxr+pV3yud6qMgBPpeo2K9dEwNLHUS1uwwege8OseX0dzdLLKZj
	UnN5ctHPC48lsOMKqWm90JdMlT+bJtMwJ8P4RdSj4xD0KfHyAY4IljjbtMPa6hg=
X-Gm-Gg: ASbGncv/i+WAIhero4TKRVc7lt2fc2KZi00eXu54tGUvaj8BP3ETU/yi2cT/VCtFT5l
	NUsqx/WudPolDNsJfs9XM8d8qdDKgclEeWlJYqVqb3WY8r5E4TUMyVbwNp6rgw+DLZMRZm3LMc9
	b5IjDaZnShGLT6Y1uLArfPOJm4O8yHJLReCBBYKNUDoMN9zeydEy/fejpR/h6Uw+8/2DrYgX2PE
	TNsv+SFz3Hdxsv+y24Sra/zvaVRdQzPYUU/Ma9Hd5jFpNp/Ic/54LVY5vYsjFHsKvZtZ3+ThTEy
	y0q6bS4+a9PrIxtMuO2gFUxRXZO06CxjHZOI3Ph1J3LqYJr8mg==
X-Google-Smtp-Source: AGHT+IGyEcwIUTZtYtssZEIQClpbBVEqxd3T1X/W9wsKPy3pGHiYnZmgLn6QRRS86rH3uHjsZwNMLw==
X-Received: by 2002:a5d:64c4:0:b0:386:459e:e138 with SMTP id ffacd0b85a97d-38a223f71c7mr51700868f8f.36.1736239707327;
        Tue, 07 Jan 2025 00:48:27 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:26 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 07 Jan 2025 09:48:26 +0100
Subject: [PATCH v3 2/5] iio: adc: ad7380: enable regmap cache
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-ad7380-add-alert-support-v3-2-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Enable regmap cache, to avoid useless access on spi bus.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bc7d58850a3e2a84a241d81377e3dc14c43fc101..b97d2978289e92ad502cd6a67de43d2b51cdab56 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -663,6 +663,20 @@ static int ad7380_regmap_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+static const struct reg_default ad7380_reg_defaults[] = {
+	{ AD7380_REG_ADDR_ALERT_LOW_TH, 0x800 },
+	{ AD7380_REG_ADDR_ALERT_HIGH_TH, 0x7FF },
+};
+
+static const struct regmap_range ad7380_volatile_reg_ranges[] = {
+	regmap_reg_range(AD7380_REG_ADDR_CONFIG2, AD7380_REG_ADDR_ALERT),
+};
+
+static const struct regmap_access_table ad7380_volatile_regs = {
+	.yes_ranges = ad7380_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7380_volatile_reg_ranges),
+};
+
 static const struct regmap_config ad7380_regmap_config = {
 	.reg_bits = 3,
 	.val_bits = 12,
@@ -670,6 +684,10 @@ static const struct regmap_config ad7380_regmap_config = {
 	.reg_write = ad7380_regmap_reg_write,
 	.max_register = AD7380_REG_ADDR_ALERT_HIGH_TH,
 	.can_sleep = true,
+	.reg_defaults = ad7380_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ad7380_reg_defaults),
+	.volatile_table = &ad7380_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,

-- 
2.47.1


