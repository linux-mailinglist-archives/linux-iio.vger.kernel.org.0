Return-Path: <linux-iio+bounces-13318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C59EBE65
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590CB188AE58
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0F723A57B;
	Tue, 10 Dec 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi0ByZvw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219C1EE7BD;
	Tue, 10 Dec 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871089; cv=none; b=VJ1fY2D2dWHSOmeZaZCHkXLq+2MBT8S+951P0xsm1m9wkEh7Yd1hDR169Th+iNMYGBiLkAIVXIL86Jb5q7xJBsUHnf3/2ZVe9N6//xGNGVoUAli2Cefcj5/ynt2lfcEklHi3c5dM9/z9y2CTEyu7UZS/fSKPlAsnp0xE0+8u1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871089; c=relaxed/simple;
	bh=7TW3tWshDmQ8/W7HMUh4kHwonbvhYqNw/VA4qh/iOjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7Ue7J+41Xkm3cSJf8rZpLA+RDAKvzLXzpJYbkAYst9P7mrp/mXgfH6DZ4xFevlOdc5F4Tb42yTbQiNoDOVbuxWM579u99zk4vTjFc7OLxq45BT6GdxOS1ZpKYLag4DcDXlNNL7qruuyebAVQuPki3zpp/UaCDhexnQfKlYhY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi0ByZvw; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f29e2e756bso805120eaf.3;
        Tue, 10 Dec 2024 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733871086; x=1734475886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEE6TBtjTNV52zCm8G38x6GI2YSppUzVwpIheONIRC4=;
        b=Wi0ByZvw9TmPK+H4gwVnO2BoBMPId5iqirrlEXzxrqXv+ojypIyN2iTCVJYHGLjrxy
         2yXQRKSAdOdiALSWNcRVE27uBFBBMosZe7661D5WEN2CSdbx0JlsiqCSHPszWpCpr2of
         vGjrprksBTo2+hXYN+AEIVaeNhpxPPOoj4R8OMM5VQvbSgYERM370XLgDzoMXYX9t5VE
         7DFoqk6oYC8kqJXZmQe7aikoNbHKl+LKTU15uLoBU2isF9s/C2WnJha/GxOHqj3qYlRR
         O0OqMctV6PAwCSgk8w6cF3AvvwJOyuobS3IGpZU0zwH0X+LqoDkX65oDh0RB9nZHmuCw
         KS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733871086; x=1734475886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEE6TBtjTNV52zCm8G38x6GI2YSppUzVwpIheONIRC4=;
        b=GGSVjZU6MLLBTFGxMwCQK1RoPTkrRRXt2yV4BOTmi1ngt2y314OrtvG7X/dqEY79c6
         Ne2K3BurprWL8P5oKGmp9fvd7Q/8/tYfxKmS2wv6OGgC5zJ9kZ/t9BQZbN1tiyYsiF/m
         4CMeX9y5K/spRQBQlsGCqfq7dMjDVgDQGU5o44fapRuR5Sjv6pkT8F5j0ImGjm3rXWxa
         I0oa1d7XbV51MU8H163Hsqb4wohnZdgHaSQdAYyPrmJWlTXNC6Gqtc26WcT1O89krERc
         0FWlmupD35KBZcbMjTfLy2ciD/qwUfi3QY3ejTGGTvru0TLoj+JnzNvU8ug8hpUGtkdN
         5eLw==
X-Gm-Message-State: AOJu0YxGb+f/lHmKFVwskHHN55NkEZCCM6RaFI52oCs5Lv0ugRi8aIE7
	oC1jFF6FUe6b3cxIIY34twHb3kIjfUT25UklhGLqejKjmWdCeUisnpAWbA==
X-Gm-Gg: ASbGncvAVvIpaqMl+oOU0BhJ/0y7XW9QE8hW1yQ4aUlLF4unF3P0OgxgAlYy8gGAdOp
	vkp6a3CgYaOBlbtu569MeyaRv5TCWYPkpoam60TN5cFCZOwvdW0RH44/CIesE3cSFHhHySDr6Aw
	36blYZ61+TA4m4RSNiWAkfMMdZR/BkeedLJLDU9gLUhzAKBMtLs+KwA+Nby821tP7X+UKZyxEGB
	AlC5fS8V+buxX9MwEsOxmkf7hsMnMIvi9YCSKy6lpx15puxAeBf
X-Google-Smtp-Source: AGHT+IHMwiVLCWSNMEOoLUYKgpJzj/vfMrlb55mzDhYgYysv8CpQQucVZesnq7NIUEZ4Vi0nqR+A8A==
X-Received: by 2002:a05:6820:206:b0:5f2:d972:a6f5 with SMTP id 006d021491bc7-5f2da06342dmr329487eaf.1.1733871086518;
        Tue, 10 Dec 2024 14:51:26 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2a9d525f2sm1704136eaf.4.2024.12.10.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:51:26 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	andre.przywara@arm.com,
	lee@kernel.org,
	wens@csie.org,
	sre@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
Date: Tue, 10 Dec 2024 16:48:57 -0600
Message-ID: <20241210224859.58917-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

After performing a git bisect, I identified a commit that broke the
battery and charger driver for my AXP717 PMIC. This was caused by
commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").

After digging into it, it appears when mfd_add_devices was called with
a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
made by the various AXP20X power drivers would not be able to generate
a dev_name(dev) for some reason, and the iio_channel_get() call used in
the devm_ helper would fall back to making a iio_channel_get_sys()
call. After the platform ID was updated, now iio_channel_get() is no
longer falling back to iio_channel_get_sys(). At least this is my
limited understanding of what happened.

To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
that directly calls iio_channel_get_sys(), and I updated all the
affected drivers with the new routine. I then no longer experienced
any issues with the drivers on my devices.

Chris Morgan (2):
  iio: core: Add devm_ API for iio_channel_get_sys
  power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans

 drivers/iio/inkern.c                    | 18 ++++++++++++++++++
 drivers/power/supply/axp20x_ac_power.c  |  4 ++--
 drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
 drivers/power/supply/axp20x_usb_power.c |  6 +++---
 include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
 5 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.43.0


