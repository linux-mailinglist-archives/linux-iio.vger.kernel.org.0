Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688C1182385
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgCKUu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 16:50:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCKUu2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 16:50:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so3898762ljj.7
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2020 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kIernzhyjsVY1rKtF4ETvR/ADo7/EzV9Slge1+0oT4Y=;
        b=h7Gzd4wH6LcmUMnIjBJHEpbuAzHFiCmBIJSpYU2HKamm4ZJGcY5OwfX2T90YePws7n
         0vJXI7VEvS1mMHbFbDooAuEPwmrB/GNAkf8V5sZbrPl9Iz6rsQuUjKGeic9Np2672Ruj
         3Cb0h+iyN6oB+ixhFN8pryr3DLtmdfCKFAEERhmWrIumjg961zodWj4l6tI8AQOPZdmQ
         NA1X+VbFY8Nl6CgNfWkQ4oYHzFMxvxfTaXag8LHUtSJtEed93wqjZCY027DTdrkfURlN
         FBrzOyR5xEVVZ9SiitlhWuzFhLBpJUeQXFGxBxsx2Q80tmMvPXZaGyeNtDQAiwjXkvhn
         kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kIernzhyjsVY1rKtF4ETvR/ADo7/EzV9Slge1+0oT4Y=;
        b=gJI2U1sbbde3YcPC6FEKJQYXEuZrhMJ1q8PHxjgrgCvJ8CoAk5DYzzgl87cjmRK+yS
         sBSLGfjeAvvTdjEpDxkN47CYAhRPPE0DFQpaMPxKyLKFwbMtlSLGfWPPx2PMAqLbQ3Ze
         PEd65g/YRIUUqAXDH/ptjIhZFMfaIP/tkEIgv9+CZe6nD57MXYL4M++yM5AhR0v4aJKd
         uUir2nSzw3xvZcITf6PWjfsL75cR9WJeVbO3DwXyKuwzjfKzhNIPx8qn+PkRtwIV9FNU
         CWls8CzANAbYznoyUr5oiKUsypGsrfpJdR1j7ldPCKKDbjgFRzfcLCYWszt8kGRo4k3X
         kkjg==
X-Gm-Message-State: ANhLgQ1XRHLRqMLmflemgxSXM8q+mLfNjposvVsJIkHmW8Gpa/ouA+uh
        /ju/NiylER6EqiJgR/XG1ng=
X-Google-Smtp-Source: ADFU+vuK9y6FpTluu3YG3LtJdbutTZkdgZDUlfeKaiFg+nCC3BpUWX4Kg/TAlLetOmkqXGMEdQQYFA==
X-Received: by 2002:a2e:869a:: with SMTP id l26mr3065873lji.286.1583959826219;
        Wed, 11 Mar 2020 13:50:26 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id e4sm18829829ljl.27.2020.03.11.13.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 13:50:25 -0700 (PDT)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
Date:   Wed, 11 Mar 2020 21:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

We are working on a project where we want to connect LS6DSM (via SPI), and
connect LIS3MDL via the sensor hub, as I2C slave device.

We would like to add settings/configuration for LIS3MDL, to the shub
source, since currently only LIS2MDL is supported. We've made an attempt,
see diff at end of this mail.

1. LIS2MDL only got a single full scale setting, hence it is not possible
    to change. While LIS3MDL got four possible settings. Is it enough to add
    a corresponding function like st_lsm6dsx_shub_set_fs_val() and call it
    from st_lsm6dsx_shub_write_raw(), when mask == IIO_CHAN_INFO_SCALE?
2. LIS3MDL got 8 possible ODR settings, however ST_LSM6DSX_ODR_LIST_SIZE is
    defined to 6 (st_lsm6dsx.h). Is it fine to increase
    ST_LSM6DSX_ODR_LIST_SIZE to 8? This will also affect odr_table in
    struct st_lsm6dsx_settings.
3. In the patch, we've tried to copy the correct registers and values from
    magnetometer/st_magn_core.c, does it look ok?

The IIO subsystem is new to use, we possibly miss fundamental knowledge.

Regards,
jimmy

---
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index eea5556..8621dba 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
  			.len = 6,
  		},
  	},
+	/* LIS3MDL */
+	{
+		.i2c_addr = { 0x1e },
+		.wai = {
+			.addr = 0x0f,
+			.val = 0x3d,
+		},
+		.id = ST_LSM6DSX_ID_MAGN,
+		.odr_table = {
+			.reg = {
+				.addr = 0x20,
+				.mask = GENMASK(4, 2),
+			},
+			.odr_avl[0] = {  1000, 0x0 },
+			.odr_avl[1] = {  2000, 0x1 },
+			.odr_avl[2] = {  3000, 0x2 },
+			.odr_avl[3] = {  5000, 0x3 },
+			.odr_avl[4] = { 10000, 0x4 },
+			.odr_avl[5] = { 20000, 0x5 },
+			.odr_avl[6] = { 40000, 0x6 },
+			.odr_avl[7] = { 80000, 0x7 },
+			.odr_len = 8,
+		},
+		.fs_table = {
+			.reg = {
+				.addr = 0x21,
+				.mask = GENMASK(6, 5),
+			},
+			.fs_avl[0] = {
+				.gain = 146,
+				.val = 0x00,
+			}, /* 4000 uG/LSB */
+			.fs_avl[1] = {
+				.gain = 292,
+				.val = 0x01,
+			}, /* 8000 uG/LSB */
+			.fs_avl[2] = {
+				.gain = 438,
+				.val = 0x02,
+			}, /* 12000 uG/LSB */
+			.fs_avl[3] = {
+				.gain = 584,
+				.val = 0x03,
+			}, /* 16000 uG/LSB */
+			.fs_len = 4,
+		},
+		.pwr_table = {
+			.reg = {
+				.addr = 0x22,
+				.mask = GENMASK(1, 0),
+			},
+			.off_val = 0x2,
+			.on_val = 0x0,
+		},
+		.bdu = {
+			.addr = 0x24,
+			.mask = BIT(6),
+		},
+		.out = {
+			.addr = 0x28,
+			.len = 6,
+		},
+	},
  };
