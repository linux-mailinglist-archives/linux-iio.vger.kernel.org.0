Return-Path: <linux-iio+bounces-15672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B3A385C8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2984188B619
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB444212FA2;
	Mon, 17 Feb 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPfzpXqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17B21D598
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801806; cv=none; b=G6KuUaKjsQ922EElMDUxxBIQ15tSe1p3t2EYm59+YDU6TD6rKZmWQW4HGXMWu40a7Cv7HeoPpYR1NhBj2WQNRQM7b2hDUv4jZaJRqA5YQikN6SCF0cbLKtVAdyrA4sTmrEqcXhJolBNa3QB19GYm97pfeICKxm6LEjafSwGHHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801806; c=relaxed/simple;
	bh=duHF+YnUsljzLCfyZThw0z+/i4q1Acv5f53Nt0ayupI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBzqVhHaIlH1P7XyylNnsiWqtRZU3uqelV4s2pj29XcUAIq4WhKp+eFLexwSjtOiJ+d+n0zI438JuUrGUBDNr5/WXpyC+AchsaYgKVw7o81UYd7onFC9JcBUwoUfI/Bt4HetNZ6C7ab6O+ZPq+hB/idZNvdn9UiG0IcFm6gPRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPfzpXqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CAFC4CEE7;
	Mon, 17 Feb 2025 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801806;
	bh=duHF+YnUsljzLCfyZThw0z+/i4q1Acv5f53Nt0ayupI=;
	h=From:To:Cc:Subject:Date:From;
	b=HPfzpXqUSpbVM6A0vSdFuo9VaadkdTyaLOPR7DOa8zcqXIRoQuW3W5VEjuZIA63lY
	 uZ5dtXGgjB4fq2Br09fo7fy9f/ShfbMdeXb0aC3Mja7zUFx9rIAsnO91zqQ74ZXWPg
	 z6A56ZNYRE4Or+p2SAG8JUB6knYI8GVRTX4JdWdFVZSsOIqh4KRFl7nqn+/ihbJfdO
	 z2liy3lVxW3v1SY+vKnMXX1cRIlXRQf4xqnsC7If9nbwiUqsTUxBQglL1EY+A9Raio
	 xcrUh55kTQi7oq8b3bA074CR38WRUFCanugdWco2QWlIfP5eM5s7yt4K/4R0gwUY0+
	 CNFAqI0WdnJCw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/29] IIO: ADCs: Sparse friendly claim of direct mode
Date: Mon, 17 Feb 2025 14:16:00 +0000
Message-ID: <20250217141630.897334-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note that a number of the drivers touched in this series have no
obvious active maintainer, so it would be much appreciated if anyone
has time to take a look! It is a large series so feel free to review
any you have time to look at rather than feeling you need to look
at the whole thing!

This is effectively part 3 of what will probably be around 5 series
focused on moving from iio_device_claim/release_direct_mode() to
iio_device_claim/release_direct(). The new form is more consistent
with conditional locking semantics and sparse markings have been
added that let us detect miss-balance between claim and release.

More details can be found in the cover letter of the first series:
https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/

This series focuses on the ADC drivers.

Jonathan Cameron (29):
  iio: adc: vf610: Move claim of direct mode to caller of
    vf610_read_sample and use guard(mutex)
  iio: adc: vf610: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
  iio: adc: ti-ads1100: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ti-ads1015: Use guard(mutex) and factor out code for
    INFO_RAW
  iio: adc: ti-ads1015: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: stm32-dfsdm: Factor out core of reading INFO_RAW
  iio: adc: stm32-dfsdm: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad4030: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad7192: Factor out core of ad7192_write_raw() to simplify
    error handling.
  iio: adc: ad7192: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad7768-1: Move setting of val a bit later to avoid
    unnecessary return value check
  iio: adc: ad7768-1: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad7606: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad7791: Factor out core of ad7791_write_raw() to simplify
    error handling
  iio: adc: ad7791: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad7793: Factor out core of ad7793_write_raw() to simplify
    error handling
  iio: adc: ad7793: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad799x: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ad_sigma_delta: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: at91-sama5d2: Move claim of direct mode up a level and use
    guard()
  iio: adc: at91-sama5d2: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: max1027: Move claim of direct mode up one level and use
    guard()
  iio: adc: max1027: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: max11410: Factor out writing of sampling frequency to
    simplify errro paths.
  iio: adc: max11410: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: mxs-lradc: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: rcar: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: Switch to sparse friendly iio_device_claim/release_direct()

 drivers/iio/adc/ad4030.c           |  21 ++--
 drivers/iio/adc/ad7173.c           |   9 +-
 drivers/iio/adc/ad7192.c           | 119 ++++++++++----------
 drivers/iio/adc/ad7266.c           |   7 +-
 drivers/iio/adc/ad7298.c           |   7 +-
 drivers/iio/adc/ad7380.c           |  56 +++++-----
 drivers/iio/adc/ad7476.c           |   7 +-
 drivers/iio/adc/ad7606.c           |  14 ++-
 drivers/iio/adc/ad7768-1.c         |  10 +-
 drivers/iio/adc/ad7791.c           |  31 +++---
 drivers/iio/adc/ad7793.c           |  80 +++++++-------
 drivers/iio/adc/ad7887.c           |   7 +-
 drivers/iio/adc/ad7923.c           |   7 +-
 drivers/iio/adc/ad7944.c           |   7 +-
 drivers/iio/adc/ad799x.c           |  14 ++-
 drivers/iio/adc/ad_sigma_delta.c   |   7 +-
 drivers/iio/adc/at91-sama5d2_adc.c |  54 +++++-----
 drivers/iio/adc/dln2-adc.c         |   7 +-
 drivers/iio/adc/max1027.c          |  37 +++----
 drivers/iio/adc/max11410.c         |  72 ++++++-------
 drivers/iio/adc/mxs-lradc-adc.c    |  14 ++-
 drivers/iio/adc/rcar-gyroadc.c     |   9 +-
 drivers/iio/adc/stm32-adc.c        |   7 +-
 drivers/iio/adc/stm32-dfsdm-adc.c  |  76 +++++++------
 drivers/iio/adc/ti-adc084s021.c    |   9 +-
 drivers/iio/adc/ti-adc108s102.c    |   7 +-
 drivers/iio/adc/ti-ads1015.c       | 168 ++++++++++++-----------------
 drivers/iio/adc/ti-ads1100.c       |  44 +++-----
 drivers/iio/adc/ti-ads1298.c       |   7 +-
 drivers/iio/adc/ti-ads131e08.c     |  14 ++-
 drivers/iio/adc/ti-tlc4541.c       |   7 +-
 drivers/iio/adc/vf610_adc.c        |  36 +++----
 32 files changed, 440 insertions(+), 531 deletions(-)

-- 
2.48.1


