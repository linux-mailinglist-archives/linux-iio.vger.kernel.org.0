Return-Path: <linux-iio+bounces-11709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A19B7E6D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACE328572F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B21C3F1D;
	Thu, 31 Oct 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kB6M+I7U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61371BB6B5
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388444; cv=none; b=EzoT9Ct8Pz+EgvXjtjCNkNYW79GJWlfIKNJHGZoi0+N+QQNe5r+RyKCQHpAjQj0apWU0j7t4nS1B+4NlkmpuZhJyR2aZeG0fTkreMi+fMsExfRuFdN0mpSa2zlSGb6cjYiee5rl1G6Tw4zRJtOfgIYLd02SiZUITw3P0O7og3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388444; c=relaxed/simple;
	bh=zKN9SrS3On2qDuWoKGREwN2j1scUNnsIaI+YVLp8NZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGtVob3WljaVFI/odBDDdHQhMGD1cUapHeDeKhGOxS3A2U7JwPH67ibRTxpusYNXmJzjQudQv/UHNFPtoZ0z2ON+Ljn2Bqqh5Mi5LtTFx9mMe0R3joxLe6qN0rab1v5LsG8JjLpIWuAuZl6XVxZlT9gbBL6lDYCdG/wCS/jC5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kB6M+I7U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so780009f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388435; x=1730993235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNVlgZbMHatULKuPqR/ehfFhVRq6GfasgmsLRyp3kiY=;
        b=kB6M+I7U8zzXIUvbVajmyUQDNYmO/+0zT/7bfO32bw4NW4FcjYi1bFHajhQalmbuOT
         qhaK2l/l1TpgdCphE7ZNj1AgF917AZhpEFXjys5k6FItwVZzNKsYHS4KYWoJIH8+fTg2
         4rAn4ARn38MQQYAjuhckpkS9w2LxijnW7s2EFu94lEcypPZHh9AQgeRboTqy3AdVcJwc
         aYJPodqSTaUA9NDrmiI/YxS1T3o7hmF4bqDQh/jZoU16M7Vg97m+5VLAN1MCMo3gWQ5o
         25YauT1p+3xKl5DBojXStLiTn3xXlzbbOyEfbmQJzj7BDm5JqpFIJe488ptzgrIItAfD
         5WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388435; x=1730993235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNVlgZbMHatULKuPqR/ehfFhVRq6GfasgmsLRyp3kiY=;
        b=fc056OYYGAmFW0MoUFDce4CtIQZQf710Q5j8QwjNPhFIE9KhHeJ/FEMzj6AVQ7Ar9I
         tJjC2qKAH2xYuqV1n1Q7zOIpNSnx6syi1QbITP2A1GI1kHh8POuacgtBCnaScZf2aiZE
         kBCfg8hzYW08kIboYM+XZSSfM9sW2wElcbfCVFjP/ODuls/Z5FcMNIxZ5i4PYOYRFnKR
         kufFhG7UGDhRQJYrnyuWXXjja2eRudS7BsCfQvB2yYSUUKNIypAeLGg1E/fBW8MEaAHF
         /a4+zs/8a7jqammybz+f5zEwhv4xz7e1bY+vKj83buxZX/6TaaQLlIK2t9fiWkCBZ8SC
         fvDg==
X-Gm-Message-State: AOJu0Yzr1ouhDjDEPrrRKdBDPwP567Mhc0wxS/k66sT4xPuBoir8r2EH
	6kB0FKdAGFOhcHw1aFckKOVbGSbVOOYEzEFrjMrwZEz90qySplIeOhS3GQ/0IzQ=
X-Google-Smtp-Source: AGHT+IGOgA2+T5ZQIukQ4DQ1UKH9lD78fd8+mZGwsrT72KWNxwUQ7MK1q1dtkX4huLnya4y3YoeFOQ==
X-Received: by 2002:a05:6000:1a85:b0:37d:4125:5cba with SMTP id ffacd0b85a97d-381be7d8c46mr2905915f8f.32.1730388434664;
        Thu, 31 Oct 2024 08:27:14 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:02 +0100
Subject: [PATCH v2 07/15] iio: fix write_event_config signature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-7-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
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

