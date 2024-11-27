Return-Path: <linux-iio+bounces-12749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029009DAE41
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4DF281284
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95920125E;
	Wed, 27 Nov 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kz3HrGdL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334614B07E
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737769; cv=none; b=NoPFjJ6aOK9eCltFyUIthZiGiyP8JAZstvV3kyDH2dZPEv1yWcEjyjOdUecx7zhNp/6xnXw8EOziU2BjR59pZ2w/zKFnoY70pogGUGRJJEnTNdCFmHbfTKpA5ej5JEaO//afsd8ZFRVkZnx3C8g9FsJJpRDdHL/4rut6D/7kkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737769; c=relaxed/simple;
	bh=1ftbiftdl6ZdpQqo9ri7NZgAIFw2EbqSBDlIOrIfeWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VQoNtx40PVokaqxY5U+AG6ETcWwxqYrdQzULaGVZp3nl3G7brhcIP72F9cNt71+t3anDOmx6AKsWPwoIN6mA1S2Rs1w3MWtKckoLx71rmymiDM7AgiTFymlsXfPfQOyHhIAFvcU/t8oql8EHvuSYFaPKYbNaLv4W+Tk+p5SV7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kz3HrGdL; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29678315c06so121168fac.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732737766; x=1733342566; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Orr376RhENxaAHUP4lGmXNqSrVBuptfDyJfLhs4GHI=;
        b=kz3HrGdLkgKHTXRp9r3LgqPNJbg/qUeQdFpI9mYZG2xiqQPh5AyYS4edmx42yIB62j
         +CVQHq9ukAj2BqygUJfn2s2ydYgx3+JO6yjNGnyHbDx3hRwtDzkmrCcm4eBmV9ZvHatD
         rpeOna9T4aisYZG+K5ljTqNE7pyKms7+S18KBt9+vYum+Z/X+pOH7St0RrB+rgzFqqm6
         BPdA5FvzPCPD/N3y7S1amwivTBVQ/yN8JvoYs358wo6F4M050aR4+MQanOYuuw/ki8yU
         2Gm2Atjc1A5UHRui+XDXizKubyRM+ELz9LBSltlWGPGiwgzaAP3uhsSe67JPadQVgTUv
         Ag2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732737766; x=1733342566;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Orr376RhENxaAHUP4lGmXNqSrVBuptfDyJfLhs4GHI=;
        b=L1ev48a/aFDIpyRFSuDXqnyDnflpQpuorTRi025o9rv1Ng6xImzmIamrH3aRvPOpUB
         CPOB4FT3kyK2g2n/bjRn+RVknZstgfQtrs2QIIY1ZTTJnPH7SyVk0mKVkB44q5+381FJ
         eqqYvYBheEiHkmXztkD7mPQbb1AlSqybqERC/r36o+lArTDVD9SeerfMtlMaB3iVwG4N
         PlQDaWCEe9pigHkoUmGKxn1edEzJVxuTMY6UZonNlNwtVa5oF3wkcSW2Np3mQwF2RrZE
         WcynDe10FF3zOuy6O9c3UilvfjpHxHxXSyJroAGR6YfXsTWxNgzfbSOa4hniI6AnbnR2
         1R3g==
X-Forwarded-Encrypted: i=1; AJvYcCXuOrwGZ6JDOBoHknG3+SmnN0mDPhC9mnVSBV8rDCdJ2wJAPS7N+6sb+CY3CIjTAIFlHmj0BzgThXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohpbAt0RSE8zETgr7Y6zELB+UbLTR8jomDYJm/WnR5mBf7oek
	Syg+HpggiH2iH2tW7sdjOwehhkTE9Do9E5DW21VlWzHLLld/acMWcXb1XGnUDUo=
X-Gm-Gg: ASbGncsal7rh7gAdRGdHLi9qYalcM9ro4di3bJZSYoSqJBjhRo1V8Jdqh3wKj3ERxb1
	DPmisuJ9q6cweksQpeTv6wNpsQ/Oy99Jo1PIdvq+OyGJ2VtD1G0nhXS3nNoVaJvyK9w8/WOqhzm
	tEEUTJyRKmD5UK5nPduCLeKFNhCQpDU292Pbl6+uVOtzVYtOqEx0d6du4NjdxZgJwn3Z61bH4D2
	SDargaswvpL57zU+/JZFYzDqTS/02LKyu5BmHP7dDrHWpT32QEpRHTTQVOi5WErJdOJQBjYCko8
	Pe4oFA==
X-Google-Smtp-Source: AGHT+IGH07T7bi4UBZhWQf0rm7MH3WI1YNahfDRN+tfUO8iPG05KkPFbitS0hHlmfz/nN5IPIv0wpA==
X-Received: by 2002:a05:6870:e0cd:b0:26c:5312:a13b with SMTP id 586e51a60fabf-29dc42f5ab8mr4000169fac.30.1732737765046;
        Wed, 27 Nov 2024 12:02:45 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d6654e9sm5069542fac.24.2024.11.27.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:02:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
Date: Wed, 27 Nov 2024 14:01:52 -0600
Message-Id: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALB6R2cC/52NQQ6CMBBFr0K6dkw7hRBceQ/DgpZBJtGOaSuRE
 O5u5Qgu/uL9/Py3qUSRKalLtalICyeWUABPlfLzEO4EPBZWqLE2BhGYBYbRl7TWWJj4A0ECeAk
 pA4dJIOX49hk6pKZznSFCUuXuFamMD9WtLzxzyhLXw7yYX/uHZDGgYdSN12ixdq29umF9sIt09
 vJU/b7vX/GrPQbjAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

While working ad7124, Uwe pointed out a bug in the ad7173 driver.
static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
and was being modified during driver probe, which could lead to race
conditions if two instances of the driver were probed at the same time.

The actual fix part is fairly trivial but I have only compile tested it.
Guillaume has access to ad4111 hardware, so it would be good to get a
Tested-by from him to make sure this doesn't break anything.

---
Changes in v2:
- Fixed chip name in a few places.
- Add new simpler patch for "fix" that gets backported.
- Rebase other patches on this and incorporate feedback.
- Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com

---
David Lechner (3):
      iio: adc: ad7173: fix using shared static info struct
      iio: adc: ad7173: remove special handling for irq number
      iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct

 drivers/iio/adc/ad7173.c               | 474 +++++++++++++++++----------------
 drivers/iio/adc/ad_sigma_delta.c       |   5 +-
 include/linux/iio/adc/ad_sigma_delta.h |   2 -
 3 files changed, 249 insertions(+), 232 deletions(-)
---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


