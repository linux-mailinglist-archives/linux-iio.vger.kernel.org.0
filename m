Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76727CD056
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJFKWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 06:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFKWm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 06:22:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA3F2084B;
        Sun,  6 Oct 2019 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570357361;
        bh=e+Hd6JGqXeeXPPUTvP+COxjnXZT9DefoIm0M7Up6rrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YxjCWHF8pb4qER5uGz98QeiaiDDW2tJDFQU7Jfy2U/T+tAOaNTKqvSfLo3zQDESwX
         VJeVPS0hcwoE0XZX8sp7Ni/6UfPT77/FeDuFiqVhNkQtODt5AU0GdoBGX2EQmVa0a5
         vJX89jfZuFq0t4M/ykE/TRVAbW9XpPhu7x8io808=
Date:   Sun, 6 Oct 2019 11:22:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/7] iio: adc: max1027: Prepare the introduction of
 different resolutions
Message-ID: <20191006112236.481102f8@archlinux>
In-Reply-To: <20191003173401.16343-5-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-5-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Oct 2019 19:33:58 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Maxim's max1027/29/31 series returns the measured voltages with a
> resolution of 10 bits. There is a very similar series, max1227/29/31
> which works identically but uses a resolution of 12 bits. Prepare the
> support for these chips by turning the 'depth' into a macro parameter
> instead of hardcoding it everywhere. Also reorganize just a bit the
> macros at the top to avoid repeating tens of lines when adding support
> for a new chip.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Minor comments inline.

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 78 ++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index f9b473ee6711..5d5d223dd42a 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -83,7 +83,7 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  #endif
>  
> -#define MAX1027_V_CHAN(index)						\
> +#define MAX1027_V_CHAN(index, depth)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  		.scan_index = index + 1,				\
>  		.scan_type = {						\
>  			.sign = 'u',					\
> -			.realbits = 10,					\
> +			.realbits = depth,				\
>  			.storagebits = 16,				\
>  			.shift = 2,					\
>  			.endianness = IIO_BE,				\
> @@ -115,52 +115,42 @@ MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
>  		},							\
>  	}
>  
> +#define MAX1X27_CHANNELS(depth)			\
> +	MAX1027_T_CHAN,				\
> +	MAX1027_V_CHAN(0, depth),		\
> +	MAX1027_V_CHAN(1, depth),		\
> +	MAX1027_V_CHAN(2, depth),		\
> +	MAX1027_V_CHAN(3, depth),		\
> +	MAX1027_V_CHAN(4, depth),		\
> +	MAX1027_V_CHAN(5, depth),		\
> +	MAX1027_V_CHAN(6, depth),		\
> +	MAX1027_V_CHAN(7, depth)
> +
> +#define MAX1X29_CHANNELS(depth)			\
> +	MAX1027_V_CHAN(8, depth),		\
> +	MAX1027_V_CHAN(9, depth),		\
> +	MAX1027_V_CHAN(10, depth),		\
> +	MAX1027_V_CHAN(11, depth)
> +

Modify this a touch so the macro for MAX1X29_CHANNELS includes
MAX1X27_CHANNELS.  That way each macro's name matches what it
does rather than the 'additional channels' for that device.

> +#define MAX1X31_CHANNELS(depth)			\
> +	MAX1027_V_CHAN(12, depth),		\
> +	MAX1027_V_CHAN(13, depth),		\
> +	MAX1027_V_CHAN(14, depth),		\
> +	MAX1027_V_CHAN(15, depth)
> +
>  static const struct iio_chan_spec max1027_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7)
> +	MAX1X27_CHANNELS(10)
>  };
>  
>  static const struct iio_chan_spec max1029_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7),
> -	MAX1027_V_CHAN(8),
> -	MAX1027_V_CHAN(9),
> -	MAX1027_V_CHAN(10),
> -	MAX1027_V_CHAN(11)
> +	MAX1X27_CHANNELS(10),
> +	MAX1X29_CHANNELS(10)
>  };
>  
>  static const struct iio_chan_spec max1031_channels[] = {
> -	MAX1027_T_CHAN,
> -	MAX1027_V_CHAN(0),
> -	MAX1027_V_CHAN(1),
> -	MAX1027_V_CHAN(2),
> -	MAX1027_V_CHAN(3),
> -	MAX1027_V_CHAN(4),
> -	MAX1027_V_CHAN(5),
> -	MAX1027_V_CHAN(6),
> -	MAX1027_V_CHAN(7),
> -	MAX1027_V_CHAN(8),
> -	MAX1027_V_CHAN(9),
> -	MAX1027_V_CHAN(10),
> -	MAX1027_V_CHAN(11),
> -	MAX1027_V_CHAN(12),
> -	MAX1027_V_CHAN(13),
> -	MAX1027_V_CHAN(14),
> -	MAX1027_V_CHAN(15)
> +	MAX1X27_CHANNELS(10),
> +	MAX1X29_CHANNELS(10),
> +	MAX1X31_CHANNELS(10)
>  };
>  
>  static const unsigned long max1027_available_scan_masks[] = {
> @@ -181,6 +171,7 @@ static const unsigned long max1031_available_scan_masks[] = {
>  struct max1027_chip_info {
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
> +	unsigned int depth;

Could we use the channel real_bits field instead of replicating the info?

>  	const unsigned long *available_scan_masks;
>  };
>  
> @@ -188,16 +179,19 @@ static const struct max1027_chip_info max1027_chip_info_tbl[] = {
>  	[max1027] = {
>  		.channels = max1027_channels,
>  		.num_channels = ARRAY_SIZE(max1027_channels),
> +		.depth = 10,
>  		.available_scan_masks = max1027_available_scan_masks,
>  	},
>  	[max1029] = {
>  		.channels = max1029_channels,
>  		.num_channels = ARRAY_SIZE(max1029_channels),
> +		.depth = 10,
>  		.available_scan_masks = max1029_available_scan_masks,
>  	},
>  	[max1031] = {
>  		.channels = max1031_channels,
>  		.num_channels = ARRAY_SIZE(max1031_channels),
> +		.depth = 10,
>  		.available_scan_masks = max1031_available_scan_masks,
>  	},
>  };
> @@ -284,7 +278,7 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		case IIO_VOLTAGE:
>  			*val = 2500;
> -			*val2 = 10;
> +			*val2 = st->info->depth;
>  			ret = IIO_VAL_FRACTIONAL_LOG2;
>  			break;
>  		default:

