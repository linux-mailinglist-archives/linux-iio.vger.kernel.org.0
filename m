Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6CA9DE6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfIEJLg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 05:11:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731167AbfIEJLf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 05:11:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53E187B649258E9DD4E;
        Thu,  5 Sep 2019 17:11:34 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 17:11:29 +0800
Date:   Thu, 5 Sep 2019 10:11:17 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PULL v3] Second set of new device support, cleanups etc for
 IIO in the 5.4 cycle.
Message-ID: <20190905101117.00006785@huawei.com>
In-Reply-To: <20190905053449.GA16997@kroah.com>
References: <20190903211708.2ba07358@archlinux>
        <20190905025008.GA3207@archlinux-threadripper>
        <20190905053449.GA16997@kroah.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Sep 2019 07:34:49 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Sep 04, 2019 at 07:50:08PM -0700, Nathan Chancellor wrote:
> > On Tue, Sep 03, 2019 at 09:17:29PM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> > > 
> > >   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take3
> > > 
> > > for you to fetch changes up to 6fa029486b74c266c39b718b8643ed42d24f977a:
> > > 
> > >   iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1 (2019-09-03 21:11:28 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Second set of new device support, cleanups and features for IIO in the 5.4 cycle
> > > 
> > > Revised pull request to fix up a missing Signed-off-by and roll in
> > > a fix in the lsm9ds1 support after I broke it when applying.
> > > Revised again because the fix changed a hash meaning a fix
> > > that previously followed it now had the wrong fixes tag.
> > > 
> > > A few fixes in here that could have gone a faster path but aren't quite
> > > worth the rush for 5.3.
> > > 
> > > New device support
> > > * ad7606
> > >   - Support the ad7606b which adds a software controlled mode alongside
> > >     the pin controlled only approach of the ad7606. Including dt-bindings.
> > > * lsm6dsx
> > >   - Add support for the gyro and accelerometer part of the lsm9ds1 which is
> > >     a compound device also including a magnetometer (st_sensors driver).
> > >     Includes bindings and precursor rework of the driver.
> > > 
> > > Features
> > > * ad7192
> > >   - Add support for low pass filter control.
> > >   - DT binding docs.
> > > 
> > > Cleanups and minor fixes
> > > * MAINTAINERS
> > >   - Fix a typo in a path.
> > >   - Add entry for ad7606
> > > * ad5380
> > >   - Fix a failure to dereference a pointer before atempting to assign the
> > >     value.
> > > * ad7192
> > >   - Drop platform data as not used in mainline and we now have full DT bindings.
> > > * ad7606
> > >   - YAML conversion for dt-bindings.
> > > * adis16240
> > >   - Rework write_raw to make it more readable using GENMASK.
> > > * adis16460
> > >   - Fix and issue with an unsigned variable holding potential negatives.
> > > * cros_ec
> > >   - Fix missing default of calibration vector so that we get 'something'
> > >     before calibration is complete on a given axis.
> > > * hid-sensors
> > >   - Use int_pow instead of opencoding.
> > > * isl29501
> > >   - rename dt-binding docs to include renesas inline with other renesas parts
> > >     and general current convention.
> > > * kxcjk1013
> > >   - Improve comments on the 'unusual' ACPI ids used to identify which sensor
> > >     is which in certain laptops.
> > > * lsm6dsx
> > >   - Add one bit to the fifo status masks for a number of parts.
> > >   - Drop a reserved entry from the sensitivity values to tidy up interface.
> > >   - Use core conversion macro from G to m/s^2 for lsm9ds1 to make it easier
> > >     to relate to the datasheet and consistent with other parts supported.
> > > * max1027
> > >   - Use device managed APIs to avoid manual error handling and cleanup.
> > > * rfd77402
> > >   - Typo in Kconfig help.
> > > * sc27xx
> > >   - Switch to polling mode from interrupts as interrupt handling typically
> > >     to slow for very short sleeps.
> > > * st-sensors
> > >   - Fix some missing selects for regmap.
> > > * tools
> > >   - Add a .gitignore containing the binary outputs.
> > > 
> > > ----------------------------------------------------------------
> > > Alexandru Ardelean (1):
> > >       iio: imu: adis16460: fix variable signedness
> > > 
> > > Andy Shevchenko (1):
> > >       iio: hid-sensor-attributes: Convert to use int_pow()  
> > 
> > This patch causes a linking failure on arm32 when CONFIG_HID_SENSOR_HUB
> > and CONFIG_HID_SENSOR_IIO_COMMON are set (I caught this on arm32
> > allyesconfig):
> > 
> > arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_read_raw_hyst_value':
> > hid-sensor-attributes.c:(.text+0x23c): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x280): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `hid_sensor_format_scale':
> > hid-sensor-attributes.c:(.text+0x388): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: hid-sensor-attributes.c:(.text+0x414): undefined reference to `__aeabi_uldivmod'
> > arm-linux-gnueabi-ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o:hid-sensor-attributes.c:(.text+0x444): more undefined references to `__aeabi_uldivmod' follow
> > 
> > int_pow() returns u64, which causes issues when just trying to use
> > normal division. Looks like most of the dividends are 32-bit so not
> > really sure how to resolve this otherwise I would have sent a patch.
> > Please look into this when you get a chance.  
> 
> 0-day is now reporting this as well :(

Yes sorry about this.  I'd failed to chase up on why 0-day isn't building
iio.git/testing any more which I'd come to rely on for 32bit coverage.
I have a question out now on that + whether we should just revert this patch
and revisit in the next cycle.  

Thanks,

Jonathan