write_event_config callback use an int for state, but it is actually a
boolean. iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to write_event_config.

Fix signature and update all iio drivers to use the new signature.

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

cc: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/accel/adxl367.c                    | 2 +-
 drivers/iio/accel/adxl372.c                    | 2 +-
 drivers/iio/accel/adxl380.c                    | 2 +-
 drivers/iio/accel/bma400_core.c                | 2 +-
 drivers/iio/accel/bmc150-accel-core.c          | 2 +-
 drivers/iio/accel/fxls8962af-core.c            | 2 +-
 drivers/iio/accel/kxcjk-1013.c                 | 2 +-
 drivers/iio/accel/mma8452.c                    | 2 +-
 drivers/iio/accel/mma9551.c                    | 2 +-
 drivers/iio/accel/mma9553.c                    | 3 ++-
 drivers/iio/accel/sca3000.c                    | 2 +-
 drivers/iio/adc/ad7091r-base.c                 | 3 ++-
 drivers/iio/adc/ad7291.c                       | 2 +-
 drivers/iio/adc/ad799x.c                       | 2 +-
 drivers/iio/adc/hi8435.c                       | 2 +-
 drivers/iio/adc/max1363.c                      | 2 +-
 drivers/iio/adc/pac1921.c                      | 3 ++-
 drivers/iio/adc/palmas_gpadc.c                 | 2 +-
 drivers/iio/adc/ti-ads1015.c                   | 2 +-
 drivers/iio/adc/xilinx-ams.c                   | 2 +-
 drivers/iio/adc/xilinx-xadc-events.c           | 2 +-
 drivers/iio/adc/xilinx-xadc.h                  | 2 +-
 drivers/iio/cdc/ad7150.c                       | 2 +-
 drivers/iio/dac/ad5421.c                       | 2 +-
 drivers/iio/dac/ad8460.c                       | 2 +-
 drivers/iio/dummy/iio_simple_dummy.h           | 2 +-
 drivers/iio/dummy/iio_simple_dummy_events.c    | 2 +-
 drivers/iio/gyro/bmg160_core.c                 | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c           | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c     | 2 +-
 drivers/iio/imu/kmx61.c                        | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 2 +-
 drivers/iio/light/adux1020.c                   | 3 ++-
 drivers/iio/light/apds9300.c                   | 2 +-
 drivers/iio/light/apds9306.c                   | 2 +-
 drivers/iio/light/apds9960.c                   | 2 +-
 drivers/iio/light/bh1745.c                     | 2 +-
 drivers/iio/light/cm36651.c                    | 2 +-
 drivers/iio/light/gp2ap002.c                   | 2 +-
 drivers/iio/light/gp2ap020a00f.c               | 2 +-
 drivers/iio/light/iqs621-als.c                 | 2 +-
 drivers/iio/light/ltr390.c                     | 2 +-
 drivers/iio/light/ltr501.c                     | 2 +-
 drivers/iio/light/max44009.c                   | 2 +-
 drivers/iio/light/opt3001.c                    | 2 +-
 drivers/iio/light/stk3310.c                    | 2 +-
 drivers/iio/light/tcs3472.c                    | 2 +-
 drivers/iio/light/tsl2563.c                    | 2 +-
 drivers/iio/light/tsl2591.c                    | 2 +-
 drivers/iio/light/tsl2772.c                    | 2 +-
 drivers/iio/light/us5182d.c                    | 2 +-
 drivers/iio/light/vcnl4000.c                   | 5 +++--
 drivers/iio/light/veml6030.c                   | 2 +-
 drivers/iio/position/iqs624-pos.c              | 2 +-
 drivers/iio/proximity/aw96103.c                | 2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 2 +-
 drivers/iio/proximity/hx9023s.c                | 2 +-
 drivers/iio/proximity/irsd200.c                | 3 ++-
 drivers/iio/proximity/sx9500.c                 | 2 +-
 drivers/iio/proximity/sx_common.c              | 2 +-
 drivers/iio/proximity/sx_common.h              | 2 +-
 drivers/iio/proximity/vcnl3020.c               | 2 +-
 drivers/iio/temperature/mcp9600.c              | 2 +-
 drivers/iio/temperature/tmp007.c               | 2 +-
 include/linux/iio/iio.h                        | 2 +-
 65 files changed, 72 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index e790a66d86c79f7de9650ea47f11c8990825fd42..705375f3b56e653631491a8316a56d0dcb171e89 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1073,7 +1073,7 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	enum adxl367_activity_type act;
 
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index ef8dd557877bd44570e84579b1af89e6b02cc523..5b9eb364760a281e8ef0ef15124cc1c8e8b0f58c 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -940,7 +940,7 @@ static int adxl372_read_event_config(struct iio_dev *indio_dev, const struct iio
 
 static int adxl372_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
 				      enum iio_event_type type, enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 9f6f0a45efce7981736c3a8f005f4fef83f05cfd..5d2bda1a6a783c3f5bf6dfa6830bc80cc7055e01 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1386,7 +1386,7 @@ static int adxl380_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct adxl380_state *st = iio_priv(indio_dev);
 	enum adxl380_axis axis;
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 0bf5f321cfe79147df01fa674de779e506818b46..906d2577be2d64220046ec56ef675ddafb9a50ab 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1293,7 +1293,7 @@ static int bma400_disable_adv_interrupt(struct bma400_data *data)
 static int bma400_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 0f32c1e92b4dc121bb85516acef4941b0421f100..158579350d596e11ab36d9ea4692e5837cca482e 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -804,7 +804,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 					   const struct iio_chan_spec *chan,
 					   enum iio_event_type type,
 					   enum iio_event_direction dir,
-					   int state)
+					   bool state)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index ab427f3461dbbef535c2ec2cf2982202ca97bb82..f07fba17048e7b5c1958807b14d4bcb3ff87e26d 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -617,7 +617,7 @@ static int
 fxls8962af_write_event_config(struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan,
 			      enum iio_event_type type,
-			      enum iio_event_direction dir, int state)
+			      enum iio_event_direction dir, bool state)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
 	u8 enable_event, enable_bits;
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a6621cd69707bfdf6dfe0b1bf87e0829d2c7c545..6ce84b2dd720b719c0bd9baa653af54539e93ac2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1093,7 +1093,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 					   const struct iio_chan_spec *chan,
 					   enum iio_event_type type,
 					   enum iio_event_direction dir,
