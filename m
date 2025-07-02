Return-Path: <linux-iio+bounces-21236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662AAF593A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960E91C43EA1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA52287266;
	Wed,  2 Jul 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMsg5OFk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4603286D57
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462594; cv=none; b=csGSQDKSi8l1qAFhSjAFC/1e869oho26GfIMsjfNgNNij3figV/iNLO7K6P2cp6P8vuxr42bvKTmoBhSQoRwtQJIqDDnw+C62muuMHCovL6j6nSC7OeELdQKfKWtW/Bjf7OS8VcCVChXWtG/ETAPtUa7ZI+23xiEybkE+lz+3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462594; c=relaxed/simple;
	bh=uguVMOs498CfTrH9plrVHdny1EJQ4gyCxJEXAN6fCIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XF12nt/bV5fkoRi7jplax4RQaao8ViRKcj2spm/jZdlxU5jegPsK8/OI5S+3CRaHTSLPVWhcoWDqClEbXSbBa8+uYZEzjYU1QgXS3n6xpKmGcaqupS7DZh8bnbMKsDlFipU0h0r20jB2NzDoYc+ZzKfSZ7gocZ2ahS0iBd4FwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cMsg5OFk; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73a4c557d47so3352213a34.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751462590; x=1752067390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFYt4T4iLFFrKBdNoVxkXLX7CJ/267haK8Kjvmqh/Zs=;
        b=cMsg5OFkehjeWeyHp81+0gjXf1bv2s+PHAxJF188edLQkRuKce7icgaiC369lLitvl
         PYxao9E+uTg6bohRacKCQ4pCHAZacyK0qEQMCp1uj5cPclfmQ0ssq6pny4GuJ9cKMPr7
         jP2O65zo1p0tDBMM8Dj2AG270uzFfsiqWi00qTdKrKgD9F8ceDxS7Omm79TTh2pv8rgM
         Vlt01dLDW6NYd/1EqpXrKGROBDrHjtFFPlbZI1l3/9c3oB71/J/HiW0v+18XH/F9b25i
         auY2Qadx0tQy9YlHzabBGW8OFdry0/woc4WJQatOLGpOQFyAwsICnSEP+GPvkGoX877K
         WZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462590; x=1752067390;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFYt4T4iLFFrKBdNoVxkXLX7CJ/267haK8Kjvmqh/Zs=;
        b=gM4tK4ppSMLGXDHQEW9dUBE42+yEiRl3+kSLhv0VudQnjrhXZez9pgvdfI8/m9unbX
         m7ueUaKepq3cuWwkfDxeSMIdE+GkKsokxNQ1JrNsrNAPeBfmRIAtinG2ce9ZaSAA47oN
         jf3jc6xd7e1GmhJUPnSJ2q5D+bY3a93FiF0/SR2SuvT82Yv410iJT0KOCWYmNuiSinV2
         h0p00CP5dybpNOQWWGMyz+tWJZgh8+inG+RgkAgKgZmhxpcIO6Wc3m/uiWTmh1md1PZR
         OOBMK9y7S8YpxBokFh2haWEh3d+5bXL4fzTVjd8xXJCwLXIzHYnp54kv0IXniqVwuoDC
         PAPg==
X-Gm-Message-State: AOJu0YykZaSA7OcSNATRjyXsQuIpXI3YAIOgVg9AiWCCe1e8nbK2+Fth
	ZG3ibjC9S+Q3ApNPtx3p8dWVTpLNJ50jc/Hzox1e+gePSlMR6NUWMNHqj+CYGspWlA0=
