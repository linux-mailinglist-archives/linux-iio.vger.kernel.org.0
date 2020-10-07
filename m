Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C933286016
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgJGN3P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:29:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39013 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgJGN3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:29:15 -0400
X-Greylist: delayed 6794 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 09:29:13 EDT
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AD5FD6001A;
        Wed,  7 Oct 2020 13:29:11 +0000 (UTC)
Message-ID: <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date:   Wed, 07 Oct 2020 15:29:11 +0200
In-Reply-To: <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
         <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
         <20201007083602.00006b7e@Huawei.com>
         <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
         <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
         <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.0 (3.38.0-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-10-07 at 15:08 +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/7/20 1:35 PM, Bastien Nocera wrote:
> > On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
> > > <snip>
> > > > Dmitry, any existing stuff like this in input?
> > > 
> > > There already is a SW_FRONT_PROXIMITY defined in
> > > input-event-codes.h, which I guess means detection if
> > > someone is sitting in front of the screen. So we could add:
> > > 
> > > SW_LAP_PROXIMITY
> > > SW_PALMREST_PROXIMITY,
> > > 
> > > And then we have a pretty decent API for this I think.
> > 
> >  From the point of view of writing the consumer code for this API,
> > it's
> > rather a lot of pain to open the device node (hoping that it's the
> > right one for what we need), getting the initial state, setting up
> > masks to avoid being woken up for every little event, and parsing
> > those
> > events.
> 
> There is not much difference with the iio sysfs API though, you would
> also need to iterate over all the iio devices and test if they
> are a proximity sensor (and read the new location sysfs file
> discussed).
> 
> > Where would the necessary bits of metadata for daemons to be able
> > to
> > find that those switches need to get added?
> 
> evdev files export info on which events they can report. Not only
> the types of events (EV_SW in this case) but also a bitmask for
> which event-codes they can report within that type.

I know that, I've written enough of that type of code ;)

I meant a way to avoid having to go open each evdev, read its
capabilities, and close them when it doesn't, and re-do that every time
a new event device appears. In other words, can you please make sure
there will be a udev property that we can use to enumerate and filter
devices with those capabilities?

> > If you go down that route, you'll definitely want a want to attach
> > the
> > "palmrest" to the touchpad/keyboard that it corresponds to,
> > otherwise
> > that might have weird interactions when using external keyboards
> > and
> > touchpads. (I don't know what you'd use that proximity sensor for
> > though)
> 
> The proximity sensor is primarily for deciding how strong a signal
> wireless devices inside the laptop may emit.

So we'll need a way to know what wireless device is inside the laptop
so that policy only applies to that one. This was already fun when it
was just event devices that needed grouping ;)

