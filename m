Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A595121EE35
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNKop (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 06:44:45 -0400
Received: from vps.xff.cz ([195.181.215.36]:46676 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNKoo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jul 2020 06:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594723483; bh=ISbEoYLOvtTnx9JsAafH45kzahVwCN2GvMztna3r75U=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=OncBpStIUqmS3i3hXXelU7JXxuXUq5IXLIdmNXRLkaE0714lCvMJjquBsA9q2o24V
         2+h9+TmGU/uBDmnbsyRUGYwu//RCKNKkU7dm9XEcoBG4POgBi+StuvVDtjZ1y7QFHQ
         yNfnAOQwNugsPisrgg7HXLp6pOyRM1SHQ6rRSmkg=
Date:   Tue, 14 Jul 2020 12:44:41 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
Message-ID: <20200714104441.nrnaauqunjst67ix@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20200703194406.110855-1-megous@megous.com>
 <20200704172916.7a8a7359@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704172916.7a8a7359@archlinux>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

On Sat, Jul 04, 2020 at 05:29:16PM +0100, Jonathan Cameron wrote:
> On Fri,  3 Jul 2020 21:44:05 +0200
> Ondrej Jirman <megous@megous.com> wrote:
> 
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > The STK3311 chip has a variant called STK3311-X, which has a different
> > chip id of 0x12.
> > 
> > Add the chip id to the driver.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Given this is clearly not quite compatible with the stk3311 probably
> best to also add a an id to the of id table.  Any idea what else
> is different?

I've looked at it more, and there's no stk3311 either. It always has
some suffix, like -sa -9 -a -wv -x, .... So I don't think a new
ID in the table is neccessary. The driver can differentiate based on
chip id, in case it will ever become necessary.

regards,
	o.

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/stk3310.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> > index 185c24a75ae6..1a8401d198a4 100644
> > --- a/drivers/iio/light/stk3310.c
> > +++ b/drivers/iio/light/stk3310.c
> > @@ -37,6 +37,7 @@
> >  
> >  #define STK3310_CHIP_ID_VAL			0x13
> >  #define STK3311_CHIP_ID_VAL			0x1D
> > +#define STK3311X_CHIP_ID_VAL			0x12
> >  #define STK3335_CHIP_ID_VAL			0x51
> >  #define STK3310_PSINT_EN			0x01
> >  #define STK3310_PS_MAX_VAL			0xFFFF
> > @@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
> >  
> >  	if (chipid != STK3310_CHIP_ID_VAL &&
> >  	    chipid != STK3311_CHIP_ID_VAL &&
> > +	    chipid != STK3311X_CHIP_ID_VAL &&
> >  	    chipid != STK3335_CHIP_ID_VAL) {
> >  		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
> >  		return -ENODEV;
> 
