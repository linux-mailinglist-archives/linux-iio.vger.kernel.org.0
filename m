Return-Path: <linux-iio+bounces-11402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5989B1F57
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1CB2114F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019B16A956;
	Sun, 27 Oct 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="sAtW7H56";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQUeQ+8L"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED392C859;
	Sun, 27 Oct 2024 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049708; cv=none; b=ob6tqhMcxcWLDTIcW7tUxgDCkNZQVwDLfVmgderPxG2ondrkNi64aAEXtNJD18LYnK+yU7a2JxuhZfgP1DQWXQy7AtoL7VS9+XpuU/DigCCCNZ6fgesHF6RCoS4NXBre5Ve9I3fTyifRdq4qbcOcDe0JPNDlOHSK/vflSHch288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049708; c=relaxed/simple;
	bh=+QdGcc72XmgoJtLUqz1tpZ2gAv0BfhZKj6uMIcLS/aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvNA/ZEBhzeBBHWZXeetKqH4cb1SDNkvvubdZ2/52gALc3qYepm9NWp6CPrKHPYDsOOP/Xhw4IemP7+NK1hXdPMUB62DPtO3J+nsxwpfZkxd9jWZC8hhoBMee1lAEGQnGh9gchafhe18PZFPsFQWOQ4/tkCFlIMwvtQiawV3Wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=sAtW7H56; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQUeQ+8L; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DD0E114007F;
	Sun, 27 Oct 2024 13:21:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 27 Oct 2024 13:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1730049702; x=1730136102; bh=yOpK+TjSYM
	0F/8RnI16GiZns9duRSi5QdM3eOBUUnrs=; b=sAtW7H56AQ9mo6Iuno3XoeIade
	2eIPba6PsD4rKxFLtaswUqfTQI9Vk0JJtnKpeEm1iuVdRCrYCopKhTG3Li518oij
	D9MhpYUvoE1d03RYgF17dC9/XxCbRmG0IE8KTPa1LPcwRDeJe3GK55Ham5SZUhfO
	ERicFxCE8UpzZU2hHRl+9wbQl+JLMJTmrGCCduYvA7U8fUnI9+NKbqOJhrUhv4tt
	o8DMWKhBHDCnyJx2gVVqRmH0MIXQZwbdebx/WhpXTra2PQCk3ewiOepYNIiXeaXU
	KPUyHYCkCw18ayI/Niqu+/GV6j8KVzo5qarcl8rcS3qesvqMhCZmmhmdqD9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730049702; x=1730136102; bh=yOpK+TjSYM0F/8RnI16GiZns9duR
	Si5QdM3eOBUUnrs=; b=FQUeQ+8LSSeOdrJ02NBgeQad1DKnQ1K+7YdtspR/aBuj
	pfYVHBGKFO8Zany5ub7SVQDA8gDv8/nHDpQClSQK4zyieYc+tKf0Xt2Jra22R9fk
	LPZzowMdsvOQSVHsiU8O06/6U3vmGzALQYWLbivvGy1Yq8npkaBd65U0Htg5+rQQ
	cdIAPmTwNpgqnHtJ9duPz5mxX/rtdK1bMD98w7KSThO75dr4x+Lq1VOiTdUGaRcK
	eQVp1hAVuIfQhJbMrgmAC6ZTYrXpSjUGHhgO3vPi0HaAMNIlDl6g1lnA15LX1xwa
	IOMJZ+67SQ68TGVuVfVGscRsvhqcpM/zS5BBd+osfw==
X-ME-Sender: <xms:pnYeZ9_3w6k_-XKroaPAfyD30sJwp6A-0mYpf0yGPw56hfxU5eGRKg>
    <xme:pnYeZxsArYTFgZD-xJ70HviGRTlnSxNrLE73lZAMarpRIItMiF1zz0CmDm2CT3Z_3
    kbgo3ffmRJ3kjF7Bw>
