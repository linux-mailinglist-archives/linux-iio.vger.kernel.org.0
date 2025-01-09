Return-Path: <linux-iio+bounces-14065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD2A08012
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4237A3A7040
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115B19E7F8;
	Thu,  9 Jan 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n4IrSBhV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51BBA2D
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448451; cv=none; b=rcVGKA03nXjNGGCroLtINlSesASySELyo4Nyz/w214GPb7mORRc9in3cqo3zZECUxMjqYYanQ9BXdy1RC1WGQVegFDyR+yH4SUCsdE7owYOA/cRXmvL8qe1AZxOU62AnhTg3/SJw7fqKEnK6+bZcv5XGVlj3OrU6N/caHkwJ494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448451; c=relaxed/simple;
	bh=SdHLgA6hMZWHMgsbotcJ+WvghAkLReDpXCVd3Hw1HEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q84f/4v8Ev+M+NwmAlhvqdK7+cg1fJWnRToug8Q/eC5BrZ+1SsvfR4YrzohrEKW+HYuvAvFsY1kJA0hIopaDXLq2zzZJz53MEwClKvK4UDDwI1u7IgBj+Sc5e1XXf9i5tg+xA07n91yOYt75F2qIDmc0VY+ThkzlZu/lIKGvCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n4IrSBhV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6e9317a2aso191204785a.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736448446; x=1737053246; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBzfPU9gNZEbLc1BBci6q4AdbZIidQPUgRG2TRlPwYg=;
        b=n4IrSBhVmRxetI8s+H4hKi0ZYREVSuk8SC/OW2lWTBgxeOwmCkIjbUTStGhrDv4zLO
         hIKMqenpeYPha6mBXqtL9M5NmZvGJ1Krb3aChFg5ylVr1Oc8OqveCdD1wxr8M7D75UFW
         9aS+KoM/miz+NFKnkCV5wdK151ScRYbQAc/Z3thEgOEQc6ctO9S3CHH026cBCyJiiPyh
         pLRB89+FfgeITBYg0uDOEdrpGrXiwhglU0qudmYangScxIJNtu7pHUaduXnBOoF0DdDj
         LiY+ZLyM/bdjI/ZAGa3vksBBcdQIKgWGK5HtQrgqZgUM1npGIoEG+GIaFusfIozrQIz1
         e8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448446; x=1737053246;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBzfPU9gNZEbLc1BBci6q4AdbZIidQPUgRG2TRlPwYg=;
        b=vtf+FJ7I3HedgA1A3IefiLiOppnzOIzZM8WoILJYAvbvln6UUJHhK0wJCww0iCOdI6
         7dHS3QQg+gbfvjqntevTXESrBUSfGUc+W8doLma//3euSilDP4cs9evqaSrkcp3C94YL
         9VrcFk6tN8khMcalpc1EJFtZcj1P9PGUFw4HVVbOjvqAbpIUXKaLK/HlqWeCzKK0sQkn
         M+z628F/gtJMzMcALmhWs1HbYN7H48hlCwdUyHOsgP/L64uofxA/4WANZGryI7i3aGub
         P7ur74xXHP0ACJdCA7AwBGbzGFsF/IFIFkjhVWihFOrw7DVdyvwZrQjJ2mjb+8fWowB4
         nH0w==
X-Gm-Message-State: AOJu0YyPDj3ezsx8UlOlY7NnaUlofkoxI9uCqE7foFgh6l7tNynxkMof
	U0Leyx1rWU8tDTD0gpYjyNtR2EjeeTrgKJvoddh/QACtzXXGYbM8+ORHErQahQ8=
X-Gm-Gg: ASbGncsQc9nnDN2iTZEzRPC8rCfUIzeNFsjp8wtu1tBjbrBxcdQbJ8AnS2I9lRhzZ4d
	SdUyJI7emfa0oz2LmPrmo1+mkfCNxuNq8kZu0UCRHgdXgPQAP1gmzKzfyOGviCiDYYdZ3d59Syl
	omDvk8UTWjCE15nPMe1EF9auzS7XAVRpsY1I/TlZhQtw9FyIHzoW9QtK9Epf0D4aEPYGi2t0IBm
	HEQzQ7h9021X1sKmh32/T1Bj9X45q/asIOL5M1mtaNRfWHa4eLhvxbBmbV27KZwlous6vgys8ES
	fZ8kUYow/VPqKOmj
X-Google-Smtp-Source: AGHT+IHGX7Nrz9RlIt6zKZH3ez/179ERRbKkoOyF6dqrbwBF/lI8nHTn4mEoeT8UyPp04zylRgXEYQ==
X-Received: by 2002:a05:6214:468a:b0:6d8:b81c:ecc1 with SMTP id 6a1803df08f44-6dfa3a99e36mr65481166d6.13.1736448446627;
        Thu, 09 Jan 2025 10:47:26 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade733e9sm1075596d6.82.2025.01.09.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 10:47:25 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/2] iio: adc: ad4695: add oversampling support
Date: Thu, 09 Jan 2025 13:47:22 -0500
Message-Id: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALsZgGcC/32NQQ6DIBBFr2JmXRpAtLWr3qNxATLoJCoGGlJju
 HupB+jyveS/f0DEQBjhUR0QMFEkvxaQlwqGSa8jMrKFQXKphBQ3pq1qu4b5hCHqZZtpHZnsVOs
 M1tq5GspyC+joc1ZffeGJ4tuH/TxJ4mf/95JgnHHDVWPvdWP18DR6n8kEvA5+gT7n/AWYlyR6u
 QAAAA==
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add driver logic and documentation for the oversampling feature of the
AD469x parts from Analog Devices. For now, this only works with offload
support, and takes advantage of that mode's higher performance to make
oversampling possible on multiple channels with varying sampling
frequencies. Some significant rework of the driver had to be done in
order to conditionally support this feature, including use of
iio_scan_types to help determine the appropriate spi message
configurations depending on oversampling ratio.

This series depends on David's recent SPI engine changes for adding
offload support:

https://lore.kernel.org/all/20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com/

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Changes in v2:
- Removed section in cover letter about correct implementation
- Simplify math of ad4695_get_calibbias() in ad4695.c, based on
  Jonathan and David's suggestions
- Link to v1: https://lore.kernel.org/r/20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com

---
Trevor Gamblin (2):
      iio: adc: ad4695: add offload-based oversampling support
      doc: iio: ad4695: describe oversampling support

 Documentation/iio/ad4695.rst |  36 ++++-
 drivers/iio/adc/ad4695.c     | 333 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 338 insertions(+), 31 deletions(-)
---
base-commit: 0c6c3bf84f541fb4ec7097baf9eac10136f98c62
change-id: 20241217-ad4695-oversampling-2946fbe3aff3

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


