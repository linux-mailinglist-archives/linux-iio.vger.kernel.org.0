Return-Path: <linux-iio+bounces-18044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571CA87188
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9083AF36B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8D18A6AD;
	Sun, 13 Apr 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkgXgzE4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245892AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540496; cv=none; b=AsDsI6QbJIEjKU7IFmGHgJhhgPl/wGTUokmE8ZTzT65O0s4cXvz7nIKrgEwB0vDamWEdGd4zWpRW866wRDDcBIQG3jSt4QeGDSqCtQnWKGHgXCj59JhqrBoqstD31O7qgEZyMldh9v4P6KNH4+wxt9C8/NyAHw6ILE8VLcRJfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540496; c=relaxed/simple;
	bh=5FLV8zaqLD8SiYs8nFVDHT/HhbfUQqd/rDhWJjyTcV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZjSNO0RpggCci0PI9z7NlXiMqm7TAapTI7s+q2axEQkETOhy+BERlQyQYgDVg/2ztNicaOAZmEdOWGcx4s+w4QnND7GPSEsw/rFhGfd5uc66I8KD0JnMXWly8LVz1Bo2JPdSVc9gfFVWZNnoZYoTLWNkm3InxAQ4cOQIvhZArFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkgXgzE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B97C4CEDD;
	Sun, 13 Apr 2025 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540495;
	bh=5FLV8zaqLD8SiYs8nFVDHT/HhbfUQqd/rDhWJjyTcV0=;
	h=From:To:Cc:Subject:Date:From;
	b=RkgXgzE4qXoWCUdosOYm5uE3KVlY0kIkClemJqsrQbdxaGfvw+VmUUq/rYiRTKeZY
	 fEfVqTy996VocnlcYlbX8F9MphhW8xVzIGg06uMYcBoAVApPzh0iwSKSpSjeSvgImY
	 imC2WoDTF+QshJJIUaZWzTmJOy2wdoWJGdENswxrHiM6SMEKyu3Dr5HTPCScxnna2z
	 ZH443WiJmOUqKBCVfghwjKEAiHf2yBZCD/mFA6nKgP//BipMFcoQ8fOYolgpVz8SLF
	 m/ekYPslVfU4QWEmFu4Bb54j6V1xifqqm/CNW7sb8Ylb4Jv88R2+nxw1cu7q6M6qLG
	 CnFPTjTPJBsuw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 00/20] IIO: Introduce iio_push_to_buffers_with_ts() taking an input buffer length argument.
Date: Sun, 13 Apr 2025 11:34:23 +0100
Message-ID: <20250413103443.2420727-1-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v3:
- Take the dummy driver back to doing a kzalloc()
- Various white space changes.
- Tag collection
v2:
- Add some fixes via aligned_s64 (thanks David)
- Improve naming of new parameter and mark the error check unlikely (thanks Nuno)

When using the IIO buffers, the length of each scan element is always known to
the IIO core (used for sizing kfifo elements etc) and depends on which channels
are enabled. Devices often use fixed size structures or arrays.

The core code previously had no way to check that the driver had provided a large
enough buffer, potentially leading to errors or to non sanitized data being presented
to user space. In particular the iio_push_to_buffers_with_timestamp() helper
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

Jonathan Cameron (20):
  iio: adc: ad7266: Fix potential timestamp alignment issue.
  iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
  iio: adc: dln2: Use aligned_s64 for timestamp
  iio: accel: adxl355: Make timestamp 64-bit aligned using aligned_s64
  iio: introduced iio_push_to_buffers_with_ts() that takes a
    data_total_len argument.
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

 drivers/iio/accel/adxl355_core.c              |  6 ++---
 drivers/iio/accel/bma180.c                    |  2 +-
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
 drivers/iio/accel/stk8312.c                   |  4 +--
 drivers/iio/accel/stk8ba50.c                  |  4 +--
 drivers/iio/adc/ad4000.c                      |  3 ++-
 drivers/iio/adc/ad4030.c                      |  4 +--
 drivers/iio/adc/ad4695.c                      |  3 ++-
 drivers/iio/adc/ad7266.c                      |  9 +++----
 drivers/iio/adc/ad7298.c                      |  4 +--
 drivers/iio/adc/ad7380.c                      |  4 +--
 drivers/iio/adc/ad7476.c                      |  4 +--
 drivers/iio/adc/ad7606.c                      |  4 +--
 drivers/iio/adc/ad7768-1.c                    |  7 ++---
 drivers/iio/adc/ad7779.c                      |  3 ++-
 drivers/iio/adc/ad7923.c                      |  4 +--
 drivers/iio/adc/dln2-adc.c                    |  6 ++---
 drivers/iio/adc/ina2xx-adc.c                  |  2 +-
 drivers/iio/adc/max1118.c                     |  4 +--
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
 drivers/iio/adc/ti-ads131e08.c                |  4 +--
 drivers/iio/adc/ti-ads8688.c                  |  4 +--
 drivers/iio/adc/ti-lmp92064.c                 |  4 +--
 drivers/iio/adc/ti-tlc4541.c                  |  4 +--
 drivers/iio/adc/ti-tsc2046.c                  |  5 ++--
 drivers/iio/adc/vf610_adc.c                   |  6 ++---
 drivers/iio/chemical/atlas-sensor.c           |  5 ++--
 drivers/iio/chemical/bme680_core.c            |  4 +--
 drivers/iio/chemical/ccs811.c                 |  4 +--
 drivers/iio/chemical/ens160_core.c            |  4 +--
 drivers/iio/chemical/pms7003.c                |  4 +--
 drivers/iio/chemical/scd30_core.c             |  3 ++-
 drivers/iio/chemical/scd4x.c                  |  3 ++-
 drivers/iio/chemical/sps30.c                  |  4 +--
 drivers/iio/dummy/iio_simple_dummy_buffer.c   | 27 +++++++++++++------
 drivers/iio/magnetometer/af8133j.c            |  3 ++-
 drivers/iio/magnetometer/ak8974.c             |  4 +--
 drivers/iio/magnetometer/ak8975.c             |  4 +--
 drivers/iio/magnetometer/als31300.c           |  3 +--
 drivers/iio/magnetometer/bmc150_magn.c        |  4 +--
 drivers/iio/magnetometer/hmc5843.h            |  2 +-
 drivers/iio/magnetometer/hmc5843_core.c       |  4 +--
 drivers/iio/magnetometer/mag3110.c            |  4 +--
 drivers/iio/magnetometer/rm3100-core.c        |  4 +--
 drivers/iio/magnetometer/yamaha-yas530.c      |  4 +--
 drivers/iio/pressure/bmp280-core.c            | 25 ++++++++++-------
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
 drivers/iio/temperature/maxim_thermocouple.c  |  7 ++---
 drivers/iio/temperature/tmp006.c              |  4 +--
 include/linux/iio/buffer.h                    | 12 +++++++++
 88 files changed, 236 insertions(+), 184 deletions(-)

-- 
2.49.0


