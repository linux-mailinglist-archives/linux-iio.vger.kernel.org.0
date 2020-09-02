Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4955125AC2C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgIBNnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 09:43:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbgIBNnV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 09:43:21 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 999C6AA511B62DBBBB06;
        Wed,  2 Sep 2020 14:25:06 +0100 (IST)
Received: from localhost (10.52.121.91) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 14:25:06 +0100
Date:   Wed, 2 Sep 2020 14:23:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel
 modes
Message-ID: <20200902142333.00005b71@Huawei.com>
In-Reply-To: <CAHp75VcXLyw40JaU42jQ3fSL7mtHPv++xqcka-oTKUbsW4erpg@mail.gmail.com>
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
        <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
        <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
        <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
        <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
        <CAHp75VdvnUsEf=fsRQRmyxQO=1m09M5U19GBtSPkjxSGA5cRBA@mail.gmail.com>
        <BN6PR03MB259650CEEEC9647AB5C9D8338E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
        <CAHp75VcXLyw40JaU42jQ3fSL7mtHPv++xqcka-oTKUbsW4erpg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.91]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 12:28:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 2, 2020 at 12:12 PM Hennerich, Michael
> <Michael.Hennerich@analog.com> wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Mittwoch, 2. September 2020 10:52
> > > On Wed, Sep 2, 2020 at 11:09 AM Hennerich, Michael
> > > <Michael.Hennerich@analog.com> wrote:  
> 
> ...
> 
> > > I see. Can we consider this email as the official answer from AD that this ID is
> > > being allocated for this certain component?  
> >
> > To my knowledge only PNP/ACPI vendor IDs need to be registered with the UEFI
> > ACPI working group.  
> 
> Correct.
> 
> >  AD part numbers are unique. The ID chosen uses the
> > part number prefixed with the PNP Vendor ID. ADxxxx->ADSxxxx
> > Please consider this as allocated.  
> 
> Thank you for confirming this!
> 

Great to clear this particular one up.

One side note on this for anyone who might find this email thread.
If we do have an ACPI ID that doesn't use an official
PNP or ACPI ID, but there are boards shipping with it, then we can't
drop the ID.   We can however add a note to the driver making the
point that it is not an official ID and so we may remove it if
all known boards that used it are now considered obsolete.
Even better to list a product it does occur in so we avoid
having the conversation again!

A lot of these got through my reviews due to lack of knowledge of how
ACPI IDs worked until a few years ago.  Still like all ABI we are
stuck with it until we can remove it without anyone noticing :(

Jonathan

