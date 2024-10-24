Return-Path: <linux-iio+bounces-11075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651769AE03E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E161283864
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABB1B6CFD;
	Thu, 24 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dl3fqVlN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4ED1B218B
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761172; cv=none; b=jZv2avb9qUEKBdGoxS/YCnJKF957JsVxbAkxIjsixouEZq1NTJFVJ/btqRC30+vKtSMwt7I0nJrUL1FZg6T0vihau79C+KYR0ipttUrbY57fhzsHKD7URiWrmS6HbVVzDtnGu/Eqh1cq3GQBzRv66C42xa8K9xDSuqNyXkQ1FwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761172; c=relaxed/simple;
	bh=QGdUMjRpMYxCmFq2pXqUJVmN8eN7QxzrP+sC6cNn0qU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nfoifdca0z1yjmQaNIk0m64IomlYWNYIUdpVDEiecYVaJRxgi2dgON2jT4z9FAUmi5SwZB6Vo9Rj9wgfxEQNU9ptGvMKbahKFETdY7nzuzqbXPOawe/Ck/aT/pOa68YU0pxBLWiN9rsyFI5Xc3Lz34uTLU1jBSBpBvYlupUKnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dl3fqVlN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d462c91a9so435562f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761168; x=1730365968; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vx0eUgvgDMYu97caj8Fvwuv1gvofiM1BDQhVIQnSVpg=;
        b=dl3fqVlNzKQNi37KAG3QEVFN1KfdV+l6CxQQ8qHXyXJd3Pio5k+2xBeUrNcUtf3ldv
         12tf8/LQNPoXD8f51C0K27vDfoc4jH8UYEkqpHzYrvAHB78NORbfG2vma4Y9bM4es67n
         6RxsHr/kj+eUZH87rLSoAm65xeti3nRRotyWRJH8yhL8ExN91YhwUoJ4TQ04vw8l8cUs
         slywsNApMC3p2T/HmmNxgqvzraK3bcQswWAixGuJqDf7UmXCWtbcfSJ9vm1VUmxAF/aq
         Dpl0KmL5xNV/BMls5ilpYsrob2QyeNOuU6MFBZdXXe4RYfylsj2NhyFNq8OzyKcNxbRQ
         sxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761168; x=1730365968;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx0eUgvgDMYu97caj8Fvwuv1gvofiM1BDQhVIQnSVpg=;
        b=L6Au7Wf/sHQW7VOtAXSP1JRqu+HA42GSjod122OxBOwFoT1nV87jk5hIXES0Lldova
         416fpM5Y2B6OKHgoSwuGBluBNV3cZynD2QvPGTpvZb04K8e4+5YB2FmThowZgloLqZc+
         g/mgEXoAjnz0ruWL0eafuuhk0ztVOLOBuoLafBGofRH0vjmQIl2Fh45n9e/z0OKLvUCQ
         RipP104kld9vioXvu0aJOQ+3tquuioyf/9Rh8CGyPeiE7XwvM5SnDMg2SFpwjJfi0IUr
         wS3jQcm+DjGW+xNE8eqRNq87LbWoWV/G699giKeJ4CK3a8aTIq5IIIFxKIIwjsKiV1tz
         /0zw==
X-Gm-Message-State: AOJu0YyfB+ZzPk7QDibHD7gdxFFwGiEJriHXyXZoH/Wv63g6y0yD6eU+
	PQXqJZbgK2EQYD5Nu36EXJdDXI+v8ZNrLk14fjm3yMRwRxT1qd+t24yhWsNxmYM=
X-Google-Smtp-Source: AGHT+IHA45txqMv6fiCd6E+I5xqCrbrjkPK/VXPgue7ugGcgW6QHaUAS7lo3qSSFpDfYjE1RQxWTIA==
X-Received: by 2002:a5d:49c8:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37efcef0d0dmr3531695f8f.2.1729761167762;
        Thu, 24 Oct 2024 02:12:47 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/7] iio: fix write_event_config signature
Date: Thu, 24 Oct 2024 11:11:22 +0200
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADoPGmcC/x2NsQ7CMAwFf6XyjKUmwMKvIIaS2OEtDnJCqVT13
 4kYb7i7nZo4pNFt2sllRUO1AeE0UXotVoSRB1Oc4yXM8cxAZcXGX0cXllWsc6qmKNxQbOkfFw7
 PFPQaNUtWGqm3y3D+m/vjOH4as7IidgAAAA==
X-Change-ID: 20241023-iio-fix-write-event-config-signature-1bc1f52fdedf
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.14.2

Hello,

This series update the write_event_config callback signature to use
a boolean instead of an int for state variable. iio_ev_state_store
is actually using kstrtobool to check user input, then gives the
converted boolean value to write_event_config.

First, fix the write_event_config callbacks from iio drivers that are
checking state input, or that are converting state to bool. This is
useless code, then update signature.

This patch has been partially written using coccinelle with the
following script:

$ cat iio-bool.cocci
// Options: --all-includes

virtual patch

@c1@
identifier iioinfo;
identifier wecfunc;
@@
 static const struct iio_info iioinfo = {
        ...,
        .write_event_config =
(
 wecfunc
|
 &wecfunc
),
        ...,
 };

