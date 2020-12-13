Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA852D8E31
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436680AbgLMPNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 10:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437022AbgLMPNk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 10:13:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286BE23121;
        Sun, 13 Dec 2020 15:12:57 +0000 (UTC)
Date:   Sun, 13 Dec 2020 15:12:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: IIO Driver for TMP117 Temperature sensor
Message-ID: <20201213151253.059e541c@archlinux>
In-Reply-To: <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
        <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
        <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 11:48:40 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:
> > On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:  
> >>
> >> I have this TI's TMP117 sensor with me and I was thinking about writing an
> >> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> >> place for this driver? if yes, can someone help me get started with this,
> >> I haven't written an IIO driver before. I have this sensor and also a
> >> raspberry pi with me for testing.  
> > 
> > This could also fit into drivers/hwmon.
> > Looking at the HWMON subsystem there are more TMP drivers there
> > (TMP102/103/108/401/513).
> > The first 3 seem a bit more similar to TMP117 (in terms of register map).
> >   
> 
> It would probably be better suited for hwmon (it has limit registers,
> suggesting a common use as hardware monitoring device).
It is a curious part.  I suspect TI based their design for a medical grade
digital thermometer chip on an existing hwmon part.

The limit registers are very simple so could be supported by IIO.
This sits somewhere in the middle of high end thermocouple chips which
tend to be in IIO and typically lower accuracy / range hwmon parts.

It's in the fuzzy borderline region so I doubt anyone would raise strong
objections to which subsystem it was in.  Guenter has fallen on the
hwmon side of things and I'm fine with that.

Jonathan

> 
> > Let's see what others have to add.
> > But, all-in-all whatever driver you end up writing, the easiest method
> > is to copy an existing similar driver and extend it.
> > Sometimes, a part can be added to an existing driver.
> > At a quick scan through existing drivers, it doesn't look like TMP117
> > is similar to existing drivers, so it may require a new driver
> > altogether.  
> 
> I don't see an immediate match either, but the tmp102 hwmon driver
> might be a good start.
> 
> Guenter
> 
> > I may have missed something though.
> > 
> > Thanks
> > Alex
> >   
> >>
> >> --
> >> Thanks and Regards
> >>
> >> Yours Truly,
> >>
> >> Puranjay Mohan  
> 

