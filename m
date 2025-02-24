Return-Path: <linux-iio+bounces-16008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B885DA422C4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852B94249A6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271871519B0;
	Mon, 24 Feb 2025 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GBGke6Hb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11698146D57
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406256; cv=none; b=NkB9/ipTLwdkNOgVtodpAghA4QVGkNj/qb/sGZx7kb2FgMW47wBbOohRkeWxeGwX0p/dPnbu/H7rCxUtF/0nbQR/KhgtFwigadSOl85ONENzlcDnSgMHGQJvDG9stUQRP1vZyUHxVyKcw+9kLkI9tzGqJRy0WjRDnTWCDhlswM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406256; c=relaxed/simple;
	bh=BRca3gj2PkpV9SyaPYi59In8bsj2B+W6naUDybav0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRKLKXFtOY/NGYqFpFPPbWtD2xlbDFSCmzIm+wbOMJUoowCVyH8DajEkiC6N5uy9qaF1sY22rhEJ0cGF8QKcOKfDvaTOuRtbcTZFkVdQ6bS/M/0s5TzV61c1MioDCKkc3vnQ55U19onfryEscJ4cbQXPCRjuHYmFilfqfH9Xgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GBGke6Hb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso6414378a12.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406253; x=1741011053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbkFCx0EfP3wBC1PETMUYmTJ23p6zOVlf0nfEfb93AM=;
        b=GBGke6HbZ/F7aYGdYldBBwzm5D6H5nXDGeiRuvFarFOCiTOAsLtErQr+dz18e8CPn3
         AX1Vg02aSEeUsWEcx7hTiWaewtFZ1p2vTVGSYzSzyAuHF3DSGlQdWU+k6bkteJpFGIPE
         KzmYOWSDCYhrw2jaXoJsRKMY2Vkq9CjI4c4n/7W5/yCn8dowwDgC4HKzWrllciVjogKQ
         KEckRNen4CnTDN2ez9omEiNx9IGnfgZW9oUxaMIORM31ED3vRYxYSc3cVLkXysGZNOBj
         J+YvCJEKUiA1qyqb6xlwg3jXewgd5Mv/UOaU7OTBdAp3k6nhyXHG7Pt7d/z8+CVakej5
         CreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406253; x=1741011053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbkFCx0EfP3wBC1PETMUYmTJ23p6zOVlf0nfEfb93AM=;
        b=EWdI2weJfsLssA4DRJ/paM+tvRc3eG6xtT+PHTahmcNLUByfdJz9GXh3gRjmIM4gBd
         IcgQ7WvFfyTrEdMJJhKkEKfghQtd+jJQTspe3SlY028LZD1gn8vnRT4neqO+bX/bp2Hx
         x9jfgXhqQSPcwHLg8nmwoF2+bsVtXupv5V4ZmQ+7smGGK1uxQLUGufmi8r3SHD/wry1N
         jNcYR8bmQPVfu/DIwuhyvA234cEvBrGJGDTcixoNC0Tctt9ZBUgCvwv77nEM6u3CKMdW
         xc/qD8V06UyTLxbwWzseTos0/w8eEl2L7ovpWAahu7u7kEnVFfMqyN0yPCNhlu2fU3Zn
         Pq4g==
X-Gm-Message-State: AOJu0YwTHozKP2ijqBe1YwgXdueu8y7cOyhMuCQThFk1b+tYV6M8QI4l
	8TCn/usr29mOuuD0YJmdxGjZ6TzntMEnBtXBlFFYcK6YKQ03FyGLRPPQ0koTXfc=
X-Gm-Gg: ASbGncsLxeczO1tc6uGlBrdF1w9dyop9GX0Mb93k96wF7JKzWgq37kY//5lifW/ZlXt
	Fial8Wy9cdUDLdSrjC4P7/t94BtshDtCmVulq5cXwFJG1mCUN/a8fLwPSRaxZUpf2MS13Qp8lWg
	LhsQjhkjzs5FcGpwgCidbYcdsi20Z3xsOGZ3llvtZ3M3N+UJUsB2Qg4ScJj0eCWbLio5/OkfyQn
	qVjJocMlWJgvSITQ9WlARb1rA7uJd4CcT0sqrGp/6jZNRTMLpQELmEr5MXkRDGG3nMdbiR6yhpk
	q/ZRCOmY2eUfQSpQ0nP+9D2Q0Vz1PpY=
X-Google-Smtp-Source: AGHT+IHel0v7CXXzVE8v6rBV9/613PJyO/r7h0m6cGahoS83gRxz4oJtIbI6wgIGljI7abaK/QLklg==
X-Received: by 2002:a05:6402:2114:b0:5db:f26d:fff1 with SMTP id 4fb4d7f45d1cf-5e0b7246e2amr10273521a12.21.1740406253171;
        Mon, 24 Feb 2025 06:10:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287e2asm18363206a12.71.2025.02.24.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 5/7] iio: adc: ad_sigma_delta: Add error checking for ad_sigma_delta_set_channel()
Date: Mon, 24 Feb 2025 15:10:16 +0100
Message-ID:  <d3dad036e55200fd38ae0233b6356b59e0c33dcd.1740405546.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
References: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=BRca3gj2PkpV9SyaPYi59In8bsj2B+W6naUDybav0vw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3R/78MFap3aZahuuOnEiK9ANmZeu2aYSD3s /vD+JeTaM+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x90QAKCRCPgPtYfRL+ Tu59B/4+Ue9wRunY0+WHjYinRQ+bfnbYEtuonwk6f2PeyAkzNa/r8QPWUhf7A3naZzgCrGfdrEP AzOeRq31BQpkLYVJ/nNVfUiPSGr08kJg1WDVTsyfOq4X/sEuUN3jv695ZB1j4s+7Zy5He2qFo3p SIEpZYL6oH+QZGWsTGNGvWB0hmbtzggTF5/QjW9GEgqEO7If+CgB3YXn0pkZx2f3VXHWh6CzGC4 gg0g9hJBgSYN7gwwIp50lGwYgdNC+bINpzeCCGJNb4DiqApOevvR1UhGv8oC+6PKuVgufgKIoMk 5dCqBmE2gcSBJyn578eCwRwArGLEl7TVnr8I/4DqPyi+Z8h/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

All other calls to ad_sigma_delta_set_channel() in ad_sigma_delta.c
check the return value afterwards. Do it for all calls.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fbe241b90f37..8be1717f034b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -391,7 +391,9 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	ret = ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	if (ret)
+		goto out_release;
 
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
@@ -432,6 +434,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
+out_release:
 	iio_device_release_direct_mode(indio_dev);
 
 	if (ret)
-- 
2.47.1


