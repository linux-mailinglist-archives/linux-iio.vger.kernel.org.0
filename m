Return-Path: <linux-iio+bounces-10750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFE9A4A20
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E8BB227E3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCDA19049A;
	Fri, 18 Oct 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="kRi6T3tJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMLMIRZZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F914F9D9;
	Fri, 18 Oct 2024 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294712; cv=none; b=CJu+0gRUDkdsROereAshsIZgG5/XIJDeaOsh5XP4B0Kb6ycSVGo3AdSpwYTNvOUCCcHB4rWw8mF2Ml/CvFDpeH8prErtdVEcTiFRBmfXV67c9srFSqoFfvosxe3Wu0ZTYwlsFXjFclBS5d8X+x9dd761GzmB7eOkV13wkNG17vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294712; c=relaxed/simple;
	bh=4FPYZLVVg17Co/ie7N0rzEIkz+XXrxHLuXUTzig2iCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUKsANjBPAQmsc8WFu3qn0EYWoDgxn5pjROvmiZFayKwueCibd2Fnwf9DzezicK8L6EWftJ2Zwlu/ond2vEokWQWeR6VvmuCbQh1T6Mkz1I8wf/U3CaE8hZsXxbCXShFxaBeC3B5tTDafsxN4VA63MoPW8fsNxmkAtlOk1OIoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=kRi6T3tJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMLMIRZZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F3D013801AB;
	Fri, 18 Oct 2024 19:38:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 19:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1729294709; x=1729381109; bh=+J57weygeT
	grY1yTeItGKwPc6oaJWjw+mzCVb0ceK7A=; b=kRi6T3tJYvZk37DHbNtIj5cRQE
	LrzVvnGiaHTKNMac8X7wbFd09q/rSW+QRSXCF0NS3MnjifE98nvceLN6e8d4NkrW
	4rF+z9fFBEXybAkhEudk2r2zNlJstsRdO5T8IkHOcBQn5HrmGgxguYsnWDNPiIfy
	hgT5P6T4rSVj9jeYGRq3AsVpn80ZlNeUVkLtyHXAVv2QHu6vcj3DuHhQTfAEgboJ
	oT+Ol/lGZzTp4YKHvqyF0RumIlcyJniGMlyvPrgvzPu4vjrfCho5ur0IFeec7KLz
	QplQR+HJMT1oqfFXiJtA79fFXy+IRRCZ6LlLpDf6F7oDw0Ndlsnq2MJ7kpWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729294709; x=1729381109; bh=+J57weygeTgrY1yTeItGKwPc6oaJ
	Wjw+mzCVb0ceK7A=; b=pMLMIRZZf45btg8fsYfGH9wMLmNfwNZtZKTQGyX+8SNs
	eZsMk3GDOwk04li51anI9P2506YYUZs2pSj1nIYxfFjigr59fS1bNhjjc97nDB6N
	M/CcjOzZ8HvotiUdS65jSjiSnnJ2xFbifNw+9ZhJelJn7RBt1gifN3MdXbBmXnUT
	mlciCwdRoQvOp/UmwH8t/0Luow/nfRKOIn3Zg30xpDV1npGpmuz4Qc4raAUkGDVK
	wG9FvnasuXb+RTZ4vo4mjep6a/sIGAfoPoEZ7BNERinqdETdMJXlLrlD44+pWgjK
	VuUjn70JoFeHvdf8wr6S4aZbYJ32TYdgjoD4R0cSvQ==
X-ME-Sender: <xms:dPESZ9Wrn4AR0V4n5ItfTZDaEfP8Fh6MBlq4V23oomhhjxanVAilZQ>
    <xme:dPESZ9mjr56qhxZbKs6Ljk6zt7eVK3IPIdIlvgV4gfy7JENXCc-LQ2fEgFNBrL5YM
    0qbpzlNz8bO2x8S2w>
X-ME-Received: <xmr:dPESZ5YRao-3f_A-zmN7Q6Kq7FEIyt3UG07p3MjWPo8llpnsieZjDrpQIJoDanZbu_3adysAZmO38RJuryBMzr0f-VYJOrIDAeQwkk_4bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:dPESZwWtIevAn3RcgBCh2-0jgSkZ26ch2qLO7aJzE8mqmvR24NkPuA>
    <xmx:dPESZ3ntqHGVkKLtEzBxq6KTZoenlXF3auS2_4vhqRxdE01M1P7d_Q>
    <xmx:dPESZ9duuoRhpELzlxItUsVG_SbcKk5RCUoG_GGSTe_Yi9q0S0RHaw>
    <xmx:dPESZxHtxxXF6mC0Kd5qr6FegJmYLGfJFDGbdW5gBV_bWbHmAzSZ-Q>
    <xmx:dfESZ69T_YmNCDfHMd7RmVbgD_BEIWXiBvbXCFSWTuLqFtxKCF7w5xZ3>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:26 -0400 (EDT)
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
Subject: [PATCH v2 0/6] Add i2c driver for Bosch BMI260 IMU
Date: Fri, 18 Oct 2024 16:36:06 -0700
Message-ID: <20241018233723.28757-1-justin@justinweiss.com>
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

V2
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

v1: https://lore.kernel.org/all/20241011153751.65152-1-justin@justinweiss.com/

Justin Weiss (6):
  iio: imu: bmi270: Use INFO_SAMP_FREQ instead of INFO_FREQUENCY
  iio: imu: bmi270: Provide chip info as configuration structure
  dt-bindings: iio: imu: Add Bosch BMI260
  iio: imu: bmi270: Add support for BMI260
  iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
  iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU

 .../bindings/iio/imu/bosch,bmi260.yaml        |  77 +++
 MAINTAINERS                                   |   1 +
 drivers/iio/imu/bmi270/Kconfig                |   1 +
 drivers/iio/imu/bmi270/bmi270.h               |  25 +-
 drivers/iio/imu/bmi270/bmi270_core.c          | 441 +++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  24 +-
 drivers/iio/imu/bmi270/bmi270_spi.c           |  19 +-
 7 files changed, 574 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml


base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
-- 
2.47.0


