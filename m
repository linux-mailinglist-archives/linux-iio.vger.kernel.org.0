Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303BC3445A5
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCVNYi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCVNYQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 09:24:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB82C061756
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:24:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u4so21007769ljo.6
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWRPYpGeHomkJqdhoguoY1NbJR7GWM7qtJctWdWwN5s=;
        b=bxXUp7mJWw6PkOODhzOWbgAqSUBRp73Mt35Tazoh9dqDFt1vmIRVUFqIf8G2nc8IVB
         58Ws7QyxXxmybknx4QATp1DoDFLya5a6GUoxqYAd76qYjpeJZUVUMZjqgALEhNQznpIG
         m02ZEyNidK/pO+rvckdVa0Ij/37iWg195uSslX3g49YQ9B+Dzbr5z9RQqcMOxBkPAWHW
         gG5RiJz/8UHnTzWBTlN2vtE1cJ4DVpy9GA1X+8nqqot8SIzNFl9W0ljrMLd+nkSW44oQ
         Qz1o1dt9m1GlwioHqEtql9QYKXqsVT8qq/NaaJsR5zbprNtC49jRckuOBFXTb3lqqb57
         +4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWRPYpGeHomkJqdhoguoY1NbJR7GWM7qtJctWdWwN5s=;
        b=M5iLNP+REQ83Ql99Djebj0Ts25v9xdsqGIDVBl+1hX6qH3G0oQz9XemSDOIl76yjp9
         TTCHTWEQzbHdhy2metkzkyNiZtHX1W/oRoNlaXCDb165UF0iCn54BM4S+NPqPaiMRgOw
         ALrdEILpjnXAColfCq6+Fk94FSqUAWa0cdBA/2VuV4bVsADCMUId5y5cLj8wWiFbIwZK
         lmZOViSAASIfxfZhKbmb9uv1iUAziv69igjXqORFjeDZcPEHrY+urgRSnOt8HMeR6cmd
         6CMj3Ob0aKiWQx6Fxqezdp3PbQvzMFYGHIyI7xqugYCE0PZ0kVQh11sEy4D/gocew9xF
         gNmw==
X-Gm-Message-State: AOAM5307gdjO8pdqArn6pXzc3AI9sL2pZv9KzLL4s393yUwzfM3V5jGU
        VINaj6ifRW1EdP7c0E+FBreMwQ==
X-Google-Smtp-Source: ABdhPJz8cuBZeBlEEZF0RRih1h6zzzkNqT1sUHGnK8DNulVGcNDRPtRDW0z/bhXlm+jnTBiKY/Gd3g==
X-Received: by 2002:a2e:5710:: with SMTP id l16mr9390473ljb.228.1616419453593;
        Mon, 22 Mar 2021 06:24:13 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id w5sm1565293lfu.179.2021.03.22.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:24:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger
Date:   Mon, 22 Mar 2021 14:24:08 +0100
Message-Id: <20210322132408.1003443-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It may happen that the MPU6050 is the only hardware
trigger available on your system such as this:

> lsiio
Device 003: hscdtd008a
Device 001: mpu6050
Device 002: gp2ap002
Device 000: ab8500-gpadc
Trigger 000: mpu6050-dev1

And when you want to use it to read periodically from
your magnetometer like this:

> iio_generic_buffer -a -c 100 -n hscdtd008a -t mpu6050-dev1

Then the following happens:

[  209.951334] Internal error: Oops: 5 [#1] SMP ARM
(...)
[  209.981969] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[  209.988925] PC is at inv_scan_query_mpu6050+0x8/0xb8
[  209.993914] LR is at inv_mpu6050_set_enable+0x40/0x194

This is because since we are not using any channels from the
same device, the indio_dev->active_scan_mask is NULL.

Just checking for that and bailing out is however not enough:
we have to enable some kind of FIFO for the readout to work.
So enable the temperature as a dummy FIFO and all works
fine.

Fixes: 09a642b78523 ("Invensense MPU6050 Device Driver.")
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add Fixes: tag, this is the initial commit but I do not
  think backporting makes sense, this is a non-regression
  non-critical fix.
- Fix a nit found by Andy (return mask value directly).
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f7b5a70be30f..de8ed1446d60 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -11,6 +11,16 @@ static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 	unsigned int mask;
 
+	/*
+	 * If the MPU6050 is just used as a trigger, then the scan mask
+	 * is not allocated so we simply enable the temperature channel
+	 * as a dummy and bail out.
+	 */
+	if (!indio_dev->active_scan_mask) {
+		st->chip_config.temp_fifo_enable = true;
+		return INV_MPU6050_SENSOR_TEMP;
+	}
+
 	st->chip_config.gyro_fifo_enable =
 		test_bit(INV_MPU6050_SCAN_GYRO_X,
 			 indio_dev->active_scan_mask) ||
-- 
2.29.2

