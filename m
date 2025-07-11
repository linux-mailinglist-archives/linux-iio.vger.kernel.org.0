Return-Path: <linux-iio+bounces-21574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80449B02194
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BCBB60B29
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192E2DC33F;
	Fri, 11 Jul 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uOvklqnR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521B2EF677
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250706; cv=none; b=kLuqkGePHBcWRp+VTPJbQH49oUueU5WURl37B39S/PqK9j3FdFmU8beUAplfuNVHAzl9YmA0dcszcu6Mp3b70tNKoJehsWXbtvOSKLrELlSMdD4DZSN24db/pJC0n4mzb91ke3kW+6vAMoMxOIMx/1CHXCgycpX4HK7cX4EMIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250706; c=relaxed/simple;
	bh=Cle63T6Oo5Tw2DeqJ+hu2bgb3QTwH3FBeOGkiV672Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HKsiZ31ljRkX901ASB2WMwZMFu3iRNVH80Oio0N+cU3apf4wVT37YIYwnYd8aErh+XwHF2RzPQPOt7IhnB1JNm8lyCmtHs1/bQNbHxCzrhmeUeM5By6MbtaGzNmSracvMueQ8XCpdYeDpzVdwkJfwJxLCjImQIOlOoZtzXOh2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uOvklqnR; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2efa219b5bbso617606fac.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752250703; x=1752855503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkaULoFsJgrFgGT294bMe5qA/hs1W++ZH7et9nZG3CE=;
        b=uOvklqnRmOtDaRSieF1ZVU5NQo90Wp8m4vewReuQdkfK3GFaMEW+/5J1/bdeXSjQCC
         yidWWR2nd8TZg86fYyRHbngtgX++2VGswfsRYNJkIcASir1meLCs47bJys3zbUnK2/px
         Hs3aeIiNkVkUdMWpkSqWYjMbTwqMNzFuherqzavlSJDqrsdgNcWYqXNedcO8AfgWZ8Gv
         L3Vt25ms4A1GQAXDHM6bo6YLsBEVUk3Dqn7zWg557rUB2VUGC1oGFyRQa/lG7AnbfZQc
         JFg37/4F1rbPgUDVAjL1+W74x1LBg4dBpnc0xjeO7Nmloc2ljfijh1n0odGKXTdj6Rf5
         vTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250703; x=1752855503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkaULoFsJgrFgGT294bMe5qA/hs1W++ZH7et9nZG3CE=;
        b=oyW3JCFff8MlJPrh5KmC5I/yv4bkylLCvRt+NoVxx+Bk5bpQ8yOHO8Oic88F1mkRMe
         a/JfXhNa4R7B8bFZEVp4WjS9XSw5O/clXY+GIjL5BR7nY/qWcsO2ABs0lz63SnJsPK3T
         kzavuDlyi1OetIm+QN827hvICK1vJj8CPsoSnbakL5G/GDoo9lUhbC41d9ts5iZJEz71
         hGLGx7CSJZkybzsOjNmixXwRCaUnDHiM9Nh1HDzPALrjOPPmGbT4QCOa9BBI2FOwR+dd
         yrkYdLGkjMox8ZJXNN+16W6vtehEyUCT8G4c+0ImK084wGf4GxMHhB133+wE38+gqSqs
         XkGA==
X-Gm-Message-State: AOJu0Yy+b7VsIo2pDeWB/ZnGEnp4bMxrfGKrKsb0Tg3ms0eaatdkrztl
	Fx7+pr5lDsx0HEl+QkPr/H9JJlf0oe/RyR9Hsi2Um/butSvSI7DMQMlj3/0MvxoAp6HiEXpBsGN
	oAlfNjdY=
X-Gm-Gg: ASbGncsjhwcribXCZNMvHnoiqYeCFuzVLgo19oAD6P1//sytaTpdkjXtDkilotJGoL0
	7Qszi0IBJy1lk8GG5TT0wM7fyt8Hb5/7u5Pb8UAn5BJOqQS2u9GwfMUJ7IvLfe0GPY9ehEESqqp
	qzNb8vjOxPdvQo+ghsxzzwXSRxOdesIBduKHX0WKeY966Me/GedyVCVurQ5A5KBcv4MvXmBfRRU
	x069H3Cl1hpXXS0v4PGmrdmDw5grFKc6l4QuCBp2ygilUCS7W6RzecBVNF/ZmNkS+b7X/3Zrnz/
	8lVAHxUVC5ynofkGaYIOHN4Vr1MoX9W4Ie/n5xfhvrks2S5I4cs6/ym9YavnRQQ9sF46neq9k3S
	trT3n39xW9NWfRtHRBvy4heZHJxa/
X-Google-Smtp-Source: AGHT+IHDxMu3z0weN+B2hl6khrxAtBeyMDMlt4rGH4W1DiaHeJ0zXaJwL90MVeJghPqCJYhLsv1iKw==
X-Received: by 2002:a05:6871:7287:b0:2a3:c5fe:29b9 with SMTP id 586e51a60fabf-2ff26a6e976mr3789632fac.29.1752250702825;
        Fri, 11 Jul 2025 09:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11259495sm782504fac.17.2025.07.11.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 11:18:13 -0500
Subject: [PATCH] iio: proximity: isl29501: use scan struct instead of array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEQ5cWgC/x3NQQrCQAxA0auUrA1kKjLFq4gMtcnYgHYkaatQe
 ndHl2/z/wYupuJwbjYwWdW1TBXh0MAw9tNdULkaWmpPFENA1YKLCz6LyQ+JZXj0Jum25CyW3jq
 PaXaM2HXEnAMfKRLU3ssk6+f/ulz3/QvOccQnewAAAA==
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Cle63T6Oo5Tw2DeqJ+hu2bgb3QTwH3FBeOGkiV672Vg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocTlGUjdBccxhCdzwpAbLg8kaVkN60W7RZjD/m
 B7S1EjQmQ2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHE5RgAKCRDCzCAB/wGP
 wIBjCACFI8uzWwu8GhFLDuJSHx7GvQkZ4NbmmhB6B2bWtCB8ekQ8jNJ2nXDE+I/Ts9VQ5TE/i5X
 vu5Cw/M4M5MLdg0AY+JsJWz6fJ/BnlWVLSyV53f3AoIAg04kZ93oGI3BiCgDDnYxlS7Cx/2Tu9E
 zB9MueepW5xHuUz2/vo0qBghm9E5477a6SdhqVBFhDhyyaG/B3cArzlU2TrCR/GCrKeixXDt9VZ
 uHqSW7+RSpvnDnx2ksHnf8y0MWvY2VakOs/5aPRLv5V4e/QStZKAOjiuzalrdIlSWszfMw56GeH
 KB63a5xQ5hmlZCy0laRyWvjGqYy4YbbTSR2Tc3etQDN3f3W5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the scan buffer array with a struct that contains a single u32
for the data and an aligned_s64 for the timestamp. This makes it easier
to see the intended layout of the buffer and avoids the need to manually
calculate the number of extra elements needed for an aligned timestamp.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/isl29501.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index d1510fe2405088adc0998e28aa9f36e0186fafae..0eed14f66ab700473af10414b25a56458335b381 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,15 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
+	struct {
+		u32 data;
+		aligned_s64 ts;
+	} scan;
 
 	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+		isl29501_register_read(isl29501, REG_DISTANCE, &scan.data);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


