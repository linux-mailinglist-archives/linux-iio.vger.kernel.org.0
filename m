Return-Path: <linux-iio+bounces-10828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FB9A571D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0727281F91
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638AE197A81;
	Sun, 20 Oct 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="Iy7yA2bw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBUpiVni"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB636124;
	Sun, 20 Oct 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461681; cv=none; b=ndnq86P/vR6fQy2J8pDNDJ7J8y+mtcbnxmM3qKKW73aFXbgS+wporAs7OVRonSHTnijDpGWO7YcTs/p6QS5lgoIhfYxcwK7vUGWRyQBxM74LJCI9gq0MU4FH/rGqSnqeSgP5KGzeWU5Vn0TmKrELYJ4Qwe8Or/eGTmS/pJhprDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461681; c=relaxed/simple;
	bh=SAxD+YN/nWlldSwxMzHVMubuKmQDYCkzJ911r9U5BUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O23kl/CbqGdKGp2PCbbt5G81jTw/yY78IsZcLqiKC49XkRS9SU0ee8lZiTFrUMllGnZADO1LNV5JClW487Y+J0Zyw4Ot/SZQk1DtXJL2SOEWiDb+GOMJHFBWH6tkL2DctUv6RyKTKLxdUKy4dVn2D7TKKsD49C4t+Mznwhshg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=Iy7yA2bw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBUpiVni; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97A752540086;
	Sun, 20 Oct 2024 18:01:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 18:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1729461676; x=1729548076; bh=byLw5eBOY6
	V3NDY1Eh1YvaVhZE8OQs5SHoztxFI3UsI=; b=Iy7yA2bw6DFvrSmozxtYc+D9zv
	n1T68tIqUdBcFwWJlN9re5BIFIsO9m+/dfKFPZ7ka9re/NWXO1S/oBdAC2CXGET9
	r0QqspBqJgIdjOT4m5zbar4RTEgx4lHIG6rbLN/tE26nyybIR3epc9QlJPoquNSt
	jlhjaYdXsjXCRpNdYLnpyIjNgQRRcefPzVs9OuC2dxN2Z+piAEMA7/Qp3QbpjM3E
	1PqkqfdSMe4+Su76m25o5u3FuRqeuR+QUvDYG2S3qSUX6/ByH6NelATEnZtCy5Xc
	25BSZzSDg4aZAI+raly2lnlamXlhDF0yp2/OUFkyEDIspwCNUPJ8ksOvcMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729461676; x=1729548076; bh=byLw5eBOY6V3NDY1Eh1YvaVhZE8O
	Qs5SHoztxFI3UsI=; b=RBUpiVnilrB8zypHMJUA8M671oqNjSt4NSn9YMjpKZAf
	dcRFMiMjhdefAeuEjgL1Sw6aTv9zXJ4otyQh7sl2ISkGlmn5bvw7Sj4racxA3fA7
	fpEEbc0N4hI3KAteDEJFZDQbJmvXCc391RLGLKK1s2N0T7inUCIagO3PsP+kkscu
	pM2cjK6NxYdops525fXrvA5WaaJxEZPr7qYfumREB5im+rljyvYmBT1g3MGq8C4V
	tQ5BrGAl6eq3zaRJy2Gqd1k97NwjRc6kvE/CqRt/YDZCtz0HniLlRxwmTjIXALcE
	ER+hvHd1ZkALEpolNYlN+3wf6aSvN2jwwKj52UVE4w==
X-ME-Sender: <xms:q30VZ311-PLgm0ZP2MrxfvnKnEcxJTeTq7RGQRVr-Qrl4fmcsj0Xhw>
    <xme:q30VZ2FwiqrXrDC-cR5kBnSy1jgFw6ZW2MOPe7XD8QGmrtTCyTYSEmq5YIXtpDuu3
    ydWQuvtrH3Rd0znzw>
X-ME-Received: <xmr:q30VZ35Xtaz6_mP7_7dRentBILJKTE9nguwwhjMr4vTRYGkjmvyXXMUVpJTGk9teYgD_oZKym9E8-G4n1tumoZy7s9aLdms1ct8Vbh-BGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvghish
    hsrdgtohhmqeenucggtffrrghtthgvrhhnpefhhfefleehuedvgedtleeuleekleetvdef
    hfegveeigeeutdfgteelkeekvdetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhushht
    ihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehrohgshheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhsthhi
    nhesjhhushhtihhnfigvihhsshdrtghomhdprhgtphhtthhopehlihhnuhigqdhiihhose
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q30VZ83g3KZ3xUGmZGpjiz_vFUOwdUvMxTGAUHAnERsCFFZ3AbqGVA>
    <xmx:q30VZ6GpQ71I38WruwUTlYICQ_cdCJuZam-lugvyMSVcylXF-KC3Ug>
    <xmx:q30VZ997iN-Ix-QpKDqyJfmWxQpWmrBzmOWa3rR6vAX7_J-HVnya1A>
    <xmx:q30VZ3mpmNKEvrfVxCAohE4-Unyx-glp_hxCiIQXUwxjdSaJMTx3Fg>
    <xmx:rH0VZxf6lXszr_RhUejQirlpk-2FyB26yxMmvTOXSxx3CXE8E_XEQQxT>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:14 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v3 0/6] Add i2c driver for Bosch BMI260 IMU
Date: Sun, 20 Oct 2024 15:00:04 -0700
Message-ID: <20241020220011.212395-1-justin@justinweiss.com>
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

V3
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

Justin Weiss (6):
  iio: imu: bmi270: Remove unused FREQUENCY / SCALE attributes
  iio: imu: bmi270: Provide chip info as configuration structure
  dt-bindings: iio: imu: bmi270: Add Bosch BMI260
  iio: imu: bmi270: Add support for BMI260
  iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
  iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU

 .../bindings/iio/imu/bosch,bmi270.yaml        |   4 +-
 drivers/iio/imu/bmi270/Kconfig                |   1 +
 drivers/iio/imu/bmi270/bmi270.h               |  21 +-
 drivers/iio/imu/bmi270/bmi270_core.c          | 442 +++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  24 +-
 drivers/iio/imu/bmi270/bmi270_spi.c           |  19 +-
 6 files changed, 496 insertions(+), 15 deletions(-)


base-commit: 1a8b58362f6a6fef975032f7fceb7c4b80d20d60
-- 
2.47.0


