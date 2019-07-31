Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5D7BBCF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfGaIhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 04:37:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfGaIhX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jul 2019 04:37:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7681FA5D765ABC0D6C1;
        Wed, 31 Jul 2019 16:37:17 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 16:37:16 +0800
Date:   Wed, 31 Jul 2019 09:37:04 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
CC:     Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
        "Jacopo Mondi" <jacopo+renesas@jmondi.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 04/12] iio: adc: max9611: Fix misuse of GENMASK macro
Message-ID: <20190731093704.00006c84@huawei.com>
In-Reply-To: <20190729215214.eueitve4tfxmqer3@uno.localdomain>
References: <cover.1562734889.git.joe@perches.com>
        <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
        <20190714125403.0789dc9e@archlinux>
        <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
        <20190729215214.eueitve4tfxmqer3@uno.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 23:52:14 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hello,
>   so I finally run some test and...
> 
> On Sun, Jul 14, 2019 at 05:19:32AM -0700, Joe Perches wrote:
> > On Sun, 2019-07-14 at 12:54 +0100, Jonathan Cameron wrote:  
> > > On Tue,  9 Jul 2019 22:04:17 -0700
> > > Joe Perches <joe@perches.com> wrote:
> > >  
> > > > Arguments are supposed to be ordered high then low.
> > > >
> > > > Signed-off-by: Joe Perches <joe@perches.com>  
> > >
> > > Applied to the fixes-togreg branch of iio.git and marked for
> > > stable etc.  
> 
> I don't see it in v5.3-rc2, has it been collected or are we still in
> time for an additional fix?
> 
> >
> > This mask is used in an init function called from a probe.
> >
> > I don't have this hardware but it looks as if it could
> > never have worked so I doubt the driver and the hardware
> > have ever been tested.
> >
> > Does anyone have this device in actual use?  
> 
> Because it turns out this is 2 times embarrassing. The mask definition
> is indeed wrong, as Joe reported and fixed, but also this line
> >
> > 	regval = ret & MAX9611_TEMP_MASK;  
> 
> is very wrong as regval is read as:
>         ret = max9611_read_single(max9611, CONF_TEMP, &regval);
> 
> So that should actually be:
>         regval &= MAX9611_TEMP_MASK;
> not
>  	regval = ret & MAX9611_TEMP_MASK;
> Ups...
> 
> Yes, it worked by chance, as regval was always 0, which is in the
> range of acceptable temperatures :/
> 
> >
> > 	if ((regval > MAX9611_TEMP_MAX_POS &&
> > 	     regval < MAX9611_TEMP_MIN_NEG) ||
> > 	     regval > MAX9611_TEMP_MAX_NEG) {  
> 
> Also reading this condition and how I had defined the temperature
> calculation formula makes me wonder if this it totally correct, but
> for the moment:
> 
> 1) if Joe's patch has been collected, I can send an additional patch to
> fix how regval is computed.
> 2) If Joe's patch still have to be collected, the regval computation
> might be fixed there.

I think this will have hit linux-next on the same day as your email.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/iio/adc?id=ae8cc91a7d85e018c0c267f580820b2bb558cd48

So follow up patch please.

Thanks!

Jonathan
> 
> Sorry for taking so long to get back to you and thanks for noticing.
> 
> Thanks
>   j
> 
> > 		dev_err(max9611->dev,
> > 			"Invalid value received from ADC 0x%4x: aborting\n",
> > 			regval);
> > 		return -EIO;
> > 	}
> >
> >  
> > > Thanks,
> > >
> > > Jonathan
> > >  
> > > > ---
> > > >  drivers/iio/adc/max9611.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > > index 917223d5ff5b..0e3c6529fc4c 100644
> > > > --- a/drivers/iio/adc/max9611.c
> > > > +++ b/drivers/iio/adc/max9611.c
> > > > @@ -83,7 +83,7 @@
> > > >  #define MAX9611_TEMP_MAX_POS		0x7f80
> > > >  #define MAX9611_TEMP_MAX_NEG		0xff80
> > > >  #define MAX9611_TEMP_MIN_NEG		0xd980
> > > > -#define MAX9611_TEMP_MASK		GENMASK(7, 15)
> > > > +#define MAX9611_TEMP_MASK		GENMASK(15, 7)
> > > >  #define MAX9611_TEMP_SHIFT		0x07
> > > >  #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
> > > >  #define MAX9611_TEMP_SCALE_NUM		1000000  
> >  
> 


