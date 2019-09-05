Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0805DA988F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 04:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfIECuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 22:50:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfIECuO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Sep 2019 22:50:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so244310wro.4
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2019 19:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZP0O+jVxv3gqC1t/WFp9pzwShgniSyQeh/xGVVbuYg=;
        b=MQU3+X2AinSL1NWAjqc+NxI0bxWwU5xfCzNHhASmJONgB3DtQoSGRh5lOk85A9Aqqv
         pzTLC3V533mupWrZYOtqvEXCMQYNY1eEvHRXp7i1YES53RtKNcyBHGvDc6wLDtboaFd9
         RTLNtY6hVxuO/rAjHXJDgzFLJXk03eL3f4MX0O2UBH9mGYr5ly4Pp44NDdcwDiKrl5Hy
         k3LNaUyEtU9ZxyoqQjuRV+1SfP4/kMXdoeKBcFYI4+7Jeup3x4SXwTSdZg56jcQuckwK
         PkVwzM3RAtKY+lgIDEG8nb3MX/UfIiaa4DQdouz/j6Iab08hqnJ2IOYRhutz8MeG2P6z
         heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZP0O+jVxv3gqC1t/WFp9pzwShgniSyQeh/xGVVbuYg=;
        b=DNLKATD1BVirC0abFBmjXbcR+nptwF4bnur9g8qyLa+nJphx8rjIVD5IkVYBZv+xz8
         NRyyXwYre/q5u6zx4zQKtXWgSIKa8IUkUoIGoRQL8zhL5D6eXKHDWs3S7GQMe5WjqjXo
         SrEDpEZOeqojn6Vo+2eek5Ym/MW1FzhyBmFngeT8oe7YeUAwN12EiLve3Duk+Uld1WiL
         wIf8DjQjLD2Uxo43ewIkHX+4HevJGtYwMGPEIc9GzqpWxbfkWQ4imKQjt4RTapMhxHAZ
         jaOm5JTkAJesMcCOMOfxypuPGRE7lGOx/jRNYN5T5C5URiLbDPQk0EsSF4AdJzkMsOUJ
         uoew==
X-Gm-Message-State: APjAAAXzsYIYGTrSRUWSBE730RKDUdepdGjcikuHGymZrcue6PCsyfCr
        pRjCZu+t1W7yLqX/emmduFo=
X-Google-Smtp-Source: APXvYqwY1ZidDupWsk2PTVontFx/5DRHq97DAHRNmj3YVqxdASGdlw1x7w3MLkPY7or+u4VIex4U+A==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr559006wrv.312.1567651810863;
        Wed, 04 Sep 2019 19:50:10 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id m18sm759672wrg.97.2019.09.04.19.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 19:50:10 -0700 (PDT)
Date:   Wed, 4 Sep 2019 19:50:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL v3] Second set of new device support, cleanups etc for IIO
 in the 5.4 cycle.
Message-ID: <20190905025008.GA3207@archlinux-threadripper>
References: <20190903211708.2ba07358@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903211708.2ba07358@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 03, 2019 at 09:17:29PM +0100, Jonathan Cameron wrote:
> The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> 
>   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take3
> 
> for you to fetch changes up to 6fa029486b74c266c39b718b8643ed42d24f977a:
> 
>   iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1 (2019-09-03 21:11:28 +0100)
> 
> ----------------------------------------------------------------
> Second set of new device support, cleanups and features for IIO in the 5.4 cycle
> 
> Revised pull request to fix up a missing Signed-off-by and roll in
> a fix in the lsm9ds1 support after I broke it when applying.
> Revised again because the fix changed a hash meaning a fix
> that previously followed it now had the wrong fixes tag.
> 
> A few fixes in here that could have gone a faster path but aren't quite
> worth the rush for 5.3.
> 
> New device support
> * ad7606
>   - Support the ad7606b which adds a software controlled mode alongside
>     the pin controlled only approach of the ad7606. Including dt-bindings.
> * lsm6dsx
>   - Add support for the gyro and accelerometer part of the lsm9ds1 which is
>     a compound device also including a magnetometer (st_sensors driver).
>     Includes bindings and precursor rework of the driver.
> 
> Features
> * ad7192
>   - Add support for low pass filter control.
>   - DT binding docs.
> 
> Cleanups and minor fixes
> * MAINTAINERS
>   - Fix a typo in a path.
>   - Add entry for ad7606
> * ad5380
>   - Fix a failure to dereference a pointer before atempting to assign the
>     value.
> * ad7192
>   - Drop platform data as not used in mainline and we now have full DT bindings.
> * ad7606
>   - YAML conversion for dt-bindings.
> * adis16240
>   - Rework write_raw to make it more readable using GENMASK.
> * adis16460
>   - Fix and issue with an unsigned variable holding potential negatives.
> * cros_ec
>   - Fix missing default of calibration vector so that we get 'something'
>     before calibration is complete on a given axis.
> * hid-sensors
>   - Use int_pow instead of opencoding.
> * isl29501
>   - rename dt-binding docs to include renesas inline with other renesas parts
>     and general current convention.
> * kxcjk1013
>   - Improve comments on the 'unusual' ACPI ids used to identify which sensor
>     is which in certain laptops.
> * lsm6dsx
>   - Add one bit to the fifo status masks for a number of parts.
>   - Drop a reserved entry from the sensitivity values to tidy up interface.
>   - Use core conversion macro from G to m/s^2 for lsm9ds1 to make it easier
>     to relate to the datasheet and consistent with other parts supported.
> * max1027
>   - Use device managed APIs to avoid manual error handling and cleanup.
> * rfd77402
>   - Typo in Kconfig help.
> * sc27xx
>   - Switch to polling mode from interrupts as interrupt handling typically
>     to slow for very short sleeps.
> * st-sensors
>   - Fix some missing selects for regmap.
> * tools
>   - Add a .gitignore containing the binary outputs.
> 
> ----------------------------------------------------------------
> Alexandru Ardelean (1):
>       iio: imu: adis16460: fix variable signedness
> 
> Andy Shevchenko (1):
>       iio: hid-sensor-attributes: Convert to use int_pow()

This patch causes a linking failure on arm32 when CONFIG_HID_SENSOR_HUB
and CONFIG_HID_SENSOR_IIO_COMMON are set (I caught this on arm32
allyesconfig):

arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_read_raw_hyst_value':
hid-sensor-attributes.c:(.text+0x23c): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x280): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_format_scale':
hid-sensor-attributes.c:(.text+0x388): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x414): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o:hid-sensor-attributes.c:(.text+0x444): more undefined references to `__aeabi_uldivmod' follow

int_pow() returns u64, which causes issues when just trying to use
normal division. Looks like most of the dividends are 32-bit so not
really sure how to resolve this otherwise I would have sent a patch.
Please look into this when you get a chance.

Cheers,
Nathan
