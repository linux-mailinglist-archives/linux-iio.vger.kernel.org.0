Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4852C42F3
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 16:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgKYPdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 10:33:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2149 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgKYPdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 10:33:02 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ch4b36Bbbz67GYr;
        Wed, 25 Nov 2020 23:30:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 25 Nov 2020 16:33:00 +0100
Received: from localhost (10.52.126.32) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 25 Nov
 2020 15:32:59 +0000
Date:   Wed, 25 Nov 2020 15:32:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: fake ACPI IDs in the drivers
Message-ID: <20201125153243.00001e48@Huawei.com>
In-Reply-To: <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
        <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de>
        <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.32]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Nov 2020 14:00:54 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Nov 25, 2020 at 1:47 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 11/25/20 12:14 PM, Andy Shevchenko wrote:  
> 
> > > Recent discussion [1] [2] around faking ACPI ID in RTC subsystem and a
> > > sudden check [3] (due to last Hans' patches related to ACPI based
> > > systems) of IIO makes me wonder if we may start cleaning drivers from
> > > faked ACPI IDs and establish a stricter rules for the ID table
> > > entries.
> > >
> > > Thoughts?  
> >
> > The cat is probably out of the bag.
> >
> > If there are systems shipping with those unregistered ACPI IDs we still
> > have to support them.  
> 
> Yes, but we can do our best to google for them and try other sources
> (like contacts with vendor companies who can acknowledge if there were
> an ID issued or not).
> 
> > I'd assume that most drivers that have a acpi_device_id table do have
> > hardware that uses that ID and were not just cargo culted.

I fear that is overly optimistic :(

Every time the ID is non obvious we are pretty safe it has come from real
hardware (whether registered or not) but we have a bunch were introduced
by various fairly new contributors that I let in before I knew better :(
Those tend to just be part numbers squished into ACPI ID format.

> >
> > For new drivers we should push back on unregistered IDs, but if there is
> > hardware that uses them we have to take the patches.  
> 
> Right. But at the same time we have to push the idea of proper IDs to
> the vendor companies, so they won't abuse ACPI specification anymore.
> 

Absolutely.  Sometimes it is just a case of moaning and asking whether
hardware is already shipping with the ID - if not push back hard so they
ideally go persuade their management to put a proper process in place.

So upshot, in my view, is to be very careful removing existing IDs
but definitely be very resistive to introducing any new ones without
confirmation they are on some companies official registers.

Jonathan


