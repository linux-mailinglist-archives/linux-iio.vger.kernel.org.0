Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFE1B883B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYRsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYRsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:48:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27ABF206B6;
        Sat, 25 Apr 2020 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587836894;
        bh=bi0cxJLPQhpp3syjgRoSATl47TvoQVeDksKErDsCS2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfXwBjpXIt/A5fj/rnHVA4S+v6bapF6XAbcpOUSOlg5VBKciuihNuSqa6aUuRWBbB
         NYLXRtHiA+qDWk2MvKwid9P6AqhoPibcv9wrG2pcIQJF7qaUiLXL/wQDKrBywHaqZZ
         esHKKLo5zLpdqbGS9UD6Gu9MHVCZQugqD//eVoZ4=
Date:   Sat, 25 Apr 2020 18:48:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Nick Reitemeyer <nick.reitemeyer@web.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8974: add Alps hscdtd008a
Message-ID: <20200425184810.4b12e165@archlinux>
In-Reply-To: <20200412143524.377d2c16@archlinux>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
        <20200406141350.162036-3-nick.reitemeyer@web.de>
        <20200406143113.GA126707@gerhold.net>
        <20200412143524.377d2c16@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Apr 2020 14:35:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 6 Apr 2020 16:31:13 +0200
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > On Mon, Apr 06, 2020 at 04:13:53PM +0200, Nick Reitemeyer wrote:  
> > > The hscdtd008a is similar to the AK8974:
> > > Only the whoami value and some registers are different.
> > > 
> > > Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>    
> > 
> > Thanks a lot for sending this patch upstream!
> > 
> > I checked this with the datasheet available here:
> > https://tech.alpsalpine.com/prod/c/pdf/sensor/geomagnetic/hscd/hscdtd008a_data.pdf
> > 
> > Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> > 
> > ... and it seems to produce reasonable values on samsung-golden:
> > 
> > Tested-by: Stephan Gerhold <stephan@gerhold.net>
> > 
> > Linus Walleij might want to test this on his samsung-skomer :)  
> 
> Looks good to me, but I'll need a review on the binding (particularly
> the vendor prefix as it's in a generic file). 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.
Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > Stephan
> >   
> > > ---
> > >  drivers/iio/magnetometer/ak8974.c | 38 ++++++++++++++++++++++++-------
> > >  1 file changed, 30 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > > index d32996702110..ade4ed8f67d2 100644
> > > --- a/drivers/iio/magnetometer/ak8974.c
> > > +++ b/drivers/iio/magnetometer/ak8974.c
> > > @@ -49,6 +49,7 @@
> > >  #define AK8974_WHOAMI_VALUE_AMI306 0x46
> > >  #define AK8974_WHOAMI_VALUE_AMI305 0x47
> > >  #define AK8974_WHOAMI_VALUE_AK8974 0x48
> > > +#define AK8974_WHOAMI_VALUE_HSCDTD008A 0x49
> > > 
> > >  #define AK8974_DATA_X		0x10
> > >  #define AK8974_DATA_Y		0x12
> > > @@ -140,6 +141,12 @@
> > >  #define AK8974_INT_CTRL_PULSE	BIT(1) /* 0 = latched; 1 = pulse (50 usec) */
> > >  #define AK8974_INT_CTRL_RESDEF	(AK8974_INT_CTRL_XYZEN | AK8974_INT_CTRL_POL)
> > > 
> > > +/* HSCDTD008A-specific control register */
> > > +#define HSCDTD008A_CTRL4	0x1E
> > > +#define HSCDTD008A_CTRL4_MMD	BIT(7)	/* must be set to 1 */
> > > +#define HSCDTD008A_CTRL4_RANGE	BIT(4)	/* 0 = 14-bit output; 1 = 15-bit output */
> > > +#define HSCDTD008A_CTRL4_RESDEF	(HSCDTD008A_CTRL4_MMD | HSCDTD008A_CTRL4_RANGE)
> > > +
> > >  /* The AMI305 has elaborate FW version and serial number registers */
> > >  #define AMI305_VER		0xE8
> > >  #define AMI305_SN		0xEA
> > > @@ -241,10 +248,17 @@ static int ak8974_reset(struct ak8974 *ak8974)
> > >  	ret = regmap_write(ak8974->map, AK8974_CTRL3, AK8974_CTRL3_RESDEF);
> > >  	if (ret)
> > >  		return ret;
> > > -	ret = regmap_write(ak8974->map, AK8974_INT_CTRL,
> > > -			   AK8974_INT_CTRL_RESDEF);
> > > -	if (ret)
> > > -		return ret;
> > > +	if (ak8974->variant != AK8974_WHOAMI_VALUE_HSCDTD008A) {
> > > +		ret = regmap_write(ak8974->map, AK8974_INT_CTRL,
> > > +				   AK8974_INT_CTRL_RESDEF);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		ret = regmap_write(ak8974->map, HSCDTD008A_CTRL4,
> > > +				   HSCDTD008A_CTRL4_RESDEF);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > 
> > >  	/* After reset, power off is default state */
> > >  	return ak8974_set_power(ak8974, AK8974_PWR_OFF);
> > > @@ -267,6 +281,8 @@ static int ak8974_configure(struct ak8974 *ak8974)
> > >  		if (ret)
> > >  			return ret;
> > >  	}
> > > +	if (ak8974->variant == AK8974_WHOAMI_VALUE_HSCDTD008A)
> > > +		return 0;
> > >  	ret = regmap_write(ak8974->map, AK8974_INT_CTRL, AK8974_INT_CTRL_POL);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -495,6 +511,10 @@ static int ak8974_detect(struct ak8974 *ak8974)
> > >  		name = "ak8974";
> > >  		dev_info(&ak8974->i2c->dev, "detected AK8974\n");
> > >  		break;
> > > +	case AK8974_WHOAMI_VALUE_HSCDTD008A:
> > > +		name = "hscdtd008a";
> > > +		dev_info(&ak8974->i2c->dev, "detected hscdtd008a\n");
> > > +		break;
> > >  	default:
> > >  		dev_err(&ak8974->i2c->dev, "unsupported device (%02x) ",
> > >  			whoami);
> > > @@ -674,18 +694,18 @@ static bool ak8974_writeable_reg(struct device *dev, unsigned int reg)
> > >  	case AK8974_INT_CTRL:
> > >  	case AK8974_INT_THRES:
> > >  	case AK8974_INT_THRES + 1:
> > > +		return true;
> > >  	case AK8974_PRESET:
> > >  	case AK8974_PRESET + 1:
> > > -		return true;
> > > +		return ak8974->variant != AK8974_WHOAMI_VALUE_HSCDTD008A;
> > >  	case AK8974_OFFSET_X:
> > >  	case AK8974_OFFSET_X + 1:
> > >  	case AK8974_OFFSET_Y:
> > >  	case AK8974_OFFSET_Y + 1:
> > >  	case AK8974_OFFSET_Z:
> > >  	case AK8974_OFFSET_Z + 1:
> > > -		if (ak8974->variant == AK8974_WHOAMI_VALUE_AK8974)
> > > -			return true;
> > > -		return false;
> > > +		return ak8974->variant == AK8974_WHOAMI_VALUE_AK8974 ||
> > > +		       ak8974->variant == AK8974_WHOAMI_VALUE_HSCDTD008A;
> > >  	case AMI305_OFFSET_X:
> > >  	case AMI305_OFFSET_X + 1:
> > >  	case AMI305_OFFSET_Y:
> > > @@ -926,12 +946,14 @@ static const struct i2c_device_id ak8974_id[] = {
> > >  	{"ami305", 0 },
> > >  	{"ami306", 0 },
> > >  	{"ak8974", 0 },
> > > +	{"hscdtd008a", 0 },
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, ak8974_id);
> > > 
> > >  static const struct of_device_id ak8974_of_match[] = {
> > >  	{ .compatible = "asahi-kasei,ak8974", },
> > > +	{ .compatible = "alps,hscdtd008a", },
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ak8974_of_match);
> > > --
> > > 2.26.0
> > >     
> 

