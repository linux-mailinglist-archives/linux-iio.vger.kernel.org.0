Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8D345D26
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCWLk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Mar 2021 07:40:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2730 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCWLkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2021 07:40:00 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4Thg0TyCz67rYB;
        Tue, 23 Mar 2021 19:31:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 23 Mar 2021 12:39:58 +0100
Received: from localhost (10.47.84.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 11:39:57 +0000
Date:   Tue, 23 Mar 2021 11:38:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Drew Fustini <drew@beagleboard.org>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "Daniel Baluta" <daniel.baluta@nxp.com>,
        David Lechner <david@lechnology.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: iio: adc: anyone working on TI ADS7066?
Message-ID: <20210323113839.0000537a@Huawei.com>
In-Reply-To: <20210323043917.GA517382@x1>
References: <20210320035234.GA95301@x1>
        <20210320182609.5e4e7f3c@jic23-huawei>
        <20210323043917.GA517382@x1>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.123]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Mar 2021 21:39:17 -0700
Drew Fustini <drew@beagleboard.org> wrote:

> On Sat, Mar 20, 2021 at 06:26:24PM +0000, Jonathan Cameron wrote:
> > On Fri, 19 Mar 2021 20:52:34 -0700
> > Drew Fustini <drew@beagleboard.org> wrote:
> >   
> > > I have a board with a TI ADS7066 8-channel ADC [1] that I want to get
> > > working in Linux.  I see there is already driver support in iio for
> > > ADS1015, ADS79xx, ADS8344, ADS868x and ADS124S0x.
> > > 
> > > Is anyone already working with the ADS7066 or a similar part in that
> > > series?
> > > 
> > > If not, I'll take one of the existing TI drivers as a template for the
> > > ADS7066 driver.
> > > 
> > > Thank you,
> > > Drew  
> > 
> > Hi Drew,
> > 
> > I've not seen anything for this part.
> > 
> > From a 10 second glance at the data sheet I see it's capable of
> > ADC / GPIO on each pin.   If you plan to support that functionality
> > at somepoint make sure to define dt bindings and similar to specify
> > which channels are enabled and dynamically create the iio_chan_spec
> > array to match.  It can be a bit ugly to retrofit later.  
> 
> Thanks for the feedback.  The GPIO functionality is not used on the
> custom hardware that I have, so I am thinking I would only implement
> the ADC functionality.  Is that too short sighted?

That's fine.  We'd just end up with a DT binding that had a default
of "no channels specified == all ADC".

It might turn out you want to do per channel settings anyway in DT.

> 
> > Oh. It does daisy chaining as well. That is always fun to support
> > though I guess you may well not have it wired up to do that.
> > Oversampling as well - though that looks nice and simple for once.  
> 
> The hardware I have has two ADS7066 wired up in parallel so I don't
> think I would be looking at implementing dasiy chain initially.
> 
> Is that ok just implement what I am actually using or is the preference
> to have a driver implement all the latent functionality before it would
> be merged?

Absolutely fine to do just what you need initially then others can add
the fun bells and whistles when they need them.

Only exception is the binding doc should try to reflect what the hardware
can support even if the driver doesn't use it.  This applies to things
like interrupt lines or regulators.

Jonathan

> 
> Thanks,
> Drew

