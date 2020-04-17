Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468171ADF8F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgDQOLM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:11:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:49534 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730750AbgDQOLM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Apr 2020 10:11:12 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 493dL62KK6z9Y;
        Fri, 17 Apr 2020 16:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587132670; bh=6s3b8gNs32G9eUZB4hAFus/TtzJlwoWzev1bbkoi4xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP6SHoaCcNUR7ApUa4bBNYGBsYwXvaY83pl4j1wPWnaMAmtoGykU2I9FdrKTKgbmA
         rkClZ8p4lfIZ5n2FSJsqqF0kzTZOsaTGVPt9jfSlKwAxN4pocorDCXO2a5DrHaYzMN
         Y8TABHMPAZcAuokyrqxWYbvemNDQr/RNqdcb9yo5XsULT1TM2uwIVHlV5bJsWk0D8L
         Dr5bKiYkNoAhM/vrMcLYpWI2dBdUFEruUABmbEvc/p7ORKYXCp3drFY8Uak6zhzG2G
         HMaeNDO0tx7jBxLYnf80jBLeU7cp4xDm1brLc2THnAeiwJOD5stOvxeiAw7CoYncLy
         M0qL0f4bn9TPg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 17 Apr 2020 16:11:09 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 3/3 v3] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200417141109.GC18337@qmqm.qmqm.pl>
References: <20200417114020.31291-1-linus.walleij@linaro.org>
 <20200417114020.31291-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417114020.31291-3-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 01:40:20PM +0200, Linus Walleij wrote:
> The manual for the HSCDTD008A gives us a scaling for the
> three axis as +/- 2.4mT (24 Gauss) per axis.
> 
> The manual for the AMI305 and AMI306 gives us a scaling
> for the three axis as +/- 12 Gauss per axis.
> 
> Tests with the HSCDTD008A sensor, cat the raw values:
> $ cat in_magn_*_raw
> raw
> 45
> 189
> -19
> 
> The scaling factor in in_magn_*_scale is 0.001464843,
> which gives:
> 0.065 Gauss
> 0.277 Gauss
> -0.027 Gauss
> 
> The earths magnetic field is in the range of 0.25 to 0.65
> Gauss on the surface according to Wikipedia, so these
> seem like reasonable values.
> 
> Again we are guessing that the AK8974 has a 12 bit ADC,
> based on the similarity with AMI305 and AMI306.
> 
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Scale the 2.4mT/24Gauss to 15 bits for the HSCDTD008A.
> - Scale the 12 Gauss to 12 bits for the AMI305/AMI306
> - Use 12 bits for the other variants.
> - Return directly in the raw read function.
> ChangeLog v1->v2:
> - Split out the measurement refactoring.
> ---
>  drivers/iio/magnetometer/ak8974.c | 45 ++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index b8dbea119a67..f8410ac34316 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -608,6 +608,48 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (ak8974->variant) {
> +		case AK8974_WHOAMI_VALUE_AMI306:
> +		case AK8974_WHOAMI_VALUE_AMI305:
> +			/*
> +			 * The datasheet for AMI305 and AMI306, page 6
> +			 * specifies the range of the sensor to be
> +			 * +/- 12 Gauss.
> +			 */
> +			*val = 12 * 2;
> +			/*
> +			 * 12 bits are used
> +			 * [ -2048 .. 2047 ] (manual page 20)
> +			 * [ 0xf800 .. 0x07ff ]
> +			 */
> +			*val2 = 4096;
> +			return IIO_VAL_FRACTIONAL;

You can leave '* 2' out from both values. And actually, since *val2 is 2^n,
you can return IIO_VAL_FRACTIONAL_LOG2 (with *val2 = 11) and save a division
in the caller.

Best Regards,
Micha³ Miros³aw
