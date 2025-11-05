Return-Path: <linux-iio+bounces-25904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BEFC34FBB
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB973BFAEF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8C30AD00;
	Wed,  5 Nov 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBelVxxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FF309EF3
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336602; cv=none; b=rVxca3qW1la091vWQABj2IrhHuuodNAY7VCYSTZdJZxxa5GTe+VuxNHuckJFAbnnHmAxHc6p5JkslUg9AKm8U0Z9Pamfca/kVFTjwsinc+SDDFfpH5u90i1ffu9OowmYhzQNTfaRmB9/NLrfHTZRie5emH/lCGvWlxkvwJypN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336602; c=relaxed/simple;
	bh=gS6xIPz8M479BtpBVAeSxbj5OrqU4iDg1eYW71KYM1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ld/gzJUbo1bMDK3z1muljDC47T5ir++RBf0BCYkHEruZr9wVy6VTpgomiSznSxQdVHPoFm3AWQ1dPqkOr1YGL9Xh6PEi6cuYs8mhvRFO+kKMo/RiiVp9oJJnPfzjqEw4f3cryl25Pi0vpt0b5u4laKwaVZgEhr8ucgAxzxSFAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBelVxxb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b727f452fffso7358966b.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336599; x=1762941399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3eqviX4sEAmzHdgVpUcR+crLH8NTo8PXV0ibEBUOSE=;
        b=MBelVxxb8BXiJ/iVgHrjZH8WQXKlnbAAEyiGLhzBxPtoNwsB5VqMhb7AoDKLr9psqa
         bUcDwid6kUVzxVykC9Qui7d5bJyVee0czhnZpP7+N28vgPZKuyfhT5fO1QVebUVszayS
         MA9wuqjY4tgq+i+FzFhuzo+Wng6bQU6EMrrmDyEa7wVJROotSBWRFn83skZhS0bA2HbL
         DkzbOBFOXOULrU28GG+lwiwRMkTyWGVWe/Fp5RD3nCYKOmU5msFz13/9G31SiUrb2oCP
         OqNpZ7lbWVXlAal+70LM92dX/uRe4Yh4Q1PA51Uy2H0Gw0feEZxcTV6wgmYoblY4xvut
         vLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336599; x=1762941399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3eqviX4sEAmzHdgVpUcR+crLH8NTo8PXV0ibEBUOSE=;
        b=qhymb8Zyq+E4mKaWMVruT1WrV13QIfBTrvvuClRsG1UkdDvl0TgxuYSMY186O/CunD
         l15UiuBH3kOQbhODTS11gn7UMCkUEeZIEisCYMirNlXXEGpCmkRnzToiEK6jCLofGg25
         osbwSGeFBgzrA8d2KJn4WmgFZL1Eu9G/wHC4+3o1Kgc3+5JevU2dLV3R8J9DQRXtgK4m
         oY6hNQHifd1Vpn5Kyh+DQ/6dNl+a+InXdiSpCU8fnmkIgblB2T2lsYfh0nGYutMDDmHa
         eXIOYeJsk8m4NCIJJX/wBCcPJGQ6ZmhbvkM/aNt7EHU4/Gn8zSzr3uyLpM/tG00gDNj9
         g8Ag==
X-Gm-Message-State: AOJu0Yy7FnzBpx80t3u7M8Wvv3zdfKkCrUIkFIwj6vkIvAiCyzNiOJLR
	zIsxB2GCLACE+gyeM/sIJQ3nl1fPeNGqnpSKq1n6fV+wtUSUInthXdzH
X-Gm-Gg: ASbGncvDBW+6291opsATBf2a+sUKLBqu1Oqi2M08uoL6FPrfTay0CBf3Pwgtcl9gSFX
	/ZwwQ+U39lSFLQwSuVcZf+GPYB7L/6Z9WWW/buwNWWTBxgfzSfVDwqORiiwt1ePlN3DWJRM2Hgq
	MTw0Fl2F1+oe+yNA13KDOAi/iJmLbP+72aBaDDSzG6XERs7Wy5OwwTWZ0JUC+VYNalaUlm3SV1v
	PDKwk4KxvRe/bROjiBLQLILQATTETxyYZm0ntcgdDHeQgolZmOSNIB3no3Cm5F1SUJFbuZiRaCc
	NSaCSXPjsXgkzmku3i0aPYqJxCk+proPDNR4nH671pXPg9TnIOJ3bXXxXGxH7kEQZchYp91G6J0
	SkWhd/b92Uq97Zz8dXMZV5nni+/p4BNBE7wGXn/HfpGZge2GYIO8+76nN3D58gR6mvVTC5JfDTb
	SokAtPj/FbD/hZO5fBtviz5PhhSAc=
X-Google-Smtp-Source: AGHT+IHXrDPosO8ZHIEZ+QZXnNFYsmuvoGI8Bg1Z3e3Hma5A+nbmYv2e2BsBP1TmnWrxy3+CUeti1g==
X-Received: by 2002:a17:907:94d2:b0:b61:e088:b560 with SMTP id a640c23a62f3a-b72155ad0c7mr755421266b.4.1762336598739;
        Wed, 05 Nov 2025 01:56:38 -0800 (PST)
Received: from localhost.localdomain ([78.211.196.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm440266866b.60.2025.11.05.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:56:38 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 0/3] iio: mpl3115: support for events
Date: Wed,  5 Nov 2025 10:56:12 +0100
Message-Id: <20251105095615.4310-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

In this v3 I updated pressure data retrieval, so that the measurements
are now stored into u8[3], thanks for the explanation in v2. Some other
small cosmetic changes as well.

Kind regards,
Antoni Pokusinski

---
Changes since v2:
(general)
* added the patch tidying up the pressure data retrieval (u8[3] used)
(patch 2/3 "add threshold support")
* includes: removed unused linux/units.h
* read_thresh: fixed comment formatting
* interrupt_handler: val_press is now u8[3] instead of __be32 

Changes since v1:
(general)
* squashed the cleanup patch
* added the patch with the documentation update
(patch 1/2 "add threshold event support")
* patch description: explained changes in locking
* read_event_config: replaced switch with ifs
* read_event_config: return as early as possible, got rid of int_en_mask
* read/write_thresh: pressure: calculation changes to comply with raw ABI
* interrupt_handler: reordered the INT_SRC_* bits in if condition
* read/write_thresh: used sizeof() and values from limits.h
* write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
* dropped the space between casting `(u8 *) &tmp`


Antoni Pokusinski (3):
  iio: mpl3115: use get_unaligned_be24 to retrieve pressure data
  iio: mpl3115: add threshold events support
  iio: ABI: document pressure event attributes

 Documentation/ABI/testing/sysfs-bus-iio |   2 +
 drivers/iio/pressure/mpl3115.c          | 225 ++++++++++++++++++++++--
 2 files changed, 214 insertions(+), 13 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


