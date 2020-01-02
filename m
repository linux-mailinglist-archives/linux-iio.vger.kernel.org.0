Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9C12E981
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgABRnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 12:43:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:49206 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgABRnt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Jan 2020 12:43:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 09:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,387,1571727600"; 
   d="scan'208";a="244666361"
Received: from spandruv-mobl3.jf.intel.com ([10.254.45.199])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2020 09:43:47 -0800
Message-ID: <19ec09f45d1728c852ff30c7a6c18d9aca826923.camel@linux.intel.com>
Subject: Re: Display got wrong rotation after hid_sensor_accel_3d is loaded
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Thu, 02 Jan 2020 09:43:47 -0800
In-Reply-To: <CAFv23Q=aOq1YCQnW7r_eSRn1COfpvQkfjtK2+a3zU0ggxnuYew@mail.gmail.com>
References: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
         <9baeb165eddb4872fb701ff81f11692b7e153bf6.camel@hadess.net>
         <CAFv23Qmj_ZqKs9_tw1Grzzj5unFBLfK0Scy396vcHCEB+fdLOA@mail.gmail.com>
         <7830ad25a5cb7640e1da55c4278ce73c1ff3e0ad.camel@linux.intel.com>
         <CAFv23Q=aOq1YCQnW7r_eSRn1COfpvQkfjtK2+a3zU0ggxnuYew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-01-02 at 10:46 +0800, AceLan Kao wrote:
> Yes, this machine will be sold with Windows, but currently we didn't
> hear any issues from Windows side.
There are custom sensors, which probably getting used by Windows
instead of accel_3d. I didn't see any special fields in accel_3d.

Thanks,
Srinivas

> Here is the rdesc I found under /sys/kernel/debug/hid
> 
> BTW, we're trying to push BIOS to provide some useful info about the
> orientation of the sensor, so that we don't have to list those
> machines in the driver.
> 
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 於
> 2019年12月31日 週二 上午1:18寫道：
> > Hi Kao,
> > 
> > Is this device sold with Windows?
> > Can you send full report descriptor (You can get from
> > /sys/kernel/debug/hid)?
> > 
> > Thanks,
> > Srinivas
> > 
> > On Fri, 2019-12-27 at 10:30 +0800, AceLan Kao wrote:
> > > Hi Bastien,
> > > 
> > > Thanks for your suggestion.
> > > I just tried to add the following line into
> > > /lib/udev/hwdb.d/60-sensor.hwdb and got the correct screen
> > > rotation.
> > > But the cursor is still un-rotated, the cursor is drawn upside
> > > down,
> > > and its coordinates are inverted.
> > > 
> > > #########################################
> > > # STMicro
> > > #########################################
> > > sensor:modalias:platform:platform:HID-SENSOR-200073
> > >  ACCEL_MOUNT_MATRIX=-1, 0, 0; 0, -1, 0; 0, 0, 1
> > > 
> > > It looks like we should introduce a quirk into
> > > hid_sensor_accel_3d
> > > driver.
> > > There are 3 different scale variables in hid_sensor_accel_3d, but
> > > I
> > > don't see any of them would work the way I want.
> > > Do you mean to introduce new scale variables?
> > > 
> > >    drivers/iio/accel/hid-sensor-accel-3d.c:34:     int
> > > scale_pre_decml;
> > >    drivers/iio/accel/hid-sensor-accel-3d.c:35:     int
> > > scale_post_decml;
> > >    drivers/iio/accel/hid-sensor-accel-3d.c:36:     int
> > > scale_precision;
> > > 
> > > Bastien Nocera <hadess@hadess.net> 於 2019年12月26日 週四 下午11:03寫道：
> > > > On Thu, 2019-12-26 at 17:22 +0800, AceLan Kao wrote:
> > > > > Hi all,
> > > > > 
> > > > > I'm working on a new platform which comes with an accelerator
> > > > > meter.
> > > > > It's a STMicroelectronics LSM6DS3US accelerator meter, it
> > > > > doesn't
> > > > > use
> > > > > st_sensors driver, but hid_sensor_accel_3d.
> > > > > After hid_sensor_accel_3d is loaded, the display becomes
> > > > > upside
> > > > > down,
> > > > > so I tried to add some code to make it become normal.(ACCEL_X
> > > > > should
> > > > > have the same modification)
> > > > > 
> > > > > I don't know how to fix this in a correct way, please give me
> > > > > some
> > > > > hints.
> > > > 
> > > > This needs to be done as a quirk, either by applying a quirk
> > > > for
> > > > the
> > > > HID descriptors (which should have a definition of the scale,
> > > > which
> > > > would be negative for this device), or in user-space in
> > > > systemd's
> > > > hwdb
> > > > database, which your user-space consumers need to take care of:
> > > > 
> > https://github.com/systemd/systemd/blob/master/hwdb.d/60-sensor.hwdb
> > > > Cheers
> > > > 