-					   int state)
+					   bool state)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index de4525b30edcab8c786708df98f072d569c81f2e..962d289065ab7bb3da5ae102cb5ee2cb96662af5 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -974,7 +974,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int val, ret;
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index a5d20d8d08b8ee54eed0849dad433c00a055ab2c..605022f5239a6412827f4ba059aa18d490908720 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -225,7 +225,7 @@ static int mma9551_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct mma9551_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 1ea6aa00741238a8512294cdc8147a53853e5277..43ba04c606a40debb3befe1df92bd4cc7b7777d3 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -725,7 +725,8 @@ static int mma9553_read_event_config(struct iio_dev *indio_dev,
 static int mma9553_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
-				      enum iio_event_direction dir, int state)
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct mma9553_data *data = iio_priv(indio_dev);
 	struct mma9553_event *event;
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 87c54e41f6ccd2f9311653b757b2d794df1dd5d4..36cbfcbba04d6920ba68bebd70d21bc3898a044d 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1253,7 +1253,7 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index d6876259ad14499df0983b4744834d66aa789f27..eb0a059b4b0e9e8af52e9433032318d853a76c33 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -150,7 +150,8 @@ static int ad7091r_read_event_config(struct iio_dev *indio_dev,
 static int ad7091r_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
-				      enum iio_event_direction dir, int state)
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct ad7091r_state *st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 4c7f887adbbf2f2c857288b19ce8058ee5ebdffb..60e12faa32070183c64a2037c968177cb903cc11 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -269,7 +269,7 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir,
-				     int state)
+				     bool state)
 {
 	int ret = 0;
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 0f107e3fc2c85575e6820f995949a5345e9d69d3..aa44b4e2542b2679c6b5fbe7346e3e9dc17721af 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -406,7 +406,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir,
-				     int state)
+				     bool state)
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index fb635a756440300432b0bbcf1fd9ebce2e9ab92d..689e34f069877ec525c5f9ee7258d5140d4bba70 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -132,7 +132,7 @@ static int hi8435_read_event_config(struct iio_dev *idev,
 static int hi8435_write_event_config(struct iio_dev *idev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct hi8435_priv *priv = iio_priv(idev);
 	int ret;
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 8da2d8d7a9c677c6eb5c4b2903a7954c0105707d..9a0baea08ab6162b024932f3f65c8a68d156672d 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -944,7 +944,7 @@ static inline int __max1363_check_event_mask(int thismask, int checkmask)
 
 static int max1363_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index f6f8f9122a78d1b5e63d8184203eb3dae55eb560..66f206b9465e5d390aa2ad63d7d72d86f457f202 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -740,7 +740,8 @@ static int pac1921_read_event_config(struct iio_dev *indio_dev,
 static int pac1921_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
-				      enum iio_event_direction dir, int state)
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
 	u8 ovf_bit;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 67d567ee21b439e3f296c239c68d8ed6f1723b59..d283ee8fb1d2f219674ece7faa5492503671ac94 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -676,7 +676,7 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
 					   const struct iio_chan_spec *chan,
 					   enum iio_event_type type,
 					   enum iio_event_direction dir,
-					   int state)
+					   bool state)
 {
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int adc_chan = chan->channel;
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 052d2124b21570e0b90fd4aa4048adcc921301ef..47fe8e16aee42d375a74f9e97d4220542b04566d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -806,7 +806,7 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 
 static int ads1015_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index ebc583b07e0c00bd08c3219f595edd8df26a8378..76dd0343f5f76a6b1a8882e41d6a7f333c3a36e4 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -905,7 +905,7 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  enum iio_event_type type,
 				  enum iio_event_direction dir,
-				  int state)
+				  bool state)
 {
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int alarm;
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index 90f62377c34d97fcf3695103edc4d8e9a17d0a83..c188d3dcab48fea007ac065397bb17f952ca09db 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -121,7 +121,7 @@ int xadc_read_event_config(struct iio_dev *indio_dev,
 
 int xadc_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	unsigned int alarm = xadc_get_alarm_mask(chan);
 	struct xadc *xadc = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 3036f4d613ff5d44018c098781576d3f71fd5b49..b4d9d468311723fa79cfd7f10781f788dbf9c9db 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -25,7 +25,7 @@ int xadc_read_event_config(struct iio_dev *indio_dev,
 	enum iio_event_direction dir);
 int xadc_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state);
+	enum iio_event_direction dir, bool state);
 int xadc_read_event_value(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
 	enum iio_event_direction dir, enum iio_event_info info,
diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 4c03b9e834b88d6eafabb63999a1ed2c1720118f..e64a41bae32c67e43fc9021c186170c4bacb2ae3 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -232,7 +232,7 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 static int ad7150_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	int ret = 0;
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 7644acfd879e046ebea39e16a5566f58e9ceefed..1462ee640b16863e779bb550fa64445b5c8bd72c 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -384,7 +384,7 @@ static int ad5421_write_raw(struct iio_dev *indio_dev,
 
 static int ad5421_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
 	unsigned int mask;
diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 7470d97825e0a6b0124c2a3bac3d5709dcded534..f235394589dfb6ae575e37819dfd33dc35f77f23 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -573,7 +573,7 @@ static int ad8460_read_event_value(struct iio_dev *indio_dev,
 static int ad8460_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int val)
+				     enum iio_event_direction dir, bool val)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
 	int fault;
diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index a91622ac54e06e037502fbc956f0bd7c35de7509..8246f25dbad04f2bb612177631ebc1bedfc1f1e9 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -60,7 +60,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
 					const struct iio_chan_spec *chan,
 					enum iio_event_type type,
 					enum iio_event_direction dir,
-					int state);
+					bool state);
 
 int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index 63a2b844be50834e232f653bbb893dee29171c4c..c7f2d3a4d60b2602bd180feca7c141b2dd6e35a7 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -53,7 +53,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
 					const struct iio_chan_spec *chan,
 					enum iio_event_type type,
 					enum iio_event_direction dir,
