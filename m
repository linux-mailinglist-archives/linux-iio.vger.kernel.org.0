Return-Path: <linux-iio+bounces-19158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C02AA9C7B
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0FD17EC49
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2012749FB;
	Mon,  5 May 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C4LJgICt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE876274641
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472950; cv=none; b=t1qdxzyoMb1+tGRq3yXO8HhQivqF7I7vdqlZVKCT43SZibUYp/FXBqDjw5F2bsJCYAOsO9Y7UI/Q2olOZJMGE+0BX56BkU3DVjbgu/feMMljGwP/g35TRzFIjpZLK/Gxmil43Gg1g3zmWdz6vU5MV8DM3hG1CSOy2VEKY39U3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472950; c=relaxed/simple;
	bh=fqxIyfja2TG+RPVHXvxo3s5HiNJPQBH0+aehmw+7fLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBAQvjQQY3Pb3p9TyV7gA7cyKFtRIfSnS1vnsCIq/Sjwjmh2iheBgRbdxJTsEzvi+yy4go6MzVvtB7+w0oPKH2Zo4nLyolgggYmi64w9HQtchQzFSxHqNjLPTIVkXRYLcDMSXQG/Xef4WPsD2K3IuOEf8mo8++ovSaC9oL82VDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C4LJgICt; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7304efb4b3bso2773322a34.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472948; x=1747077748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GaQ0qD1htcx0uX6tZ+7jRM6UbEY8HZq4N85AjHlpNc=;
        b=C4LJgICtwgmK2mFnbZFZUSNbgz9Dq62AiOcQBPaY5qRTxS4cDT5HUbLsvkzD0YBWfu
         oNoDud4l4N8k7OcovkVnor2CBT33KuR2+vlbAFjHRx4LY6el3sLUXvPP4f2o8UC0qtx+
         2VJwhFkjdTx/2C0t0Fc6eXvflYEBAbZ7an3rdG0NdX7tOVb26wey6B9XcaLH+lwiToIR
         0zJdPWN7MXcLdg8K6u4JSOBdDk5eOoeHJOVUvm2jn1tJAecKR2q4+pF9slijfuNrDFSR
         Vx+WMEU/OrIDJWS6noVBCZrUt3xgWVfmWiCzSRei2KOQhzadrd8b7DAtSVJP6aqjp+N3
         4mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472948; x=1747077748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GaQ0qD1htcx0uX6tZ+7jRM6UbEY8HZq4N85AjHlpNc=;
        b=ApZ0mPSyYX61KUsdiqB6xixLch2u7O7YKb3EiBd+s29ZMQAUjl5CTThFCwqvdqeAhd
         HVpqOKgqdKYua4rQQHsQEabafBIa/LaftL7SVM3eGkPQfgV4LhJdikIvq8ezS6oLpVaZ
         BbflW/Bu4568gD74n+SESsQun0q2bURsoXX8SvkoQlybk8CARzxC1ZiWQh4r6SPSIZU1
         dG6f11Ltl959TdQPCUvC2dBbEd0TPuUZ3D2BClfC0WowghdPtqB5MjXdaOf74Rq1jhEK
         dDF+I/SzyfOcO6sgshC1CArFxZlgOkBTTK1qhGHGzIvMbe2D2uhf2om2rCT3Mw1VABdj
         UQdg==
X-Gm-Message-State: AOJu0YzCd8h1HqeP1NJyh8q3txFoyz51x4qieqEheCkV1gInORQtfgsx
	ioEQ4MjgWVyFDoY6jwPK+pkqtzbGhog+1oIV6b/j+Aqkkr1jLqgYGJEKs1xr1wQ=
X-Gm-Gg: ASbGncstLyRlA32mWNmGPr1QTAStJKclVX/sgOuFC1Lww1E2EfavG5P2dCQWhNYgGXs
	vE4CHj/rDXjsnDuYLMyX/j53Gaj2AB+I99ESko0FAUTcRNJUaG+0VtyvnvKI0Tv5Qty8SCuEp6U
	qCSbcaCqkQa8tAZoMvIm7/CZ5NfTsyTeTHzw6bddm3TUEtx8Rk3+jNyz+chOIJHcC6V1Skv7flL
	dmcLXKBGshm1SN044nv0y/0H6mTe9REhrBRDya5mPupjuyZ/UEJwVDozDAsRWrDKVofloKnN/s1
	JAlatHSelNwf7estwL8IFYZKLXfWYWniafOfQ61HPkaLS+3ojzfWedqx
X-Google-Smtp-Source: AGHT+IF36vY622ewxTuUs56rHIJSkbZjcvyKU7lkaOYMvBXSgM+/TfEola2PYnMEq9Ot7LzWUZeKAQ==
X-Received: by 2002:a05:6830:6404:b0:72a:4762:d387 with SMTP id 46e09a7af769-73206dc17cdmr93092a34.11.1746472947937;
        Mon, 05 May 2025 12:22:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:31 -0500
Subject: [PATCH 04/14] iio: dac: ad5761: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-4-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fqxIyfja2TG+RPVHXvxo3s5HiNJPQBH0+aehmw+7fLU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+gqLY7x/JA1itYeDfyzmzv4xLJWQO9wP30U
 TEkqvT63amJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPoAAKCRDCzCAB/wGP
 wNbKB/4s6oJCMyJE1XwZeyV/6fyZjzVKETfRWxPO1ooSaXcStBa9hAE3YJbkXDgLR7FMmZKO9Q1
 df067PKR28kz4uDdOH171gnfFusSM7V/05+d6TdQkMeE2BG/kcguVj1BaIFRlKVth+HK5EeLVFN
 qgLpQD3awB75XIz/IGoRZfrvLg8IDqMuBAyBvvIlwgqNEoAvqdgLCX/y4P9lucPJU/osiIlzQNB
 yxZKgLI9W89oAJOhCP2VJkgPSEy9O0QS5+9ik4UzUEJ7CA1OZhfKJaYJrv55Yb2oiBhCKGQ9/f9
 Oj/I56tqJpGyc1unQbbnJ1BXbv8gArOXcDyIahTliJzeu9BH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the ad5761 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5761.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 124571ba35d1021cccbcf6883cd16607ba108af9..b5d20f04f070a170d911aff65c88600bd2de5428 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -137,13 +137,11 @@ static int _ad5761_spi_read(struct ad5761_state *st, u8 addr, u16 *val)
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = &st->data[0].d8[1],
-			.bits_per_word = 8,
 			.len = 3,
 			.cs_change = true,
 		}, {
 			.tx_buf = &st->data[1].d8[1],
 			.rx_buf = &st->data[2].d8[1],
-			.bits_per_word = 8,
 			.len = 3,
 		},
 	};

-- 
2.43.0


