Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46E6AC623
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfIGKtY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 7 Sep 2019 06:49:24 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44132 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfIGKtY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 06:49:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5842C9E774F;
        Sat,  7 Sep 2019 11:49:22 +0100 (BST)
Date:   Sat, 7 Sep 2019 11:49:19 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     rishi gupta <gupt21@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Custom sysfs entries for persistence, gain & threshold in light
 sensor
Message-ID: <20190907114919.15d8c638@archlinux>
In-Reply-To: <CALUj-gsjKkiF8vrzgeWkh9wo-qBuJDW+5eLPqHqdj3v3ngk4UA@mail.gmail.com>
References: <CALUj-gsjKkiF8vrzgeWkh9wo-qBuJDW+5eLPqHqdj3v3ngk4UA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Sep 2019 22:03:52 +0530
rishi gupta <gupt21@gmail.com> wrote:

> Hi experts,
Hi Rishi,

> 
> I am writing driver for veml6030 ambient light sensor. Application can
> set persistence, gain & threshold which will in turn update registers
> in sensor.
> 
> In IIO framework there is no standard constant for this.

So first element here is whether there aren't standard ABI elements for these.

A quick look suggest threshold maps to an IIO event, so look at that ABI.

Persistence - I'm guessing as the datasheet I have doesn't actually explain
what it is... Probably number of cycles for which the value has to be
over the threshold for an interrupt to occur?  This maps to period, though
you'll have to do the magic to convert form cycles to seconds.

Gain maps to 1/Gain == scale in IIO terms.  What userspace cares about is
what maths it needs to do to get a real world value and that is given
by scale.  Here you have the complexity of integration time also feeding
into that value so it's not that straight forward.

Think about what combination makes sense for light sensor uses... 
Gain typically increases noise, integration time decreases it. Otherwise
they both effect the scale.  So various options exist:

1) Just provide scale and pick sensible combinations to give low noise
   and reasonable integration time for a given scale.
2) Map scale control just to gain, but the values it takes will change
   as the integration time is changed.

From an IIO ABI point of view either is fine. 


> 
> 1) Does using sysfs entries will be fine or there is better alternative.
> 
> static IIO_DEVICE_ATTR_WO(gain, 0);
> static IIO_DEVICE_ATTR_WO(threshold, 0);
> static IIO_DEVICE_ATTR_WO(persistence, 0);
> static IIO_CONST_ATTR(persistence_available, "1 2 4 8");
> static IIO_CONST_ATTR(gain_available, "0.125 0.25 1 2");
> 
> static struct attribute *veml6030_attributes[] = {
> &iio_const_attr_gain.dev_attr.attr,
> &iio_const_attr_threshold.dev_attr.attr,
> &iio_const_attr_persistence.dev_attr.attr,
> &iio_const_attr_persistence_available.dev_attr.attr,
> NULL
> };

If we do need to define things for a particular device that aren't
generic enough to add to the main ABI then this approach is one
option.  However, it makes them only available to userspace. May
be fine for this sort of device, but in general the use of
iio_chan_spec_ext_info is preferred.  Here however, I think the
examples all map to existing ABI.

> 
> 2) Can IIO_CHAN_INFO_HARDWAREGAIN can be used for gain instead of
> custom sysfs file.
> 
> Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf

Nope. Hardware gain is normally used for things like time of
flight sensors, where it is changing the gain of something that
is only indirectly connected to the thing being measured. In those
cases it lets them measure at larger distances but doesn't make
any difference as long as the measurement is successful.

> 
> Regards,
> Rishi

Thanks,

Jonathan
