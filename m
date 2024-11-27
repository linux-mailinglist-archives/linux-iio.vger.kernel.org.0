Return-Path: <linux-iio+bounces-12745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FA9DAA64
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53FBB21AEA
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8931FF617;
	Wed, 27 Nov 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XPWMgxrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05461FF7C4
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720015; cv=none; b=Qd/IzWnOmcWS94btyxoJQPdtjZWdZd8I0YxgocPR3ijTsidYrEhiLUB4a1WjmW24LUdPMr3e3+cUi7e50YYUlcZm1xq4be4G1LtX8e73dicrDizNzjqMlwqmwCfrkTrLJmsCd89mq4I0o/a0qweOUqDqgUJYuGiheui6ov+MoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720015; c=relaxed/simple;
	bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUq21bLpMpscFEx4g6sG7rbuCx2GH4zdq+kQNLYQXWnpSwEnRitEOS1Z6TtR3NvNArjFRMK1HBu7WQ3Cjo0PRaMQ1fBY+pM8WHJNgptsG4rLKmP90TdhunYHUySO/sPIQeQuGmFsrOwv5hjiNMzV3nem5aDffTnxyW2OhEe/uuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XPWMgxrT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3823e45339bso4959168f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732720011; x=1733324811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=XPWMgxrTvJpRrHr7L5Ts9VTHkLIPkK9UZPL1NnWhNGtyx83l14Bfpg6vAW8deu6Th3
         gW7ywCikWAT1ipmrnHRWW0I9gJTKo0UfIz5g7etJhUCKnjtUPzm7UcI3kqSyrDdBY/ki
         hxFf0RcF2530QYCp7HNFDayMLi+x/3fyfWlh2xIGsvfIL7tfYTYQOgjtDMjHkMpnSVG6
         IHmwpCfDM0zcBMfVb70qkCytSAr8xO+P5GK8mCiDGDpNplzRVkBu8AvQAjP/haD8dyll
         V40POdkoen/EVhg5UwhewrfY39AVT7TW2dhw27EbEiYuhVQP8EfkiTUsPcnJ9hYBJLVU
         WXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732720011; x=1733324811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=rKG6+QdN4cjdL8qK6n6UiEX69lh9d8uEq55KZc4P5ieDhLv4N6C5S94N6PJlW/xmyt
         fq0D/LLPVSxDZWV7A6cpnrGh4o3P1KrfVc5Szcuaw5MKqmtZOnzFbuPAdnfwD8rzzXBy
         8R7AigZ0dETjhyYa1rq5sFOxSbI79hvQOuYFRuq22LURwCZkARPF3p1MRWZ2ZsdlQOQ1
         kMYHZEC/8JUOVtuz4GlV2MzBxJd1OhRP+QsydpqOuDQ/LGBcz7W1bKZSZwNvn3FEJuvh
         YdlqJOa6x0y4KaYdGDF+/yz6S/KfYddco11XgCQ9Bxx4T9urYhkZL9ECb+aiMecOthmp
         qBOg==
X-Forwarded-Encrypted: i=1; AJvYcCWPU/C8tqd/ufq8cp/G7q5bgVUQfps8g7Mls7unGKf6uwx51tibXauYgHAu1QYW2eIkOknAcs7SQAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4mOSlKnpsYxtOtBOrPYfpS2ShZ8wYbkKC1Ox7MONhXe2FNv6
	3tEc+yAkJlrcZBg6BJUoKrNUU9ei2QLwNgA56GCrN7aB5kVtomrv1C5E5G4BfhOFFXJKqwdI40n
	h5Zw=
X-Gm-Gg: ASbGncsHAbVoD7Mj8Hd7SagZbYpUc6dS7258l+X470bHJCOB++JSpt0Ej4Trxw/kF46
	lLtI2eoV5SNdw2LeczlucXghj/KD1L0Tf5g684lC29+9/kAa5WPj5DXhIzNwz+/QDNeOCt9Kt7y
	oG5+eccvx1RCYgV6O1Zlj1byRQcKlTSMyyjx46IgYpC5oazOl07lne3qykD6SjKh3oBMqqwEKrL
	tqIP4jw16oEpuTJioOugGuPg3btCy1gN3SDKPhXxF/rKVc4Rf4CodPEoq7Gb66VAj9DOyuGX0sD
	k5tC
X-Google-Smtp-Source: AGHT+IEdVagKnN7ScxTCCHc6botfDUQwjo5t5vCUD3sywf9pEq2gwZDQdLE7YiLyra6lsD8bi8tdtw==
X-Received: by 2002:a05:600c:5488:b0:434:a91e:c709 with SMTP id 5b1f17b1804b1-434a9e0c1e8mr24638375e9.28.1732719607272;
        Wed, 27 Nov 2024 07:00:07 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm23943565e9.9.2024.11.27.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:06 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 01/10] iio: adc: ad7124: Don't create more channels than the driver can handle
Date: Wed, 27 Nov 2024 15:59:30 +0100
Message-ID: <20241127145929.679408-13-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPUdZucAX2c0f4j3lwLFQfEx4Ynwm9Zsma60 WqCqNIV1u+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz1AAKCRCPgPtYfRL+ TghLB/9IMmwbVTOfyNgsOPDFtvxK+HTtiZ69EdisfS2BhnNupqAGgb67yFfVMO67L4H9wsy4dik j+cGYPFCKJEUNwoYHVtbkn5OwhbG/4yN847Qp+LHbnPXRyV4tBztHDuBZnKp3u4e5NwHlQyYAm5 q+cKni4lCp9dKZizknTYzErUr96/hBIHr1xsUOFp8f17EVBI/WkLUf0zV/DabNvWLv9ZNILyUG3 BAzIcz8RZvrpiQ0Oe0J42MRW5Xunrr+rkxELDO2xt0X2B5XbwEEYKKZ5STHuYZde/Z1m0LdvCQm edmPZEsFMAg6QFu3V/rRPQMPZyKo5PeyqQUgNu1mgOPXoO6g
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
index 8d94bc2b1cac..5352b26bb391 100644
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


