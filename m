Return-Path: <linux-iio+bounces-2736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EAF85982F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBD6B20C6C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB86EB5F;
	Sun, 18 Feb 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxVIIPVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635111E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277616; cv=none; b=RsvB1Kt3kQmUK4B+e1EGIpL7R9o37Zyoi9HjfEhODNn7X9WomG1NHvZUQ92iQ8GoICNFNPLlWNBggIUwR3SlG9gEF8ImyJIgG2blc/wp5c3zPKeEHEr4KtTmlWJSH4JKx85ubgbvfNKg4W2A5qOFbQ39MDb8gK0Nv9lcGbfLTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277616; c=relaxed/simple;
	bh=Ufk01NXg9TVMUcW5fXn5K78iFMYCUwNmjKQNw5pT3II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQhRlRYazRuo+a0Z5eIKjThuVOWaHDl7oxIgolhoJBBW8wtjj02NDDb8YUCaHVWGScTqhr6+jRBtbJb7BdVrCznnfjabDorWmfbNi4hN80M02GooZhu/IfHLKG4YFYnfNl59eJjdC2iuLyZIKZ7dQzZbW/3Y7Km2bUH99pPjGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxVIIPVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E389AC433C7;
	Sun, 18 Feb 2024 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277615;
	bh=Ufk01NXg9TVMUcW5fXn5K78iFMYCUwNmjKQNw5pT3II=;
	h=From:To:Cc:Subject:Date:From;
	b=oxVIIPVL71uZozbg3g1qKX9TNW/GmUCYaaKTX7Ea8x4pfPm0PfwlC3v+ZFbA8pHgo
	 HMpspXRURZEYevgKePZaDFZcM3PwrR3JgeQ4SkS5FHO4vQXt1+WD3u6qK6pPxU3BwL
	 xzgWFv6AE17SvX6O23BeThDaz1nJ5dKSATQn8hWMNwZRDgsWIj/nZ4VScEfixMhiZd
	 uFLPZ5oO+WtXC4YrW8rcviz+5VZUvDavh/mcgCJ8TcVzrTkKIYBX0F/3z9igPQUtmg
	 aA11h4mqLQCW2o1felfIFio7MgR89Jp/9HAdESpR3gBW+4nWkAEkvkv54RJBjev7Xw
	 EEaVLlRXlfGbA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] IIO: Drop incorrect includes of linux/of.h
Date: Sun, 18 Feb 2024 17:33:15 +0000
Message-ID: <20240218173323.1023703-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These were false positives when I was looking at which drivers
should be converted over to fwnode based handling from
linux/property.h

None of them use anything defined in linux/of.h, so drop the include
and include more specific headers (mostly linux/mod_devicetable.h)
instead.

Jonathan Cameron (8):
  iio: light: vl6180: Drop unused linux/of.h include
  iio: light: al3320a: Drop unused linux/of.h include
  iio: light: al3010: Switch from linux/of.h to linux/mod_devicetable.h
  iio: adc: ads8688: Switch to mod_devicetable.h for struct of_device_id
    definition
  iio: accel: adxl372: Switch from linux/of.h to linux/mod_devicetable.h
  iio: accel: bma180: Switch from linux/of.h to linux/mod_devicetable.h
  iio: accel: kxsd9: Switch from linux/of.h to linux/mod_devicetable.h
  iio: dac: mcp4821: Switch to including mod_devicetable.h for struct
    of_device_id definition.

 drivers/iio/accel/adxl372_spi.c | 2 +-
 drivers/iio/accel/bma180.c      | 2 +-
 drivers/iio/accel/kxsd9-spi.c   | 2 +-
 drivers/iio/adc/ti-ads8688.c    | 2 +-
 drivers/iio/dac/mcp4821.c       | 2 +-
 drivers/iio/light/al3010.c      | 2 +-
 drivers/iio/light/al3320a.c     | 1 -
 drivers/iio/light/vl6180.c      | 1 -
 8 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.43.2


