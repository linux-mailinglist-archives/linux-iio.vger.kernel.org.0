Return-Path: <linux-iio+bounces-8926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF369676EF
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C282812B4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CB17E8F7;
	Sun,  1 Sep 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApjTiadZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282617E473
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199203; cv=none; b=jJDDmItC9uQfkrWAlpQ1X/G8S8dB3wDTVrE/NutYrisi1zJE61tBjt9+8a2eBM5Eev8cl8Kma6yXbf2y767rf2qpARLNG/nTv+6W+emwD9XgXO+wEJj4QKdr2F9bjCVM/gk907xpSzkDIZbsN7kloi3eTozYNP2ZC3qG53ilZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199203; c=relaxed/simple;
	bh=R4tKWM3G5k9uICsscMIQEPSWUzirNUeoQfJsmgLlx0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/ao9L/Q+OF5KMwdpFNgtTijkR4AphpvoEwdcezVkboKvEjwYGEr8aL3poJ9JKcGouh6kjABSUIe7nx0eC7tHsbEqignHe5RxN7tj8V1N7/jfncY4gcYttTD3pN5s1P/fAR7hF/IZEyi9l2EnZXeuKFzAwSeGA4KXOknF02dWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApjTiadZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06180C4CEC3;
	Sun,  1 Sep 2024 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199203;
	bh=R4tKWM3G5k9uICsscMIQEPSWUzirNUeoQfJsmgLlx0k=;
	h=From:To:Cc:Subject:Date:From;
	b=ApjTiadZ5IV/IbhAqx9WyOucpcq/z1qxPr9eNWzJU4DWVEO20XLdwq/WPRuZQoRKg
	 EDKssc+6XOWm3IiLXKM55OnxzMYSqJo4arqETeLKHLa4zM75Ynapv6H0le/jblKY8x
	 hLWLd8V16B/sTp5rAhY8xhqHqKjyXENIiepMAAeOsSJRQze4X+CeOT+8IKZCeDy84j
	 /q/zo96NJHIGRBac/0eA80OV/g9j9P2MlEahDGJfn9kNIetInVryi6PP7jH3RllswH
	 TXRLragPb53tu1xTBenYuiwJsCJ4u7GdU6dXYgzoHTF2deAsTqbWaAYLtZajrlKbY/
	 +Yvud/Wnetqug==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/15] IIO: use irq_get_trigger_type() instead of opencoding.
Date: Sun,  1 Sep 2024 14:59:35 +0100
Message-ID: <20240901135950.797396-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Andy pointed out in a review that there is an irq_get_trigger_type()
helper that first gets the irq data then extracts the type from it.
This saves on opencoding those two steps when the irq data isn't used
for anything else.

Update all the sites this pattern occurs in IIO to use the helper.
In a few cases there will be a slightly different error message is
somehow there is a valid irq number passed to this call and it doesn't
have the data associated with it.

Jonathan Cameron (15):
  iio: accel: adxl380: use irq_get_trigger_type()
  iio: accel: fxls8962af: use irq_get_trigger_type()
  iio: adc: ti-ads1015: use irq_get_trigger_type()
  iio: common: st: use irq_get_trigger_type()
  iio: gyro: fxas21002c: use irq_get_trigger_type()
  iio: gyro: mpu3050: use irq_get_trigger_type()
  iio: humidity: hts221: use irq_get_trigger_type()
  iio: imu: bmi160: use irq_get_trigger_type()
  iio: imu: bmi323: use irq_get_trigger_type()
  iio: imu: inv_icm42600: use irq_get_trigger_type()
  iio: imu: inv_mpu6050: use irq_get_trigger_type()
  iio: imu: st_lsm6dsx: use irq_get_trigger_type()
  iio: light: st_uvis25: use irq_get_trigger_type()
  iio: magn: ak8974: use irq_get_trigger_type()
  iio: pressure: bmp280: use irq_get_trigger_type()

 drivers/iio/accel/adxl380.c                        |  7 +------
 drivers/iio/accel/fxls8962af-core.c                |  2 +-
 drivers/iio/adc/ti-ads1015.c                       |  2 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |  2 +-
 drivers/iio/gyro/mpu3050-core.c                    |  2 +-
 drivers/iio/humidity/hts221_buffer.c               |  2 +-
 drivers/iio/imu/bmi160/bmi160_core.c               | 11 +----------
 drivers/iio/imu/bmi323/bmi323_core.c               |  8 +-------
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 10 +---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  9 +--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  2 +-
 drivers/iio/light/st_uvis25_core.c                 |  2 +-
 drivers/iio/magnetometer/ak8974.c                  |  2 +-
 drivers/iio/pressure/bmp280-core.c                 |  2 +-
 15 files changed, 15 insertions(+), 50 deletions(-)

-- 
2.46.0


