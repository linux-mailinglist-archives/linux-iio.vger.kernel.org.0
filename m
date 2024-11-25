Return-Path: <linux-iio+bounces-12653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D439D8DBE
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795AA16696B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1418FC92;
	Mon, 25 Nov 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3oiHbDa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976E18E359;
	Mon, 25 Nov 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569383; cv=none; b=B6/1SuebHxqQcP3PAas8iqWAZzrAj5KlUT+oTHoKynD3AJ/TDCXfnzEVCs2jmxVVtOaeXBsxLmrwfkeUNFcd15SWPzzy+AtB3YCHwtugvfl4hGAB3guO/L8afgDHVauOq9SyJlPy77X6iVN5QNXG3IcUNFlkrfx8DZE8ZRGpZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569383; c=relaxed/simple;
	bh=Kxd3jL2agBf6vwd6iXEw4ixRCMMaFRPmxbKJl/epnLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jd5xHTXzgZ6e8Zbwuk71HBBb2RGFhiJX+pXcMhiVwtsJpvSmmXyTdsSdhhFVojhLSUxcPYaq68fditq7PLVrUFXbLnE6Ilbz0Q576DtUOlYaBebBGt//4PSUT3eNvKepc7CyTGhxrv0jTDW8kALddMO/o82UV7FkCz3fgRGjTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3oiHbDa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43494a20379so18267985e9.0;
        Mon, 25 Nov 2024 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569379; x=1733174179; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMsBq/1wIMdpWsY4RKvycz22ohmv1H7HalrPjsXNQ4=;
        b=Y3oiHbDao9/WAStszWrqRoj5XZvn4MN+GI/I43tkxgKoVCdu6ZWOjDF9xs0xDRb1ks
         Fc9xNxnXGCREC0ORjjLZvsY0jpdowilYk8PEk0fY3WqNwqPr3H/Pm55m8kGRUWR9pfb8
         XD4ZjIhkXKAZN8B/28cvbDVvvP1L6Urv7ydM22XnFnwoVllTdXXjkBvDUKM2jmW/radG
         SVL2nFyW3RdKAbypioHeNi1aqp3O/1OWbdiAWKatmy+WHGuCdvA9mOYovsJGSQIEDRYB
         oql5LxhTjc6MaBa892MtYlilPXjp8wkxtxubp7qGOPtIDd2XIMgDrI68ZbqMqa8gnzVr
         p2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569379; x=1733174179;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsMsBq/1wIMdpWsY4RKvycz22ohmv1H7HalrPjsXNQ4=;
        b=WRO7T7LHspUoJTy5eGyDF8yusr2bpfRAtK0z5awCz8f/nGw9JzJUHinEQsyoUkiVME
         zF1GbKHaUVsNk4OvxrQuRcBWKIX3zPoSI771sMddXr+tLkEDPKnWvNNV2QTWHRNQKD7T
         vBKMk1yeX8D+tyrtTwrIuEK8d9pYlS+nidkcEVhJZMdFvpC4rRE30NLWxVaCrYOsQ/nA
         DCRlUz9p8d+6FL00ktghTopN1tWEUOwfwL6xko/EWpDWft8iRuRIRreVAWRkI+At1j2W
         DJJhraX5Mig5Xk75xguH8zOZ3qW4x7Kb+A/HyTuLnD1GO56UQ7cjEcnEB9C1OFUzEInN
         VPNA==
X-Forwarded-Encrypted: i=1; AJvYcCUVuXTN/HGDkhuV2wAvwNz7rrjZTYFNDdHfuGhl23B4pSYzaLkQNN/MOuVbegDgI587ex5x2P2urXfAc/0M@vger.kernel.org, AJvYcCWudmzuZRe93jvwO4NlkH7ThSoRCajh4j5FsgH8smvNikB6T4zL1qvoGa3Gwr8XC/si8xFWBDu/@vger.kernel.org, AJvYcCXuVwfMFVEUl9MIXujXdYz28RQCLiz30Zeadid7N6iCX/NHTyZy74EiF/l/1teHWKdGbshCPEMT98U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdjOnVvZNpwTwfnVCMaP6OnmgUqsrvBZmwdw1CMQAU4Cst8ZP
	Rk/O2RLjjfpbAt2sNLTIA48YriBPMfvA7ARLYZ0s1bIZdEtGTG3jcI6mSA==
