Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7283EFE8B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhHRIEL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 04:04:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36733 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbhHRIDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 04:03:11 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A021620002;
        Wed, 18 Aug 2021 08:02:25 +0000 (UTC)
Date:   Wed, 18 Aug 2021 10:03:13 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: chemical: Add Senseair Sunrise CO2 sensor
Message-ID: <20210818080313.dtxz6obtjslhsutm@uno.localdomain>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <CAJCx=gnx=U6grCBarPOuc=v201v+Hyp8oiaYdVH-=-2JdNEQ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJCx=gnx=U6grCBarPOuc=v201v+Hyp8oiaYdVH-=-2JdNEQ1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matt,

On Tue, Aug 17, 2021 at 10:01:40AM -0700, Matt Ranostay wrote:
> On Tue, Aug 17, 2021 at 8:49 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Hello,
> >    this is a small driver for the Senseair Sunrise 006-0-0007 CO2
> > sensor.
> >
> > The driver supports continuous reads of temperature and CO2 concentration
> > through two dedicated IIO channels.
> >
> > While the driver is rather simple I'm not sure calibration is handled in
> > the correct way. In this version, at probe time, a check on the general
> > error register is made to verify if a calibration cycle is required.
> > The calibration takes a time in the order of a few seconds, and currently
> > can only happen at probe time.
> >
> > Is there a mechanism available in the IIO framework to expose a trigger to have
> > userspace decide when the calibration has to happen ? In my understanding IIO
> > triggers are meant to trigger read events, using them for calibration purpose
> > seems not the right thing to do, or am I mistaken ?
>
> For sure you shouldn't use the trigger framework for that.
>
> You should use an attribute group, e.g.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/proximity/as3935.c?h=v5.14-rc6#n168

Thanks for the pointer! I'll consider that for v2!

>
> - Matt
>
> >
> > Thanks
> >   j
> >
> > Jacopo Mondi (2):
> >   dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
> >   iio: chemical: Add Senseair Sunrise 006-0-007 driver
> >
> >  .../iio/chemical/senseair,sunrise.yaml        |  51 +++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  MAINTAINERS                                   |   6 +
> >  drivers/iio/chemical/Kconfig                  |  10 +
> >  drivers/iio/chemical/Makefile                 |   1 +
> >  drivers/iio/chemical/sunrise.c                | 310 ++++++++++++++++++
> >  6 files changed, 380 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> >  create mode 100644 drivers/iio/chemical/sunrise.c
> >
> > --
> > 2.32.0
> >