-					int state)
+					bool state)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index bb235697262bc363f4117aee7eb987318806fa63..ba877d067afb7a7bd0d350edd8f2be86fe673c69 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -748,7 +748,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir,
-				     int state)
+				     bool state)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 1e6c083ea5c1bbddb878f08cd4f4be725c0e319f..76a88e1ccc1d89988eb52d6b1be8da0f5005f0e6 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -785,7 +785,7 @@ static const struct attribute_group bmi323_event_attribute_group = {
 static int bmi323_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 21ebf0f7e28fec302cbf8ab890fc53a3de6f36cd..40271352b02cf6e0acdfa7a8b2d50f384650a6c0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1173,7 +1173,7 @@ static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
 					  const struct iio_chan_spec *chan,
 					  enum iio_event_type type,
 					  enum iio_event_direction dir,
-					  int state)
+					  bool state)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 2af772775b68932db45f2b9a5d40dc8b1bb247b5..324c38764656ad74e2bbdc54824b4321db3c0b81 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -942,7 +942,7 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
 				    enum iio_event_direction dir,
-				    int state)
+				    bool state)
 {
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fb4c6c39ff2e157593f02513cc8e01cd7eea9bdf..caefa15e559b8808051ff1c7f82c3f36c947933c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1959,7 +1959,7 @@ static int
 st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 			      const struct iio_chan_spec *chan,
 			      enum iio_event_type type,
-			      enum iio_event_direction dir, int state)
+			      enum iio_event_direction dir, bool state)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index db57d84da616b91add8c5d1aba08a73ce18c367e..32e58496cb10ae5578935302c08dbbbb46c5f79a 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -502,7 +502,8 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 static int adux1020_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
-				       enum iio_event_direction dir, int state)
+				       enum iio_event_direction dir,
+				       bool state)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
 	int ret, mask, val;
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 11f2ab4ca261813aff04b8c25d4595a531fb43cb..95861b2a5b2d94011d894959289c5c4f06cc1efe 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -321,7 +321,7 @@ static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
 
 static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, int state)
