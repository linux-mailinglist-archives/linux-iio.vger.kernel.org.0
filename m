Return-Path: <linux-iio+bounces-19073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD9AA8C32
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 08:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F755189392E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 06:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A01BCA1C;
	Mon,  5 May 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NkXT6ykL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02C1459F7;
	Mon,  5 May 2025 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426035; cv=none; b=sTy+OuCmrmedBfZTUoYaWCWKtQ2p1VtuC7NAoR/v8/s8D2z4tE9gGPFBA8Q25FnqwF4rMdIqEFqgOLdF8z1boTthyKrs8xDNxUFbiLtn8cVo72BaDz8MSkaAuXSkvhsdhLv2LJIBneMmlPpjHUxmhU2vlShnwavys6gSVGlss9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426035; c=relaxed/simple;
	bh=l0nxOgufb31in1ONbVZ8SNBKiilPv70ouEvml3UxvZk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OcFoxgmC7AfAQvTbKRsqWkl1/X3E1DN9/IftbQVkAJML6nezfPLVXaodwiTShtQEl2Jf+PfAT4TFBTABITrmJOWv8c+hP4e5DclZhypIH1frtx0x0w1MLfhyUwlOHBGEupRgtSS/QjAGOTKJjrCn+dGKE0VucpsIPTU1HNetkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NkXT6ykL; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746426023; x=1746685223;
	bh=6gC4p2VGpOcPA3d9KZlIOkx8dy/hj4qThwos84ThB/o=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=NkXT6ykLHI0fnd+O26GILIdEVzaoKuZHir3QL1j5/SdRwfWt8aZc5dUixQOi2qcW2
	 clB175pzmRca+IV15lVBu5mPuSY0tRZKlSbKNKXNTjUdFKL8ZYLvFJzFJ+9cpM1oZl
	 cxhGsF2uRg2aSjngnD3bguc+By7maAHg432LkmpoFAQhknkGlcnuJnwXrbE6ldtXIK
	 dXglQdqJ2yxtL/q1sJEko84JnJqnzayoSGTGGse3HDqm+UAbaltstbjFQzHMTFeCDB
	 j8vXzQLjWB15bMV6swHfcxkLRkc0I/iM9V52RGOJZf2L3+La8h4ahTYUM4GdzLhTKc
	 4gKd4sxr+fQDA==
X-Pm-Submission-Id: 4ZrWbm6sJ5zLT
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 0/2] iio: accel: fxls8962af: Fix temperature readings
Date: Mon, 05 May 2025 08:20:18 +0200
Message-Id: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJYGGgC/12MQQ6CMBBFr0Jmbc202BJccQ/jommnMImCaU2DI
 dzdQlyou3mT/94CiSJTgnO1QKTMiaexQH2owA127EmwLwwKlUaNUoT5lkSNDYXaG49GQ5k+IgW
 e98zlWnjg9Jzia69muX3/AlmKcukTGmmxwbbterIjz0c33WErZPVtqY+lBAqSNhgdpLXG/Vjru
 r4BkohqLs8AAAA=
X-Change-ID: 20250501-fxls-307ef3d6d065
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Add the correct scale to get temperature in mili degree Celcius.
Add sign component to temperature scan element.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v3:
- Dropping define infavor of inline scale value
- Added using constants from units.h
- Tweaked commit msg to make it more assertive
- Link to v2: https://lore.kernel.org/r/20250502-fxls-v2-0-e1af65f1aa6c@geanix.com

Changes in v2:
- Correct offset is applied before scaling component 
- Added sign component to temperature scan element
- Link to v1: https://lore.kernel.org/r/20250501-fxls-v1-1-f54061a07099@geanix.com

---
Sean Nyekjaer (2):
      iio: accel: fxls8962af: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature scan element sign

 drivers/iio/accel/fxls8962af-core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250501-fxls-307ef3d6d065

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


