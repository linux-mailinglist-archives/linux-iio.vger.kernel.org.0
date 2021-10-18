Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D1432281
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhJRPTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 11:19:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3999 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhJRPTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 11:19:48 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HY0kZ23m4z6899G;
        Mon, 18 Oct 2021 23:13:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 18 Oct 2021 17:17:33 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 16:17:33 +0100
Date:   Mon, 18 Oct 2021 16:17:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <20211018161732.0000565f@Huawei.com>
In-Reply-To: <CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
        <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
        <20211017115843.2a872fbe@jic23-huawei>
        <CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 10:40:33 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> +Cc: Hans
> 
> On Mon, Oct 18, 2021 at 6:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 16 Oct 2021 19:27:50 +0300
> > Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> >  
> > >  BMI160: AYA NEA accelometer ID  
> 
> accelerometer
> 
> > >     On AYA NEO, the accelerometer is BMI160 but it is exposed
> > >     via ACPI as 10EC5280
> > >
> > >     Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>  
> >
> > I guess it is hopelessly optimistic to hope that we could let someone
> > at the supplier know that's a totally invalid ACPI id and that they
> > should clean up their act.
> >
> > Curiously it looks like a valid PCI ID pair though for a realtek device.
> >
> > Ah well.  Applied to the iio-togreg branch of iio.git and pushed out
> > as testing to see if 0-day can find any issues with it.  
> 
> NAK. And I explain below why and how to make progress with it.
> 
> The commit message should contain at least the link to the DSDT and
> official technical description of the platform. Besides that, it
> should have a corresponding comment near to the ID in the code.
> 
> On top of that, in particular to this case, the ID is very valid from
> the ACPI specification point of view, but in this case it's a
> representation of the PCI ID 10ec:5280 which is Realtek owned. So, we
> need to hear (okay in reasonable time) from Realtek (I believe they
> are active in the Linux kernel) and that OEM.
> 
> I hardly believe that Realtek has issued a special ID from the range
> where mostly PCIe ports or so are allocated, although it's possible.
> We need proof.
> 
> What I believe is the case here is that OEMs are just quite diletants
> in ACPI and firmware and they messed up with BIOS somehow that it
> issued the ID for the device.
> There are also two other possibilities: OEM stole the ID (deliberately
> or accidentally), or the device is not just gyro, but something which
> contains gyro.
> 
> As to the last paragraph, see above, we must see DSDT. Without it I
> have a strong NAK.
> 
> P.S. Jonathan, please do not be so fast next time with ACPI IDs.

No problem.  Will pull this one once I'm back on correct PC.

Jonathan

> 

