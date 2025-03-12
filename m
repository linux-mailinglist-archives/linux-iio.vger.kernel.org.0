Return-Path: <linux-iio+bounces-16746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D292AA5E3C0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788B4189FF77
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A212505CA;
	Wed, 12 Mar 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KnjDmopl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388F1E2823
	for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804738; cv=none; b=k5UUS7wB1MCFC0LrVCOSvP1mMxoZ0ptTFTk2kTrzyiSiQa/09i5q2Bnk12dWh2V1B325OI0IZYLdXCaGcAM4BYBQ4IgaPYQKlsYezGjBPigZ52H8ePXrrxv2EXInPruDlgKtiXwaZsoVlBKHLPj5zeh/tsMHQlmPQh1SPh02Qw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804738; c=relaxed/simple;
	bh=K6OHUJ/MJMnjJqYQ3RMY3JQFQnpsiuzZgsvsB29joaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6zEt+rkO5uuytg9n/1UffLTDEF9L1W6I4kq6hH8kRVCJnh6I5/tn3c/DWyw2Ls/iMd6DUgOURFJi+JFrCoYkfUODrtl8BOgQ9VSjI3j/SK2kVB/dc30KVSfJA/+o9XUkoRzbUyBn52fLLaFWT3J92fgoSnt+MqGqd4JonJEoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KnjDmopl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so721195e9.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741804733; x=1742409533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGkqUlA/hNVsM3wGnwg0HAimPyuChhV2vT9VgL5Lk0w=;
        b=KnjDmoplxy1mFEuWzuO5FT3GANs81NKkT3CLlK36bnhT+UEQy9uRznEvzgxJHGYADW
         Pz/CQszkYXrdoYFD+6cvCbKsx1mBVxsf5i/cxz3w6H1C5Oaz5gV50I9myuhMSKfJbsWY
         9/BpVP66gpYJJxNqaYk1PsopKlRppzeaNUjnTezFJr7jowlVtxSWqGZB1E0WhYVw95nZ
         +CxOKsxs8Mf0+79PX2QcpNNlOTcJiqdG2DFwWW0AW4avczLX1IfIZt/8lXdDDbxLfOPA
         xvOd+t/7YzEh0Mc6zSyygZLCDyJtVfpSDp9PylVTEhl7cDhS7p41lmmMTv/tygBPQ8Fq
         rBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804733; x=1742409533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGkqUlA/hNVsM3wGnwg0HAimPyuChhV2vT9VgL5Lk0w=;
        b=LqZKfZUf0yspRIIM/wyDqVUixVAHPSvK4nGs/JL8+WhEnz3O+DZdCKVNIXOnhrz4Wx
         kITLRjZo/8UXLGCEsG/SdSfc6jYadWe/umvi2Yg0K9eNt0xaLFh2s+WXROzIMn3GkzYY
         IRM2ov8iBkMaGNHELTBuRy2YmNLA3/Nm0joYiutdsbMz4xMs2Wsd05docXEi9kJMmpn+
         AQcDzejdD0EWuU8cJcbY3rgk1U5psbueQhxjUzCQfOo8e2kFyD9k6Viz6tAFCzJ3W82k
         dIVCvHe2DpH8laZwXqOlnZDpr4mNqyRK1pNzUbsmC8m+SMZDtRYzLZ1kd8EFogjQb0t0
         CViw==
X-Gm-Message-State: AOJu0Yz+usSHlr2c13LFZ6kjZHj8UwrVGLGSHeAmC88uQzimUKOe56zL
	pba9TLfUM/Qo3xGnecVamsl2gpN9T9QC197HvQPx08UNJdhDgTGVQybKOjIjyA0=
X-Gm-Gg: ASbGncvVG40dex01W9XfXohb+f8rr10cQz6ZhFBvjJeSMM1wMMCefm6WTEhzDnNFkW9
	oXr2m7++pgBqppfGC+/ECwabFR2IsTQ1sCvmEDwpU2+HA5IyZU012iAaXLsqNVJg/gVeepmNvMz
	3h1EnOL7JapZ0T8ZWdVP2kUk7Unz3DRHWyDp7tzZHFqW52qALJoz+R3owOi4UKHL28xEZwWNGeI
	V2tIg7sewh6u+5l/o9x4osYcueaKyIFZF+QZf7EmZ2AOae17sNPjklX9HgXlD3Xmjnnvf70Bkrv
	R2Pjt/F8fSleoRCSnGcOh7xgwJcuI1GQkkqcGl9W21g/R19ls4tDOqBHR2JYcCC7NjBjnCKcObh
	yuukTAQIHOT8MHz0DcB02cg==
