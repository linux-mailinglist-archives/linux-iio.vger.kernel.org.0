Return-Path: <linux-iio+bounces-7136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7E92419E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A51C22559
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44721BB682;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmSk+VmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1315B995;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932378; cv=none; b=oU6yAMdyg1gO46koBAeV3UDQDkVTi/BkO14NjmP9bJLWbHarm/gbNwskeyCPo33iY9Vz4JF9AT1tLVuLcnQjKu8nXDQqV8yl3R3wePfgx5+877wJCL9QYEiIy3JFtgg+Epz1R3Gln0yl0dDov03Hg1rNfyQ/6O9/OvsFr7DyfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932378; c=relaxed/simple;
	bh=jcgekClSNbMNhKgcEzrXZ/EyPCCRQaAQrnvaG+E2eag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oeT+w5WUgMz+U2TrpZwbUPX3FIT6slYbYjmx5mCxsTyjc6jHw0fFTVEhUp8LhgufMjC9aBWZ67JsuItFf/x2TmQjP83fOIwWEYO4gp3i4OzWmSXd6pLcs4lnenJJa+DUUvE0xI3Cc8L8Co2+NLVfuo6dU9hy/fn8WAcvYWAKu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmSk+VmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFED3C116B1;
	Tue,  2 Jul 2024 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932378;
	bh=jcgekClSNbMNhKgcEzrXZ/EyPCCRQaAQrnvaG+E2eag=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gmSk+VmCDmDmQJ7bZaDEMqgUWP3HWTGLSLZdbFwUJRa3Yoq9+u77+1aZcQP5dosco
	 tGBDi5e2ZKLykmUIbFfzTobzE7Fp6KuPunZXp8LFs/KbIlCXC6qc7B6M0wTsTkv6KG
	 yiER6mZNsa83nzzYiYh+/NqOKg0zwNx8zFr0KsvB3QStuaWu3v75EegLUSGLLR0Hzj
	 i3re4NjFygsY7t3qqqA14yI5qY31UrSsU4y91Q86QSfKukTZSrr6QDQ7S4PACshOWO
	 JOJ7lmgyWSsPrqqtdp7gLB2fEBqTvnKqwN+wHlc1zVYjhPfuND/gCk7ZSw9hSE2C9Y
	 WABJdf3o5yg4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9738C3064D;
	Tue,  2 Jul 2024 14:59:37 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] Add support for Sensirion SDP500
Date: Tue, 02 Jul 2024 16:59:07 +0200
Message-Id: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALwVhGYC/x3MQQqAIBBA0avIrBOGySi7SkRITjVQJgoRRHdPW
 r7F/w9kTsIZevVA4kuynKGgrhTMmwsra/HFQEgGWyR9OAm7BJ6yjw2iRm+XbjbWEnVQqph4kfs
 /DuP7ft/FUwBhAAAA
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719932376; l=3344;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=jcgekClSNbMNhKgcEzrXZ/EyPCCRQaAQrnvaG+E2eag=;
 b=ZxisyshPUperM+epBVMZbYObLWmXodKbAg8igdiIODh2+68BB98ztg8wAdI98sXgoitHtKy1G
 L1+EDT0GUclC7dUQkOri7ZXcN9LjpVsVOLqjOn9v7jMI80NCs/SxRRc
X-Developer-Key: i=pd.pstoykov@gmail.com; a=ed25519;
 pk=oxcGqcVV5O6wqlTh+39SbOwfbpD763i5x4TavUAHiCg=
X-Endpoint-Received: by B4 Relay for pd.pstoykov@gmail.com/20240702 with
 auth_id=179
X-Original-From: Petar Stoykov <pd.pstoykov@gmail.com>
Reply-To: pd.pstoykov@gmail.com

This patch series introduces support for Sensirion SDP500 in the IIO
subsystem. The series is split into three patches:

1. The first patch adds the device tree bindings.
2. The second patch implements the device driver.
3. The third patch updates the MAINTAINERS file.

The driver is relatively simple. It provides a way to read the measured
differential pressure directly in Pa, as the device has a fixed scale
factor of 1/60. When an applications wants to read the pressure value,
3 bytes are read from the device, 2 are data and 1 is CRC8. If the crc
check passes, the raw value is made available.

The initialization of the device just starts the measurement process.

We have been using this device and driver in a product development for
almost a year now. There the pressure is read every 25ms and is used in a
control loop. We have not even seen crc errors. We are using the
"linux-imx" repository and not the mainline one but I see no risky kernel
functions in use so it should be fine here too.

All feedback is appreciated! Thank you for taking the time to review this.

Changelog
v1->v2:
	driver code:
* Removed the use of wrapper functions for logging
* Using built-in crc function instead of a custom one
* Removed the use of a wrapper function for i2c send and receive data
* Use get_unaligned_be16 instead of custom calculation
* Removed error log if devm_iio_device_alloc fails
* indio_dev->name set directly to "sdp500"
* Updated error logging to use "dev_err_probe" in probe function
* Added a sensor readout in the probe function (first one is always bad)
* Used devm_iio_device_register instead of iio_device_register
* Removed trailing comma in "sdp500_id" data
* Deleted sdp500_remove after using devm_iio_device_register in probe
	dt-bindings:
* Fixed dt-bindings example wording
* Added vdd-supply in dt-bindings example

v2->v3:
	driver code:
* Added link to datasheet at the start of the driver code
* Removed some unnecessary defines
* Removed an unused argument of sdp500_start_measurement function
* Renamed variable that holds the received CRC to "received_crc"
* Switched to returning RAW and SCALE values instead of PROCESSED
* Change logging to use data->dev instead of indio_dev->dev.parent
* Removed unnecessary debug log of the read value from the sensor
* Added vdd regulator handling
* Added "sensirion,sdp510" as compatible
* Removed the aligning of '=' in the sdp500_driver struct
	dt-bindings:
* Added "sensirion,sdp510" as possible compatible value in dt-bindings example

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
Petar Stoykov (3):
      dt-bindings: iio: pressure: Add Sensirion SDP500
      iio: pressure: Add driver for Sensirion SDP500
      MAINTAINERS: Add Sensirion SDP500

 .../bindings/iio/pressure/sensirion,sdp500.yaml    |  41 ++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/pressure/Kconfig                       |   9 ++
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/sdp500.c                      | 153 +++++++++++++++++++++
 5 files changed, 210 insertions(+)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240702-mainline_sdp500-0d9f8c499228

Best regards,
-- 
Petar Stoykov <pd.pstoykov@gmail.com>



