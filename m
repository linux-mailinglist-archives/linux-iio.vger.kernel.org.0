Return-Path: <linux-iio+bounces-17046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C340A68019
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609CE3B4C30
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CF2066D9;
	Tue, 18 Mar 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NokKE2LK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E5206F2D
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338340; cv=none; b=KAwTRsB/UE00BEqcuooDxXXMId557AK/qbOErwFu8XZZujt9hJb/ZNYHyri9H4RIm+re8QljgexO8QrePaSQZMhQbHSdI+t9pb/ucri/HmgHHzPQEW8KBCBVvUqwjhFsA6oINEx403Gxn6h1wujTGJKGYLV8H2slO2OCNN2Vh4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338340; c=relaxed/simple;
	bh=MymKfg9hNdh7VEIVG5aw3IyW7Bibo8midSILlV4WG+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwWzqM/pkfO42FBiBg5RetAEII4nSxuKSVpPZA/Gyw+bXkM220Kwzg2KtZ47Q0xhEhSh28bOipVlcCji+gMgy6j19Nas3jg7WHwzSxec8lEYMXduNTO+4kSqzEvDIXXdv5a2OH3qW4P184DsMfczNqeGrXl9gVVjBSIOdpMjU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NokKE2LK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72bbead793dso2629699a34.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338338; x=1742943138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkbLNtVpwpFZWMs4rz6SYORu0wPhARh2K7016vD7POc=;
        b=NokKE2LKV3UlN2uBnUuj+cyanRGo3rAh8iQmVJZn094WzKOHqfGJSgFaYs7wCJULHR
         Z6afHHTEi/gMoCUwUgNrO6K3WcgP1p7qwmB3xSn9Tq6zS3Lz/aB4dFcVE4JTq629kood
         8hHHa6YIKRLpVV8E9VOECwoJ9s8v+6bmZF+zEuBzvLuPftr2I7XDOTc0ZIyT/81nfks1
         u7fNziuDmgzXNCTKkQ/bp0433SHEwH+fMpX2KBl6X1K3uGjv5vnuo7Hl9u3Pk2Wf7dK7
         Qgx0LIG1TPK+n29DjX0C3scKDGEC77+raEaXO/vngwiRqc6S22Uq6ySMtxATJ8QcXgY6
         bS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338338; x=1742943138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkbLNtVpwpFZWMs4rz6SYORu0wPhARh2K7016vD7POc=;
        b=jvDHBFr3z12c1vCHqKhY/HnQXSG8vSUwfZuwbPM2suGIrC5oh4Kgp30yOrXuDOj9jr
         qvjKB4+qNNSX6GEIu79fZeccz0n3XA5KNJz4Ql0CUbOZWupLvzHlnX/G7m6ewfBtzCDF
         dhMKm8BJbKFDDL8a/4eEhpYj1/sx9HhF0r6OxJfdf/nlxy+9+K718ulI24psf9zTzHkg
         0S9ppkezm5tebk3dAq/gsufoCxf/VyOl4N3zSGFFHVyEMJn0XxRwagaysTaZDYKtrBP2
         l/6pv2J0SVStv3QGBGRLh3jmqkibYCtsjw5qXEp+PRIh6jTs5CokwEiCTTXVk2nUOTHI
         wN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRzUGje+9LMrYoLq+cpG2mb2o7+sZ/dfu5vPT4V84hImuIjWF5EtRtKIKBIp0DmsTXmqH0ByG3vpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0HTkkxaNSJZZMdycypu+EkgSfRIrHwTpnSpFz+zmNlZf2Tjj
	9uOBWU6wCTgLfOAK4kXjmKB1TrBM6XF/clwGBNrv+SO8jaNDD79yXL05ghi+Azo=
X-Gm-Gg: ASbGncvb6u902TK6DGNUYuBhsq2wSV/bdV84so24XwDHlKuR2RHuKu24jrKne+1ePUC
	7pgN2Wn2CH+S3Bmdc2GbxzeLkhXdI+jKcqrc+e9YAOYUFdq00a+vS56yNnfF0KkaPqLkytoAGoc
	nqOUepcD1ToM+IgGlOF0OFIznzJLh2eiYthsq7mN94mgNw+aLsreqXO02pO0DKiMhns4QulUTwu
	5dJ7wSV56TcCcb3hiWdQR3SYsBuIElnU1T73JpcynJOBJRl840gxErgHACc4HNsQqkga6S1tj3c
	V3jqO5Jj2UOh384e60ycsWeLlCzf1onXajmrclUPmwap5goWhiAfpmwPc2He9UIoMo4KNyZxFrJ
	J
X-Google-Smtp-Source: AGHT+IHZuyggkmPqrQGrGAUy7Y06HBEeAVytcb7xb+U7eWde81LwLef59gm2Mn288clBZJ6aSWdajg==
X-Received: by 2002:a05:6830:914:b0:72b:a465:d955 with SMTP id 46e09a7af769-72bfbdc7d99mr447313a34.12.1742338337879;
        Tue, 18 Mar 2025 15:52:17 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:10 -0500
Subject: [PATCH v2 02/10] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-2-4b605427774c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MymKfg9hNdh7VEIVG5aw3IyW7Bibo8midSILlV4WG+E=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkcpJMq2rXU95PQB6TEGoJ22ZJZHkAdMUEdB
 d+M7ZlvgiWJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAO+9A/+ItmzaIp+mvBlYOaQ0EVK1pPYXT9Ef/+hE05DhnQ
 /X1qg7hTt9WlpdYgq56g6OVsvu58Ya+R9Ha6OG/7/7X1Q/Bkx5VflVXQInblBfYqXOyFHjG4CKv
 EJ10ellc80Ja5FDifbJjam5YXMJbUzOj+aU5+2oxnO/l0ouPj7F7CH6ktuNA4zqg2OS8zR7L71/
 D8qo6wTGBxCdj07xLCNup90hz+CSFoT9yP9oMNOCi7btpRYASauKOyWOrCTOVK2reIAGe3LUFXy
 vpvf7Y1zWoGS5eM2kNf8FqhfZXw6zS7+K0zEZ6V28fZbsNlEMdZCkxOHIb7l7VyFaGodREU0VLD
 UvMu6STQB1g0Lx/6TxaI9jT5d70vmTbxUraLkUrfzokC3IxeXkBADFu/CDeM6p39uz1nmp/fksP
 iu1IJMCvOHAvMAV10YVRQgY/u3d86kndlceWf7xrj3OpwPN07AgAF9+7CsTBLvc1I0FscVaNCgD
 eXnxDtqyMY12MOiDhASlwxZXcw+aXDXZWM6ONtR3fVlufQEJGL3zRwTpefw0wNxhIQn6LtCQ2Fa
 8cc7kJ00DMTkiwuW0QiIAhpNTYzhA2lDo9bWw+umVCq3jkgBDcXQ/XyOslGir8FxWtEKvlLhRY6
 yDvV1G1juaePJO8eo4A2jpjEGs0Kx/0FQj7/s5qLAohA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add missing error check in ad7606B_sw_mode_config().

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 885bf0b68e7775c5f4a12dfb827f502d5f782e8c..c028e08efe2c82cd97249f98eec50a9a9c06471f 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -174,11 +174,13 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
 
 	/* Configure device spi to output on a single channel */
-	st->bops->reg_write(st,
-			    AD7606_CONFIGURATION_REGISTER,
-			    AD7606_SINGLE_DOUT);
+	ret = st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
+				  AD7606_SINGLE_DOUT);
+	if (ret)
+		return ret;
 
 	/*
 	 * Scale can be configured individually for each channel

-- 
2.43.0


