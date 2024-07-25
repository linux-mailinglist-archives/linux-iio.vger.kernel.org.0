Return-Path: <linux-iio+bounces-7890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125493C6A4
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E831F24388
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6B19D8BD;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlKMe7AC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2019D892;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921967; cv=none; b=qFaUfFoT0+TMfCKk/sbiMdcW9uUYmubx2YVRuMW91it/6/I2VsDjSC0p/SijQNfrAOQSiUW3IIBOWgI4M+FPKZdEaa2X0QOFH9YEGKMMcKyAayVey758xwck0i5xXx//vpM+sYNgmmPiejwNqtIa1t5SkYJN1u0S9i4uHABgFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921967; c=relaxed/simple;
	bh=SpYr0L55Hz3FjEJofLqAKNn+BX8Kmuw3pOqP/1Yo8tU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W27DEW1b4ZdkvcPI45gGwf0napjqqJ04Ukgo1U4cNNynbPN3e0HMKgvkuHP0hqSa+6HWBvo1R/IIehjH89ZBEnv4W0IMmZGwvKbheeOf36cIA1tC5pGHXsZ8xr7kD6ZocaSDRrWXNnfNdV4zsh/FI9VkW88X0/i1J6lHwGvcWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlKMe7AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD13FC116B1;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921966;
	bh=SpYr0L55Hz3FjEJofLqAKNn+BX8Kmuw3pOqP/1Yo8tU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YlKMe7ACdOyG2QKzwQ0SR0kPnJB1/q87LVz59cjSTSLQQ6f3mwg4cRciJAnuo7sBm
	 H0suiZE1NlH/xFCrV5kPjBzSjqHOHJslHSjDK+uH6PXa3sms+ut7sojvrLYjLsAXnG
	 jspev36o/UUm72OLLzkz5/rG1C3Udp5+jiUp2by2gHELtBq+Mz5BqjpkKqJGF7sUvP
	 P/y7w295U7nHYLfB2PHY/hTjxN5ewXBh3DD3UrT/NJQ77tc5mH3rHXxXUSGrzr9G/e
	 RDIOEcSxV0bQUJFeSYnF8DihqD3lU84rtD+gjd/jhT69Z9RyzCv+cbR47UFDRJJblI
	 RNGJ4WXcAcnIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA8C3DA49;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] Add support for Sensirion SDP500
Date: Thu, 25 Jul 2024 17:37:26 +0200
Message-Id: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZxomYC/3WNwQrCMBBEf6Xs2ciSRNp48j+kSE227UKblESCU
 vLvxt49vmHmzQ6JIlOCa7NDpMyJg6+gTw3YefATCXaVQaLU2KIU68B+YU+P5LYLokBnxs5qY6T
 soK62SCO/D+O9rzxzeoX4OQ6y+qX/XVmJKjQoUbdPRUS3qVaWsw0r9KWUL7d/ZH+uAAAA
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721921965; l=3607;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=SpYr0L55Hz3FjEJofLqAKNn+BX8Kmuw3pOqP/1Yo8tU=;
 b=lJYI+kAuPeQirrIkMHfHgC3Bort52h8+w01VwR/6FZudzusqFJLXyHqgpM/KgZBDrRL6pOXab
 lZJJy3D6aiPCZJbCZjfC+9YAs0cHHW+jivfVSxtUZ0a1wtOc1pgQWFD
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

Link to v3: https://lore.kernel.org/r/20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com
v3->v4:
	driver code:
* include linux/mod_devicetable.h
* limit all lines to 80 characters
* fix C++ style comment
	dt-bindings and MAINTAINERS:
* fix filename

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>

---
Petar Stoykov (3):
      dt-bindings: iio: pressure: Add Sensirion SDP500
      iio: pressure: Add driver for Sensirion SDP500
      MAINTAINERS: Add Sensirion SDP500

 .../bindings/iio/pressure/sensirion,sdp500.yaml    |  46 ++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/pressure/Kconfig                       |   9 ++
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/sdp500.c                      | 157 +++++++++++++++++++++
 5 files changed, 219 insertions(+)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240702-mainline_sdp500-0d9f8c499228

Best regards,
-- 
Petar Stoykov <pd.pstoykov@gmail.com>



