Return-Path: <linux-iio+bounces-23995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1CB53DFE
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D3CAC246B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1232DFA3E;
	Thu, 11 Sep 2025 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yb+hlcYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA762DF6F5
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626974; cv=none; b=tFCbTY149hcrLfwssCf/KAVLxrd6kn97LGiP98scliytwuWk9qa05D29OiDN2IO1zKXetLAyYuguPsUWFguR7dtFoIkTLboLTRRofm4rVl4gk5TzHbhGn6dUZMPpDx3v3ByxNlCWbyTETdjomZaWoMor6DIXNksD3/isJL+Ua1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626974; c=relaxed/simple;
	bh=i9T58MycddWfLe+i8zGezd6uS/EwTdKltDHiVjFrZ8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SXUS7wXNV/1Rouw24HFY1U3SAalhlOLccZaG1RBGyaOY2Qp9mGCzMjHrpGoFFw5iy+ep9X897LX4IZq8DKl3rADGd5yquspsYHl3AH0vQ2dopgYFAsCzjyC7MLkGEn8nlMHUC5gLSKefwD0v54U/fh65EKkCx4TTxd8JQSEDl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yb+hlcYe; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-746d3b0f7e5so1022024a34.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626971; x=1758231771; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRbURiGhXE1uZ4Mn6WYfEJ7/Zc33cUV1wGXM/oGq+0E=;
        b=yb+hlcYeR7RwklKNmFkCLtFEXXsEzQl8vit4jUdNbhEkgqoXSQJRZvBzryfH4Q1ZxR
         gHYS8ta5WbbLvnpXhnJxQ853xFjlrXC4shudxcnJozctXdK/u+baFsI6wUwBcZ2B5lAU
         wVPUoaYQLWfzTmltz5pznr9mpCGbDx9w/mdsk7KoAZ/XLh/nO4EedUHN0Fowpfrvf6AS
         O8swNR74/0opJoMs2rl4ee65edqG9GJ2yOaQxRch114Srm1ITYcwM6n2iZmkllw08LAo
         ylO8rrJPgQXXIckIkIPcQVQCE2PCNSnvHxBXrFQp8j3j6fzxWp5cs+3hJlI15DUNFvXV
         G3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626971; x=1758231771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRbURiGhXE1uZ4Mn6WYfEJ7/Zc33cUV1wGXM/oGq+0E=;
        b=s7fcwaq+Iegoc/0mgfLgTPqYrlGmWnoj6S/aTgpcqJiWqEmN6fBhQxeDKz1RLdKZ/o
         uXn8vfMb8w6MZxDdKGF9oqD8Pv/GdxZdAvm8AAzZg6SBoYeBcQJ8wnIBPT8Ufycji6GF
         GrchrYh7Gk0y4sNQ6nAm8oTtkAnpXE8mw4FRszRbNZWgaf2WSt5R3dMhHcAsi2V6HSbM
         KRxb4KXVKxjuO+ybfx7dkWWfxm0peLnkzj/NYu0yQmlxEOt3F4TJ21F4LmFYAlvcymc/
         zFiqgz15OthyWpml8qfNSX/5UG7CLfYGXDsN457Vf1ypTXbS2yYXFzumlht62wnOr2Lo
         jnzQ==
X-Gm-Message-State: AOJu0YyIokg5/2oyRMutUjybKn7GRMP3Y9fXA2P+Bf12BWELXIGlXzod
	FolPcaZjdJu+FvBIlWbwscJUIoCuWDr6IoM5wRCXO0K3sCtSTUoy9I6nzw5Qzp82zn0=
X-Gm-Gg: ASbGnctA5vHNjrsYiowy3K7xkDYa33h7PeDTWHMIPDrk1AwcVacJlHGShnvgH/e1UWB
	Y9EeBu5Ycrt6EcNqbi+hpGghyDWTeqDP+1njKIyp5CF6igeCSY1GzIN+5lSg+xHwsBrAt2ckck8
	9goWZ1zOh3WRAQVSp8JvZVFX9mN/VvgC/jaA8JcBk0nXpUh034EQObFcuIw7QpWtYBADR5PQDIq
	1Fp1+BiggwP1MgMFCxdCCzvWpovqTdx0FaNZTUS7sOzB54iiqjrV9P+SKZH3XWsTU++ObfgOHYo
	lFRkVkA9rsAVp8pTaAUCmIucBtBWGd30ZFN7006ksEZ2m/0oLxk0YucqEo1j0nI6Sysp+HtmgHr
	Pi3DHAAS2lYQF0fe77cpgN80yuzj5J/QJ8hNzcSg=
