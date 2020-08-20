Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE624B19F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHTJCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 05:02:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHTJCg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Aug 2020 05:02:36 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6C4FC1758EF362B9B98E;
        Thu, 20 Aug 2020 10:02:32 +0100 (IST)
Received: from localhost (10.52.123.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 20 Aug
 2020 10:02:32 +0100
Date:   Thu, 20 Aug 2020 10:01:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Denis CIOCCA <denis.ciocca@st.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Mario TESI <mario.tesi@st.com>, <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Message-ID: <20200820100100.00000d33@Huawei.com>
In-Reply-To: <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
References: <20200811134846.3981475-1-daniel@0x0f.com>
        <20200811134846.3981475-3-daniel@0x0f.com>
        <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
        <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
        <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.156]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


+CC: GregKH as this will pass through his tree.

As a quick summary, it seems we have some cloned parts that appear to be compatible
with certain ST micro parts, but have different whoami address values.

Entirely reasonably, Denis is not happy to have them added to the ST maintained driver
given the potential for future incompatibilities.

I don't particularly mind a separate driver, though I would ask that we remove
a lot of the abstractions from the ST driver as they won't be necessary given
the much more restricted parts being supported,

Greg, I'm guessing this is far from the first time this has happened.
Any advise?

Jonathan


On Wed, 19 Aug 2020 18:19:21 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Hi Jonathan,
> 
> I strongly disagree that these parts will be supported by STMicroelectronics driver.
> We DO NOT want to find out one day that we need to modify our structure in order to support competition. If they need to support this chip, please provide a new driver for that part leaving STMicroelectronics driver managing our parts.
> 
> Thanks & Br,
> Denis
> 
> 
> 
> > -----Original Message-----
> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Daniel Palmer
> > Sent: Sunday, August 16, 2020 5:00 AM
> > To: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>
> > Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
> > SC7A30E
> > 
> > Hi Andy,
> > 
> > On Sun, 16 Aug 2020 at 18:55, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > > No SoB tag?! Hint: `git commit -a -s --amend` would fix this if you
> > > have properly configured Git.
> > >  
> > 
> > Sorry I wasn't aware it was needed for an RFC.
> >   
> > > On top of that, can you add Datasheet: tag with links to the actual
> > > component datasheets?  
> > 
> > I will do that for the v1 of the patch series. All of the datasheets I've found so
> > far are mostly Chinese but the register tables are in English. I've collected
> > them together
> > here: http://linux-chenxing.org/silan/index.html
> > 
> > Cheers,
> > 
> > Daniel  


