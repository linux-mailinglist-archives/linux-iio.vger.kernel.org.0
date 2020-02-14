Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA43A15D126
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 05:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgBNEkP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Feb 2020 23:40:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:49367 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgBNEkO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Feb 2020 23:40:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 20:40:13 -0800
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="347881419"
Received: from amanivas-mobl.gar.corp.intel.com ([10.252.162.109])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 20:40:08 -0800
Message-ID: <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Date:   Thu, 13 Feb 2020 20:40:05 -0800
In-Reply-To: <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
         <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com>
         <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-02-13 at 15:56 +0100, Benjamin Tissoires wrote:
> Hi,
> 
> On Wed, Feb 12, 2020 at 3:45 PM Hans de Goede <hdegoede@redhat.com>
> wrote:
> > Hi,
> > 
> > On 2/12/20 3:56 AM, Sandeep Singh wrote:
> > > From: Sandeep Singh <sandeep.singh@amd.com>
> > > 
> > > AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> > > is part of MP2 processor (MP2 which is an ARM® Cortex-M4
> > > core based co-processor to x86) and it runs on MP2 where
> > > in driver resides on X86.The driver functionalities are
> > > divided  into three parts:-
> > > 
> > > 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
> > > and
> > >                          provide that data into DRAM.
> > > 2: Client driver :-     This part for driver will use dram data
> > > and
> > >                          convert that data into HID format based
> > > on
> > >                          HID reports.
> > > 3: Transport driver :-  This part of driver will communicate with
> > >                          HID core. Communication between devices
> > > and
> > >                          HID core is mostly done via HID reports
> > > 
> > > In terms of architecture it is much more reassembles like
> > > ISH(Intel Integrated Sensor Hub). However the major difference
> > > is all the hid reports are generated as part of kernel driver.
> > > AMD SFH driver taken reference from ISH in terms of
> > > design and functionalities at fewer location.
> > > 
> > > AMD sensor fusion Hub is part of a SOC 17h family based
> > > platforms.
> > > The solution is working well on several OEM products.
> > > AMD SFH uses HID over PCIe bus.
> > 
> > I started looking at this patch because of the phoronix' news item
> > on it.
> > 
> > First of all I want to say that it is great that AMD is working on
> > getting the Sensor Fusion Hub supported on Linux and that you are
> > working on a driver for this.
> 
> Yep, couldn't agree more :)
> 
> > But, I've taken a quick look, mainly at the
> > "[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD
> > sensor fusion Hub (SFH)"
> > patch.
> > 
> > AFAIK with the Intel ISH the sensor-hub itself is actually
> > providing
> > HID descriptors and HID input reports.
> > 
> > Looking at the AMD code, that does not seem to be the case, it
> > seems
> > the values come directly from the AMD sensor-hub without being in
> > any
> > HID specific form, e.g.:
> > 
> > +u8 get_input_report(int sensor_idx, int report_id,
> > +                   u8 *input_report, u32 *sensor_virt_addr)
> > +{
> > +       u8 report_size = 0;
> > +       struct accel3_input_report acc_input;
> > +       struct gyro_input_report gyro_input;
> > +       struct magno_input_report magno_input;
> > +       struct als_input_report als_input;
> > +
> > +       if (!sensor_virt_addr || !input_report)
> > +               return report_size;
> > +
> > +       switch (sensor_idx) {
> > +       case ACCEL_IDX: /* accel */
> > +               acc_input.common_property.report_id = report_id;
> > +               acc_input.common_property.sensor_state =
> > +                                       HID_USAGE_SENSOR_STATE_READ
> > Y_ENUM;
> > +               acc_input.common_property.event_type =
> > +                               HID_USAGE_SENSOR_EVENT_DATA_UPDATED
> > _ENUM;
> > +               acc_input.in_accel_x_value =
> > (int)sensor_virt_addr[0] /
> > +                                               AMD_SFH_FIRMWARE_MU
> > LTIPLIER;
> > +               acc_input.in_accel_y_value =
> > (int)sensor_virt_addr[1] /
> > +                                               AMD_SFH_FIRMWARE_MU
> > LTIPLIER;
> > +               acc_input.in_accel_z_value
> > =  (int)sensor_virt_addr[2] /
> > +                                               AMD_SFH_FIRMWARE_MU
> > LTIPLIER;
> > +               memcpy(input_report, &acc_input,
> > sizeof(acc_input));
> > +               report_size = sizeof(acc_input);
> > +               break;
> > 
> > And the descriptors are hardcoded in the driver so as to fake a HID
> > device.
> > 
> > So going through the HID subsystem seems like an unnecessary
> > detour,
> > which just makes things needlessly complex and harder to debug
> > (and extend).
> > 
> > The HID devices which the current patch-set is creating ultimately
> > will result in a number of devices being created under
> > 
> > /sys/bus/iio/devices
> > 
> > And this are the devices which userspace uses to get the sensor
> > data.
> > 
> > IMHO instead of going through the HID subsys the AMD Sensor Fusion
> > Hub
> > driver should simply register 4 (*) iio-devices itself and directly
> > pass the data through at the iio subsys level rather then going the
> > long way around by creating a fake HID device which then gets
> > attached to by the hid-sensor driver to ultimately create the same
> > iio-devices.
> > 
> > There are examples of e.g. various iio accel drivers under:
> > drivers/iio/accel/ you could start with a simple driver supporting
> > just the accelerometer bits and then extend things from there.
> > 
> > Benjamin, Jiri, Jonathan, what is your take on this?
> 
> Hard to say without knowing AMD roadmap for that. If they intend to
> have an ISH-like approach in the end with reports and descriptors
> provided by the firmwares, then it makes sense to keep this
> architecture for the first revision of devices.
> If not, then yes, this is probably overkill compared to what needs to
> be done.
> 
I suggested this approach to follow something like Chrome-OS EC based
hub, but looks like in longer run this may come from firmware. That's
why they may have decided.

Thanks,
Srinivas
 

> Sandeep, can you explain to us why you think using HID is the best
> way?
> 
> On a side note, I don't necessarily like patch 4/5 with the debugfs
> interface. It's adding a kernel API for no gain, and we should
> already
> have the debug API available in the various subsystems involved.
> 
> Cheers,
> Benjamin
> 
> 
> 
> 
> > Regards,
> > 
> > Hans
> > 
> > 
> > *) One for accel, gyra, magneto and light each
> > 
> > 
> > > Sandeep Singh (5):
> > >    SFH: Add maintainers and documentation for AMD SFH based on
> > > HID
> > >      framework
> > >    SFH: PCI driver to add support of AMD sensor fusion Hub using
> > > HID
> > >      framework
> > >    SFH: Transport Driver to add support of AMD Sensor Fusion Hub
> > > (SFH)
> > >    SFH: Add debugfs support to AMD Sensor Fusion Hub
> > >    SFH: Create HID report to Enable support of AMD sensor fusion
> > > Hub
> > >      (SFH)
> > > 
> > > Changes since v1:
> > >          -Fix auto build test warnings
> > >          -Fix warnings captured using smatch
> > >          -Changes suggested by Dan Carpenter
> > > 
> > > Links of the review comments for v1:
> > >          [1] https://patchwork.kernel.org/patch/11325163/
> > >          [2] https://patchwork.kernel.org/patch/11325167/
> > >          [3] https://patchwork.kernel.org/patch/11325171/
> > >          [4] https://patchwork.kernel.org/patch/11325187/
> > > 
> > > 
> > > Changes since v2:
> > >          -Debugfs divided into another patch
> > >          -Fix some cosmetic changes
> > >          -Fix for review comments
> > >           Reported and Suggested by:-  Srinivas Pandruvada
> > > 
> > > Links of the review comments for v2:
> > >          [1] https://patchwork.kernel.org/patch/11355491/
> > >          [2] https://patchwork.kernel.org/patch/11355495/
> > >          [3] https://patchwork.kernel.org/patch/11355499/
> > >          [4] https://patchwork.kernel.org/patch/11355503/
> > > 
> > > 
> > >   Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
> > >   MAINTAINERS                                        |   8 +
> > >   drivers/hid/Kconfig                                |   2 +
> > >   drivers/hid/Makefile                               |   1 +
> > >   drivers/hid/amd-sfh-hid/Kconfig                    |  20 +
> > >   drivers/hid/amd-sfh-hid/Makefile                   |  17 +
> > >   drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 243
> > > ++++++++
> > >   drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 177 ++++++
> > >   drivers/hid/amd-sfh-hid/amdsfh-debugfs.c           | 250
> > > ++++++++
> > >   drivers/hid/amd-sfh-hid/amdsfh-debugfs.h           |  14 +
> > >   drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 260
> > > +++++++++
> > >   drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
> > >   drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  85 +++
> > >   .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275
> > > +++++++++
> > >   .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
> > >   .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642
> > > +++++++++++++++++++++
> > >   16 files changed, 2458 insertions(+)
> > >   create mode 100644 Documentation/hid/amd-sfh-hid.rst
> > >   create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
> > >   create mode 100644 drivers/hid/amd-sfh-hid/Makefile
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
> > >   create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
> > >   create mode 100644 drivers/hid/amd-sfh-
> > > hid/hid_descriptor/amd_sfh_hid_descriptor.c
> > >   create mode 100644 drivers/hid/amd-sfh-
> > > hid/hid_descriptor/amd_sfh_hid_descriptor.h
> > >   create mode 100644 drivers/hid/amd-sfh-
> > > hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
> > > 

