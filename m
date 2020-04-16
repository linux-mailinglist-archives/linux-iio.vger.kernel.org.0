Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF461ACA79
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504225AbgDPPfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503878AbgDPPfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 11:35:12 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 08:35:11 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5301::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA5C061A0C;
        Thu, 16 Apr 2020 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587051310;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BCeEOgm/2AQXBqZX9ijmy+r0/K/JKtbBfYXnVmRlUHc=;
        b=XByQx+1ixlHQQE8yu+W3/vngSgai1b+W8DkbgtFUpifEXF3E6OzIrb79LL5JOJ17+d
        aPxbHhSIj2Y8OMm81pOAZY+caFc9zdJZCBiavj7bpB7flcalyYF+XBf0c9HWtQ49fc6Q
        bXwY2z+5RahT2pKIymSZimvmDkQee+P2n6ZxrsLMe2srVybC1kSps55b+itMU7TSdSim
        +vg8zcVDp3ZS4Wlyk48NRsTzmW+ArGC/w/rNgAtBgYIVdN98yUGz9c8RevPzhQPbs4eV
        5gcUbygAQ6h9n7AIT2ztyTktrr+p1jJX1wsSYNIs/Y0BxOsnnaIa69iOfeCEjt+0dG4N
        S5pw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id k074e0w3GFW5BGq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Apr 2020 17:32:05 +0200 (CEST)
Date:   Thu, 16 Apr 2020 17:32:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200416153200.GA897@gerhold.net>
References: <20200416140917.8087-1-linus.walleij@linaro.org>
 <20200416140917.8087-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416140917.8087-2-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On Thu, Apr 16, 2020 at 04:09:17PM +0200, Linus Walleij wrote:
> The manual for the HSCDTD008A gives us a scaling for the
> three axis as +/- 2.4mT per axis.
> 

I wonder if we can really assume that this applies to
the other models (e.g. AK8974) as well?

> When I implement this the biggest axis indicates 0.59 Gauss
> which is a reasonable measurement for the earths magnetic
> which is in the range of 0.25 to 0.65 Gauss on the surface
> according to Wikipedia.
> 
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Split out the measurement refactoring.
> ---
>  drivers/iio/magnetometer/ak8974.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 5361647b9054..effcdd93e650 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -603,6 +603,18 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
>  		*val = outval;
>  		ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * The datasheet for HSCDTF008A, page 3 specifies the
> +		 * range of the sensor as +/- 2.4 mT per axis, which corresponds
> +		 * to +/- 2400 uT = +/- 24 Gauss. So 0x7fff is 24 Gauss and
> +		 * 0xffff is -24 Gauss. To account for the one missing value if
> +		 * we multiply by 1/S16_MAX, instead multiply with 2/U16_MAX.
> +		 */

I just want to note that (according to the datasheet), HSCDTD008A
produces either 14-bit or 15-bit measurements (depending on
the HSCDTD008A_CTRL4_RANGE bit that we set by default).

I think this isn't exposed correctly in the AK8974_AXIS_CHANNEL() macro
(realbits is 16 instead of 15), so this might need special casing for
hscdt008a?

The reason I mention this is because I think it would also affect the
scaling that you implement here. With 15-bit output it produces values
from +16383 (0x3fff) (= 2.4 mT?) to -16384 (0xc000) (= -2.4 mT?).

So it would never reach the 0x7fff and 0xffff you mention
in your comment.

> +		*val = 24 * 2;
> +		*val2 = U16_MAX;
> +		ret = IIO_VAL_FRACTIONAL;
> +		break;
>  	}
>  out_err_read:
>  	return ret;
> @@ -667,7 +679,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
>  		.channel2 = IIO_MOD_##axis,				\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
>  		.ext_info = ak8974_ext_info,				\
>  		.address = index,					\
>  		.scan_index = index,					\
> -- 
> 2.21.1
> 
