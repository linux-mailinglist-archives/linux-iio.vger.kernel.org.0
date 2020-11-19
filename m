Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803B32B977F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgKSQLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 11:11:08 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44239 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgKSQLI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 11:11:08 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9A4EA20011;
        Thu, 19 Nov 2020 16:11:04 +0000 (UTC)
Message-ID: <e0853f4690a531c89c9d48cc009a97f05ba0181b.camel@hadess.net>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org
Date:   Thu, 19 Nov 2020 17:11:04 +0100
In-Reply-To: <6df00683-9508-3dd9-831e-9b343658287b@redhat.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
         <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
         <20201007083602.00006b7e@Huawei.com>
         <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
         <20201112062348.GF1003057@dtor-ws>
         <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
         <20201113065832.GD356503@dtor-ws>
         <6df00683-9508-3dd9-831e-9b343658287b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-11-19 at 16:39 +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/13/20 7:58 AM, Dmitry Torokhov wrote:
> > On Thu, Nov 12, 2020 at 10:50:12AM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 11/12/20 7:23 AM, Dmitry Torokhov wrote:
> > > > On Wed, Oct 07, 2020 at 11:51:05AM +0200, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 10/7/20 10:36 AM, Jonathan Cameron wrote:
> > > > > > On Mon, 5 Oct 2020 22:04:27 -0400
> > > > > > Mark Pearson <markpearson@lenovo.com> wrote:
> > > > > > 
> > > > > > > Adding Nitin, lead for this feature, to the thread
> > > > > > 
> > > > > > +CC linux-input and Dmitry for reasons that will become
> > > > > > clear below.
> > > > > > > 
> > > > > > > On 2020-10-03 10:02 a.m., Hans de Goede wrote:
> > > > > > > > Hi All,
> > > > > > > > 
> > > > > > > > Modern laptops can have various sensors which are kinda
> > > > > > > > like proximity sensors, but not really (they are more
> > > > > > > > specific in which part of the laptop the user is
> > > > > > > > proximate to).
> > > > > > > > 
> > > > > > > > Specifically modern Thinkpad's have 2 readings which we
> > > > > > > > want to export to userspace, and I'm wondering if we
> > > > > > > > could use the IIO framework for this since these
> > > > > > > > readings
> > > > > > > > are in essence sensor readings:
> > > > > > > > 
> > > > > > > > 1. These laptops have a sensor in the palm-rests to
> > > > > > > > check if a user is physically proximate to the device's
> > > > > > > > palm-rests. This info will be used by userspace for
> > > > > > > > WWAN
> > > > > > > > functionality to control the transmission level safely.
> > > > > > > > 
> > > > > > > > A patch adding a thinkpad_acpi specific sysfs API for
> > > > > > > > this
> > > > > > > > is currently pending:
> > > > > > > > https://patchwork.kernel.org/patch/11722127/
> > > > > > > > 
> > > > > > > > But I'm wondering if it would not be better to use
> > > > > > > > IIO to export this info.
> > > > > > 
> > > > > > My first thought on this is it sounds more like a key than
> > > > > > a sensor
> > > > > > (simple proximity sensors fall into this category as well.)
> > > > 
> > > > [ sorry for sitting on this thread for so long ]
> > > > 
> > > > So I think the important question here is if we only ever want
> > > > yes/no
> > > > answer, or if we can consider adjusting behavior of the system
> > > > based on
> > > > the "closeness" of an object to the device, in which case I
> > > > think IIO is
> > > > more flexible.
> > > > 
> > > > FWIW in Chrome OS land we name IIO proximity sensors using a
> > > > scheme
> > > > "proximity-lte", "proximity-wifi", "proximity-wifi-left",
> > > > "proximity-wifi-right", etc, and then userspace implements
> > > > various
> > > > policies (SAR, etc) based off it.
> > > 
> > > Interesting, so 2 questions:
> > > 
> > > 1. So your encoding the location in the sensor's parent-device
> > > name
> > > instead of using a new sysfs attribute for this ?
> > 
> > I think it depends on the kernel we use and architecture. On x86 I
> > think
> > we rely on udev, like this:
> > 
> > https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-nocturne/chromeos-base/chromeos-bsp-nocturne/files/udev/99-cros-sx-proximity.rules
> > 
> > DEVPATH=="*/pci0000:00/0000:00:15.1/*", SYMLINK+="proximity-wifi-
> > right"
> > DEVPATH=="*/pci0000:00/0000:00:19.1/*", SYMLINK+="proximity-wifi-
> > left"
> > ATTR{events/in_proximity1_USE_CS1_thresh_either_en}="1"
> 
> So that results in a symlink under /dev, right ? That seems like
> it is not really compatible with how most modern userspace discovers
> hw (through udev). Although I guess code using udev could still
> lookup the symlink in the udev per device data, this just not feel
> like a good way forward.

We can tag it, the metadata will be readable in where we need it,
through libudev, so that's not a big bother.

