Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67A2147D4
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGDRts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:49:48 -0400
Received: from vps.xff.cz ([195.181.215.36]:37448 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgGDRts (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593884986; bh=gePBFYf0OKwf1JpwnwFGo1PMkHdisVfSx93M0nTaPuI=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=UuSnZzK3XJ0gjlIYs5Ptf2B7J9R2IGupn0VhzieqhJCc5T2031FdrEQxyCdD0v6F4
         IjDs6Z0Vo7UJZo5H5mFJkwtNmzb2xK1oHOVBxSvxCGoHJHYX/H3TC5qYn9NfGf4aIE
         YWVMEZm9rmSeyPGZ6EXL9nzTAzuZPcupEB2xGsLY=
Date:   Sat, 4 Jul 2020 19:49:45 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
Message-ID: <20200704174945.knawjt2yg52ejx2n@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20200703194406.110855-1-megous@megous.com>
 <20200704172916.7a8a7359@archlinux>
 <d2df561c8db7e11eb6937f824f483e33be1db7bc.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2df561c8db7e11eb6937f824f483e33be1db7bc.camel@aosc.io>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sun, Jul 05, 2020 at 01:09:37AM +0800, Icenowy Zheng wrote:
> 在 2020-07-04星期六的 17:29 +0100，Jonathan Cameron写道：
> > On Fri,  3 Jul 2020 21:44:05 +0200
> > Ondrej Jirman <megous@megous.com> wrote:
> > 
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > > 
> > > The STK3311 chip has a variant called STK3311-X, which has a
> > > different
> > > chip id of 0x12.
> > > 
> > > Add the chip id to the driver.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > 
> > Given this is clearly not quite compatible with the stk3311 probably
> > best to also add a an id to the of id table.  Any idea what else
> > is different?
> 
> By the way, STK3311 seems to have many variants lying around, and all
> of them have different IDs. The pinouts seem to be different but the
> registers are compatible.
> 
> [1] is a datasheet of STK3311-S34 with ID 0x1e.
> [2] is a datasheet of STK3311-A with ID 0x15.
> 
> I cannot find the datasheet of STK3311-X, 0x12 is read from the device.
> The model number itself is mentioned at [3], the official website of
> sensortek.
> 
> [1] 
> http://pro0fc108.hkpic1.websiteonline.cn/upload/STK3311-S34Datasheetv1.pdf
> 
> [2] 
> http://pro0fc108.hkpic1.websiteonline.cn/upload/STK3311-ADatasheetv1.pdf
> 
> [3] 
> http://www.sensortek.com.tw/index.php/en/products/proximity-sensor-with-als/

Yeah, it looks like it's the only one of stk3111-* variants that sensortek
lists on their website. I also didn't find the *-x datasheet despite trying
really hard.

All the functionality seems to work with the current driver and this patch.

regards,
	o.

> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > ---
> > >  drivers/iio/light/stk3310.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/iio/light/stk3310.c
> > > b/drivers/iio/light/stk3310.c
> > > index 185c24a75ae6..1a8401d198a4 100644
> > > --- a/drivers/iio/light/stk3310.c
> > > +++ b/drivers/iio/light/stk3310.c
> > > @@ -37,6 +37,7 @@
> > >  
> > >  #define STK3310_CHIP_ID_VAL			0x13
> > >  #define STK3311_CHIP_ID_VAL			0x1D
> > > +#define STK3311X_CHIP_ID_VAL			0x12
> > >  #define STK3335_CHIP_ID_VAL			0x51
> > >  #define STK3310_PSINT_EN			0x01
> > >  #define STK3310_PS_MAX_VAL			0xFFFF
> > > @@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev
> > > *indio_dev)
> > >  
> > >  	if (chipid != STK3310_CHIP_ID_VAL &&
> > >  	    chipid != STK3311_CHIP_ID_VAL &&
> > > +	    chipid != STK3311X_CHIP_ID_VAL &&
> > >  	    chipid != STK3335_CHIP_ID_VAL) {
> > >  		dev_err(&client->dev, "invalid chip id: 0x%x\n",
> > > chipid);
> > >  		return -ENODEV;
