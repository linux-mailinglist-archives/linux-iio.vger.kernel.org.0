Return-Path: <linux-iio+bounces-24980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F8BD07D0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E3B4E3F12
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089E1D5CC6;
	Sun, 12 Oct 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egD7CSrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3A2D6E78;
	Sun, 12 Oct 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287371; cv=none; b=T0CpnbdUCvK26cCKRmF5Tat+3s5q+hLAFvAs1BiKFdVhmLH3xBpYtW0qoVOycckoN1w4ZrL7QIW5N4pZKBouJ5BHg+f62MTiDclouvKyQdSIPGK7Eerub6pz4jCPF2TmMA4oqPRPu8a1kIz9ewdvWAuG5Nuo5ZSPAN0B/yKKX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287371; c=relaxed/simple;
	bh=KH1K6ed429b0tgcVstjVozYrLhXWSiiDpvnYePJS+qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDU679qtu4PI1xW1X691o3Ov71vG42iOmKCLMeXyv8w2CYk31S2ZIAAjBiWnEFOZKubuBlXkrqmBleAc2HOon4Ja2TlZ5QoMzr5MeY0KIM8uUFwlwLp1y0c8aTD/2iS33HFIk5RVFAa3LkXrH/WfcTei82l3tAvulfjMzKNq7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egD7CSrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEAC4CEE7;
	Sun, 12 Oct 2025 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760287370;
	bh=KH1K6ed429b0tgcVstjVozYrLhXWSiiDpvnYePJS+qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egD7CSrTFrc+EwKLx9PSMYud/pjrIQqbs4uWHjwNgMTqEa9M+PTPOg1VRzFyuoC5u
	 /7+80LVkxl5pWKyRGMOwg90b30f2stlE2eeue0vQHwt6j6PBiocWVgd+h4/hLVmbnz
	 0UUTl3/OLyJMfB2mDBww/KCZGq4hxa3UzXTWCYQswZVB3rbMOzWIMql7qvrN8+IjPa
	 +GRCpPGQ88Dxo9MqEqQt8cRVEgouWHMY6OZ2gCAoQSoKs6/IS9t9bQ7QnxihAAnkhQ
	 /NEoLtdr7aMD2pmyo1G0yhZ8ECQrwBEP9kxTogK62zAHdOFxRgneLei4qhoFaFgoVr
	 G4dvKwbe9kHbg==
Date: Sun, 12 Oct 2025 17:42:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/9] iio: imu: new inv_icm45600 driver
Message-ID: <20251012174240.24ad54df@jic23-huawei>
In-Reply-To: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
References: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 07:20:01 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> This series add a new driver for managing InvenSense ICM-456xx 6-axis IMUs.
> This next generation of chips includes new generations of 3-axis gyroscope
> and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
> intelligent MotionTracking features like pedometer, tilt detection, and
> tap detection.
> 
> This series is delivering a driver supporting gyroscope, accelerometer and
> temperature data, with polling and buffering using hwfifo and watermark,
> on I2C, SPI and I3C busses.
> 
> Gyroscope and accelerometer sensors are completely independent and can have
> different ODRs. Since there is only a single FIFO a specific value is used
> to mark invalid data. To keep the device standard we are de-multiplexing
> data from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer
> and 1 for the gyroscope. This architecture also enables to easily turn each
> sensor on/off without impacting the other. The device interrupt is used to
> read the FIFO and launch parsing of accelerometer and gyroscope data.
> This driver relies on the common Invensense timestamping mechanism to
> handle correctly FIFO watermark and dynamic changes of settings.
> 
> The structure of the driver is quite similar to the inv_icm42600 driver,
> however there are significant reasons for adding a different driver for
> inv_icm45600, such as:
> - A completely different register map.
> - Different FIFO management, based on number of samples instead of bytes.
> - Different indirect register access mechanism.
> 
> Note that regmap cache will be added in a dedicated patch set, to avoid
> increasing too much this one.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
I fixed up the patch 1 tags thing. b4 did it for me - though it
found both an Ack and a RB from Conor. I dropped the RB as that
combination makes no sense and didn't come from the same reply from Conor.

Please be careful about picking up such tags for future series.

Series applied to the testing branch of iio.git. That will get some brief
testing by 0-day. I'll rebase that on rc1 once available and then push it
out as the togreg branch which gets picked up by linux-next.

Nice work.

Thanks,

Jonathan

