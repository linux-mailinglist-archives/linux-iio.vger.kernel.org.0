Return-Path: <linux-iio+bounces-11978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2F9C04B8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFB283E57
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44D210187;
	Thu,  7 Nov 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rC9Sk2t0"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAE2076BA;
	Thu,  7 Nov 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980079; cv=none; b=YVsy/teW+3W4rV+JGb4fFeZRsVlw7NxoW2M1iao2YEFpxVs0oNjd3QJ5Gtwv4yw854mIlpHKAxVWb/BgxqmDJA+Bz4v8snRNpyYeCdvlMotu4dRshEQ8Gyo4hmYPc4vKaWi/F/mY6G8wSlBzorMfEI+4ef9bLVBSHqaqhvVwc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980079; c=relaxed/simple;
	bh=qFaM2BaJr/Or/FxVrIE+FVVouQihzZBNAcBeeHYDhGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnmCdp3xN1iox3oAokmeY5E54+OJer3wBplt7pQUYf0t5FEO9uclTh+U9OP45js5dU9fva9yBXEA+Jb242bE4EUWCkyiJu3WnmajfRzozCT8KN6QSQnMqL7pxMH94voWHr3rkFyTEFxrC5fhEOOL7F1kRWLt4TYGngchIhkcFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rC9Sk2t0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RAahKqW3YpKeIKLPCckgcq3vCFHoB1MSxhlhtUGlvLQ=; b=rC9Sk2t0fiLbLWRGQnI0Xg5GEA
	3qbzhXqrP1irOfjUNTs9sJ/vM9fJsVkdaxQZ8y3SqdgsRdxdHtZYaXwygVdUJv1uPej6DNH23Khtp
	YU1+CAgJGXJGpTef5E1lyFcAfF9jpVmg9dGUzo9DqNKC98++2r+/NLJM/i+QaZtmx4k4pkGRkSdl4
	3uvRzCzBHzP7m4p4xxbRVK2Hszy+M026g27md6kD4eiO2CCgq3Ptr7BmoDtZeDYxFU3zypYKxxrYb
	cT3q07oGdMfcP3IqsmPu9cB+R7u6wwfTMp/nsb/YvG0+cZvg+DHlQXhdaDo6qXjbMf/DT2jIe7wa3
	bq6cleMQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90yx-0005lF-Rb; Thu, 07 Nov 2024 12:47:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v9 0/9] Drivers to support the MCU on QNAP NAS devices
Date: Thu,  7 Nov 2024 12:47:03 +0100
Message-ID: <20241107114712.538976-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements a set of drivers for the MCU used on QNAP NAS devices.

Of course no documentation for the serial protocol is available, so
thankfully QNAP has a tool on their rescue-inird to talk to the MCU and
I found interceptty [0] to listen to what goes over the serial connection.

In general it looks like there are two different generations in general,
an "EC" device and now this "MCU" - referenced in the strings of the
userspace handlers for those devices.

For the MCU "SPEC3" and "SPEC4" are listed which is configured in
the model.conf of the device. When setting the value from SPEC4 to
SPEC3 on my TS433, the supported commands change, but the command
interface stays the same and especially the version command is the
same.

The binding also does not expose any interals of the device that
might change, so hopefully there shouldn't be big roadblocks to
support different devices, apart from possibly adapting the commands.


changes in v9:
- add Acks + cc-stable to HID patch
- make timeout-value a constant in core mfd-driver
- some flush serdev before sending a new command

changes in v8:
- patch for hid-sensor hub to not do wonky stuff with an old
  platform-data copy
  I hope my reading of the situation is correct here, but that
  initial platform_data really seemed wrong

mfd:
- flush serial before writing a new command
- wait for send to complete before starting the receive wait-timeout
- set expected length to 0 directly when the reply is complete
  not after leaving the receive callback


changes in v7:
- use ASCII representation in commands where possible instead of hex vals
- drop get_variant function and use mfd platform-data instead

mfd:
- a lot of style improvements

leds:
- name variables better (value -> brightness, num -> num_err_led)
- handle preservation of blink mode more effectively
- snprintf -> scnprintf
- drop duplicate "failed to register ... LED" messages


changes in v6:
- format mcu commands arrays in single lines (Lee)

mfd:
- drop obsolete remain kdoc for the removed
  reply_lock (kernel test robot)


changes in v5:
binding:
- add Conor's Reviewed-by

mfd:
Address comments from Lee
- improve commit message
- improve Kconfig help text
- sort headers alphabetical
- style and spelling improvements
- constants for magic numbers
- drop reply assignment, the mcu only replies to commands sent to it,
  so there should only ever be one command in fligth.

hwmon:
Add Acked-by from Guenter and address some remarks
  - don't allow empty fan subnode
  - use num var directly when getting cooling levels, without using ret
    intermediate
  - use dev_err_probe in thermal init function


changes in v4:
binding:
- move cooling properties into a fan subnode and reference
  fan-common.yaml (Rob)
- dropped Krzysztof's Ack because of this

mfd:
- use correct format-string for size_t (kernel test robot)

input:
- added Dmitry's Ack

hwmon:
- adapted to fan-subnode when reading cooling properties
- dropped Guenter's Ack because of this


changes in v3:
mfd
- use correct power-off priority: default
- constify the cmd-data array in command functions (Dmitry)

leds:
- don't point to temporary buffers for cdev->name (Florian Eckert)

hwmon:
- use clamp_val(), don't try to reimplement (Guenter)
- add Guenter's Ack

input:
address Dmitry's comments
- constify some cmd arrays
- add input-close callback to cancel beep worker
- drop initial input event report


changes in v2:
binding:
- rename to qnap,ts433-mcu.yaml (Krzysztof)
- drop "preserve formatting" indicator (Krzysztof)
- add Krzysztof's Review tag

mfd:
- fix checkpatch --strict CHECKs
- add a MAINTAINERS entry for all qnap-mcu-parts

Heiko Stuebner (9):
  HID: hid-sensor-hub: don't use stale platform-data on remove
  mfd: core: make platform_data pointer const in struct mfd_cell
  dt-bindings: mfd: add binding for qnap,ts433-mcu devices
  mfd: add base driver for qnap-mcu devices
  leds: add driver for LEDs from qnap-mcu devices
  Input: add driver for the input part of qnap-mcu devices
  hwmon: add driver for the hwmon parts of qnap-mcu devices
  arm64: dts: rockchip: hook up the MCU on the QNAP TS433
  arm64: dts: rockchip: set hdd led labels on qnap-ts433

 .../bindings/mfd/qnap,ts433-mcu.yaml          |  42 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/qnap-mcu-hwmon.rst        |  27 ++
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   |  61 +++
 drivers/hid/hid-sensor-hub.c                  |  21 +-
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/qnap-mcu-hwmon.c                | 364 ++++++++++++++++++
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/qnap-mcu-input.c           | 153 ++++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-qnap-mcu.c                  | 227 +++++++++++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/qnap-mcu.c                        | 338 ++++++++++++++++
 include/linux/mfd/core.h                      |   2 +-
 include/linux/mfd/qnap-mcu.h                  |  26 ++
 20 files changed, 1316 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
 create mode 100644 Documentation/hwmon/qnap-mcu-hwmon.rst
 create mode 100644 drivers/hwmon/qnap-mcu-hwmon.c
 create mode 100644 drivers/input/misc/qnap-mcu-input.c
 create mode 100644 drivers/leds/leds-qnap-mcu.c
 create mode 100644 drivers/mfd/qnap-mcu.c
 create mode 100644 include/linux/mfd/qnap-mcu.h

-- 
2.45.2


