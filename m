Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A6330CC2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCHLx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Mar 2021 06:53:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2653 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCHLxS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 06:53:18 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvGny6TXWz67wrR;
        Mon,  8 Mar 2021 19:48:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 12:53:15 +0100
Received: from localhost (10.47.81.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Mar 2021
 11:53:15 +0000
Date:   Mon, 8 Mar 2021 11:52:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
Message-ID: <20210308115203.00006230@Huawei.com>
In-Reply-To: <CY4PR03MB26318300B44C07A5890067B499939@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210221120106.00ae1078@archlinux>
        <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
        <20210306173449.06f2f32b@archlinux>
        <CY4PR03MB26318300B44C07A5890067B499939@CY4PR03MB2631.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.81.42]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Mar 2021 10:07:05 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, March 6, 2021 6:35 PM
> > To: Hennerich, Michael <Michael.Hennerich@analog.com>
> > Cc: zzzzArdelean, zzzzAlexandru <alexandru.Ardelean@analog.com>;
> > linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > lars@metafoo.de; Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> > <Dragos.Bogdan@analog.com>
> > Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
> > 
> > On Fri, 5 Mar 2021 08:57:08 +0000
> > "Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:
> >   
> > > Hi Jonathan and others,
> > >
> > > With output/dac buffer support the semantics of the scan_element  
> > type may change.  
> > >
> > > Today the Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift].
> > >
> > > While shift (if specified) is the shift that needs to be applied prior to  
> > masking out unused bits.  
> > >
> > > So far so good and it sounds universal.
> > >
> > > However, we use the right shift (operator) for that, which makes  
> > sense for capture devices.  
> > > For output devices the more logical operator would be the left shift.
> > >
> > > I'm not proposing a new Format here. I just want to get some  
> > agreement that for an output device  
> > >  
> > > le:s12/16>>4  
> > >
> > > is understood as a left shift of 4, since the unused bits are then on  
> > the LSB.
> > 
> > Good question. Guess I wasn't thinking ahead when I came up with
> > that :)
> > 
> > I'm not sure I'd mind if we did decide to define a new format for
> > output
> > buffers. Feels like it should be easy to do.
> > 
> > What do others think?
> >   
> 
> I guess the most straight forward thing would be just to add a 'shift_l' variable
> to 'struct scan_type'' and make sure either 'shift_l' or 'shift' is defined and then
> properly export either ">>" or "<<" to userspace?

Given we already know it's an output channel, can we not just use that
to make the decision?

Jonathan

> 
> - Nuno Sá 
> 