+		enum iio_event_direction dir, bool state)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 079e02be1005210ddd30b384ffa1ff7feeb098d7..8adc74040db2bddf93fbb773e3519abcc726b9a6 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1071,7 +1071,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	struct apds9306_data *data = iio_priv(indio_dev);
 	struct apds9306_regfields *rf = &data->rf;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 3a56eaae5a68f2891d061871c7013f0b5447bb47..a7f0cc99f236685900f89fbc48de3be0e9a40704 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -757,7 +757,7 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	struct apds9960_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index fc6bf062d4f510886f909509d8115f0cf892f3c4..23e9f16090ccdbb672fea741f3f4e361086f0360 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -638,7 +638,7 @@ static int bh1745_read_event_config(struct iio_dev *indio_dev,
 static int bh1745_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
 	int value;
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index a4a1505534c015e3146c00de3e38966ffd712a5b..ae3fc3299eec6c30149bbfcb638d5c0001c30ed9 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -529,7 +529,7 @@ static int cm36651_write_prox_event_config(struct iio_dev *indio_dev,
 					const struct iio_chan_spec *chan,
 					enum iio_event_type type,
 					enum iio_event_direction dir,
-					int state)
+					bool state)
 {
 	struct cm36651_data *cm36651 = iio_priv(indio_dev);
 	int cmd, ret;
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index f8b1d7dd6f5fc69da12cf37ad286112555e4919f..d56ee217fe538c8babb5df510932bd6e67c59ea6 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -340,7 +340,7 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 81e718cdeae32d60581cb490148f4f1c0bd695c7..1a352c88598e5d701256aa8659a7f9683bce56f9 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1159,7 +1159,7 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 					   const struct iio_chan_spec *chan,
 					   enum iio_event_type type,
 					   enum iio_event_direction dir,
-					   int state)
+					   bool state)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	enum gp2ap020a00f_cmd cmd;
diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index 6de33feada3a36f0656e9bdf5289560a49358b5a..b9f230210f0731b82139191366f2309f835c0b6d 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -271,7 +271,7 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 enum iio_event_type type,
 					 enum iio_event_direction dir,
