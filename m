Return-Path: <linux-iio+bounces-16710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87816A5A536
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07217A76AB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935601E2312;
	Mon, 10 Mar 2025 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gN4ONqFq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A731DF268
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639402; cv=none; b=gY2BdMIH+S+gZySKa0aaYiNPo2lFjdp5nHZIqpH6Cs0lyWGcEpcvw1GJmTpAruWmjOVo3+HYxt3Dhv5atjTmI+XyJHKN3qv6plHIM1cLxUALxBhURhOMMks5mpwo8HuPbPqKtbksDKivg4QjbLJD3kvET0eVWX9YXsPuM4wwsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639402; c=relaxed/simple;
	bh=fy3YCEIhYXyfAtQCLfJyFl5dLmJOK0fZMwPIbAJdXh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdqbcVfn5xVwEniQDNkL3m7J51Vi5ODYGiDhS8nOKagtM44Z9o36GbjdwccR1gMSKvRn/L7/+GN7ISqthkCRliRw5bFlMb3pTkscUu/kQ5sgMoFZp3ByELYg80jLouDglHQQcVPU4e79BogudfuD1Tt1gOjostcTuiA5x3370do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gN4ONqFq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-601a8b6c133so670483eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639400; x=1742244200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1AkfraDMLpclf5PdJvYaweOQN0fYlysTRqs642bX38=;
        b=gN4ONqFqXpCZXYZa1f04VYSTCT1ByZqOjVf0zFSLbuSlq8bhjV2K2w2u69iYnsuEpC
         E40T7+kIbg1abNLY6P5PL8KcjfNBbY149mT/3EY4ZyBrIaJgCsP8uzI1YS7I0mB84rey
         1RvzP3jWSmh+alAbtP9WEYy+hnKSbmpQDvP3WQ0Rcx/2t/hxLMdMhsnZZcDfIpxbP/vl
         iUe7XZVrGv5WKHmgm4HBh9TRO2hr/xlnsv81eEAPzkyN5uODCTLxmxpiw3z95qR/v/Ld
         zZRYS7YB6pa7dEum1UEAhxdiH/WWVnOGnmKDiNf1hMHy2Q9uAfGraGynpGDYSPRcHXbc
         XRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639400; x=1742244200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1AkfraDMLpclf5PdJvYaweOQN0fYlysTRqs642bX38=;
        b=Ehbb14OOD0qUTKTcWBGhdeVIZMlN5cyc5rwCslPFltjpbFy1K8ra+T9/O0Q1MS72/C
         YYe9MGGNjAhQTqvXe26FGrjn4MwhdmWZrL4Qi/JBgNh4FeCcpQKW/H74fN0fRdS6WwQ9
         cm2u76Ujb95mLKY1xsLEKW7nDHKBbOJaZX86n9YyJXNNn1tdK2W9Xb+Sppx7MHFmHrXq
         IbtHTcWEhPM/lHk1Y+V5ZvDy3WPu/WR1d4C83lN46RoUnz5UI5pq/Fe42WLiE7NLcWGF
         fIaFL61lmd2IKZGFnqL09AoF05E6oxD5usmieGfLjGjf99Kl84yfut8n8GgwnT2VvmGn
         OEpg==
X-Gm-Message-State: AOJu0Yw9atYFlBiykxdORvKzaB5yNl22YKc3IzfeokwRYHVjAauN57C4
	G3HDQEjKfa2tgv3dchXfwyRyq7HBB6jjVpysgpNk5b774xpnckoeKgFK4fxZ8LQ=
X-Gm-Gg: ASbGncuGjakJeNvrnGo52HAnUbOKc93gf6Jcu99KliCfAPVyHWPh/iceqBEevbxBsVL
	13mPcW6XI0dUl1lJMT1i/fNlspeZBpiWXTOngovBJio0sbWyAEApEMtyh0jF3en67EAtcmMvhkV
	dOR5t4UjovjremeARMBfZP3Hu6Wdlvjc0obUcSPpJ5gZ2lgsPTVrxupbXE02ou1vmX37jc7ogme
	lht+K54Taoz8Mloahxj+TXztocTvJijQ5NSvtyx1Ei4VdDx5+ZGOEIs+d25jpKdgzWHA0jlMvbG
	Umu3JcCv0MdjwKW/Jff6VZbv9dC3OSyeqE4O9gdf8adgkTEW9Pl057zMytPNHzlG4tpy2m4fUyA
	s
X-Google-Smtp-Source: AGHT+IFjnN7xgqA5S6WxW9zh3aoenUjvYW1xuLxTRrObH49wacCSqx5z5F6Kj5S5n7YLILh9oajgoA==
X-Received: by 2002:a05:6808:4448:b0:3eb:5a58:9b6b with SMTP id 5614622812f47-3fa2bdc5125mr556668b6e.11.1741639399765;
        Mon, 10 Mar 2025 13:43:19 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:08 -0500
Subject: [PATCH 5/5] iio: adc: ad4030: explain rearranging raw sample data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-5-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a comment explaining why the raw sample data is rearranged in the
in the ad4030_conversion() function. It is not so obvious from the code
why this is done.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 54ad74b96c9f256a67848330f875379edc828b0b..636f9f33e66af73d102722b984dc1230e1417d1e 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -646,6 +646,12 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
 					   &st->rx_data.dual.diff[0],
 					   &st->rx_data.dual.diff[1]);
 
+	/*
+	 * If no common mode voltage channel is enabled, we can use the raw
+	 * data as is. Otherwise, we need to rearrange the data a bit to match
+	 * the natural alignment of the IIO buffer.
+	 */
+
 	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
 	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
 		return 0;

-- 
2.43.0