X-Google-Smtp-Source: AGHT+IEiWizoaiYKIcztiJLHT2BaPB6oEzT1qSw2eZsg/8bISZVAWzobBRVqHpjP27gxgjoVUwM3zg==
X-Received: by 2002:a05:6830:d0a:b0:746:d995:4e72 with SMTP id 46e09a7af769-7535269888emr558431a34.6.1757626970941;
        Thu, 11 Sep 2025 14:42:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] iio: adc: ad7124: add filter support
Date: Thu, 11 Sep 2025 16:41:59 -0500
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACdCw2gC/42QwW6DMAyGXwXlPA8SAi097T2qHkIwrSVCWBJQq
 4p3n4HTdtohcv5I9vc5bxExEEZxyd4i4EKR/MhBfWTCPsx4R6COs1CFqoqTqoDIg+ksn5NUmks
 HPQ0JA8R5mnxI0EnbYFX2tW4rwXOmgD09d8b1duSA3zOj0vEoHMZodhSTN1Aji78gHgHRuAl6b
 obeB3DzkAg2yxEHWDRIOFtTK21rKbX9as1roDbgp/Vu82hNROC7o3TJ2CnmAZ1nh5xROddE411
 shg+KyYfX/imL3BUPreI/+y8SCjCI5bnULdam+W1yW9f1B0Nxw8F3AQAA
X-Change-ID: 20250725-iio-adc-ad7124-add-filter-support-d1c9e53f64b5
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=i9T58MycddWfLe+i8zGezd6uS/EwTdKltDHiVjFrZ8s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0IqypPLuthEkCBjOWyozabWgyGq3psZE9+55
 ewwTH4b+06JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCKgAKCRDCzCAB/wGP
 wDZ7B/9ee0h11I3UlXOgekyhIPmdGV7ru6NrJMIE3f0rRwgVVnLNgzjqeSVbQT5hkefpab6Em+g
 LM9Dy8iZn2JDI+NfBF4oTAYD++dLc9H7arz7EYyX/mlxmm+ayP9FWQXM6WBZsr6tmicmVUZbBIb
 Sp+Ag8WQZvEPjxULnY1D3WUCt3ESq7+wLeJaF12cm5lk4W7SzisgHIVZhJjjb/F9sc3z2fy/60z
 /vfZxLpuQPNmUtTsphicZjGzQCEJmPk/CuYctsXf8RCiQ9alalVP+oAmALSpkOsZ2qG1XduOXwf
 luc4vFWGCadU7yZ9LkyB40zQh2CIqjZYREPktXvgTGE23+ex
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The AD7124 family of chips supports a number of different filter modes.
This series eventually gets around to adding support for selecting the
filter mode at runtime after first doing some cleanups to the existing
code.

The first 3 patches are just updating things to use newer APIs.

The 4th patch is addressing a shortcoming in the driver where the
sampling_frequency attributes were being limited to an integer value.

The 5th patch is the one that finally adds support for filter_type
and filter_type_available attributes.

And the last patch documents one new filter_type that was used that we
haven't seen before.

This applies on top of "[PATCH v4] iio: adc: ad7124: fix sample rate for
multi-channel use"

---
Changes in v2:
- Rebased on v4 depedendency.
- Added divisor local variable.
- Link to v1: https://lore.kernel.org/r/20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com

---
David Lechner (6):
      iio: adc: ad7124: use clamp()
      iio: adc: ad7124: use read_avail() for scale_available
      iio: adc: ad7124: use guard(mutex) to simplify return paths
      iio: adc: ad7124: support fractional sampling_frequency
      iio: adc: ad7124: add filter support
      iio: ABI: document "sinc4+rej60" filter_type

 Documentation/ABI/testing/sysfs-bus-iio |   1 +
 drivers/iio/adc/ad7124.c                | 383 +++++++++++++++++++++++++-------
 2 files changed, 299 insertions(+), 85 deletions(-)
---
base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
change-id: 20250725-iio-adc-ad7124-add-filter-support-d1c9e53f64b5
prerequisite-message-id: 20250910-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v4-1-8ca624c6114c@baylibre.com
prerequisite-patch-id: 780ed21c461fc7629b4eab73bede62a02e771379

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


