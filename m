Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50FA3130B3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 12:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhBHLXq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 06:23:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2524 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhBHLVc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 06:21:32 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZ3M14SMFz67hjM;
        Mon,  8 Feb 2021 19:14:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 12:20:50 +0100
Received: from localhost (10.47.30.32) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Feb 2021
 11:20:49 +0000
Date:   Mon, 8 Feb 2021 11:20:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Message-ID: <20210208112003.000064eb@Huawei.com>
In-Reply-To: <8967afd32123482482af599b199e347b@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-22-jic23@kernel.org>
        <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
        <8967afd32123482482af599b199e347b@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.32]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Feb 2021 08:12:21 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> > Sent: Monday, February 8, 2021 5:00 AM
> > To: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; devicetree@vger.kernel.org
> > Subject: Re: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
> > 
> > On 2/7/21 4:46 PM, Jonathan Cameron wrote:  
> > > +required:
> > > +  - compatible
> > > +  - reg  
> > 
> > Is vdd-supply really optional the way it is implemented in the driver?
> >   
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        cdc@48 {
> > > +            compatible = "adi,ad7150";
> > > +            reg = <0x48>;
> > > +            interrupts = <25 2>, <26 2>;  
> 
> One question, here we have two interrupts, but the driver is reading
> one interrupt only, do we need to call
> of_irq_get(dev, index)
> or
> of_irq_get_byname()?

Driver reads both now (again).  It wasn't the cleanest transition in this series.
I dropped the second irq in patch 5 and brought it back in patch 12.

Whilst we could in theory support only one interrupt, that would make the driver
annoyingly fiddly for something I suspect no one would actually do.
We'd need to support events only on one of the two channels to make it work.

So I vote we take lazy option of saying it's either no interrupts, or both of
them for the two channel devices.  Nothing stops us relaxing that in future
and then using get_by_name.  If we do that and also require names are in order
INT1 INT2, INT1, INT2 but not INT2 INT1 and hence optional except in the case
of only one interrupt provided.

1) New DT, old driver - no interrupts but then there weren't any previously anyway.
2) New Driver old DT - fine, either both are specified or neither.

So there is a clean migration path if we ever find anyone who has wired up only
one of the interrupt lines and really does only want events on one or two channels
but still wants readings on both of them.

Jonathan


> 
> 
> > 
> > I wonder if we should use the symbolic constants for the IRQ type to
> > make the example more clear. E.g.
> > 
> > interrupts = <25 IRQ_TYPE_EDGE_FALLING>, ...
> >   
> > > +            interrupt-parent = <&gpio>;
> > > +        };
> > > +    };
> > > +...  
> >   
> Thanks
> Barry
> 