X-Gm-Gg: ASbGnct5P3aO3gFJZKprUTwqH6/pcrFocF2nhphfaETIq2Z1LoHpoKY2MzWCqXqRle8
	8T8slS5WirKWNmufpHyOE+Un9t0bLDAEycpd+zScrtmCKOO/C5a8xVQs01fAQCRHdEGkNgcIBKW
	6Ol4QhxZqbl/+7SXUl3YU4IGAYF3UzwwFRuOGR1Ud8eFKIMczJauR0Nk93PWJ0pm6+O4vMgRT8q
	FOyOHknCmfbt6SjM9hk3Q2sPH/IRQTU/wNJFXEwO9Yo0oLZgX5/7znZVTCA145B83Yw362288EW
	lWMt8KDb577lYJcJBBnK1OO+V4OjMeKYST1WG+JuSfWQgzxV1QPzUOkyo6Lgx5Uj3M1XRNu2
X-Google-Smtp-Source: AGHT+IGB8RETDchcw6OuimkuCmKRcVJzDWc3LwUAvp9NJ6vv45+EyurXC6bx3NXGhM8WVH93FDd3yQ==
X-Received: by 2002:a05:600c:4683:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-433ce39e773mr130866255e9.0.1732569378782;
        Mon, 25 Nov 2024 13:16:18 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:18 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 00/11] iio: fix information leaks in triggered buffers
Date: Mon, 25 Nov 2024 22:16:08 +0100
Message-Id: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjpRGcC/x3MQQqDMBBG4avIrA00GWnVq0gJQX/rgCaSkVIQ7
 97g8lu8d5IiC5T66qSMr6ikWGDrisYlxA+MTMXkHq6x1rERSX7Dpji8jiH6Ja1QE54vbpkxd+y
 otHvGLL/7O7yv6w8bAsvrZwAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=2576;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Kxd3jL2agBf6vwd6iXEw4ixRCMMaFRPmxbKJl/epnLY=;
 b=Qfeds1P8y7Z9EZoxpVhjj6kyCGKOkj2NI0eU9LhGGa6YSWF0m4dOV8gOfbdGulHBQ77OB+XYu
 c9kxzl+9urqAu6zc4xHO0bn6ilFif9o9yiVTh2kM7FihLDHS3oIQBy1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This issue was found after attempting to make the same mistake for
a driver I maintain, which was fortunately spotted by Jonathan [1].

Keeping old sensor values if the channel configuration changes is known
and not considered an issue, which is also mentioned in [1], so it has
not been addressed by this series. That keeps most of the drivers out
of the way because they store the scan element in iio private data,
which is kzalloc() allocated.

This series only addresses cases where uninitialized i.e. unknown data
is pushed to the userspace, either due to holes in structs or
uninitialized struct members/array elements.

While analyzing involved functions, I found and fixed some triviality
(wrong function name) in the documentation of iio_dev_opaque.

Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-huawei/ [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (11):
      iio: temperature: tmp006: fix information leak in triggered buffer
      iio: adc: ti-ads1119: fix information leak in triggered buffer
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: adc: rockchip_saradc: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: light: bh1745: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: as73211: fix information leak in triggered buffer
      iio: core: fix doc reference to iio_push_to_buffers_with_ts_unaligned

 drivers/iio/adc/rockchip_saradc.c           | 2 ++
 drivers/iio/adc/ti-ads1119.c                | 2 ++
 drivers/iio/adc/ti-ads8688.c                | 2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 +-
 drivers/iio/imu/kmx61.c                     | 2 +-
 drivers/iio/light/as73211.c                 | 3 +++
 drivers/iio/light/bh1745.c                  | 2 ++
 drivers/iio/light/vcnl4035.c                | 2 +-
 drivers/iio/pressure/zpa2326.c              | 2 ++
 drivers/iio/temperature/tmp006.c            | 2 ++
 include/linux/iio/iio-opaque.h              | 2 +-
 11 files changed, 18 insertions(+), 5 deletions(-)
---
base-commit: ab376e4d674037f45d5758c1dc391bd4e11c5dc4
change-id: 20241123-iio_memset_scan_holes-a673833ef932

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


