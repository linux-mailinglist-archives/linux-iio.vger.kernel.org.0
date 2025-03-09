Return-Path: <linux-iio+bounces-16626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9FA58720
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188D9188C063
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761FF214207;
	Sun,  9 Mar 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyeG96aH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554D213E7F
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544500; cv=none; b=jB5tRR+0HPUuBD0dQNt7hMxKXuMR9CB1CIfHz7BghxPr5JCct77rPVE6YMF9eQ59TPXmZziVisqZirKgiJZJ0xaUNrPv9xZU62Qq7T+EUCvFwuJZeEUUbalsXCBbH5SX4MpblRwEpWkhNLSwYarezvr7lkSIDHFrIuZ0gdRty4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544500; c=relaxed/simple;
	bh=iJcT/5dNyZ3t7rW+elZGvUmvb+h1mww72zlX94LXoNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9UFb1zF4ZWODRseIY5UTi2RDwVKl9fisfScMqiTLOkBcOQ+ww5fwc6nREHPYvsU0bc2wRx4I1V7bzHI32WEW7hlnfgvCT4G0Ani+tw/yN3iu7iCvZAOkveJtLgYotQKfwtxQPp3IBPgxXMqv8t6eJR2OUq2FK24nc6ByT2ERVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyeG96aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19DEC4CEF9;
	Sun,  9 Mar 2025 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544499;
	bh=iJcT/5dNyZ3t7rW+elZGvUmvb+h1mww72zlX94LXoNY=;
	h=From:To:Cc:Subject:Date:From;
	b=kyeG96aHYCBzEkBkH6IH3s05ZTH50eeVXXkZ2LsmhlApl8IfnCqqxkYOBC5B9jWnW
	 DXTYYSQsbfEyo0H+n3nVHnnbtccVmDQ3sh2HSJR7h8NF8IhN4iO1hSDDn+9MPdEwF7
	 6iWf3hYbRiBGFqb9xeeetfDSXm07m2NHQZaaj1GNTywSo+TqK0/SsS5iEV2CLaCQuK
	 5KZEqa/1kBrYhtWDPYUv7m4w6ZyrWf1QdU+re+7ANmYRKKCorQl3NjPO44u7g2nAc6
	 p79qOJC3V2EcpQ5NuO2lroeW027O6RpxqsMEmK79TTzJ6iIE73IcId7xCnQ0CvfWTN
	 ajmpUV98MUAKA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/16] IIO: Introduce iio_push_to_buffers_with_ts() taking an input buffer length argument.
Date: Sun,  9 Mar 2025 18:20:44 +0000
Message-ID: <20250309182100.1351128-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

When using the IIO buffers, the length of each scan element is always known to
the IIO core (used for sizing kfifo elements etc) and depends on which channels
are enabled. Devices often use fixed size structures or arrays.

The core code previously had no way to check that the driver had provided a large
enough buffer, potentially leading to errors or to non sanitized data being presented
to userspace. In particular the iio_push_to_buffers_with_timestamp() helper
has the non obvious requirement for a larger buffer when timestamps are enabled
than that containing the rest of the channels (under the control of the driver).
This has lead to bugs in the past and this series aims to make that impossible
in the future by passing the size of the storage into a new variant of the helper
iio_push_to_buffers_with_ts() and performing a runtime check.

Once all drivers are converted, the expectation is the _with_timestamp()
version without this check will be removed.

The patches in this series use this helper for a large number of simple cases
and fix a few minor issues found during the conversion.  This does not cover
all drivers in each category, leaving more complex cases for future series.
Some of the remaining cases need substantial refactoring, others look to have
bugs that need more careful consideration than the cases in this series.

All comments welcome.  I haven't attempted to cc all the relevant driver
maintainers as that is a long list!

