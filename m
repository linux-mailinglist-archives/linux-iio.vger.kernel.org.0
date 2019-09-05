Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE9A9A1C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 07:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfIEFew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 01:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfIEFew (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 01:34:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEB1208E4;
        Thu,  5 Sep 2019 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567661691;
        bh=66zEaCSKoqM212x74ChMLWYtqe2rBarZ07Cp5N5KVks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEaHiaUJijbcIx2fVgc+noOFuBUVp1UCPdans7G4nIAiMCKv05xw2fco8s2F8dJ5q
         3mp9QNYszZUF2f7bXSX/oUvy/z+exrIVx4IJIl5QvQBOenDsW6VxtfTwrBMxOL/dBn
         RLH7bWGOxDMdA+MvuDq8LgvNBYzToTmq8kLL1AnU=
Date:   Thu, 5 Sep 2019 07:34:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PULL v3] Second set of new device support, cleanups etc for IIO
 in the 5.4 cycle.
Message-ID: <20190905053449.GA16997@kroah.com>
References: <20190903211708.2ba07358@archlinux>
 <20190905025008.GA3207@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905025008.GA3207@archlinux-threadripper>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 04, 2019 at 07:50:08PM -0700, Nathan Chancellor wrote:
> On Tue, Sep 03, 2019 at 09:17:29PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> > 
> >   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take3
> > 
> > for you to fetch changes up to 6fa029486b74c266c39b718b8643ed42d24f977a:
> > 
> >   iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1 (2019-09-03 21:11:28 +0100)
> > 
> > ----------------------------------------------------------------
> > Second set of new device support, cleanups and features for IIO in the 5.4 cycle
> > 
> > Revised pull request to fix up a missing Signed-off-by and roll in
> > a fix in the lsm9ds1 support after I broke it when applying.
> > Revised again because the fix changed a hash meaning a fix
> > that previously followed it now had the wrong fixes tag.
> > 
> > A few fixes in here that could have gone a faster path but aren't quite
> > worth the rush for 5.3.
> > 
> > New device support
> > * ad7606
> >   - Support the ad7606b which adds a software controlled mode alongside
> >     the pin controlled only approach of the ad7606. Including dt-bindings.
> > * lsm6dsx
> >   - Add support for the gyro and accelerometer part of the lsm9ds1 which is
> >     a compound device also including a magnetometer (st_sensors driver).
> >     Includes bindings and precursor rework of the driver.
> > 
> > Features
> > * ad7192
> >   - Add support for low pass filter control.
> >   - DT binding docs.
> > 
> > Cleanups and minor fixes
> > * MAINTAINERS
> >   - Fix a typo in a path.
> >   - Add entry for ad7606
> > * ad5380
> >   - Fix a failure to dereference a pointer before atempting to assign the
> >     value.
> > * ad7192
> >   - Drop platform data as not used in mainline and we now have full DT bindings.
> > * ad7606
> >   - YAML conversion for dt-bindings.
> > * adis16240
> >   - Rework write_raw to make it more readable using GENMASK.
> > * adis16460
> >   - Fix and issue with an unsigned variable holding potential negatives.
> > * cros_ec
> >   - Fix missing default of calibration vector so that we get 'something'
> >     before calibration is complete on a given axis.
> > * hid-sensors
> >   - Use int_pow instead of opencoding.
> > * isl29501
> >   - rename dt-binding docs to include renesas inline with other renesas parts
> >     and general current convention.
> > * kxcjk1013
> >   - Improve comments on the 'unusual' ACPI ids used to identify which sensor
> >     is which in certain laptops.
> > * lsm6dsx
> >   - Add one bit to the fifo status masks for a number of parts.
> >   - Drop a reserved entry from the sensitivity values to tidy up interface.
> >   - Use core conversion macro from G to m/s^2 for lsm9ds1 to make it easier
> >     to relate to the datasheet and consistent with other parts supported.
> > * max1027
> >   - Use device managed APIs to avoid manual error handling and cleanup.
> > * rfd77402
> >   - Typo in Kconfig help.
> > * sc27xx
> >   - Switch to polling mode from interrupts as interrupt handling typically
> >     to slow for very short sleeps.
> > * st-sensors
> >   - Fix some missing selects for regmap.
> > * tools
> >   - Add a .gitignore containing the binary outputs.
> > 
> > ----------------------------------------------------------------
> > Alexandru Ardelean (1):
> >       iio: imu: adis16460: fix variable signedness
> > 
> > Andy Shevchenko (1):
> >       iio: hid-sensor-attributes: Convert to use int_pow()
> 
> This patch causes a linking failure on arm32 when CONFIG_HID_SENSOR_HUB
> and CONFIG_HID_SENSOR_IIO_COMMON are set (I caught this on arm32
> allyesconfig):
> 
> arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_read_raw_hyst_value':
> hid-sensor-attributes.c:(.text+0x23c): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x280): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_format_scale':
> hid-sensor-attributes.c:(.text+0x388): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x414): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o:hid-sensor-attributes.c:(.text+0x444): more undefined references to `__aeabi_uldivmod' follow
> 
> int_pow() returns u64, which causes issues when just trying to use
> normal division. Looks like most of the dividends are 32-bit so not
> really sure how to resolve this otherwise I would have sent a patch.
> Please look into this when you get a chance.

0-day is now reporting this as well :(
