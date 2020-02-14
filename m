Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFEF15D658
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBNLMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 06:12:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42342 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387434AbgBNLMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 06:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581678734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EgADtpXAIc9NC8vLjU5weib7HnB3a9Giee4qncSXqQ=;
        b=Xs0RsahvFwCp29abo8vRmou/9nd62H3oCWfsoWr+6FWYredgGfGgt4ZDrX6CDwBBerVpqz
        UUxTW84B6B7rleQ/C8NWw4rZYrrt2enNAtokqYnhYpH8wFNVD6F03tPnFgviPPR1tmdboV
        K6Gfe0kijDCxT97TIE+Y4Oc7RTqUICo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-JU5JXYC0NlOpGkg3BHkLhQ-1; Fri, 14 Feb 2020 06:12:13 -0500
X-MC-Unique: JU5JXYC0NlOpGkg3BHkLhQ-1
Received: by mail-qt1-f200.google.com with SMTP id c8so5667109qte.22
        for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2020 03:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EgADtpXAIc9NC8vLjU5weib7HnB3a9Giee4qncSXqQ=;
        b=SBIjXtZJhz5NuFq9Rfabpk4izYWtqrq28qoV6g70Gul7KIyk/fjLuoqli/QyX1raO+
         2fjcBQLWlO+CIMpCoqR8SDnG7oKivYzH3jE653yXgs+g9oKSvbwWOoDc6DLb47co1Yrj
         gpKzX7JZdFlQPlCE6H7N6vC7ZkiraKlBQi7FckXNwVUcrxBd2+cOoXR4japAAA7wtlNP
         gkrp98pNqQHnTjySjs2srFZ81HodVsLyFAAB4A/qza9jvGh+b2DjmJ4L+ZLOV5lsbKO3
         wBEhupYYqjEj0Zy1uJYHCI3V1jfS7GR47BIDerX7mT5enoy4Bte9AgOZK3+nsV3fhmjt
         Sl1Q==
X-Gm-Message-State: APjAAAWejLQsT31Onq7g1nQfsEkZeBRm4TAPbpkB4YlymysWB/v9ljk6
        CRBzp9nyTbyyiWr8Ge9C6sxTN4VnR0VAsFidF9WS0/Cz4EWsvt+yfTEa3q4iJxtFjtaLJz7xzIj
        qXWtdU/XCqUSqtXkDucMmkCK2rF+A33AyS5LK
X-Received: by 2002:ac8:365c:: with SMTP id n28mr2025213qtb.260.1581678728261;
        Fri, 14 Feb 2020 03:12:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1QckY2romso9aqxIFBMHsb1vON4cEumXd/xunHm/MgJQfIkQVY0uU+NSxeeBpwO6SAZ14npaTT48Dv089ZVM=
X-Received: by 2002:ac8:365c:: with SMTP id n28mr2025194qtb.260.1581678727879;
 Fri, 14 Feb 2020 03:12:07 -0800 (PST)
MIME-Version: 1.0
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
 <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com> <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
 <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com> <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