@@
identifier c1.wecfunc;
identifier indio_dev, chan, type, dir, state;
@@
 int wecfunc(struct iio_dev *indio_dev, const struct iio_chan_spec *chan, enum iio_event_type type, enum iio_event_direction dir,
-int
+bool
 state) {
  ...
 }

make coccicheck MODE=patch COCCI=iio-bool.cocci M=drivers/iio

Unfortunately, this script didn't match all files:
* all write_event_config callbacks using iio_device_claim_direct_scoped
  were not detected and not patched.
* all files that do not assign and declare the write_event_config
  callback in the same file.

iio.h was also manually updated.

The patch was build tested using allmodconfig config.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (7):
      iio: light: bh1745: simplify code in write_event_config callback
      iio: light: ltr390: simplify code in write_event_config callback
      iio: light: ltr501: simplify code in write_event_config callback
      iio: light: veml6030: simplify code in write_event_config callback
      iio: imu: inv_mpu6050: simplify code in write_event_config callback
      iio: light: stk3310: simplify code in write_event_config callback
      iio: fix write_event_config signature

 drivers/iio/accel/adxl367.c                    |  2 +-
 drivers/iio/accel/adxl372.c                    |  2 +-
 drivers/iio/accel/adxl380.c                    |  2 +-
 drivers/iio/accel/bma400_core.c                |  2 +-
 drivers/iio/accel/bmc150-accel-core.c          |  2 +-
 drivers/iio/accel/fxls8962af-core.c            |  2 +-
 drivers/iio/accel/kxcjk-1013.c                 |  2 +-
 drivers/iio/accel/mma8452.c                    |  2 +-
 drivers/iio/accel/mma9551.c                    |  2 +-
 drivers/iio/accel/mma9553.c                    |  3 +-
 drivers/iio/accel/sca3000.c                    |  2 +-
 drivers/iio/adc/ad7091r-base.c                 |  3 +-
 drivers/iio/adc/ad7291.c                       |  2 +-
 drivers/iio/adc/ad799x.c                       |  2 +-
 drivers/iio/adc/hi8435.c                       |  2 +-
 drivers/iio/adc/max1363.c                      |  2 +-
 drivers/iio/adc/pac1921.c                      |  3 +-
 drivers/iio/adc/palmas_gpadc.c                 |  2 +-
 drivers/iio/adc/ti-ads1015.c                   |  2 +-
 drivers/iio/adc/xilinx-ams.c                   |  2 +-
 drivers/iio/adc/xilinx-xadc-events.c           |  2 +-
 drivers/iio/adc/xilinx-xadc.h                  |  2 +-
 drivers/iio/cdc/ad7150.c                       |  2 +-
 drivers/iio/dac/ad5421.c                       |  2 +-
 drivers/iio/dac/ad8460.c                       |  2 +-
 drivers/iio/dummy/iio_simple_dummy.h           |  2 +-
 drivers/iio/dummy/iio_simple_dummy_events.c    |  2 +-
 drivers/iio/gyro/bmg160_core.c                 |  2 +-
 drivers/iio/imu/bmi323/bmi323_core.c           |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c     |  9 ++---
 drivers/iio/imu/kmx61.c                        |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |  2 +-
 drivers/iio/light/adux1020.c                   |  3 +-
 drivers/iio/light/apds9300.c                   |  2 +-
 drivers/iio/light/apds9306.c                   |  2 +-
 drivers/iio/light/apds9960.c                   |  4 +--
 drivers/iio/light/bh1745.c                     | 50 ++++++++++++--------------
 drivers/iio/light/cm36651.c                    |  2 +-
 drivers/iio/light/gp2ap002.c                   |  2 +-
 drivers/iio/light/gp2ap020a00f.c               |  2 +-
 drivers/iio/light/iqs621-als.c                 |  2 +-
 drivers/iio/light/ltr390.c                     |  5 +--
 drivers/iio/light/ltr501.c                     |  6 +---
 drivers/iio/light/max44009.c                   |  2 +-
 drivers/iio/light/opt3001.c                    |  2 +-
 drivers/iio/light/stk3310.c                    |  5 +--
 drivers/iio/light/tcs3472.c                    |  2 +-
 drivers/iio/light/tsl2563.c                    |  2 +-
 drivers/iio/light/tsl2591.c                    |  2 +-
 drivers/iio/light/tsl2772.c                    |  2 +-
 drivers/iio/light/us5182d.c                    |  2 +-
 drivers/iio/light/vcnl4000.c                   |  5 +--
 drivers/iio/light/veml6030.c                   |  5 +--
 drivers/iio/position/iqs624-pos.c              |  2 +-
 drivers/iio/proximity/aw96103.c                |  2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c |  2 +-
 drivers/iio/proximity/hx9023s.c                |  2 +-
 drivers/iio/proximity/irsd200.c                |  3 +-
 drivers/iio/proximity/sx9500.c                 |  2 +-
 drivers/iio/proximity/sx_common.c              |  2 +-
 drivers/iio/proximity/sx_common.h              |  2 +-
 drivers/iio/proximity/vcnl3020.c               |  2 +-
 drivers/iio/temperature/mcp9600.c              |  2 +-
 drivers/iio/temperature/tmp007.c               |  2 +-
 include/linux/iio/iio.h                        |  2 +-
 65 files changed, 96 insertions(+), 112 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241023-iio-fix-write-event-config-signature-1bc1f52fdedf

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