X-ME-Received: <xmr:pnYeZ7ClBWbOw5oBTpo_QAzsJt5tNW-06D5PqGOC2INpjZH2WSz2UwkLdfOojnSfJlKyanhx1v3Ke4ZmiXfl8dkvkz-Q5ZW4JpMrgPIQ-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfigvih
    hsshdrtghomheqnecuggftrfgrthhtvghrnhephffhfeelheeuvdegtdelueelkeeltedv
    fefhgeevieeguedtgfetleekkedvtedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhs
    thhinhesjhhushhtihhnfigvihhsshdrtghomhdpnhgspghrtghpthhtohepudefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrghniigrnhhordgrlhgvgiesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlrghrshesmhgvthgrfhhoohdruggvpdhrtghpthhtoheprhhosghhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughr
    ihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtth
    hopehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pnYeZxcYZyaRmP_7CIJvDu8lg4wClKx9_7HaYXiXwCuB0Ms1TIUfFw>
    <xmx:pnYeZyOwAV0-8rnu4A5uLCmlJ-X1wfJ38LqmXRHNfNemC5ConRoV5A>
    <xmx:pnYeZzkNIlknz-u0CL_gu9IjeeodLq5qU5YQhyeDhd83BB-E7gcEJA>
    <xmx:pnYeZ8toipzLE1082iTE6_ZJoHCKqaFID8iFrUN_rZ5yuePmyAir4g>
    <xmx:pnYeZ8sRYD1Vx6OGDpeeogozADqnK5Ib5k_XwEyU8aeSWX3Bc4vKCPLU>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:21:40 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v4 0/4] Add i2c driver for Bosch BMI260 IMU
Date: Sun, 27 Oct 2024 10:20:21 -0700
Message-ID: <20241027172029.160134-1-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Bosch BMI260 IMU to the BMI270 device driver.

The BMI270 and BMI260 have nearly identical register maps, but have
different chip IDs and firmware.

The BMI260 is the IMU on a number of handheld PCs. Unfortunately,
these devices often misidentify it in ACPI as a BMI160 ("BMI0160," for
example), and it can only be correctly identified using the chip
ID. To avoid conflicts with the bmi160 driver, this driver will not
probe if it detects a BMI160 chip ID.

Also add triggered buffer and scale / sampling frequency attributes,
which the input tools commonly used on handheld PCs require to support
IMUs.

Like the BMI270, the BMI260 requires firmware to be provided.
Signed-off-by: Justin Weiss <justin@justinweiss.com>
---

Changelog:

V4
- Move triggered buffer and attributes patches to the front of the set
- Add more detailed commit message to DT documentation patch
- Remove ACPI IDs from SPI driver
- Remove 10EC5280 and BMI0260 ACPI IDs from I2C driver
- Add DSDT excerpt for BMI0160 ACPI ID

V3
https://lore.kernel.org/lkml/20241020220011.212395-1-justin@justinweiss.com/
- Fix: Remove SCALE and FREQUENCY attributes
- Use separate configuration structures instead of an array
- Add bmi260 as compatible ID in bmi270 dt binding doc
- Check chip ID against value in configuration instead of constant
- Update comment for DMA alignment
- Remove unreachable return statement

V2
https://lore.kernel.org/all/20241018233723.28757-1-justin@justinweiss.com/
- Fix commit titles
- Fix: Change FREQUENCY to SAMP_FREQ
- Split chip_info refactor into a separate commit from adding bmi260
- Only fail probe when BMI160 is detected
- Update chip_info based on detected chip ID
- Add BMI260 to DT documentation
- Add BMI260 to of_device_id
- Add expected BMI260 ACPI ID to the SPI driver
- Remove unused/unexpected BMI260 ACPI IDs
- Remove trailing comma for null terminators
- Use DMA_MINALIGN for channel buffer
- Read channels in bulk
- Improve for loops for detecting scale / odr attrs
- Add missing masks
- Use FIELD_GET
- Use read_avail instead of custom attrs
- Misc. formatting and line wrapping improvements

V1
https://lore.kernel.org/all/20241011153751.65152-1-justin@justinweiss.com/

Justin Weiss (4):
  iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
  iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
  dt-bindings: iio: imu: bmi270: Add Bosch BMI260
  iio: imu: bmi270: Add support for BMI260

 .../bindings/iio/imu/bosch,bmi270.yaml        |   4 +-
 drivers/iio/imu/bmi270/Kconfig                |   1 +
 drivers/iio/imu/bmi270/bmi270.h               |  10 +
 drivers/iio/imu/bmi270/bmi270_core.c          | 424 +++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c           |   9 +
 drivers/iio/imu/bmi270/bmi270_spi.c           |   2 +
 6 files changed, 448 insertions(+), 2 deletions(-)


base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
-- 
2.47.0


