Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C93B5F4C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jun 2021 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhF1Nqr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 28 Jun 2021 09:46:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3327 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhF1Nqr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2021 09:46:47 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GD7ld52cCz6L4tQ;
        Mon, 28 Jun 2021 21:30:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 15:44:19 +0200
Received: from localhost (10.47.24.170) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 28 Jun
 2021 14:44:18 +0100
Date:   Mon, 28 Jun 2021 14:44:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Ricardo Ribalda <ribalda@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Message-ID: <20210628144407.0000084e@Huawei.com>
In-Reply-To: <PH0PR03MB6366F34DC0B3D7EB7A56B6A499039@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210627163244.1090296-1-jic23@kernel.org>
        <PH0PR03MB6366F34DC0B3D7EB7A56B6A499039@PH0PR03MB6366.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.24.170]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Jun 2021 07:09:18 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Jonathan,
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, June 27, 2021 6:32 PM
> > To: linux-iio@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> > devicetree@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-Peter
> > Clausen <lars@metafoo.de>; Ricardo Ribalda <ribalda@kernel.org>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Gwenhael
> > Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>; Michael
> > Welling <mwelling@ieee.org>
> > Subject: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
> > documents.
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > We have quite a few drivers in IIO that date back to the days of
> > platform
> > data.  Many of them either worked out of the box with device tree
> > due to the spi core using the spi_device_id to match against
> > device tree compatibles, or were updated to use newer interfaces in
> > the
> > intervening years.  As such, they mostly 'work' with device tree but
> > can have some slightly odd quirks (particularly around naming of
> > supplies).
> > As we have no way of knowing what is out in the wild, we need to
> > support
> > these interesting bits of regulator naming.
> > 
> > I would ultimately like all such bindings to be documented both to
> > facilitate
> > automated check of device trees and to make things easier for people
> > trying
> > to write device tree files using these devices.
> > 
> > This series fills in the majority of the absent bindings for DACs.
> > There are some outstanding
> > * max517 - some platform data configuration needs porting over to
> > device tree.
> > * m62332 - this passes a consumer mapping in as platform data and will
> > need
> >   careful porting over the dt way of doing that.
> > 
> > There is one 'fixlet' in here for the driver to deal with a case were the
> > code was intended to allow the presence of a regulator to dictate
> > whether
> > an internal reference was used, but did not use the optional regulator
> > get.
> > 
> > I've mostly nominated maintainers based on original authorship +
> > where
> > I was feeling guilty or couldn't find anyone still active I've listed myself.
> > 
> > I got bored half way through of producing brief descriptions of
> > the devices so stopped doing so. If anyone wants to provide one for
> > these
> > parts I'm happy to add it!
> > 
> > Future series will cover the c. 40 bindings that I've identified as missing
> > for other types of devices.  I've also kept notes of easy cleanups in
> > drivers spotted whilst working these out, so will probably follow up
> > with
> > those soon as well.
> > 
> > Note I haven't tested all of these so there may well be errors or
> > elements
> > I've missed.
> >   
> 
> LGTM... Just wondering if we could not add the adi,ad5421 directly into
> the trivial-devices yaml as it looks to be the only one without any odd
> regulator name?

We could, but would probably end up pulling it out again.  As noted in
that patch description there is a bunch of stuff the binding doesn't currently
support that would make sense to add if anyone actually needs it.

Hmm. I guess it's a question of whether we think anyone will ever care :)

Jonathan
> 
> Anyways, feel free to add:
> 
> Acked-by: Nuno Sá <nuno.sa@analog.com>

