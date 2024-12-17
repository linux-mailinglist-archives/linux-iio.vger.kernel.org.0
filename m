Return-Path: <linux-iio+bounces-13584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59B9F4C44
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 14:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F23173346
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775FD1F6681;
	Tue, 17 Dec 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t11yFRtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0561D1730;
	Tue, 17 Dec 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441397; cv=none; b=qWutDRVxco83dtd1OOtM4DNn+wR3X3eTygW/WoCPODpFfLAyM5qG/V/iKjuWsSmeo9pr/yFhk226i4Upv+iZ0MfgbE1l79o22Ve8YkA22JELBQkXsZNNbZwFbZuwR1S5gT3tTdn+Gs3j1SMWne8Z2nsT+kR5W42jaE6fma7ppRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441397; c=relaxed/simple;
	bh=2ZJ0ETzEGovT3C+Lhgx2MC2gLEcVqJCSkAbyfxj/Rj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aiqop3UQ6smH42BwQLeTAMi3840NUN+weEVPCZ2qN3P9rXFt1ifqal5Z+/+ox5oqiG+ZZmPk/K5gsZO24NuKe2SHgdowCYXTDJB0Gl7ZxVlxQarL0eJjyDkLs/1dMdUlJdmbqfazxL9vBPHnMwrgbVY0h91hEx6HrT7XQKsnchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t11yFRtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6638C4CED3;
	Tue, 17 Dec 2024 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734441396;
	bh=2ZJ0ETzEGovT3C+Lhgx2MC2gLEcVqJCSkAbyfxj/Rj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t11yFRtDXZXYf7U/turp3S/eLXdXyGIa3s7eAy2myGUTN7Gzb+yZYbXAhGF12FSrf
	 4zwItyNXBM6iVo1U73e8rgNsrnM0uJL9Plf3F1tJQ7ADUjAbp+TV0CTe1P1BnNen5g
	 Pceba5qP/FIbztkrQ5ar85yQI9eKTNiS+zjipfpUK6iBwtEmex91RIMbFfg1HJB69X
	 ejQgLxNUuzKIJlQYpgv5iTm7azYq1z2UpI2OHWPe3aXgp40LluKoUzZH1AkFS2ttNw
	 W7CJ09HlujP08DuullW2BgsV72tW4rVuu+DzJ87KXvfDwkDS3RTRISYKZkM5UEF2x1
	 ssrvm9mZ517sw==
Date: Tue, 17 Dec 2024 13:16:29 +0000
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: jikos@kernel.org, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, HID, HWMON, Input and LEDs
 due for the v6.14 merge window
Message-ID: <20241217131629.GJ2418536@google.com>
References: <20241107114712.538976-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>

Enjoy!

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-hid-hwmon-input-leds-v6.14

for you to fetch changes up to 9855caf5d4eb1d8b8bba60be256186ea8e0f907c:

  hwmon: add driver for the hwmon parts of qnap-mcu devices (2024-12-17 13:14:48 +0000)

----------------------------------------------------------------
Immutable branch between MFD, HID, HWMON, Input and LEDs due for the v6.14 merge window

----------------------------------------------------------------
Heiko Stuebner (7):
      HID: hid-sensor-hub: don't use stale platform-data on remove
      mfd: core: Make platform_data pointer const in struct mfd_cell
      dt-bindings: mfd: Add binding for qnap,ts433-mcu devices
      mfd: Add base driver for qnap-mcu devices
      leds: Add driver for LEDs from qnap-mcu devices
      Input: add driver for the input part of qnap-mcu devices
      hwmon: add driver for the hwmon parts of qnap-mcu devices

 .../devicetree/bindings/mfd/qnap,ts433-mcu.yaml    |  42 +++
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/qnap-mcu-hwmon.rst             |  27 ++
 MAINTAINERS                                        |   9 +
 drivers/hid/hid-sensor-hub.c                       |  21 +-
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/qnap-mcu-hwmon.c                     | 364 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/qnap-mcu-input.c                | 153 +++++++++
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-qnap-mcu.c                       | 227 +++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/qnap-mcu.c                             | 338 +++++++++++++++++++
 include/linux/mfd/core.h                           |   2 +-
 include/linux/mfd/qnap-mcu.h                       |  26 ++
 19 files changed, 1255 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
 create mode 100644 Documentation/hwmon/qnap-mcu-hwmon.rst
 create mode 100644 drivers/hwmon/qnap-mcu-hwmon.c
 create mode 100644 drivers/input/misc/qnap-mcu-input.c
 create mode 100644 drivers/leds/leds-qnap-mcu.c
 create mode 100644 drivers/mfd/qnap-mcu.c
 create mode 100644 include/linux/mfd/qnap-mcu.h

-- 
Lee Jones [李琼斯]

