Return-Path: <linux-iio+bounces-12995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E59E1A22
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393CE166E20
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA71E32D7;
	Tue,  3 Dec 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wQcFzy4H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF51E0E13
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223671; cv=none; b=GYtWhXpuVf1AbloHJVeGrKwGzJtvD7aunswHNc2vJZnJmVPcLcdkPiYXpsUr6zh77QMVUO9XVEyRJZJImhlD0e3kb0UXMi0ESZlIHlK5lHFFKt0h5NqQgOOwu8TLsUrwkrzUSWizgdcohMaJUOqZe0D011uoXH8AcuRhCVUx6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223671; c=relaxed/simple;
	bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1aZ3K+Ytd0LFhmBZ/4b7wiOqprO5iILdRruNhgtF/G8bwaZuLxqV5y2Sxt7jXUHsNMtJ7lqtsPa9bvd96yCBcoc68mqVOvDFoLKo7aReC+mWQBNGnX8Gum5rUy33gwjcBeDecEc6lCUjNvfbVzl35oYJxyNXEmtwg9ZCARPwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wQcFzy4H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a742481aso43795835e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733223667; x=1733828467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=wQcFzy4H7cx5dy4Yu0TyMNThXj+Mw9JoZklig1Im/KYg7ELkA4FK2UnXk52o8oCn9x
         NdbDPfGvNC/qBSuzmfVeiemT3+nCLd+suXjmP4VNNchyRvBwDAfSJMLuHL73hYxz7T0R
         eP9ACz+XpFOHKI9d/fDgrMgmApluJNZkzDniGkB1vtrpr0dUFYDEkXlsEyYsS9izZQ3x
         jis5tdcOf04ezsDOB2To3ewlWzb9B4Y+/7+70GEmW08JNffXob5NmxTdlWHQ8WqgsoXy
         w9NzYJMGc6yq9ujSrz9FVDMm2rjr1BX2+N8sgblHI5RkGx2jk6Cz4nk7C2G46qaabQkM
         zxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223667; x=1733828467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=Xbo1W2FjE9e0XIPWaarpbWht+96uFhZfHp2f1tugPRtik+0mUDBVbr0GWZvaqQKaUO
         xYIt+qrb5IDLnLd+ajvkdGKYoFnqu5tEweO6wIF9ul7F8xGZrr2hCV43WyoaA7WghbjG
         IOQHG4mU52024Ipy4x48oEP0Xr3aRHQQt+USkZG3cy901qUBIGxKEh4bcjVgHOOQjv1s
         a07cEp1vvrhjHRfN2EX2PIfsl7AOcsM+64LsWgjZAvwyorVTgeUqo7FZyHy78Tm7hKRy
         IoISsoeLIZaisYPv9mlldm0S/cbJ0YWqmzCY9vKO6Ly+sCfjhDaF40aZb0PY7b0Wbl3Q
         /OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEMKx/fe/uxWD6FeJcLSgZuvyyag4wf3yL9+t6VkUC7kEvRGdg6d5aGD1amV81Kq6CxDyUjc/hV+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvAokYApq4O8I6FiMIEZa0cmlxcwlaWMg3VrMbFR3dz0OkEv+
	hsQCSl4wiohWxgFt9AllKHVc66l6Tah5IIm1CQFHIykZuXwBScnzGxgtvswwHjw=
X-Gm-Gg: ASbGncs888I0Glb3+gWhFXqQyK+9ZW793UsMAqVgN7LnO/aQnzDZRPKIJh05DnhDQYp
	KuUIePptSyUP5DhCRYUypxCYgIaKnNuecBbLY/Rgla9OOMP9wwq5+MohXdfVR/sb6oqdGFqEfY9
	oEyE9e4dxBRO1p0oPBOZ1BIBYgYCnwboAbq2WDvREyydCz10lawedCTWmFtJznTrDU4B/Kh9WVb
	A32B+TTWMnqWQ9/CQ7fDlCcmWaT29++7ty4c0QJRU/ZZKsmRT0/UFpniiFQGvQmIwHxmqQMmakW
	qeI3Nx+zUoLMzaFdJTGqkElApJcjHc+y7SBHAZU=
X-Google-Smtp-Source: AGHT+IE+mqQ8+E1BwU63HuYNVr0qrstUyQSQZpFE7EPJ/H5Udp+UnPnt8grdsj7aqFcWV/P4NyP+2A==
X-Received: by 2002:a05:600c:4588:b0:434:9c44:678b with SMTP id 5b1f17b1804b1-434d09c2766mr17812745e9.19.1733223667532;
        Tue, 03 Dec 2024 03:01:07 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm215482375e9.37.2024.12.03.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:01:07 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	devicetree@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v5 01/10] iio: adc: ad7124: Don't create more channels than the driver can handle
Date: Tue,  3 Dec 2024 12:00:21 +0100
Message-ID: <20241203110019.1520071-13-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTuTHdZucAX2c0f4j3lwLFQfEx4Ynwm9Zsma60 WqCqNIV1u+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ07kxwAKCRCPgPtYfRL+ TsRYB/4/A1UjY3nmdlsZz6U1VvAw06ETk1sobvVZ7QTDc131ydp5ZD3vx0mIBsp4FG1RP5ebW8f FbInr/cKnuhGQaVmdsoYhmmyw8vmHddCp/U0fjFASKcUSvmLHx7GSsTdq6Y6hjThl4rK5AZdoJH Oe4mGNiY/CDiRZ9ZjgBghjpP9N6RifJu5rrLtYIOLFQguCCH+UQIqiLjLDJHuKm6k1aWYDTVWZx FG3Q5t5OQuqTvmH5n7TWqhXJw4IjfOkCVUFDcqz/4whX7GRpIWqs2vLbqSzvoaqcVHWHnK5uMU3 og0JFKcl2dZeFJLC7YQw3kmKASeqx776mUpJlojkWIhbtcSQ
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