> ---
> Changes in v7:
> - Fix SPI module missing header.
> - Add comments on sub-field for fifo structure.
> - Use designated initializers in odr_to_period table.
> - Fix typo.
> - Rework regmap usage in inv_icm45600_buffer_set_fifo_en.
> - Added a comment to explain why we dont use fallbacks in DT.
> - Link to v6: https://lore.kernel.org/r/20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com
> 
> Changes in v6:
> - Reviewed headers inclusion
> - Formatting (line too short, ...)
> - moving code to patch it belongs
> - kernel doc fixes
> - Comments reviewed and simplified
> - removed dev_error_probe with ENOMEM
> - fixed useless ssize_t to size_t
> - removed useless pack attribute
> - Fixed unclear or malformed if
> - Removed useless fifo_is_data_valid wrapper
> - Use available macros instead of hardcoded values
> - Link to v5: https://lore.kernel.org/r/20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com
> 
> Changes in v5:
> - Simplified device tree, removed interrupts from mandatory param list
> - Allocated regmap_bulk_read/write buffers to dma-capable memory (for indirect reg accesses)
> - Use min/max to simplify code
> - Reordered some code/include/prototypes to the patch they belong
> - Updated to latest iio_push_to_buffers_with_ts API
> - Fix build warning with clang 18.1.8
> - Fixed some alignements
> - Avoiding irq_type silly assignation
> - Simplified fwnode_irq_get_byname error management
> - Re-ordered suspend/resume process to match + comments
> - Reverted VDDIO init to make it work without PM
> - Avoid PM underflow on VDDIO when removing inv_icm456000 module, by checking suspend state
> - Link to v4: https://lore.kernel.org/r/20250814-add_newport_driver-v4-0-4464b6600972@tdk.com
> 
> Changes in v4:
> - Introduce gyro and accel in different patches.
> - Move IRQ probe to next patch.
> - Allocate fifo memory instead of static definition.
> - Rework VDDIO management to avoid underflow.
> - Rework suspend/resume using force suspend/resume API.
> - Use helper min, clamp and sizeof instead of custom implementation.
> - Re-scoping some variables, using reverse xmas tree for declarations.
> - Fix formatting: end of list, end of file, spaces, alignments.
> - Use dev_err_probe for I3C errors.
> - Factorizing default config code.
> - Link to v3: https://lore.kernel.org/r/20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com
> 
> Changes in v3:
> - Macros renamed and added to the patch using it.
> - Using unsigned for sensor configuration parameters.
> - Using sizeof instead of raw values.
> - Using fsleep instead of usleep.
> - Simplified dt-bindings examples, setting supplies as mandatory
> - Fix bad or useless casts.
> - Partially aligned power management following 20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com
> - Fix "uninitialized symbols" warnings.
> - Link to v2: https://lore.kernel.org/r/20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com
> 
> Changes in v2:
> - Reworked patches order and content to ease review and make sure everything compiles
> - Reworked gyro and accel FSR as 2D arrays
> - Moved temperature processed sensor to core module
> - Use latest API to claim/release device
> - Implemented chip_info structure instead of relying on an enum
> - Removed power-mode ABI, only relying on ODR to switch power_mode
> - Reworked regulator control to use devm_ API where relevant
> - Reworked inv_icm45600_state.buffer as a union to avoid casts, using getter/setter instead of memcpy
> - Fixed dt-binding error and moved patch at the beginning of the patch-set
> - Reworked macros to use FIELD_PREP inline instead of inside the header
> - Fixed comment's grammar
> - Removed extra blank lines
> - Reordered part numbers alphanumerically
> - Removed useless default/error fallbacks
> - Typed accel, gyro and timestamp data when parsing FIFO
> - Fixed I2C module return code
> - Use Linux types instead of C standard
> - Reviewed headers inclusion to remove useless #include and to add missing ones
> - Link to v1: https://lore.kernel.org/r/20250411-add_newport_driver-v1-0-15082160b019@tdk.com
> 
> ---
> Remi Buisson (9):
>       dt-bindings: iio: imu: Add inv_icm45600
>       iio: imu: inv_icm45600: add new inv_icm45600 driver
>       iio: imu: inv_icm45600: add buffer support in iio devices
>       iio: imu: inv_icm45600: add IMU IIO gyroscope device
>       iio: imu: inv_icm45600: add IMU IIO accelerometer device
>       iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
>       iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
>       iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver
>       MAINTAINERS: add entry for inv_icm45600 6-axis imu sensor
> 
>  .../bindings/iio/imu/invensense,icm45600.yaml      |  90 ++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/imu/Kconfig                            |   1 +
>  drivers/iio/imu/Makefile                           |   1 +
>  drivers/iio/imu/inv_icm45600/Kconfig               |  70 ++
>  drivers/iio/imu/inv_icm45600/Makefile              |  16 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 385 ++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 782 ++++++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 557 ++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 101 +++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 988 +++++++++++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 791 +++++++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 ++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  78 ++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 108 +++
>  15 files changed, 4074 insertions(+)
> ---
> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
> change-id: 20250411-add_newport_driver-529cf5b71ea8
> 
> Best regards,


