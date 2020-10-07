Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD96285A9A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgJGIhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 7 Oct 2020 04:37:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2963 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgJGIhw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Oct 2020 04:37:52 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7562EBF685A55F89FB20;
        Wed,  7 Oct 2020 09:37:47 +0100 (IST)
Received: from localhost (10.52.123.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 7 Oct 2020
 09:37:47 +0100
Date:   Wed, 7 Oct 2020 09:36:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Pearson <markpearson@lenovo.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <linux-iio@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201007083602.00006b7e@Huawei.com>
In-Reply-To: <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
        <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.131]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Oct 2020 22:04:27 -0400
Mark Pearson <markpearson@lenovo.com> wrote:

> Adding Nitin, lead for this feature, to the thread

+CC linux-input and Dmitry for reasons that will become clear below.
> 
> On 2020-10-03 10:02 a.m., Hans de Goede wrote:
> > Hi All,
> > 
> > Modern laptops can have various sensors which are kinda
> > like proximity sensors, but not really (they are more
> > specific in which part of the laptop the user is
> > proximate to).
> > 
> > Specifically modern Thinkpad's have 2 readings which we
> > want to export to userspace, and I'm wondering if we
> > could use the IIO framework for this since these readings
> > are in essence sensor readings:
> > 
> > 1. These laptops have a sensor in the palm-rests to
> > check if a user is physically proximate to the device's
> > palm-rests. This info will be used by userspace for WWAN
> > functionality to control the transmission level safely.
> > 
> > A patch adding a thinkpad_acpi specific sysfs API for this
> > is currently pending:
> > https://patchwork.kernel.org/patch/11722127/
> > 
> > But I'm wondering if it would not be better to use
> > IIO to export this info.

My first thought on this is it sounds more like a key than a sensor
(simple proximity sensors fall into this category as well.)

Dmitry, any existing stuff like this in input?

If it does make sense to put it in IIO then rest of the questions
obviously relevant.

> > 
> > 2. These laptops have something called lap-mode, which
> > determines if the laptop's firmware thinks that it is on
> > a users lap, or sitting on a table. This influences the
> > max. allowed skin-temperature of the bottom of the laptop
> > and thus influences thermal management.  Like the palm-rest
> > snesors, this reading will likely also be used for
> > controlling wireless transmission levels in the future.
> > 
> > Note that AFAIK the lap_mode reading is not a single sensor
> > reading, it is a value derived from a bunch of sensor readings,
> > the raw values of which may or may not be available
> > separately.
> > 
> > So looking at existing IIO userspace API docs, focussing on
> > proximity sensors I see:
> > 
> > Documentation/ABI/testing/sysfs-bus-iio
> > Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> > 
> > Where the latter seems to not really be relevant.

Indeed, that one is a very odd beast :) (lightning sensor)

> > 
> >  From the generic IO API doc, this bit is the most
> > interesting:
> > 
> > What:           /sys/.../iio:deviceX/in_proximity_raw
> > What:           /sys/.../iio:deviceX/in_proximity_input
> > What:           /sys/.../iio:deviceX/in_proximityY_raw
> > KernelVersion:  3.4
> > Contact:        linux-iio@vger.kernel.org
> > Description:
> >                  Proximity measurement indicating that some
> >                  object is near the sensor, usually by observing
> >                  reflectivity of infrared or ultrasound emitted.
> >                  Often these sensors are unit less and as such conversion
> >                  to SI units is not possible. Higher proximity measurements
> >                  indicate closer objects, and vice versa. Units after
> >                  application of scale and offset are meters.
> > 
> > This seems to be a reasonable match for the Thinkpad sensors
> > we are discussing here, although those report a simple
> > 0/1 value.

Given this is a bit of computed estimate rather than a true reading, I wonder
a bit if we should treat it as closer to an 'activity classification sensor'.

For those we use a percentage value to represent the output of some probabilistic
classifier.  In reality all the versions we've had so far aren't that clever though
so they only output 0 or 100%.  See in_activity_walking_input in the docs for
example.

> > 
> > What is missing for the ThinkPad case is something like this:
> > 
> > What:        /sys/.../iio:deviceX/proximity_sensor_location
> > KernelVersion:  5.11
> > Contact:        linux-iio@vger.kernel.org
> > Description:
> >          Specifies the location of the proximity sensor /
> >          specifies proximity to what the sensor is measuring.
> >          Reading this file returns a string describing this, valid values
> >          for this string are: "screen", "lap", "palmrest"
> >          Note the list of valid values may be extended in the
> >          future.
> > 
> > So what do you (IIO devs) think about this?
> > 
> > Would adding a proximity_sensor_location attribute be a reasonable
> > thing to do for this; and do you think that this would be a good idea ?

Absolutely fine.  There is precedence in cros_ec which has a generic
location sysfs attribute (not associated with a particular channel though
it is fine to do that as well). See Documentation/ABI/testing/sysfs-bus-iio-cros_ec
We haven't moved it to the general docs because there is only one device
providing it so far.  Hence we would move it with the introduction of
this second device.

> > 
> > Regards,
> > 
> > Hans
> >   


