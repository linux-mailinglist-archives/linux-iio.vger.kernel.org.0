Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5B571B2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZTZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZTZA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:25:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F1F20663;
        Wed, 26 Jun 2019 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561577098;
        bh=9ddGytE2MAIZUMOytFZySMm/WxQbcmBwrlBm8SgBIsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jf6UJSlKMAJtNs2U6rd/Pm+8Rt34lOdXkcEID0cY+PtdcZ256uVQ/cR2KdiTBh5hC
         s1i0LObLC7xcuhwewtfmy+ZlujlxP+fGNBwt4DGi0lGiUeiH31AVPhoYWs7mgTuQ0w
         etI/kDkA6VNAP9fQUhwH/n3Hka1I9zG/IjGMrWYs=
Date:   Wed, 26 Jun 2019 20:24:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCHi V4 2/5] iio: adc: ad7124: Add buffered input support
Message-ID: <20190626202453.723aded1@archlinux>
In-Reply-To: <20190625081128.22190-2-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
        <20190625081128.22190-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 11:11:25 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch adds the option to enable the buffered mode for positive and
> negative inputs. Each option can be enabled independently.
> 
> In buffered mode, the input channel feeds into a high impedance input stage
> of the buffer amplifier. Therefore, the input can tolerate significant
> source impedances and is tailored for direct connection to external
> resistive type sensors such as strain gages or RTDs.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Changelog v2:
> - nothing changed here
> 
> Changelog v3:
> - nothing changed here
> 
> Changelog v4:
> - nothing changed here
> 
>  drivers/iio/adc/ad7124.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 810234db9c0d..ab52c5e9ecb1 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -61,6 +61,8 @@
>  #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
>  #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
>  #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
> +#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
> +#define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
>  
>  /* AD7124_FILTER_X */
>  #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
> @@ -108,6 +110,8 @@ struct ad7124_chip_info {
>  struct ad7124_channel_config {
>  	enum ad7124_ref_sel refsel;
>  	bool bipolar;
> +	bool buf_positive;
> +	bool buf_negative;
>  	unsigned int ain;
>  	unsigned int vref_mv;
>  	unsigned int pga_bits;
> @@ -473,6 +477,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  		else
>  			st->channel_config[channel].refsel = tmp;
>  
> +		st->channel_config[channel].buf_positive =
> +			of_property_read_bool(child, "adi,buffered-positive");
> +		st->channel_config[channel].buf_negative =
> +			of_property_read_bool(child, "adi,buffered-negative");
> +
>  		*chan = ad7124_channel_template;
>  		chan->address = channel;
>  		chan->scan_index = channel;
> @@ -492,7 +501,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  static int ad7124_setup(struct ad7124_state *st)
>  {
>  	unsigned int val, fclk, power_mode;
> -	int i, ret;
> +	int i, ret, tmp;
>  
>  	fclk = clk_get_rate(st->mclk);
>  	if (!fclk)
> @@ -525,8 +534,12 @@ static int ad7124_setup(struct ad7124_state *st)
>  		if (ret < 0)
>  			return ret;
>  
> +		tmp = (st->channel_config[i].buf_positive << 1)  +
> +			st->channel_config[i].buf_negative;
> +
>  		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
> -		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel);
> +		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
> +		      AD7124_CONFIG_IN_BUFF(tmp);
>  		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
>  		if (ret < 0)
>  			return ret;

