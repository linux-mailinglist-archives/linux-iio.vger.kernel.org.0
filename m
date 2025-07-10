Return-Path: <linux-iio+bounces-21536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51DB0099D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C451C3AE9B7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BE2F0C4B;
	Thu, 10 Jul 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqau8mCg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF912F0C47
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167481; cv=none; b=El75sY0C598bnTUQK0yf0IZcdIugkyoPTXzyTkVt46nrvlSa5oMmNilrVQRRABgWdpPiJo0m8FqbUVNsZSK2vNcmvHKWkZu9jfHg4iZqSAX+gOmyHk6obiJ+GnjDOmtvCL2FS6cn7TOAC/f5hZ1GvYNHZJDWoowBOdDot8y2nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167481; c=relaxed/simple;
	bh=TRJUxB4WBpe+QSGife8PyjCShwDx1HSgq8OfCej093s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBWb6mrsYCrE+0DzmNRijDQ9VThZHTF+kH5ypfLGr/3ZYj4MZbTXfmz7B0UNS08c/myVj77gg97WAFOb0tW+qawQt4mzFqVKJtyHcPuYm11dFqU2yUUEnz/NAEdiXwCR7u6q0pwNLAZWNCNQgshTCDzXYtal9P6ZbVEovSsbgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqau8mCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00380C4CEF4;
	Thu, 10 Jul 2025 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167477;
	bh=TRJUxB4WBpe+QSGife8PyjCShwDx1HSgq8OfCej093s=;
	h=From:To:Cc:Subject:Date:From;
	b=rqau8mCgF6co8lAK/Hu4XqULMveRnVnnjmvVqXezI75u4QEJmPZqh8ruLC22ghZ/J
	 a8/JnhzMwrSIHiMsmr81DuDiOrbTVfnTAw+0P85lcSFMLgKkUxXiVL8vHW4yGX9DEJ
	 mqkihSwPEBtqhvXIt0MahungTK+j8H+mmN/froEss/AnYtO58pHC+FG5YL9o3GZDSd
	 YO3FLvp2b01dVUaJWrsUe1jdf+iJiWx6kcaMEx9Et5DSh+XoHntb+7327UZJLeTuJZ
	 PE2Mwx6bnBaggmYBAteq2XR+WP1TuMDHS75+EQnjEn7hQtiJ0sHidBVa3NypgH7OgX
	 P8cZxq8hhpHTg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] IIO: More application of IWYU principles to includes.
Date: Thu, 10 Jul 2025 18:11:00 +0100
Message-ID: <20250710171107.443790-1-jic23@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I decided to look at a slightly larger set to continue trying to come
up with consistent rules (for IIO anyway) on what we want to include
direclty and what assumptions we can make about a header always including
another.

As the series goes on reduce the amount of info on particular choices made
just because the commit descriptions were getting very long.

A few open questions.
- linux/stddef.h - do we want to included this directly?
- linux/types.h - do we want to include this directly?
- linux/dev_printk.h - include even if device.h is needed for other reasons
  or rely on that as a grouping header if present and only use dev_printk
  where we don't need device.h.

I'll share a refreshed IWYU config once we come to firmer conclusions
on the various choices.  I haven't yet figured out now to not include
anything at all for things like CONFIG*

Jonathan Cameron (7):
  iio: pressure: bmp280: Apply iwyu principles to includes.
  iio: pressure: zpa2326: Apply iwyu principles to includes
  iio: pressure: mpl115: Apply iwyu principles to includes
  iio: pressure: ms5611: Apply iwyu principles to includes
  iio: pressure: hsc030pa: Apply IWYU principles to includes.
  iio: pressure: mprls0025pa: Apply IWYU principles to includes.
  iio: st_sensors: Apply IWYU principles to includes

 drivers/iio/accel/st_accel_buffer.c           |  6 ++++--
 drivers/iio/accel/st_accel_core.c             | 12 ++++++++---
 drivers/iio/accel/st_accel_i2c.c              |  5 ++++-
 drivers/iio/accel/st_accel_spi.c              |  3 ++-
 .../iio/common/st_sensors/st_sensors_buffer.c | 15 +++++++++-----
 .../iio/common/st_sensors/st_sensors_core.c   | 19 ++++++++++++++----
 .../iio/common/st_sensors/st_sensors_core.h   |  2 ++
 .../iio/common/st_sensors/st_sensors_i2c.c    |  8 ++++++--
 .../iio/common/st_sensors/st_sensors_spi.c    | 11 ++++++++--
 .../common/st_sensors/st_sensors_trigger.c    | 13 +++++++++---
 drivers/iio/gyro/st_gyro_buffer.c             |  6 ++++--
 drivers/iio/gyro/st_gyro_core.c               | 11 +++++++---
 drivers/iio/gyro/st_gyro_i2c.c                |  3 ++-
 drivers/iio/gyro/st_gyro_spi.c                |  3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  5 ++++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  5 ++---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  5 ++---
 drivers/iio/magnetometer/st_magn_buffer.c     |  5 +++--
 drivers/iio/magnetometer/st_magn_core.c       | 11 +++++++---
 drivers/iio/magnetometer/st_magn_i2c.c        |  3 ++-
 drivers/iio/magnetometer/st_magn_spi.c        |  3 ++-
 drivers/iio/pressure/bmp280-core.c            | 17 ++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |  4 ++++
 drivers/iio/pressure/bmp280-regmap.c          |  6 ++++--
 drivers/iio/pressure/bmp280-spi.c             |  6 ++++++
 drivers/iio/pressure/hsc030pa.c               | 12 +++++------
 drivers/iio/pressure/hsc030pa.h               |  5 ++---
 drivers/iio/pressure/hsc030pa_i2c.c           |  4 ----
 drivers/iio/pressure/hsc030pa_spi.c           |  5 -----
 drivers/iio/pressure/mpl115.c                 | 13 +++++++++---
 drivers/iio/pressure/mpl115.h                 |  1 +
 drivers/iio/pressure/mpl115_i2c.c             |  8 +++++++-
 drivers/iio/pressure/mpl115_spi.c             |  5 +++++
 drivers/iio/pressure/mprls0025pa.c            |  9 +++++++--
 drivers/iio/pressure/mprls0025pa.h            |  9 ++-------
 drivers/iio/pressure/mprls0025pa_i2c.c        |  1 -
 drivers/iio/pressure/ms5611_core.c            | 15 +++++++++++---
 drivers/iio/pressure/ms5611_i2c.c             |  5 ++++-
 drivers/iio/pressure/ms5611_spi.c             |  9 +++++++--
 drivers/iio/pressure/st_pressure_buffer.c     |  6 ++++--
 drivers/iio/pressure/st_pressure_core.c       |  9 ++++++---
 drivers/iio/pressure/st_pressure_i2c.c        |  3 ++-
 drivers/iio/pressure/st_pressure_spi.c        |  3 ++-
 drivers/iio/pressure/zpa2326.c                | 20 +++++++++++++++----
 drivers/iio/pressure/zpa2326.h                |  3 +++
 drivers/iio/pressure/zpa2326_i2c.c            |  7 +++++--
 drivers/iio/pressure/zpa2326_spi.c            |  6 +++++-
 include/linux/iio/common/st_sensors_i2c.h     |  5 ++---
 include/linux/iio/common/st_sensors_spi.h     |  5 ++---
 49 files changed, 249 insertions(+), 106 deletions(-)

-- 
2.50.0


