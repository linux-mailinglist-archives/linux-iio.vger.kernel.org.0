Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247746D5C6
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhLHOhi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 09:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhLHOhi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 09:37:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A59C061746
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 06:34:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so8846792eda.12
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepsea-ai.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EBV+/EzY7MB/2wrboM9FXYcDW8gyV9cvBPcNjQT91z0=;
        b=SdB/IThYL4uktyND4+zwwwZ/RZ2loDCBJFcyRydmdEASUNzYv1uEnaEmeQYxYXtRIl
         5aasd7bnz4JRK6IQMNYTB0A+5qiJtKXXJPaGMHvqqfCf0KZIPR1OMuvwJtSOJB5qFfPk
         +dCTMsD//w/+CaykW2J5Z+UvpGyDUBdE58xkk1zKIDnOMzw7BtZ2nJYsb8RPaed2eILJ
         J6UPJKeyEOTYsiTrkfL22q9d+lwgBmL7NfSNdf2uldl2fzhrKygOCBAjtIZyxsGan8g4
         BobxkD+JNcVEFb//mTp+qeeyQRXe49eHz9ukKSquSsAkt6KxZCy0gvQP07SbBUt9XCRh
         ERGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EBV+/EzY7MB/2wrboM9FXYcDW8gyV9cvBPcNjQT91z0=;
        b=BcgSHGSc1qaz2ApS/K/R1U0PeLtv2AAYlgv9zFPwBWQqnEnfxu4PDbNbv9ynVkmutE
         aLDNGqigb36a1QvD+BSuXfZcOSTXBxj7AGHE4CBQndNo+UYR6oOpWNWImTF7JgKGJeyK
         cjBC0yffSetf8CPz8cxEbBX3HxogGsLvB93vAI/vPUYTc7vUCFurkZx9FKSBQJhNInhd
         jlRadWAtoDBM6DN20p39X/HbtAj6gT0hzEhuXY5wP+UgBz/NoV+XMdzlMO1cnQ5CVJtV
         czg79b9e5U7L7OPF6dui5md5AXB14S69f3UsxaGGtsuyj6aevAHekxZEK1ZVGTo+G9kq
         kyAg==
X-Gm-Message-State: AOAM533PrKBUUHrLGXRYEEp59khFdERu5GrVJ8jH4XD5pBUn8wV5At/C
        YPwN9rQpDlrWOLeu0eHiyvsop9PEEiV2v0bNnsxRAl+tcFtWOw==
X-Google-Smtp-Source: ABdhPJw9HAv3JVbVxaloT4dZQdPntK4TN1fAMWz8pC2Tp4EUR5TgS8PYqEV22XNIhKKmuE/VhPtLvgyGBfU38nH1THY=
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr7900076ejc.568.1638974042851;
 Wed, 08 Dec 2021 06:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20211208135644.3523024-1-n.latmos@deepsea.ai>
In-Reply-To: <20211208135644.3523024-1-n.latmos@deepsea.ai>
From:   Nikos Latmos <n.latmos@deepsea.ai>
Date:   Wed, 8 Dec 2021 16:33:52 +0200
Message-ID: <CAC-bbXbkt0oYPn+EWLdEYKyj8G_muWGDZWTApyFv3cb591dc0A@mail.gmail.com>
Subject: [PROBLEM]: Error during probing process in inv_icm42600_i2c driver
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I have an ARM device based on the Broadcom BCM2837 processor (quad-core
ARM Cortex-A53, 1.2GHz), which has an Invensense ICM-42605 IMU chip
connected over I2C. I'm running an unmodified Linux 5.4.83 kernel. The I2C
driver for my device is in the following path:
drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c.

The problem is that the device driver cannot be probed. More specifically,
dmesg returns the following error message:

inv-icm42600-i2c 0-0068: mounting matrix not found: using identity...
inv-icm42600-i2c 0-0068: 0-0068 supply vdd not found, using dummy regulator
inv-icm42600-i2c 0-0068: 0-0068 supply vddio not found, using dummy regulator
inv-icm42600-i2c: probe of 0-0068 failed with error -121

During the debugging procedure, I found out that the failure occurred when
the driver tried to set up the I2C bus parameters. More precisely, by setting
the INV_ICM42600_REG_INTF_CONFIG6 register according to the values described
in the datasheet for the I2C communication, actually caused the probe function
to fail and return the error -121.

After I experimented with different values in the specific register bits,
I came to the conclusion, that the setting of the bit
INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN caused the system to successfully
probe the driver. Any other bit setting combinations failed to do so.

Any hints on why would the driver behave so?

Here is a patch that I have so far and it seems to solve the issue.

Best regards,
Nick Latmos


From d7b3922cd0182ba880ff729edb4a156b55dfb6f0 Mon Sep 17 00:00:00 2001
From: nicklat <n.latmos@deepsea.ai>
Date: Wed, 8 Dec 2021 15:51:28 +0200
Subject: [PATCH] iio: imu: inv_icm42600: enable SDR mode

Add SDR (Single Data Rate) support.
In SDR mode, data is only clocked on one edge of the clock.

Without this option enabled, the probing process fails.

Signed-off-by: nicklat <n.latmos@deepsea.ai>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 85b1934cec60..ea31f102fbca 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -21,7 +21,8 @@ static int inv_icm42600_i2c_bus_setup(struct
inv_icm42600_state *st)
        /* setup interface registers */
        ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
                                 INV_ICM42600_INTF_CONFIG6_MASK,
-                                INV_ICM42600_INTF_CONFIG6_I3C_EN);
+                                INV_ICM42600_INTF_CONFIG6_I3C_EN |
+                                INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN);
        if (ret)
                return ret;

--
2.25.1