Jonathan Cameron (16):
  iio: introduced iio_push_to_buffers_with_ts() that takes a total_len
    argument.
  iio: dummy: Use a fixed structure to build up scan to push to buffers.
  iio: dummy: Switch to iio_push_to_buffers_with_ts() and provide size
    of storage
  iio: adc: ti-ads131e08: Use new iio_push_to_buffers_with_ts() to
    provide length sanity check.
  iio: adc: Use iio_push_to_buffers_with_ts() to provide length for
    runtime checks.
  iio: accel: Use iio_push_to_buffers_with_ts() to provide length for
    runtime checks.
  iio: accel: hid: Use iio_push_to_buffers_with_ts() to provide length
    for runtime checks.
  iio: chemical: Use iio_push_to_buffers_with_ts() to provide length for
    runtime checks.
  iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
  iio: temperature: Use iio_push_to_buffers_with_ts() to provide length
    for runtime checks.
  iio: resolver: Use iio_push_to_buffers_with_ts() to provide length for
    runtime checks.
  iio: proximity: irsd200: Use a struct for scan and
    iio_push_to_buffers_with_ts()
  iio: proximity: Use iio_push_to_buffers_with_ts() to provide length
    for runtime checks.
  iio: pressure: zpa2326: Use aligned_s64 for the timestamp
  iio: pressure: Use iio_push_to_buffers_with_ts() to provide length for
    runtime checks.
  iio: magnetometer: Use iio_push_to_buffers_with_ts() to provide length
    for runtime checks.

 drivers/iio/accel/adxl355_core.c              |  4 +--
 drivers/iio/accel/bma180.c                    |  3 ++-
 drivers/iio/accel/bma220_spi.c                |  4 +--
 drivers/iio/accel/bma400_core.c               |  5 ++--
 drivers/iio/accel/fxls8962af-core.c           |  4 +--
 drivers/iio/accel/hid-sensor-accel-3d.c       |  2 +-
 drivers/iio/accel/kxcjk-1013.c                |  4 +--
 drivers/iio/accel/kxsd9.c                     |  5 ++--
 drivers/iio/accel/mma7455_core.c              |  5 ++--
 drivers/iio/accel/mma8452.c                   |  5 ++--
 drivers/iio/accel/msa311.c                    |  4 +--
 drivers/iio/accel/mxc4005.c                   |  4 +--
 drivers/iio/accel/sca3300.c                   |  5 ++--
 drivers/iio/accel/stk8312.c                   |  2 +-
 drivers/iio/accel/stk8ba50.c                  |  4 +--
 drivers/iio/adc/ad4000.c                      |  3 ++-
 drivers/iio/adc/ad4030.c                      |  5 ++--
 drivers/iio/adc/ad4695.c                      |  3 ++-
 drivers/iio/adc/ad7266.c                      |  5 ++--
 drivers/iio/adc/ad7298.c                      |  5 ++--
 drivers/iio/adc/ad7380.c                      |  5 ++--
 drivers/iio/adc/ad7476.c                      |  4 +--
 drivers/iio/adc/ad7606.c                      |  4 +--
 drivers/iio/adc/ad7768-1.c                    |  5 ++--
 drivers/iio/adc/ad7779.c                      |  3 ++-
 drivers/iio/adc/ad7923.c                      |  4 +--
 drivers/iio/adc/dln2-adc.c                    |  4 +--
 drivers/iio/adc/ina2xx-adc.c                  |  3 ++-
 drivers/iio/adc/max1118.c                     |  2 +-
 drivers/iio/adc/max11410.c                    |  4 +--
 drivers/iio/adc/max1363.c                     |  4 +--
 drivers/iio/adc/mcp3911.c                     |  4 +--
 drivers/iio/adc/mxs-lradc-adc.c               |  3 ++-
 drivers/iio/adc/pac1921.c                     |  3 ++-
 drivers/iio/adc/rockchip_saradc.c             |  3 ++-
 drivers/iio/adc/rtq6056.c                     |  3 ++-
 drivers/iio/adc/stm32-adc.c                   |  4 +--
 drivers/iio/adc/ti-adc081c.c                  |  4 +--
 drivers/iio/adc/ti-adc0832.c                  |  4 +--
 drivers/iio/adc/ti-adc084s021.c               |  4 +--
 drivers/iio/adc/ti-adc12138.c                 |  4 +--
 drivers/iio/adc/ti-ads1015.c                  |  4 +--
 drivers/iio/adc/ti-ads1119.c                  |  4 +--
 drivers/iio/adc/ti-ads124s08.c                |  4 +--
 drivers/iio/adc/ti-ads131e08.c                |  5 ++--
 drivers/iio/adc/ti-ads8688.c                  |  4 +--
 drivers/iio/adc/ti-lmp92064.c                 |  4 +--
 drivers/iio/adc/ti-tlc4541.c                  |  4 +--
 drivers/iio/adc/ti-tsc2046.c                  |  5 ++--
 drivers/iio/adc/vf610_adc.c                   |  7 +++---
 drivers/iio/chemical/atlas-sensor.c           |  5 ++--
 drivers/iio/chemical/bme680_core.c            |  4 +--
 drivers/iio/chemical/ccs811.c                 |  4 +--
 drivers/iio/chemical/ens160_core.c            |  4 +--
 drivers/iio/chemical/pms7003.c                |  5 ++--
 drivers/iio/chemical/scd30_core.c             |  3 ++-
 drivers/iio/chemical/scd4x.c                  |  3 ++-
 drivers/iio/chemical/sps30.c                  |  4 +--
 drivers/iio/dummy/iio_simple_dummy_buffer.c   | 18 ++++++-------
 drivers/iio/magnetometer/af8133j.c            |  3 ++-
 drivers/iio/magnetometer/ak8974.c             |  5 ++--
 drivers/iio/magnetometer/ak8975.c             |  4 +--
 drivers/iio/magnetometer/als31300.c           |  4 +--
 drivers/iio/magnetometer/bmc150_magn.c        |  4 +--
 drivers/iio/magnetometer/hmc5843.h            |  2 +-
 drivers/iio/magnetometer/hmc5843_core.c       |  4 +--
 drivers/iio/magnetometer/mag3110.c            |  4 +--
 drivers/iio/magnetometer/rm3100-core.c        |  4 +--
 drivers/iio/magnetometer/yamaha-yas530.c      |  5 ++--
 drivers/iio/pressure/bmp280-core.c            | 25 +++++++++++--------
 drivers/iio/pressure/hid-sensor-press.c       |  5 ++--
 drivers/iio/pressure/hsc030pa.c               |  4 +--
 drivers/iio/pressure/mpl3115.c                |  4 +--
 drivers/iio/pressure/rohm-bm1390.c            |  3 ++-
 drivers/iio/pressure/zpa2326.c                |  6 ++---
 drivers/iio/proximity/as3935.c                |  4 +--
 drivers/iio/proximity/hx9023s.c               |  4 +--
 drivers/iio/proximity/irsd200.c               | 12 ++++++---
 drivers/iio/proximity/mb1232.c                |  4 +--
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  5 ++--
 drivers/iio/proximity/srf08.c                 |  4 +--
 drivers/iio/proximity/sx_common.c             |  4 +--
 drivers/iio/proximity/vl53l0x-i2c.c           |  4 +--
 drivers/iio/resolver/ad2s1210.c               |  3 ++-
 .../iio/temperature/hid-sensor-temperature.c  |  5 ++--
 drivers/iio/temperature/maxim_thermocouple.c  |  7 +++---
 drivers/iio/temperature/tmp006.c              |  4 +--
 include/linux/iio/buffer.h                    | 13 ++++++++++
 88 files changed, 230 insertions(+), 179 deletions(-)

-- 
2.48.1


