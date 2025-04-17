Return-Path: <linux-iio+bounces-18225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C0A92419
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B708216D72B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44C255235;
	Thu, 17 Apr 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbFhuWAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C62561A2;
	Thu, 17 Apr 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911229; cv=none; b=ec2pob2veBFq3nXB0l8iRdWNQ3cUB1ZSbnsjjuiBP6Mo6qZyXYz8YdYUVKafge+vrZdhpQs9F+o0EL3PVkbZcpQQ1h6jvHdgZL07VXCLP3TsnGY+KZJ3iauWqbj19c/73RWGiloPiws5BI7IXJHEWNVV7qsPYFntGhWCIpFv9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911229; c=relaxed/simple;
	bh=B3oiwQ06L6toD7AGLQE3aUk9GxID3uGGOBMZ1m/kEz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INeq+dc8klOOyOJjVr0mHITwDuB1Z2sg4uBUb90aZfj+9KSh21LSWj8UKzc0fvkzBe3vcdf0lluoI6mpznUME4nVwHy3c95YfXPxlAWz75SsBJxKxjZWaQn8p1ebBktbcN+D744mmJh/REWwebfZX/BqPKhr6ZQRVW16+3jqpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbFhuWAj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ed16ce246bso6157016d6.3;
        Thu, 17 Apr 2025 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744911226; x=1745516026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1UCgSsSJ9uUnGpJjZsHgiNtHFzddYOd1P3ndYRWxOk=;
        b=TbFhuWAj+lrhWLIYDwnEfqlzMCtj+/+X9/TQiP8weuzbzH1Bt89jfRTu4TBWj970oj
         MXbZ7schDjVLwrPHg2wclujq/QKkzWlGe4qHktl5hLUn237kpQBCH2shZZRteJEDAhPa
         JZTSPBVPCs0H1yIPG7Qhb3eOYExngdXLnB/rLqHJTxTMyjr48N1DKzbB+v3xh1H0o3yX
         GKDaDCJF4Ec8nNvrr2EfX+9BGx/QIgDBNAJKhazLOhI9OJ7+7GKNrHQRS+WlMoYr0qRA
         v2wVe0ES+XAEc7C6oDJTG4A1Wv6zF5f9FyHlJoSpfwawgH9344zT0+rYj+yAyS6LD/XJ
         Q73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744911226; x=1745516026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1UCgSsSJ9uUnGpJjZsHgiNtHFzddYOd1P3ndYRWxOk=;
        b=nDZMrojkYkymzrsBWQ2MmG7Jwi4L4WoOf4IHwH+fEfYXlMy2EXL871HYqCHpPFhb/B
         Lm/3SzHuGRlEEz+KDZyFJi5VQ4TZ9KVC+b7A4WYsMzMNSF4UXzQ4AV0fEkcr7uHab8aR
         shq3+8ON0kso/rXm4zLqRHNfjMINEc/ZegTtfK3xEz6+zV4V3eG52FMsDp/OHPbb07is
         MPhxBuY97plzRrxBvbfBAO6/JclJXj6WxntphqUm5WbenEd7sM8l5lXS4QU9vLd8a5ou
         4hRwtlVk2PF01oUZnfFEUy1RYDNTLCO/sXVpgdijUFHT/s37PzHzQ1vccnUE/+brolAj
         rIyA==
X-Forwarded-Encrypted: i=1; AJvYcCVddBwhKDOJuJXfNpYgbQPSVjqUOuuhqM7AZG6WiDOLPyej9nyt660Zf/djDZ/sjbSvrvfKktkT4X51yaio@vger.kernel.org, AJvYcCXaz1+JUwrDCPSiGVCmTqvl32DOIRMeCSsGA7k9+LHBFQ4BUSxtPqZtJLvQDKnwsRltjrb9cNFXJKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bLNgf8fv7UH4Um/UHJLwHUxYUstvJ6kD+xqlD+twRHxsOStR
	kqO2nfWuhcRvnGPIVx3HjaKpC75I6PFNbZI44lQVPDI3DKz1In9n
X-Gm-Gg: ASbGncv7ccWZhtzUW59g7pZJXYNRG4/83lr4vhBioHXxZMK7bMW3F4PWn/S2exr/Y5p
	nl2gnZTqBhxhJioVUl+wH7G4zdJwPzkkj+fA9AoT5p2NfSfNPY+liQ50H8XZ74yrL6VYeDndXaG
	EAl3B0oqNfoQWjr673MsPJE7HmeJ2jbCOqhdvY9VYsxw0aLoXPvZI7ZkBADFwJ3FGMg5BinO67W
	Bj4etXDZpW20zQA6OD/Uw+Bbx5W1PHvPpcjJa0BXpSTRbtdjeSH9M2zvjR5qhvvLsA53D3qXiy3
	33nFA6HYyAl02pQ13RN/1Rtb1pAL5Ru8dEzY/8wvDXxP06AHCINEX0UqhqIADVmgDA==
X-Google-Smtp-Source: AGHT+IGRC5CoH8reAVUroHZt/4NSL+Ssvd0PhZUbQ6lj1DRgpN5BrYRY0BCSdA4WUtaH5kleDzjDWQ==
X-Received: by 2002:a05:6214:e89:b0:6ea:d033:2853 with SMTP id 6a1803df08f44-6f2b2f306a3mr112410116d6.16.1744911226285;
        Thu, 17 Apr 2025 10:33:46 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c217casm1375946d6.99.2025.04.17.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:33:46 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] iio: frequency: ad9832: Remove unused parameter from data documentation
Date: Thu, 17 Apr 2025 13:33:33 -0400
Message-ID: <20250417173333.607844-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a leftover from the patch: commit 566564e80b0e ("staging: iio:
ad9832: use clock framework for clock reference").

The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
master clock (MCLK) frequency rather than relying on a frequency value
passed from platform data.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes since v2:
	- Specify driver in the title.
	- Include referenced patch.
---
 drivers/staging/iio/frequency/ad9832.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index 98dfbd9289ab8..d0d840edb8d27 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -13,7 +13,6 @@
 
 /**
  * struct ad9832_platform_data - platform specific information
- * @mclk:		master clock in Hz
  * @freq0:		power up freq0 tuning word in Hz
  * @freq1:		power up freq1 tuning word in Hz
  * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
-- 
2.43.0