-					 int state)
+					 bool state)
 {
 	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
 	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 3bdffb6360bcbaab4df1a2d39c8ea3813b5d6bd3..df664f36090301e21d6e2f92035198e15e018712 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -553,7 +553,7 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
-				int state)
+				bool state)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7228611d4c59032d7b0e4f3e958cf24184de7f37..b92b5580c91cc7fce338a747630224687357372e 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1077,7 +1077,7 @@ static int ltr501_read_event_config(struct iio_dev *indio_dev,
 static int ltr501_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 3b92362675dc96fd37272bb5c25c20717b8c25b0..8cd7f5664e5b1a13aceb3aaeac3f6eef14a1eaac 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -422,7 +422,7 @@ static int max44009_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	struct max44009_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index ff7fc0d4b08f9905bd6514d5f1c64b5923ec86cb..65b295877b41588d40234ca7681bfee291e937c2 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -634,7 +634,7 @@ static int opt3001_read_event_config(struct iio_dev *iio,
 
 static int opt3001_write_event_config(struct iio_dev *iio,
 		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, int state)
+		enum iio_event_direction dir, bool state)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index c6f950af5afa0f77a617bd2baf0a08eef5ec26f0..b81cc44db43c377ad8a8cc61c4430decb187181d 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -324,7 +324,7 @@ static int stk3310_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	int ret;
 	struct stk3310_data *data = iio_priv(indio_dev);
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 04452b4664f306339db42657c03e08bfc0ffff11..4186aac04902e6b12ee7978ef19c3b47faf773f7 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -327,7 +327,7 @@ static int tcs3472_read_event_config(struct iio_dev *indio_dev,
 
 static int tcs3472_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct tcs3472_data *data = iio_priv(indio_dev);
 	int ret = 0;
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 1a6f514bced6e0bd542c14a279071d5820a462c8..f1fe7640fce63bddad57fbe7809ee60bbfd44e1f 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -630,7 +630,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 
 static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 850c2465992fa0d83430236825ce94051a104272..b81ca6f73f92732dc66a9be35c9dbed5088e8da1 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -985,7 +985,7 @@ static int tsl2591_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct tsl2591_chip *chip = iio_priv(indio_dev);
 	struct i2c_client *client = chip->client;
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 26082f239c4c3aeabfe73ed100d6e885f5266329..349afdcbe30dd0c4c0fbabaa16ff7832e407e8ee 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1081,7 +1081,7 @@ static int tsl2772_write_interrupt_config(struct iio_dev *indio_dev,
 					  const struct iio_chan_spec *chan,
 					  enum iio_event_type type,
 					  enum iio_event_direction dir,
-					  int val)
+					  bool val)
 {
 	struct tsl2772_chip *chip = iio_priv(indio_dev);
 
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index de6967ac3b0b3be02a96f3eb05aa58c49b0c87c7..c83114aed6b23f1d68068105b7c145bedf005b36 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -627,7 +627,7 @@ static int us5182d_read_event_config(struct iio_dev *indio_dev,
 
 static int us5182d_write_event_config(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+	enum iio_event_direction dir, bool state)
 {
 	struct us5182d_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4e3641ff2ed446262c12380e520d3d220865c00c..e19199b17f2ef7ebd022c211605418711b8220d2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1456,7 +1456,7 @@ static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1501,7 +1501,8 @@ static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
 static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
-				       enum iio_event_direction dir, int state)
+				       enum iio_event_direction dir,
+				       bool state)
 {
 	int ret = -EINVAL;
 	u16 val, mask;
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 95751c1015909cd80543a559673f435d1a168f68..208a040ee345c3e137e4e58c397c59ce4d68aa30 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -821,7 +821,7 @@ static int veml6030_read_interrupt_config(struct iio_dev *indio_dev,
  */
 static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, int state)
+		enum iio_event_direction dir, bool state)
 {
 	int ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
index 4d7452314209fedd2e41e52764c6d036535cbbb1..8239239c6ee272f7dd6c4a615a29dd7f28d4be51 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -181,7 +181,7 @@ static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 enum iio_event_type type,
 					 enum iio_event_direction dir,
-					 int state)
+					 bool state)
 {
 	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
 	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 707ba0a510aa5f2a30d3fa70ae81fa58b8dfbc33..cdd254da9e5035e3c3e062fe27982b4108cc6a45 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -422,7 +422,7 @@ static int aw96103_read_event_config(struct iio_dev *indio_dev,
 static int aw96103_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
-				      enum iio_event_direction dir, int state)
+				      enum iio_event_direction dir, bool state)
 {
 	struct aw96103 *aw96103 = iio_priv(indio_dev);
 
diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index b1a4a923e788949b583eca68ebd878e33e385f16..667369be05553ea668bfcd79695645dbf1e56a25 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -167,7 +167,7 @@ static int cros_ec_mkbp_proximity_read_event_config(struct iio_dev *indio_dev,
 static int cros_ec_mkbp_proximity_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
+				     enum iio_event_direction dir, bool state)
 {
 	struct cros_ec_mkbp_proximity_data *data = iio_priv(indio_dev);
 
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 38441b1ee040c7c26047b0cb2ac443ecb8396df3..4021feb7a7ac70a135fb5fdcb832b9218b961fdc 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -874,7 +874,7 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct hx9023s_data *data = iio_priv(indio_dev);
 
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index fb0691da99ee621e19013a64d122f097e793efd9..b09d15230111e6e5bbaae189adc26059a5a19f7a 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -648,7 +648,8 @@ static int irsd200_read_event_config(struct iio_dev *indio_dev,
 static int irsd200_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
-				      enum iio_event_direction dir, int state)
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct irsd200_data *data = iio_priv(indio_dev);
 	unsigned int tmp;
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index e3da709424d5b2bd4e746df7adc4a4969e62f2a6..c4e94d0fb163740e5acb9bd1a3afd694023b04fa 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -540,7 +540,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir,
-				     int state)
+				     bool state)
 {
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret;
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index bcf502e0234236e2362c1eb63da3bc488b0178a1..76384c74fe0120e9d004ecad28b4339793edb414 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_NS_GPL(sx_common_read_event_config, SEMTECH_PROX);
 int sx_common_write_event_config(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
-				 enum iio_event_direction dir, int state)
+				 enum iio_event_direction dir, bool state)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
 	unsigned int eventirq = SX_COMMON_FAR_IRQ | SX_COMMON_CLOSE_IRQ;
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index da53268201a9fcdec9469fb5798d049146b08329..fb14e6f06a6de3485e0b817e4a069d5300ddfb6c 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -143,7 +143,7 @@ int sx_common_read_event_config(struct iio_dev *indio_dev,
 int sx_common_write_event_config(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
-				 enum iio_event_direction dir, int state);
+				 enum iio_event_direction dir, bool state);
 
 int sx_common_probe(struct i2c_client *client,
 		    const struct sx_common_chip_info *chip_info,
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index d1ddf85f53836ec34464d382426b187804964a57..bb6c9cc88b358de098543df8a0da7d22914c5e47 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -449,7 +449,7 @@ static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       int state)
+				       bool state)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index f1bb0976273d37fd662ed4e7e3f43c9ae82e2aaf..c2447860adfd6f4b1a9f4d61e3de301271fe05d9 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -200,7 +200,7 @@ static int mcp9600_write_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      int state)
+				      bool state)
 {
 	struct mcp9600_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index 9bdfa94234929c35f3e4871bc291be21bbfba82e..fd4d389ce1dfec031652d4f7881ec0b72a015998 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -216,7 +216,7 @@ static irqreturn_t tmp007_interrupt_handler(int irq, void *private)
 
 static int tmp007_write_event_config(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, int state)
+		enum iio_event_direction dir, bool state)
 {
 	struct tmp007_data *data = iio_priv(indio_dev);
 	unsigned int status_mask;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 747e89975d369f3c76aa49a96a7dc09f185e2557..409c417daa0cfeb5f7d90d10fe6f637a8e9fa5fe 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -518,7 +518,7 @@ struct iio_info {
 				  const struct iio_chan_spec *chan,
 				  enum iio_event_type type,
 				  enum iio_event_direction dir,
-				  int state);
+				  bool state);
 
 	int (*read_event_value)(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,

-- 
2.47.0


