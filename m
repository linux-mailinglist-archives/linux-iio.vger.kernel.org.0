Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8561C3CC531
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhGQSLy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 17 Jul 2021 14:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233280AbhGQSLy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 14:11:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A71D6113D;
        Sat, 17 Jul 2021 18:08:54 +0000 (UTC)
Date:   Sat, 17 Jul 2021 19:11:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ricardo Ribalda <ribalda@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Message-ID: <20210717191116.4fc3af96@jic23-huawei>
In-Reply-To: <PH0PR03MB63666D9D4DD53EBB08462B1599029@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210627163244.1090296-1-jic23@kernel.org>
        <PH0PR03MB6366F34DC0B3D7EB7A56B6A499039@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210628144407.0000084e@Huawei.com>
        <PH0PR03MB63666D9D4DD53EBB08462B1599029@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 08:28:30 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Monday, June 28, 2021 3:44 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org;
> > Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org;
> > Lars-Peter Clausen <lars@metafoo.de>; Ricardo Ribalda
> > <ribalda@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Gwenhael Goavec-Merou
> > <gwenhael.goavec-merou@trabucayre.com>; Michael Welling
> > <mwelling@ieee.org>
> > Subject: Re: [PATCH 00/15] dt-bindings: iio: dac: Add most missing
> > binding documents.
> > 
> > [External]
> > 
> > On Mon, 28 Jun 2021 07:09:18 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > Hi Jonathan,
> > >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Sunday, June 27, 2021 6:32 PM
> > > > To: linux-iio@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> > > > devicetree@vger.kernel.org
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-  
> > Peter  
> > > > Clausen <lars@metafoo.de>; Ricardo Ribalda  
> > <ribalda@kernel.org>;  
> > > > Hennerich, Michael <Michael.Hennerich@analog.com>; Gwenhael
> > > > Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>;  
> > Michael  
> > > > Welling <mwelling@ieee.org>
> > > > Subject: [PATCH 00/15] dt-bindings: iio: dac: Add most missing  
> > binding  
> > > > documents.
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > We have quite a few drivers in IIO that date back to the days of
> > > > platform
> > > > data.  Many of them either worked out of the box with device tree
> > > > due to the spi core using the spi_device_id to match against
> > > > device tree compatibles, or were updated to use newer interfaces  
> > in  
> > > > the
> > > > intervening years.  As such, they mostly 'work' with device tree but
> > > > can have some slightly odd quirks (particularly around naming of
> > > > supplies).
> > > > As we have no way of knowing what is out in the wild, we need to
> > > > support
> > > > these interesting bits of regulator naming.
> > > >
> > > > I would ultimately like all such bindings to be documented both to
> > > > facilitate
> > > > automated check of device trees and to make things easier for  
> > people  
> > > > trying
> > > > to write device tree files using these devices.
> > > >
> > > > This series fills in the majority of the absent bindings for DACs.
> > > > There are some outstanding
> > > > * max517 - some platform data configuration needs porting over to
> > > > device tree.
> > > > * m62332 - this passes a consumer mapping in as platform data and  
> > will  
> > > > need
> > > >   careful porting over the dt way of doing that.
> > > >
> > > > There is one 'fixlet' in here for the driver to deal with a case were  
> > the  
> > > > code was intended to allow the presence of a regulator to dictate
> > > > whether
> > > > an internal reference was used, but did not use the optional  
> > regulator  
> > > > get.
> > > >
> > > > I've mostly nominated maintainers based on original authorship +
> > > > where
> > > > I was feeling guilty or couldn't find anyone still active I've listed  
> > myself.  
> > > >
> > > > I got bored half way through of producing brief descriptions of
> > > > the devices so stopped doing so. If anyone wants to provide one  
> > for  
> > > > these
> > > > parts I'm happy to add it!
> > > >
> > > > Future series will cover the c. 40 bindings that I've identified as  
> > missing  
> > > > for other types of devices.  I've also kept notes of easy cleanups in
> > > > drivers spotted whilst working these out, so will probably follow up
> > > > with
> > > > those soon as well.
> > > >
> > > > Note I haven't tested all of these so there may well be errors or
> > > > elements
> > > > I've missed.
> > > >  
> > >
> > > LGTM... Just wondering if we could not add the adi,ad5421 directly  
> > into  
> > > the trivial-devices yaml as it looks to be the only one without any odd
> > > regulator name?  
> > 
> > We could, but would probably end up pulling it out again.  As noted in
> > that patch description there is a bunch of stuff the binding doesn't
> > currently
> > support that would make sense to add if anyone actually needs it.  
> 
> Fair enough :)
> 
> - Nuno Sá
> 
Applied all except patch 5 where something odd happened with the test scripts
that needs another look.

Thanks,

Jonathan


