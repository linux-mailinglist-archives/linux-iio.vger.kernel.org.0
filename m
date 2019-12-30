Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9065312D26E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2019 18:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfL3RSH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Dec 2019 12:18:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:29340 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3RSH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Dec 2019 12:18:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 09:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,376,1571727600"; 
   d="scan'208";a="393292748"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2019 09:18:06 -0800
Message-ID: <7830ad25a5cb7640e1da55c4278ce73c1ff3e0ad.camel@linux.intel.com>
Subject: Re: Display got wrong rotation after hid_sensor_accel_3d is loaded
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Mon, 30 Dec 2019 09:18:06 -0800
In-Reply-To: <CAFv23Qmj_ZqKs9_tw1Grzzj5unFBLfK0Scy396vcHCEB+fdLOA@mail.gmail.com>
References: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
         <9baeb165eddb4872fb701ff81f11692b7e153bf6.camel@hadess.net>
         <CAFv23Qmj_ZqKs9_tw1Grzzj5unFBLfK0Scy396vcHCEB+fdLOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Kao,

Is this device sold with Windows?
Can you send full report descriptor (You can get from
/sys/kernel/debug/hid)?

Thanks,
Srinivas

On Fri, 2019-12-27 at 10:30 +0800, AceLan Kao wrote:
> Hi Bastien,
> 
> Thanks for your suggestion.
> I just tried to add the following line into
> /lib/udev/hwdb.d/60-sensor.hwdb and got the correct screen rotation.
> But the cursor is still un-rotated, the cursor is drawn upside down,
> and its coordinates are inverted.
> 
> #########################################
> # STMicro
> #########################################
> sensor:modalias:platform:platform:HID-SENSOR-200073
>  ACCEL_MOUNT_MATRIX=-1, 0, 0; 0, -1, 0; 0, 0, 1
> 
> It looks like we should introduce a quirk into hid_sensor_accel_3d
> driver.
> There are 3 different scale variables in hid_sensor_accel_3d, but I
> don't see any of them would work the way I want.
> Do you mean to introduce new scale variables?
> 
>    drivers/iio/accel/hid-sensor-accel-3d.c:34:     int
> scale_pre_decml;
>    drivers/iio/accel/hid-sensor-accel-3d.c:35:     int
> scale_post_decml;
>    drivers/iio/accel/hid-sensor-accel-3d.c:36:     int
> scale_precision;
> 
> Bastien Nocera <hadess@hadess.net> 於 2019年12月26日 週四 下午11:03寫道：
> > 
> > On Thu, 2019-12-26 at 17:22 +0800, AceLan Kao wrote:
> > > Hi all,
> > > 
> > > I'm working on a new platform which comes with an accelerator
> > > meter.
> > > It's a STMicroelectronics LSM6DS3US accelerator meter, it doesn't
> > > use
> > > st_sensors driver, but hid_sensor_accel_3d.
> > > After hid_sensor_accel_3d is loaded, the display becomes upside
> > > down,
> > > so I tried to add some code to make it become normal.(ACCEL_X
> > > should
> > > have the same modification)
> > > 
> > > I don't know how to fix this in a correct way, please give me
> > > some
> > > hints.
> > 
> > This needs to be done as a quirk, either by applying a quirk for
> > the
> > HID descriptors (which should have a definition of the scale, which
> > would be negative for this device), or in user-space in systemd's
> > hwdb
> > database, which your user-space consumers need to take care of:
> > 
https://github.com/systemd/systemd/blob/master/hwdb.d/60-sensor.hwdb
> > 
> > Cheers
> > 