X-Google-Smtp-Source: AGHT+IFSTUcNjPlNA1hpBd8lWdS+sF0vkogK8YDHdtdi75jRGft1ZXnjbUKe+hGrfGKsPIe/q99/eQ==
X-Received: by 2002:a05:6000:25e2:b0:391:4094:3806 with SMTP id ffacd0b85a97d-39140943bb4mr13497133f8f.47.1741804732907;
        Wed, 12 Mar 2025 11:38:52 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm21339586f8f.46.2025.03.12.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 11:38:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad7124: Fix 3dB filter frequency reading
Date: Wed, 12 Mar 2025 19:38:36 +0100
Message-ID: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=K6OHUJ/MJMnjJqYQ3RMY3JQFQnpsiuzZgsvsB29joaA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn0dStIWj4hBg3cEPxYv+SG0pzTFLQnWVwJXkWq jD6ZwFRZEiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9HUrQAKCRCPgPtYfRL+ TvduB/9TDMdWtPB5gUgDhDky37zhi+BWYqtodsjpV5dKuNanLTuZnWdQAabjxr+vU1NJxZD4elm WPe4l5paRNj+570OmuXU2r94AYmGcUxBQgMzb/foHtvtsFDdAr7geixEY9IDGVe1MOnPkmtyrbX 8xOIfxIJbvC6pT9n8QpUra9TKx1QjaDBF4EMlloScYJAKPOwUB6KBbdQk6JFn3ufzi28W66qqtN ecPf3VdExl5gKzxPVjavVWa1qE8rMeK9nomG5A5Op/vTIYjWuQkdK/AIPeitMKFacRDeLWKkeez zdumn0XO/4UHMt9L8vSRtjg0E8kkwbjVlifSYj8oEDSvj71C
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes another fix for the ad7124: The getter function for the
filter_low_pass_3db_frequency sysfs property used wrong factors to
calculate the f_{3dB}.

The first patch is a cleanup I implemented before I noticed the issue. I
didn't switch their ordering because I was lazy. If I continue to
discover issues in the ad7124 driver at that rate, swapping for this one
fix doesn't really matter :-)

Note the setter function is still broken. And it's worse enough that I
don't know how to fix it at all. The relevant part of the function looks
as follows:

	sinc4_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 230);
	sinc3_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 262);

	if (sinc4_3db_odr > sinc3_3db_odr) {
		new_filter = AD7124_FILTER_FILTER_SINC3;
		new_odr = sinc4_3db_odr;
	} else {
		new_filter = AD7124_FILTER_FILTER_SINC4;
		new_odr = sinc3_3db_odr;
	}

The issues I'm aware of in this function are:

 - the sinc3 factor should be 0.272 not 0.262 (which is fixed for the
   getter in patch #2)
 - for freq > 1 the if condition is always true
 - In the nearly always taken if branch the filter is set to sinc3, but
   the frequency is set for sinc4. (And vice versa in the else branch.)

Also it's unclear to me why sinc4_3db_odr > sinc3_3db_odr is the test to
decide between the two branches. Maybe something like

	if (abs(sinc4_3db_odr - current_odr) < abs(sinc3_3db_odr - current_odr))
		use_sinc4()
	else
		use_sinc3()

would make more sense.

I intend to add a filter_type property to the driver next. When this is
implemented setting the filter_low_pass_3db_frequency shouldn't be
needed any more and we can either keep the function as is (and
discourage its use) or just drop it.

Best regards
Uwe

Uwe Kleine-König (2):
  iio: adc: ad7124: Make register naming consistent
  iio: adc: ad7124: Fix 3dB filter frequency reading

 drivers/iio/adc/ad7124.c | 176 +++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 91 deletions(-)


base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
-- 
2.47.1


