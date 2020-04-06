Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517CD19F7FC
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgDFObZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:31:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:16592 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgDFObZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 10:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586183482;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ey2GXzMvyqvroTPmaRXrrAz5iqe+P8aBisZEkCVhpDA=;
        b=kIjXbZNo262/j1YJtknncryLNywq2RifZsfQEy6gQDoZVbRgjPZn+2LYPYZ7cZixNF
        mNXHClDbYaaKKMS4GqASRDe9VBNwbdo4dAIQ6A3EtZ1eDXrU1xuIj7wpzvFOthvlAA6o
        GIM4kS8q1km9yAcdPd0CBl8mhypnAxZo1e6yAlUi5Mdl+ay9NlDKIrcWigSE67B0aNnU
        WFDgYk6ts8Qf7Ivp1FwKOjB7NnTAmNEs+WSHkE0UAxY4UOIikYErxnd3Ewlt/SDcOooj
        9GiE+596A/wqKvroz5Oz1pEO7AGD+FAKm7UCznSWT5GdIBHdiAw+CVn6du36iqF9ULB4
        HJ8Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w36EVK2fF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 6 Apr 2020 16:31:20 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:31:13 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Nick Reitemeyer <nick.reitemeyer@web.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8974: add Alps hscdtd008a
Message-ID: <20200406143113.GA126707@gerhold.net>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
 <20200406141350.162036-3-nick.reitemeyer@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406141350.162036-3-nick.reitemeyer@web.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 06, 2020 at 04:13:53PM +0200, Nick Reitemeyer wrote:
> The hscdtd008a is similar to the AK8974:
> Only the whoami value and some registers are different.
> 
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>

Thanks a lot for sending this patch upstream!

I checked this with the datasheet available here:
https://tech.alpsalpine.com/prod/c/pdf/sensor/geomagnetic/hscd/hscdtd008a_data.pdf

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

... and it seems to produce reasonable values on samsung-golden:

Tested-by: Stephan Gerhold <stephan@gerhold.net>

Linus Walleij might want to test this on his samsung-skomer :)

Thanks,
Stephan

> ---
>  drivers/iio/magnetometer/ak8974.c | 38 ++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index d32996702110..ade4ed8f67d2 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -49,6 +49,7 @@
>  #define AK8974_WHOAMI_VALUE_AMI306 0x46
>  #define AK8974_WHOAMI_VALUE_AMI305 0x47
>  #define AK8974_WHOAMI_VALUE_AK8974 0x48
> +#define AK8974_WHOAMI_VALUE_HSCDTD008A 0x49
> 
>  #define AK8974_DATA_X		0x10
>  #define AK8974_DATA_Y		0x12
> @@ -140,6 +141,12 @@
>  #define AK8974_INT_CTRL_PULSE	BIT(1) /* 0 = latched; 1 = pulse (50 usec) */
>  #define AK8974_INT_CTRL_RESDEF	(AK8974_INT_CTRL_XYZEN | AK8974_INT_CTRL_POL)
> 
> +/* HSCDTD008A-specific control register */
> +#define HSCDTD008A_CTRL4	0x1E
> +#define HSCDTD008A_CTRL4_MMD	BIT(7)	/* must be set to 1 */
> +#define HSCDTD008A_CTRL4_RANGE	BIT(4)	/* 0 = 14-bit output; 1 = 15-bit output */
> +#define HSCDTD008A_CTRL4_RESDEF	(HSCDTD008A_CTRL4_MMD | HSCDTD008A_CTRL4_RANGE)
> +
>  /* The AMI305 has elaborate FW version and serial number registers */
>  #define AMI305_VER		0xE8
>  #define AMI305_SN		0xEA
> @@ -241,10 +248,17 @@ static int ak8974_reset(struct ak8974 *ak8974)
>  	ret = regmap_write(ak8974->map, AK8974_CTRL3, AK8974_CTRL3_RESDEF);
>  	if (ret)
>  		return ret;
> -	ret = regmap_write(ak8974->map, AK8974_INT_CTRL,
> -			   AK8974_INT_CTRL_RESDEF);
> -	if (ret)
> -		return ret;
> +	if (ak8974->variant != AK8974_WHOAMI_VALUE_HSCDTD008A) {
> +		ret = regmap_write(ak8974->map, AK8974_INT_CTRL,
> +				   AK8974_INT_CTRL_RESDEF);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(ak8974->map, HSCDTD008A_CTRL4,
> +				   HSCDTD008A_CTRL4_RESDEF);
> +		if (ret)
> +			return ret;
> +	}
> 
>  	/* After reset, power off is default state */
>  	return ak8974_set_power(ak8974, AK8974_PWR_OFF);
> @@ -267,6 +281,8 @@ static int ak8974_configure(struct ak8974 *ak8974)
>  		if (ret)
>  			return ret;
>  	}
> +	if (ak8974->variant == AK8974_WHOAMI_VALUE_HSCDTD008A)
> +		return 0;
>  	ret = regmap_write(ak8974->map, AK8974_INT_CTRL, AK8974_INT_CTRL_POL);
>  	if (ret)
>  		return ret;
> @@ -495,6 +511,10 @@ static int ak8974_detect(struct ak8974 *ak8974)
>  		name = "ak8974";
>  		dev_info(&ak8974->i2c->dev, "detected AK8974\n");
>  		break;
> +	case AK8974_WHOAMI_VALUE_HSCDTD008A:
> +		name = "hscdtd008a";
> +		dev_info(&ak8974->i2c->dev, "detected hscdtd008a\n");
> +		break;
>  	default:
>  		dev_err(&ak8974->i2c->dev, "unsupported device (%02x) ",
>  			whoami);
> @@ -674,18 +694,18 @@ static bool ak8974_writeable_reg(struct device *dev, unsigned int reg)
>  	case AK8974_INT_CTRL:
>  	case AK8974_INT_THRES:
>  	case AK8974_INT_THRES + 1:
> +		return true;
>  	case AK8974_PRESET:
>  	case AK8974_PRESET + 1:
> -		return true;
> +		return ak8974->variant != AK8974_WHOAMI_VALUE_HSCDTD008A;
>  	case AK8974_OFFSET_X:
>  	case AK8974_OFFSET_X + 1:
>  	case AK8974_OFFSET_Y:
>  	case AK8974_OFFSET_Y + 1:
>  	case AK8974_OFFSET_Z:
>  	case AK8974_OFFSET_Z + 1:
> -		if (ak8974->variant == AK8974_WHOAMI_VALUE_AK8974)
> -			return true;
> -		return false;
> +		return ak8974->variant == AK8974_WHOAMI_VALUE_AK8974 ||
> +		       ak8974->variant == AK8974_WHOAMI_VALUE_HSCDTD008A;
>  	case AMI305_OFFSET_X:
>  	case AMI305_OFFSET_X + 1:
>  	case AMI305_OFFSET_Y:
> @@ -926,12 +946,14 @@ static const struct i2c_device_id ak8974_id[] = {
>  	{"ami305", 0 },
>  	{"ami306", 0 },
>  	{"ak8974", 0 },
> +	{"hscdtd008a", 0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ak8974_id);
> 
>  static const struct of_device_id ak8974_of_match[] = {
>  	{ .compatible = "asahi-kasei,ak8974", },
> +	{ .compatible = "alps,hscdtd008a", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ak8974_of_match);
> --
> 2.26.0
> 
