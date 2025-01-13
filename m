Return-Path: <linux-iio+bounces-14327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A120A0C3EF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E925188960B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2661DA0EB;
	Mon, 13 Jan 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d3xGa2HR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685621C1AAA
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804606; cv=none; b=m/dzftx0SxyVzjihuSgtspGB1lQtz51YaiwD/jL2YnBFyqYfSGbqLx+gqTDw+9fcplipcmHvBpyiuSCib4m25TT8M3pp4P+sVFD39BNpPXTs83KLx5gc76NJohwpivx5T/S1esAGvpq2Bj4wgw8+JfvpcQ1JaDwkwKybf/UxsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804606; c=relaxed/simple;
	bh=OdiGpjzJP09tM7YmDVcDCEkXRZggTC30KbXTuS8PPBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wr/rzfUXX7i3/h64pp0HSQyaYQRvYr6HghNqgIW8PLd8ehYdTSLA60zkHtEWmi/94+ieBkXVJifeJ63ZN7NOVi1Isr3+rannD5vSKtUr0OHosLyVhPGfXdMF2R/D/BG2EVeyRL8tC9kKKRCWwEVQqCI92Bh9P5qNEVQaG+LBdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d3xGa2HR; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f33ad7d6faso3408012eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736804603; x=1737409403; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s58kY+LwR2bJFi+/4PweUENo2LtXaumNnfvnmqRUW2w=;
        b=d3xGa2HRcOpPjDm+lm8E4cy3p/ZsI7E5LPJq0UGd66U54I+7oAnsocH1Tve52UY03n
         QnfbKeU9KfZLaHys8pF69P7m0Gwkysn051WB7+MEkphFZmp5uElPtQ3bbMueTL8OnoBP
         l4+IkxXXC0oq09B1fFfFPFgCDp3LEX4tHOsvY/KWOnZzjKIUJMfjfe4u3LqcF4/r0+Mi
         dtp+wxB2Y5XGTJPrz6TKfUq21Ok/q3JwMdO60Q0dlPZ82BBDO6C1zMODH7RPeHZOG2j1
         fusw1SeDaGUgiNAuZ62XjrvUB/Vw2/uxFx47i72eHQaMxbSmwqzIC6ohVktF0rSfBRY2
         uDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736804603; x=1737409403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s58kY+LwR2bJFi+/4PweUENo2LtXaumNnfvnmqRUW2w=;
        b=B6K3YTLumKFb9TQuy/wkckvxVm+tq6VlqF6nR21//CKIe9Fyi5yISDg4Nz6mW0QPHL
         ZPDfI/FTRUAedBMrnr71YRCq7YEECqFpdT4nTWRHKoBEtAaBukg8qu2GxN9Ca6UDs0dF
         EU86LzAXCIHUmXb0JAIxC98qaL5ltN4QZepjnzZmsqgB6h9TJwrhYs10N6Y/tn9Ac99z
         XLjYpi452sJsPfyuI0Ubj4Mfq2UXQ7OVmS9U1FPtGoXEd3QwVuNREZtUAejKoKb96LSN
         vIzX9xXhmNn9BtESVBkgrhqDIIpWiqxLLEpEL4GRDtf+rB46TMH9V0OMQirpznqXdrD4
         W+gg==
X-Forwarded-Encrypted: i=1; AJvYcCXY3iXU5EsoaV4t6MM8QBVv1eNTyJdjinoLp23uD/Xq4/U3zXK6MLyaaVhlEyDV/b5BE4VeXHgYuqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZM8VElsi5mDcPQTrsfY9YtwfqFx26wygsqXDx0cGHpLArSu1u
	TPo2qBaXC0nZF7YwqHShLQ4bG2fRRYeOwsda/NQsV3OEooC1FjiYwwQhBafG8Xw=
X-Gm-Gg: ASbGncuNQXrcrFYWYvB1tj2NVJ7hpFNeMwMBLo05exm0XBaut8JmNhumACSMuNRrwQ2
	ne8enS4s7nsSZXp4/91j5FdXbTLcCIiZgak54vax4Tni1gA63WRTIjTuEHrw651UZ/oMKtiD797
	XiRa8k5mikv438dgslmIQNcAvjyGrdga5jak5BaUjksuPCfmNfrvbJZl+3mWKiitj5hHDZ8VY2j
	JEQ1XVL4Rcv+BVD3y62Ylg3nzx97WGgibVDjx9uRaGmWMWglKHqCkfiQnPcPWCVVO1z2q6Egas+
	9ukfynz2h1jk
X-Google-Smtp-Source: AGHT+IFn7vbaASiL3TDyyHMyJqcrGMXpbVYhkEITvAKmqPOFBEppynaWwM+XY4X4/dPCZ7sZc3cT8w==
X-Received: by 2002:a05:6820:c8e:b0:5f6:6547:8a0f with SMTP id 006d021491bc7-5f730929358mr17181899eaf.6.1736804603494;
        Mon, 13 Jan 2025 13:43:23 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882624f77sm3606806eaf.7.2025.01.13.13.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:43:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/2] iio: adc: ad7173: fix non-const info struct
Date: Mon, 13 Jan 2025 15:43:17 -0600
Message-Id: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWIhWcC/53NwWoCMRDG8VeRnJ2SmWQ3rKe+R/GwSUYdaJOSb
 BdF9t2NglDEix5y+MLw+59V5SJc1WZ1VoVnqZJTG3a9UuEwpj2DxLYVabKIRCCSYYyhPWfQwE6
 OkHKCkFOdQNIuQ53KX5hgIO4GPyAzsWrcb+F2fEt9bds+SJ1yOd3KM15/34jMCBqi7oImQ9Y78
 +nH07f4wh8h/6hrZ6b/tnvBpmb7PjpN5J3t+ye2ududRtQv2KbZFhnDEGLE0T3Yy7JcAI+Gjua
 bAQAA
X-Change-ID: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

While working ad7124, Uwe pointed out a bug in the ad7173 driver.
static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
and was being modified during driver probe, which could lead to race
conditions if two instances of the driver were probed at the same time.

The fix from v2 has already been picked up, so these are the remaining
patches that can now be applied since the fix has made it's way back
into the iio/togreg branch.

Guillaume, since there were significant changes in this revision, it
would be nice if you could test again.

---
Changes in v4:
- Replaced patch that removes irq_line field with a different approach
  that still looks up the IRQ by name.
- Link to v3: https://lore.kernel.org/r/20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com

Changes in v3:
- Dropped first patch that was already applied.
- Fixed compile error due to spurious rebasing artifact.
- Rebased on top of latest iio tree and resolved conflicts.
- Link to v2: https://lore.kernel.org/r/20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com

Changes in v2:
- Fixed chip name in a few places.
- Add new simpler patch for "fix" that gets backported.
- Rebase other patches on this and incorporate feedback.
- Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com

---
David Lechner (2):
      iio: adc: ad7173: move fwnode_irq_get_byname() call site
      iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct

 drivers/iio/adc/ad7173.c               | 489 +++++++++++++++++----------------
 drivers/iio/adc/ad_sigma_delta.c       |  11 +-
 include/linux/iio/adc/ad_sigma_delta.h |   4 +-
 3 files changed, 266 insertions(+), 238 deletions(-)
---
base-commit: 56ea2bb4297338aa1c185696b287d384ec27c0d4
change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


