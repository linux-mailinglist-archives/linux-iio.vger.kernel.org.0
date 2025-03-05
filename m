Return-Path: <linux-iio+bounces-16437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD09A53EA6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BFF3A9B76
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 23:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B101207A10;
	Wed,  5 Mar 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ0POtWK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F5207A0A;
	Wed,  5 Mar 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218601; cv=none; b=RO/Kpzx1g3ssiDiwEmVYAiXOu+oCC0W/cUWRtfUon+9iZbMBjAgzPJ6wDmBQYlljoi4HDwL50bPKFwrc7WUaPk4Wn5N/Ryr77+MJ3lCNyHb1tDBBv6mmAD4FDvA8OvQsW23ofyCOuNMvWm2fZX6XLxBXg1w9vRh9tlJ3wn13DP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218601; c=relaxed/simple;
	bh=srv7+73zZ3QRWDNH+XUQfVHz07EIMvSwvA+4Vv4LBUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amkbYhVLTMuuiR7YHP+p7ohxBHSyl2MFCxp79JxOzFyejVJ15lQvDIhlM1yP6+KizBl/JKB7RtC2UpbbyHFfHv5DGfIvBo7jrd2Gev2MqYWLbERReEmdYO6ld+EF5eXZxoGkvjzdm8tHQq4RmgnNzgKUAPgBwvfr/bZpVWvDZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ0POtWK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so174755a91.1;
        Wed, 05 Mar 2025 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741218598; x=1741823398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXrDkcy8Q6nQXUpC8HwRtU5ASiNa8W4yd1e69lH3gRQ=;
        b=MQ0POtWKc25r9Y2KQUDJ2vweVClvgRZ2GhPvxL8x115DYljtpn61X8O5rvHXCjadsb
         RHhCu7Ta5+rnHbhRMpbLqDDIEnIOVpgfszh6xHyJlP3ehp9kiza20jM7Y7P8NBn6nIHJ
         jhCLCgYu0/NmWjA1iFdXszVeB4BSoo2Pjyjy2tK+B1UdcfLwXpT5WdKjD/cvJ5Te8SId
         HY3NM2UMIVcgyoVwAchsophepaT3pTkDAmjLuwVXlMobygLC82b6mGcLHc3MJY+IzcX4
         +Ya/CczUqyZ4+CsUV2r5TW07LgB0dNxb95KUCzSgGBn5hOFoOS5yjz+Tg83BndXRfcSa
         ojXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741218598; x=1741823398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXrDkcy8Q6nQXUpC8HwRtU5ASiNa8W4yd1e69lH3gRQ=;
        b=r8i1rKPhUC/RGpYhROz74F/3+wZUSwQ7pgOT+kBuczln3Sw/EqiqNHRyRJ9EeDmTA/
         rRYydv6I31jiXwscubo4fdSE9GY2npsCyDTrLBA3RGZ6QDJnwLfb25DfwmsWiofuqshQ
         ETs7lCbL5frkgnUGJ1oW/A5gIAKL1ZDdiYlTrGEoPllBrHXVcs+FrMtowxSRDTUquttS
         fEi2wg42yQDKSBNx5IpcLQMcD02DH5a8wq9rS6pkXFLb7mTlNEsJe7DUO425GBWymkeD
         /1a7QaEJxr5rbkZuXtovxQIqwV7wPjKmRYOfofo6a6ZvpPmbCmmoLYySV6Llza8NiMkA
         jkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUAyJw9svWqaYbl5ojLEV7wkJ0Rew1EDfs3jifyuj01E/j6KIeXK4nyqa9qmTK+xLqGLNzmg7mizpo=@vger.kernel.org, AJvYcCV03Q8QpD0fLSH2TBDV/GADx5d0lySgqmfWsoLWAvfZjhGyjKlT9KXDe7xr/OFeRZyxaE5abMOJ3jGz1a/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FTu3S9FRUMpT5KlP5ZdMHAggqxnK9pUZSImc3twk+pVLzNZd
	24OvIHlSXeDOGn+82p1hTHAeD0o+/HMiLsiNqys0nb2kH29HNlQt
X-Gm-Gg: ASbGncs4ksy30qsT6cniMBxNW/SPt6GGsZiQ3w3w/RFmZ9TU5UdsPOnQQ2LjoVTeIdz
	FvC2IBE3IUYBhtbUTnKXGu2UaekbvBCCrhH7vzXJ4u7/jhy89UQjDkaIYhJxV4VJx6IBiqFFuar
	1bZUqL6JymJ/g9OCgU6akuAEpu9eqgq9fZ76a2X/KjuBobT29OyXB6iQFBCCjgsbwL29BH49BVE
	iHldf5xenr9Afp2JuxUnT6MmHefKM7j77/3oub1tu1DHU0yoyox9CawoBMTuVXmnBmNL5NpwCXV
	+5Qyt+J+AV+POnaiZABb8YDcnVwaMhKNONUtOyvuL+sXxauUsnXIqCnl0r2U8W33TDE=
X-Google-Smtp-Source: AGHT+IGlLVFKV+bPSwKWxrV0p1XcSjqEKjMMcOVLXGy3X1qxV6UJqiIFM8Cvzo8f79okMG49rA/FyQ==
X-Received: by 2002:a05:6a21:33a1:b0:1ee:ced0:f0a4 with SMTP id adf61e73a8af0-1f34952dc23mr10368128637.34.1741218597780;
        Wed, 05 Mar 2025 15:49:57 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c1cf1sm16274a12.40.2025.03.05.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:49:57 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] staging: iio: adis16203: Remove unneeded spi_set_drvdata()
Date: Thu,  6 Mar 2025 05:19:49 +0530
Message-Id: <20250305234949.1548646-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By making use of devm_iio_device_register(), we no longer have a driver
remove callback.
Since this was the last user of spi_get_drvdata(),
we can drop the call to spi_set_drvdata().

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c..3faf3c61046a 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -267,8 +267,6 @@ static int adis16203_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->channels = adis16203_channels;
-- 
2.34.1


