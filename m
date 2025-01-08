Return-Path: <linux-iio+bounces-14017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BAA05C08
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177833A2661
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC21FC10C;
	Wed,  8 Jan 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V1ji1sbT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777071FBC8C
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340589; cv=none; b=Ie3C3AZ18dcN98byRVN4NcMaVwKZyXtUrKTYgURyIe+nqEKQQ2OlZw6Fncw6njgl6yrlvF9UcFKWLTLd+S5bwCKxLMr0mCTXlfMMsCsQ8eLTy+AIlqmtY4oIM9/xkV+g6oBm6nnL5az6UVbaQly43Zg1s69HWkXyYakpxcw0qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340589; c=relaxed/simple;
	bh=JiKbZ9Dc0gtggUQQiZa957Mbp+mx1KjmP3cEz6HLKJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGWJFDVVDnJiRT/rSJTMFQsWKAnqWUVDNYY8VnTNgbAVbOAeSIoRzgihpr5ZYQeY53fIQTYSUI5zilwfw1wBarf37pljEIA7vspaW8iVUim+M3hrXQVqYsKmg7/VhzjXBniUBUuvmXHi1fa6+0JlLq16rH/Dz+HHQyi+PBU6BlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V1ji1sbT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so6393869f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340585; x=1736945385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpTEVIUx2zsR6KrubLLJzhSMtP7WWrv/YPCN+rrmWfE=;
        b=V1ji1sbT7uWp1qrT4j2zGjg6L/9duvaEvyOxzlgOzLcOwi+2Fj0Ydgwt7zFTkbIJ2W
         9FtCY4hNFke058XvGBVABecSG0n9EU/oSSO93JK9ZqqMRNm1sgD2DoVLrGWBnZiEN0go
         Eoi555EqOe8ey5uTmzdNvHI/KxZ0ZFwqp3IdZNoX1go4y/c19+YTsIt65tLK5Fq3DzFj
         dSsdTu96wscA5USTLlZhSOhCjRvC9Hr1MFuWBiTRsp5uETcqduvgw+RV/lb6rclz1KWT
         2F3BFosXZjSs+s5rNzyUqSImLdy0fOYbWZ09JrtBln7+KUvlDC8ZhZsiOO85yV9L/QEh
         eEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340585; x=1736945385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpTEVIUx2zsR6KrubLLJzhSMtP7WWrv/YPCN+rrmWfE=;
        b=OSMz4/Q9m105DDK99/dWlzBq+6o2P/NtsG5wzLEyXddERIIxGpxoEU4FImbZQ2adlg
         hdZW3BPaVCbfTw4QoYVfERkYQ9NOV/4SGuPEmUpzqPVwbdb+jB652Vg2VSovhPO2F5hv
         UAVnjfQSaS8EM4k9SC73OPRT28jrvMKsgOmvGRZQam/GLTW9oXI96jlZfWnlgys2Ixhx
         Y6iz5Hs76LozTFndSGfbL6YlWzTn1AfOTxHK3XJrnlnPPnwRApQkjuN9t51aDxo0cx0T
         mCZLYCSx24zlychJ8UYUFS1Kpqnxsz72ah1mQY78l0vyWxLlhbWdjS0ZVrFH1nuL/RAQ
         I28Q==
X-Gm-Message-State: AOJu0YxpvuAb4SEGDxovapfQ52LY/y0IIjV1OCqZT+bUNFs9clDSASQN
	LOdyv3mq5g3REs4fWhrKUMFZJ0qifzBqDG4dnk7Zfy0obdLMcgAKZIlVQXCnxNI=
X-Gm-Gg: ASbGnct5FORT+fWQbP6UuIdbwlfrDn787RrEHlGBUlznYitbSOKIPFzWtumRLWoACYU
	MJ12iR8PeQhY9rQCuftMXdH8C8iFAkbVFGdkNoixmNRB/baNQWc6oOrLgz3e5uusSMD+9RzgkZK
	gCdMDkJfNr7Hz2onB1RsDpu2bCT9vIHqPMxGP8S+tYMxjvcoBFP29LEvJW4lOVLRVq0+yVtdL/i
	w5B6s1Kte+6rkeow2ckrsAKI93wsTNO/JFJT/QjlCwEJhZ49dyXzD8m1EX1HjqxJa2ZwWnj2mNc
	ExhQab0e7yaC/cV3WhddnkFE75zdjYTRHvztjTVpYF+g9YxWajEZyQ==
X-Google-Smtp-Source: AGHT+IHvoSPBsQF/zm7w0rdXalA6GzUY9WExMWrYVqa4uKyDTat1oJdLA0hTNsE97vT1IdC9ulsKTg==
X-Received: by 2002:a05:6000:186d:b0:38a:20d9:32e6 with SMTP id ffacd0b85a97d-38a87308c4bmr2326100f8f.45.1736340584729;
        Wed, 08 Jan 2025 04:49:44 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:44 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jan 2025 13:49:34 +0100
Subject: [PATCH v4 2/5] iio: adc: ad7380: enable regmap cache
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-ad7380-add-alert-support-v4-2-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Enable regmap cache, to avoid useless access on spi bus.

Reviewed-by: David Lechner <dlechner@baylibre.com>
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


