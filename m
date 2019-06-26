Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21B571B6
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFZTZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZTZa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:25:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332CA20663;
        Wed, 26 Jun 2019 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561577129;
        bh=17SmlQOB16n8ABcZcXfvr/VljlqwX+htptnV1U7ULd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KrW9kanM4nUc3adGaHL8IjyuCHfd35a1/SvKU/FDWO2dgY1ySWO/K0eCy0gvR/3tE
         z1uHhBTD9PA3efM76gssVjC6xaCkQTLVsJA6l3vnBWkdL96thU5wu+xD3rzrjagS9Q
         w05wyYTTtcOrqHjX1TvTqEjQWPB9dbLDtUwQjsAQ=
Date:   Wed, 26 Jun 2019 20:25:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V4 3/5] iio: adc: ad7124: Shift to dynamic allocation
 for channel configuration
Message-ID: <20190626202525.6eec81fe@archlinux>
In-Reply-To: <20190625081128.22190-3-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
        <20190625081128.22190-3-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 11:11:26 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch changes the channel configuration member of the device
> structure from a fixed size array to a dynamic allocated one with a size
> equal to the number of channels specified in the device tree. This will
> ensure a more flexibility for compatible devices.
> 
> Ex. ad7124-4 - can have 4 differential or 8 pseudo-differential channels
> ad7124-8 - can have 8 differential or 16 pseudo-differential channels
> 
> Also the device can suspport any other combination of differential and
> pseudo-differential channels base on the physical number of inputs
> available.
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
>  drivers/iio/adc/ad7124.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index ab52c5e9ecb1..edc6f1cc90b2 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -121,7 +121,7 @@ struct ad7124_channel_config {
>  struct ad7124_state {
>  	const struct ad7124_chip_info *chip_info;
>  	struct ad_sigma_delta sd;
> -	struct ad7124_channel_config channel_config[4];
> +	struct ad7124_channel_config *channel_config;
>  	struct regulator *vref[4];
>  	struct clk *mclk;
>  	unsigned int adc_control;
> @@ -439,6 +439,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  	struct ad7124_state *st = iio_priv(indio_dev);
>  	struct device_node *child;
>  	struct iio_chan_spec *chan;
> +	struct ad7124_channel_config *chan_config;
>  	unsigned int ain[2], channel = 0, tmp;
>  	int ret;
>  
> @@ -453,8 +454,14 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  	if (!chan)
>  		return -ENOMEM;
>  
> +	chan_config = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> +				   sizeof(*chan_config), GFP_KERNEL);
> +	if (!chan_config)
> +		return -ENOMEM;
> +
>  	indio_dev->channels = chan;
>  	indio_dev->num_channels = st->num_channels;
> +	st->channel_config = chan_config;
>  
>  	for_each_available_child_of_node(np, child) {
>  		ret = of_property_read_u32(child, "reg", &channel);

