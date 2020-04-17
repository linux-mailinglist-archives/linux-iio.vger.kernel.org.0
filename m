Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF84B1ADF2E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgDQOF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:05:26 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:28071 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgDQOFY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:24 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 493dCQ3Hfmz9Y;
        Fri, 17 Apr 2020 16:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587132322; bh=TAOYr63+uIr7oNQPvOmOsA677cFgSi4L7cNZ3Qv5dek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA1gQTwgoDY6qCXApyrJTN3fYSH/K6DMp6UyNvvf98ixbSYn8WCi8hFbu2G20/tsU
         23shR+LNzVUU2CH5Hro+NhonfBBcOQSJijozLoc7F8XvvC7Fgtik24cuvapsutV/ky
         PXMrTk6sx6bgg56fQm1v1+7hm3xBFvYWP1JMPZrmKYPq6MGibL0bDnSfqSOV3wGVLz
         nRChbKA/U769pM3Bv/+SlEFVGD1SAwpT+gNp1LFGQ/6e49FCr0TzfUEvWxHe8UbYyh
         /40549SLt79y1MHycc2eMAqAGUrrtKUSwXVykpvA7+t1yzcINBPe6KJXxHAMlTLhzI
         nlveKC8OoqwFA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 17 Apr 2020 16:05:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/3 v3] iio: magnetometer: ak8974: Correct realbits
Message-ID: <20200417140521.GB18337@qmqm.qmqm.pl>
References: <20200417114020.31291-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417114020.31291-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 01:40:18PM +0200, Linus Walleij wrote:
> The original AK8974 has 16 bits of actual value, while the
> HSCDTD008A has 15 bits and the AMI305 and AMI306 has 12 bits.
> Correct this by providing an extra parameter to the channel
> macro and define a separate set of channels for each variant
> of the chip. The resolution is the actual resolution of the
> internal ADC of the chip.
> 
> The values are stored in a S16 in 2's complement so all 16
> bits are used for storing (no shifting needed).
> 
> The AMI305, AMI306 and HSCDTD008A valid bits are picked from
> respective datasheet.
> 
> My best educated guess is that AK8974 is also 12 bits. The
> AK8973 is an 8 bit and earlier version, and the sibling
> drivers AMI305 and AMI306 are 12 bits, so it makes sense
> to assume that the AK8974 is also 12 bits.
[...]
> -#define AK8974_AXIS_CHANNEL(axis, index)				\
> +#define AK8974_AXIS_CHANNEL(axis, index, bits)				\
>  	{								\
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
> @@ -662,16 +662,42 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
>  		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 's',					\
> -			.realbits = 16,					\
> +			.realbits = bits,				\
>  			.storagebits = 16,				\
>  			.endianness = IIO_LE				\
>  		},							\
>  	}
>  
> +/*
> + * We have no datasheet for the AK8974 but we guess that its
> + * ADC is 12 bits.
> + */
>  static const struct iio_chan_spec ak8974_channels[] = {
> -	AK8974_AXIS_CHANNEL(X, 0),
> -	AK8974_AXIS_CHANNEL(Y, 1),
> -	AK8974_AXIS_CHANNEL(Z, 2),
> +	AK8974_AXIS_CHANNEL(X, 0, 12),
> +	AK8974_AXIS_CHANNEL(Y, 1, 12),
> +	AK8974_AXIS_CHANNEL(Z, 2, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +/*
> + * The AMI305 and AMI306 have 12 bit ADC resolution according to
> + * datasheets.
> + */
> +static const struct iio_chan_spec ami30x_channels[] = {
> +	AK8974_AXIS_CHANNEL(X, 0, 12),
> +	AK8974_AXIS_CHANNEL(Y, 1, 12),
> +	AK8974_AXIS_CHANNEL(Z, 2, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};

Maybe call it channels_12bit[] and then you wouldn't need to make
am exact duplicate for ak8974?

Best Regards,
Micha³ Miros³aw
