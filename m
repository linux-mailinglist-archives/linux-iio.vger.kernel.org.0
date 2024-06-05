Return-Path: <linux-iio+bounces-5850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D48FD4BF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A191F233F3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46C15F31D;
	Wed,  5 Jun 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNqgUmHy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4B154BEA
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610417; cv=none; b=RXCSqd60wL3UUlAJ/WPlt8/aGsqNyzKuRXJBkG68cpJVuIs1ZFiJU58NxNsR4lRNCQCymTsPt8Ih5CwTaUFTxLdk5Xa4z+QAyxFTzryAP7Za0S9rWKo3woDwCwRqerXspXFQywzXSNCx1ubwwRhH+0Qk59JWU4g8ytldO74OLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610417; c=relaxed/simple;
	bh=fPdJt4Gydxsb6XLYSRdNJ8hD/W3THq9fKXubquLZs6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKGQfwuKstF6nOyfKc/OLGnbQTM3ndCxoQWi0svbr53AAo3DfL295eF9+ZzUWhm/feiONHwgA2CinJObGwHmF4hlQyZmji0swzxPta65hM6V5DmZ9Zug81WSgwxmpRAjzTHw/YXYeAWcKEcrzX1C/eOm0WK9igNz18lSSDnTKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNqgUmHy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0eb1c809so264857b3.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2024 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717610414; x=1718215214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvmsbFq1f0xb8qTUeLHIrwaOpt4YNpx3HYdX4+QrPhA=;
        b=yNqgUmHy2UkDE3heRRb8oMaXmLeLXyM1i27wFJS/QU6flgxbWEI6TZ7da1x1XjqPQO
         VlQ19oRwmx0Yd/blYB/OvER0B5Y/49RGI6us/PAl60yjXA5+o8wOy5hEfj5ZadolRbK+
         XWIHPanx9sQPLs2/5sl8VyvI7v9OkxWCYCvKJqd4BWY60BaRMym9Ck/ROACMI/JPScoo
         WSekErhgKeJiiUPjrxf3KdbGf6pBiF0a1bGCPfBXHONpv8wSDHUMAThTTzKivKWkB3ub
         bbsqHW9iPJwiorjZWv1Xw6UL52JrjCEQWpvC3xexXC3j6MNOu7OViZQDgdh4MDbEtTMU
         WmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610414; x=1718215214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvmsbFq1f0xb8qTUeLHIrwaOpt4YNpx3HYdX4+QrPhA=;
        b=W5+ysbi1G0RyVpa1Pk4JkdnaBU+mLXmFQgh/6yMyLl5rv32ox3UZH+CVRSZp4pxiSw
         4A8Ugb5Kw3yiKgZ+BpKvNvHu3eHuQ6uQNNQHYmOtfz4qNmLlemSATj/Cz7qe+BFf96aZ
         kPzoCouHGAjHc+6J6GqlRJCAUIHysk1E8DYe1rkfTelJdyCgqp+eEcqY4eJjatbo4d/S
         pfdTDIxI0NqyQeWOwMdDKelTrHcK1nYzDN9p0eYZsxTm2R0F1cN3xTD2F8JEW1xTSI0s
         r6DvZvvL1oZsrB0SlZul+BH7IFb94uCXaz9iADhufHdqhQ0ZbMLMatqFJPwsctw7XUpu
         Gbbg==
X-Forwarded-Encrypted: i=1; AJvYcCVHRLWx7uhwZz8mmFUODrVuH+ArnVTsxr5LU1riddohr6lMc/ahdDM4jiyHalWjrUwsbV4AsIwMINvQaFhmrngjlx5IkPMYrscN
X-Gm-Message-State: AOJu0Yw9fT86cJXkbrEsf8BnqWaUEsd/mXVR8PtTd9XrP2H693poQN8+
	Ii5cgPofTj/+w4AyaoHTcl2oEJZjLxkEYJfzrviPC5TcpG8LlziAyQdEp+wigNoxMKTNQCgBwsZ
	8KuKdLA7cqA==
X-Google-Smtp-Source: AGHT+IHixjuOYQ1InGCAjmo87JHH7BxdpNaY95UBwdRBHB8eZTSP6/tJXCeai8kdlzm5GsjEUY/q6O3hk54taA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:6688:b0:622:cd7d:fec4 with SMTP
 id 00721157ae682-62cbb5e6bc6mr8437267b3.9.1717610413829; Wed, 05 Jun 2024
 11:00:13 -0700 (PDT)
Date: Wed,  5 Jun 2024 17:59:47 +0000
In-Reply-To: <20240605175953.2613260-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605175953.2613260-1-joychakr@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605175953.2613260-4-joychakr@google.com>
Subject: [PATCH v1 03/17] media: i2c: video-i2c: Change nvmem reg_read/write
 return type
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change nvmem read/write function definition return type to ssize_t.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/media/i2c/video-i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 56dbe07a1c99..2bfc221b5104 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -151,12 +151,15 @@ struct video_i2c_chip {
 	int (*hwmon_init)(struct video_i2c_data *data);
 };
 
-static int mlx90640_nvram_read(void *priv, unsigned int offset, void *val,
-			     size_t bytes)
+static ssize_t mlx90640_nvram_read(void *priv, unsigned int offset, void *val,
+				   size_t bytes)
 {
 	struct video_i2c_data *data = priv;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, MLX90640_EEPROM_START_ADDR + offset, val, bytes);
 
-	return regmap_bulk_read(data->regmap, MLX90640_EEPROM_START_ADDR + offset, val, bytes);
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config mlx90640_nvram_config = {
-- 
2.45.1.467.gbab1589fc0-goog


