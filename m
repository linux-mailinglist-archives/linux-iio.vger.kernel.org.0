Return-Path: <linux-iio+bounces-12372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D859D0FC5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF93B25A53
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33D1990A8;
	Mon, 18 Nov 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JOYBhm1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8A148FF6
	for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928813; cv=none; b=T2Ju3Y9UnvEmcarXAyZDVJK6F+jfbn5cxmIuioRj+Xil5pxGW4LqiKP4fY6/PHLyIQsk/mstvIwwWDGM4kCZ9gdQW1V/dSmINRLlYFQjtlz/DZHK2K8nrpuhpvrhhv93RBS9DUTh+Kb5CXvcimsB6Gg17qCEp4g+09g+SU04Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928813; c=relaxed/simple;
	bh=AwoRhhLqq1WWulNpltBkzcfiIf2PFCJos6WNxq0hVrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDkNOgk6ncds/eQvuivFp1fF4dHlBVFmqZesjsI/28xQjkeYVhOjvQ8Nxlkbz5A51BQH1Qdi0ccyrR4CQIJNpkxIsfA2a1ajyozVxw76mWDNnKtk3M6p3mph4vQHPKl44kfcujLxA43zQfycOpt/D2U2SqVorAmVhcKRdNhtZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JOYBhm1J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316cce103dso27950425e9.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731928810; x=1732533610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3clBHGKkxA0zoXbebM9YhLM0sVigriy0PiPrWq36rQ=;
        b=JOYBhm1JwrO6kj33x3PMmbsvhbWbpMVrybbedZKqPHoT8Ues4KvfMRCv2+HfHsQG9C
         65im3kGl4N2PLCb8gZQ8r08XcSPSs+0aZBX7Fgj0o01Qtzuxdiv0dO0PganjiZnKFPp+
         KI8SbCru0URDdwUtezbORHFbI+fKGuHLDjZOvbBWYqDasCuB6wFkfzFKnQiUGoeI0w+C
         i43NcUGsnw6/w6jCV1dSPgs/ENHlDxNR/OMPU7XgymskXmQAtN9SkaWKa49xP8ylifix
         oG+V/0Eiya6DZpDnL8yo3maghvF7yP8E521tg6gn1xq+CUn5DUT2P9CFW5+qftpxH1pW
         sEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928810; x=1732533610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3clBHGKkxA0zoXbebM9YhLM0sVigriy0PiPrWq36rQ=;
        b=aYSmAkTXL8H5GSJ/4KNCn9gGpJHmJdZujve1PwSKlUTbZ0me+TCFtefW7A6Cw0DDJd
         DU60SP/DaxFt5LdOBlWqPxiBsHs2zERwORBK1A6jXRpERQRs5BRGcFoMOdpDllpSJcsk
         5lQ+VNVkXWPQ7UIFI2GHb4eD/XPIX4r/STP0dp0oYaGzNb7LA+2XmegD7+Sa0VK4Sqc9
         p9o6IiJoWfUhC7CJT9X3ys94GygnI0Tr1VE1Rcu4wUTXWVc/ptwkfHAtdyF1p1RRfZWZ
         v2GYgebx0bYfRoSlXVHSetSUwucGV8O6N4k8s26KPuYZ7TIxSUIyxNXSJyWB6dzCxyQy
         D1iA==
X-Gm-Message-State: AOJu0YzpyAjVopLvjMhtRLYnjJ4AF5tfvdk+yGYEuFvQ5fSQtPO5+mUF
	rfSaDCdMh+uMFZlFQ6dJ9moDujHTSEuctVBQcLfJw3YLdBOANNZJbz3vs32LBSw=
X-Google-Smtp-Source: AGHT+IGXx6oSXXKahYVS7gkCoNCEnTgspzDxDZpDMaegzj57Hq2dkpWqqADyAoNPoFCIkz4gnMfCgA==
X-Received: by 2002:a05:600c:4f02:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-432df722e64mr105030275e9.1.1731928809838;
        Mon, 18 Nov 2024 03:20:09 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm153746835e9.35.2024.11.18.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:20:09 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ad7124: Don't create more channels than the driver can handle
Date: Mon, 18 Nov 2024 12:19:55 +0100
Message-ID:  <26b8c3f2f204ca62520f0f3fe1e5173bc9ba3d30.1731404695.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1731404695.git.u.kleine-koenig@baylibre.com>
References: <cover.1731404695.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AwoRhhLqq1WWulNpltBkzcfiIf2PFCJos6WNxq0hVrQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnOyLdLLX1bgBehhSBqSo1RG/wt0fy1Xa0OnO3t 5P0yZ3BdJ6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzsi3QAKCRCPgPtYfRL+ TuQCB/9J5DoSs+zCfIygvDXx/x724zk6SLAdonurWUO3DFybWhFWJ78tYa02HiyRR46yy5x2e1B YOdyqu/UCfAZ2vfxU3jqfOvApBq26/7aqJvLL9ke/h1m2dini8wzqJv23I/JCSVdNOt3jK8cpUd u66Xf6y2CLIuR/IwLDNQiQvZTj66ObOIvAx9oCjhCL1sGtS/vfai7Qb2HYazZoS5vcrKXjf/3IN x9sw1hwiqGGNggSBGm8BoBx/FyXeg89wYgsCJQvml0Zl0otFEC6emOgFlZEHia7KBOlt/EMORpP tZ8zfihVaEk0AGvz2joOdcRIh9NB9dyYPzcixaC0iSnSqfqu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 and ad7124-8 both support 16 channel registers and assigns
each channel defined in dt statically such a register. While the driver
could be a bit more clever about this, it currently isn't and specifying
more than 16 channels yields broken behaviour. So just refuse to bind in
this situation.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 749304d38415..4de69bb8653a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -821,6 +821,16 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	if (!st->num_channels)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
+	/*
+	 * The driver assigns each logical channel defined in the device tree
+	 * statically one channel register. So only accept 16 such logical
+	 * channels to not treat CONFIG_0 (i.e. the register following
+	 * CHANNEL_15) as an additional channel register. The driver could be
+	 * improved to lift this limitation.
+	 */
+	if (st->num_channels > AD7124_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Too many channels defined\n");
+
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
-- 
2.45.2


