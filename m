Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C3E446786
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhKERJB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 13:09:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4065 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhKERJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 13:09:01 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hm6H93Lrjz67Np6;
        Sat,  6 Nov 2021 01:01:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 18:06:17 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 17:06:16 +0000
Date:   Fri, 5 Nov 2021 17:06:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dmitry Maslov <maslovdmitry@seeed.cc>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, <north_sea@qq.com>,
        <baozhu.zuo@seeed.cc>, <jian.xiong@seeed.cc>
Subject: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
Message-ID: <20211105170615.000005e8@Huawei.com>
In-Reply-To: <62f8cd50.4.17ced0e99b4.Coremail.maslovdmitry@seeed.cc>
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
        <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
        <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
        <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
        <6f764cb4.e6.17cdd1249ee.Coremail.maslovdmitry@seeed.cc>
        <20211103182102.2232e680@jic23-huawei>
        <62f8cd50.4.17ced0e99b4.Coremail.maslovdmitry@seeed.cc>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Nov 2021 06:25:29 +0800
Dmitry Maslov <maslovdmitry@seeed.cc> wrote:

> > From: "Jonathan Cameron" <jic23@kernel.org>
> > Sent Time: 2021-11-03 20:21:02 (Wednesday)
> > To: "Dmitry Maslov" <maslovdmitry@seeed.cc>
> > Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>, linux-iio <linux-iio@vger.kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, north_sea@qq.com, baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
> > Subject: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support  
> 
> > > > > > > @@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
> > > > > > >         {"LTER0501", ltr501},
> > > > > > >         {"LTER0559", ltr559},
> > > > > > >         {"LTER0301", ltr301},
> > > > > > > +       {"LTER0303", ltr303},    
> > > > > >
> > > > > > Any evidence of this ACPI ID being in the wild, please?    
> > > > >
> > > > > I'm sorry, I do not exactly understand the question. Do you mean where that particular sensor is used?    
> > > > 
> > > > Can you provide a name of the machine which has this ID in its DSDT
> > > > table, please?    
> > > 
> > > We're submitting this patch specifically for reTerminal.
> > > Here is DTS file for the reTerminal, currently awaiting merge in Raspberry Pi Linux kernel
> > > repository.
> > > https://github.com/raspberrypi/linux/blob/6ef732875d705ff15cc4c25d4d0a0eee87dc2a58/arch/arm/boot/dts/overlays/seeed-reterminal-core-overlay.dts#L99
> > > 
> > > So, while at the moment ACPI part is not being used, later we might use this sensor for other, x86 based
> > > boards, for example ODYSSEY - X86J4125800.
> > > 
> > > Is there a particular reason you think this part should be omitted for LTR303?
> > >   
> > ACPI IDs are supposed to be made up of either a PNP id or ACPI ID registered with
> > UEFI forum.
> > 
> > A 4 letter version is an ACPI ID (3 letters in PNP), so it should be in this table
> > https://uefi.org/acpi_id_list
> > 
> > It's not.  So that means the proper process wasn't followed.  If you were using this
> > ID on a server, chances are we'd just tell you go fix your firmware (it's happened
> > to me and we fixed it).  However the sad truth is in consumer / embedded devices that
> > may not be a practical solution.  As such, if the ID was known to be in the wild
> > we would probably let it in.
> > 
> > Unfortunately I only really got familiar with ACPI specs in the last 4 years
> > and before that time I didn't know what the rules were - so let a load of IDs in.
> > Some of those IDs are in use on hardware that is out there so we have to continue
> > supporting them or introduce a regression on that hardware.
> > 
> > The process of applying for a PNP or ACPI ID isn't that bad for a company - you ask
> > for a particular ID and request is then sent for a round of 'has anyone an objection'
> > to the ASWG (I'm a rather inactive member so I see these every week or so).
> > Instructions at https://uefi.org/PNP_ACPI_Registry
> > 
> > Note that there would be two options for Seeed.  Either you persuade liteon to apply
> > and then issue an appropriate number (which may well not be the part number - often
> > people just start counting from 0, or assign ranges to different people in the company
> > so there doesn't need to be a central registry) or seeed applies for an ACPI or PNP ID
> > and then issues IDs for any part you want to support on an ACPI platform that doesn't
> > yet have an ID issued by the supplier.
> > 
> > Note that it's also common to use someone else's ID. Once it's assigned to a device
> > it can't be reused anyway so if say, Intel or Hisilicon had assigned one to a part
> > already then you could just reuse it for your ACPI platforms.
> > 
> > Hope that clears up how this is supposed to work.
> > 
> > Also note that every now and then we 'guess' that IDs are just cut and paste
> > jobs and remove them.  So far we've only hit ones that were in actual use a
> > few times - the majority of invalid ones weren't in use.
> >   
> Thank you for taking your time to write such detailed explanation! The whole situation
> with ACPI/PNP ID is much more clear to me now.
> As I mentioned above, currently our main goal is adding drivers necessary to support
> reTerminal, which is ARM processor based device. It means that as of now, we 
> won't be using ACPI. Do you think it is valid option to just remove that part?
> That shouldn't affect ARM based devices ability to interact with the sensor.
> 
Absolutely.  Just drop the ACPI table entry.

Thanks,
Jonathan