X-Gm-Gg: ASbGncsnKavg8vm1Fct8mI1I81KXxbHQat/C+o0Bl/s2yxd22E3g+TeLhxhqBloVOO9
	zLKvuyLzhUO67cxVbgWFz6D7dygVIcEMtdIiQR/xrX5Z3PZvk0WAYFkzSEbNIg4zLI7YADO4pXN
	5y0DDew//uY0hLtVKlWQAhy8+W/XiEr41gQfML8qAS7C4fyJDsx7FLHaEEbNwVlu97JRwVio8LA
	rfAWGn9unlPVd2tqgCNqLe3SDZMLctugIHoKnLeFoenHwtf0lINc+a4TK6lYS28OuMn1CJsxLjV
	oKJBt1/F3bDTtkDKex4FUZhh0LMhDepXdoi4VA0Blc6fBLQF+UxHEYndM7/1k3FGwoe0
X-Google-Smtp-Source: AGHT+IHTP90D/tIbM0vI5viWghRKqSu7vf4yQyWV8XoRE6XmmGTkMX/3hx6lvhsRabQ3z3feWtHVkA==
X-Received: by 2002:a05:6830:9ca:b0:73b:2480:7eb9 with SMTP id 46e09a7af769-73b4d1ee887mr2015865a34.24.1751462589740;
        Wed, 02 Jul 2025 06:23:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb122a27sm2502107a34.62.2025.07.02.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:23:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Jul 2025 08:23:00 -0500
Subject: [PATCH] iio: adc: ad4000: don't use shift_right()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALMyZWgC/x2NwQrCMBAFf6Xs2YVNaCv4KyKSNtvmXRLJRhFK/
 93gYQ5zmTnItEKNbsNBVT8wlNzFXQZaU8i7MmJ38uInuYpnoHCIa2cUEY4lc+O3KVvC1p4Ve2q
 8xDDr6Nzkl5l66lV1w/e/uT/O8we+ax5tdgAAAA==
X-Change-ID: 20250702-iio-adc-ad4000-don-t-use-shift_right-bda6e41152b6
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uguVMOs498CfTrH9plrVHdny1EJQ4gyCxJEXAN6fCIo=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJSjbZNqWpsqz/PlWXa+Wfm8pg6+ZlrtmeX3L/y6en96
 /IpDpk+nYzGLAyMXAyyYoosbyRuzkvia74250bGDJhBrEwgUxi4OAVgIjwt7P+M+Hek/DUWV97d
 eSeHYdIndoEdB1943QuKWbYvxcBt1UTrFzu+NeSx9bHLyTMYnmrXNL23i72O5ZaP/bzLPoVC59r
 17Zvjw2+oPBaImvGvYOHz7Nl93kGyikUibCGeM+RL7ujwfFK5PlVgorF7rpvbYsfXatOffBHpNq
 hWnHzDhXvThdkLpDZdUT5euHKDR5ptm2n7/Ljga1XVP793B51lTuGI9uh7b/c0IOC9nGGT2wS3a
 P/Eo0oZv7Yp3v6/bXZL2SfZx/9iasqzj8Zuy+NYpqOu6xpY/m7Dx3uu1ccndMxbXaXOKr721W/V
 fkMPs3Z3eyffzTytOQp/lI9ELBLvyJ6h5u/Quyep9mkLAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop use of shift_right() macro for unsigned value. The shift_right()
macro is intended for signed values and is not needed for unsigned
values.

This was found by a static analysis tool [1].

Link: https://github.com/analogdevicesinc/linux/pull/2831/files#diff-c14a34a6492576d22e7192cc0f61ad0083190aeb627191596fe12462f0c6f21aR557 [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 5609a7845b6f50b5818613170df6b234f8f0c496..fd3d79fca78581e51bb904d0bcfeda3d3663ea25 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -554,7 +554,7 @@ static void ad4000_fill_scale_tbl(struct ad4000_state *st,
 	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);
 
 	/* Would multiply by NANO here but we multiplied by extra MILLI */
-	tmp2 = shift_right((u64)val * MICRO, scale_bits);
+	tmp2 = (u64)val * MICRO >> scale_bits;
 	tmp0 = div_s64_rem(tmp2, NANO, &tmp1);
 
 	/* Store scale for when span compression is disabled */

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250702-iio-adc-ad4000-don-t-use-shift_right-bda6e41152b6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