In-Reply-To: <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Feb 2020 12:11:56 +0100
Message-ID: <CAO-hwJJj8uHVr_BTG0rcBchiEttuQTr7ovrtTQ=Cp5vJ2eeoNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 14, 2020 at 11:04 AM Shah, Nehal-bakulchandra
<nehal-bakulchandra.shah@amd.com> wrote:
>
> Hi
>
> On 2/14/2020 10:10 AM, Srinivas Pandruvada wrote:
> > On Thu, 2020-02-13 at 15:56 +0100, Benjamin Tissoires wrote:
> >> Hi,
> >>
> >> On Wed, Feb 12, 2020 at 3:45 PM Hans de Goede <hdegoede@redhat.com>
> >> wrote:
> >>> Hi,
> >>>
> >>> On 2/12/20 3:56 AM, Sandeep Singh wrote:
> >>>> From: Sandeep Singh <sandeep.singh@amd.com>
> >>>>
> >>>> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> >>>> is part of MP2 processor (MP2 which is an ARM=C2=AE Cortex-M4
> >>>> core based co-processor to x86) and it runs on MP2 where
> >>>> in driver resides on X86.The driver functionalities are
> >>>> divided  into three parts:-
> >>>>
> >>>> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
> >>>> and
> >>>>                          provide that data into DRAM.
> >>>> 2: Client driver :-     This part for driver will use dram data
> >>>> and
> >>>>                          convert that data into HID format based
> >>>> on
> >>>>                          HID reports.
> >>>> 3: Transport driver :-  This part of driver will communicate with
> >>>>                          HID core. Communication between devices
> >>>> and
> >>>>                          HID core is mostly done via HID reports
> >>>>
> >>>> In terms of architecture it is much more reassembles like
> >>>> ISH(Intel Integrated Sensor Hub). However the major difference
> >>>> is all the hid reports are generated as part of kernel driver.
> >>>> AMD SFH driver taken reference from ISH in terms of
> >>>> design and functionalities at fewer location.
> >>>>
> >>>> AMD sensor fusion Hub is part of a SOC 17h family based
> >>>> platforms.
> >>>> The solution is working well on several OEM products.
> >>>> AMD SFH uses HID over PCIe bus.
> >>> I started looking at this patch because of the phoronix' news item
> >>> on it.
> >>>
> >>> First of all I want to say that it is great that AMD is working on
> >>> getting the Sensor Fusion Hub supported on Linux and that you are
> >>> working on a driver for this.
> Thanks for the valuable input.
> >> But, I've taken a quick look, mainly at the
> >> "[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD
> >> sensor fusion Hub (SFH)"
> >> patch.
> >>
> >> AFAIK with the Intel ISH the sensor-hub itself is actually
> >> providing
> >> HID descriptors and HID input reports.
> >>
> >> Looking at the AMD code, that does not seem to be the case, it
> >> seems
> >> the values come directly from the AMD sensor-hub without being in
> >> any
> >> HID specific form, e.g.:
> >>
> >> +u8 get_input_report(int sensor_idx, int report_id,
> >> +                   u8 *input_report, u32 *sensor_virt_addr)
> >> +{
> >> +       u8 report_size =3D 0;
> >> +       struct accel3_input_report acc_input;
> >> +       struct gyro_input_report gyro_input;
> >> +       struct magno_input_report magno_input;
> >> +       struct als_input_report als_input;
> >> +
> >> +       if (!sensor_virt_addr || !input_report)
> >> +               return report_size;
> >> +
> >> +       switch (sensor_idx) {
> >> +       case ACCEL_IDX: /* accel */
> >> +               acc_input.common_property.report_id =3D report_id;
> >> +               acc_input.common_property.sensor_state =3D
> >> +                                       HID_USAGE_SENSOR_STATE_READ
> >> Y_ENUM;
> >> +               acc_input.common_property.event_type =3D
> >> +                               HID_USAGE_SENSOR_EVENT_DATA_UPDATED
> >> _ENUM;
> >> +               acc_input.in_accel_x_value =3D
> >> (int)sensor_virt_addr[0] /
> >> +                                               AMD_SFH_FIRMWARE_MU
> >> LTIPLIER;
> >> +               acc_input.in_accel_y_value =3D
> >> (int)sensor_virt_addr[1] /
> >> +                                               AMD_SFH_FIRMWARE_MU
> >> LTIPLIER;
> >> +               acc_input.in_accel_z_value
> >> =3D  (int)sensor_virt_addr[2] /
> >> +                                               AMD_SFH_FIRMWARE_MU
> >> LTIPLIER;
> >> +               memcpy(input_report, &acc_input,
> >> sizeof(acc_input));
> >> +               report_size =3D sizeof(acc_input);
> >> +               break;
> >>
> >> And the descriptors are hardcoded in the driver so as to fake a HID
> >> device.
> >>
> >> So going through the HID subsystem seems like an unnecessary
> >> detour,
> >> which just makes things needlessly complex and harder to debug
> >> (and extend).
> >>
> >> The HID devices which the current patch-set is creating ultimately
> >> will result in a number of devices being created under
> >>
> >> /sys/bus/iio/devices
> >>
> >> And this are the devices which userspace uses to get the sensor
> >> data.
> >>
> >> IMHO instead of going through the HID subsys the AMD Sensor Fusion
> >> Hub
> >> driver should simply register 4 (*) iio-devices itself and directly
> >> pass the data through at the iio subsys level rather then going the
> >> long way around by creating a fake HID device which then gets
> >> attached to by the hid-sensor driver to ultimately create the same
> >> iio-devices.
> >>
> >> There are examples of e.g. various iio accel drivers under:
> >> drivers/iio/accel/ you could start with a simple driver supporting
> >> just the accelerometer bits and then extend things from there.
> >>
> >> Benjamin, Jiri, Jonathan, what is your take on this?
> >> Hard to say without knowing AMD roadmap for that. If they intend to
> >> have an ISH-like approach in the end with reports and descriptors
> >> provided by the firmwares, then it makes sense to keep this
> >> architecture for the first revision of devices.
> >> If not, then yes, this is probably overkill compared to what needs to
> >> be done.
> >>
> > I suggested this approach to follow something like Chrome-OS EC based
> > hub, but looks like in longer run this may come from firmware. That's
> > why they may have decided.
> >
> > Thanks,
> > Srinivas
> >
> >
> >> Sandeep, can you explain to us why you think using HID is the best
> >> way?
> >>
> >> On a side note, I don't necessarily like patch 4/5 with the debugfs
> >> interface. It's adding a kernel API for no gain, and we should
> >> already
> >> have the debug API available in the various subsystems involved.
> >>
> >> Cheers,
> >> Benjamin
>
> Yes today, the  HID Reports are getting generated in driver. But, we woul=
d like to have HID based driver as we may go for HID based firmware in futu=
re . Hence keeping that in mind current AMD SFH design.
>
> So, kindly consider our design w.r.t HID for this patch series.

OK, that's good enough for me. Jiri, are you fine with that too?

>
> For the debugfs part,currently it is really handy for us to debug raw val=
ues coming from firmware.But if guys feel that it is not necessary, we can =
remove it.
>

2 problems here:
- patch 3/5 references this debugfs interface which is only added in 4/5.
- you are creating a new sysfs set of file for debug purpose only, but
as soon as we start shipping those, some other people will find it
more convenient to use that directly instead or IIO, and you won't be
able to change anything there.

So I would strongly advocate against having this debugfs, and suggest you t=
o:
- either keep this debugfs as a downstream patch
- either play with eBPF or kprobes to retrieve the same information
without changing the kernel.

For reference, I recently tried to replicate the hidraw functionality
with eBPF[0] without changing the kernel code, and it was working.
Well, there was no filtering on the source of the HID event, but
still, I got the same data directly from the kernel just by adding
instrumentation in a couple of functions.

Cheers,
Benjamin

[0] https://gitlab.freedesktop.org/bentiss/hid-tools/snippets/875

