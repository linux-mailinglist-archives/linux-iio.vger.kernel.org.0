Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF04600F9
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 19:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355965AbhK0Stk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 13:49:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56352 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356014AbhK0Srj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 13:47:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAEAB8091D;
        Sat, 27 Nov 2021 18:44:23 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 368C1C53FAD;
        Sat, 27 Nov 2021 18:44:19 +0000 (UTC)
Date:   Sat, 27 Nov 2021 18:49:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     lars@metafoo.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ltr501: Export near level property for
 proximity sensor
Message-ID: <20211127184920.2a9c986d@jic23-huawei>
In-Reply-To: <20211125125646.54831-2-nikita@trvn.ru>
References: <20211125125646.54831-1-nikita@trvn.ru>
        <20211125125646.54831-2-nikita@trvn.ru>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Nov 2021 17:56:46 +0500
Nikita Travkin <nikita@trvn.ru> wrote:

> Userspace tools like iio-sensor-proxy need to know the proximity level
> that should be considered "near". This value is hardware-specific and
> can be defined via the devicetree. Allow the driver to export the near
> level.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Hi Nikita,

This looks fine to me, but I'd like to leave a little time for others
to look including DT review.

Thanks,

Jonathan

> 
> ---
> The changes are mostly copied from vcnl4000 patchset introducing the
> property:
> https://lore.kernel.org/linux-iio/cover.1586094535.git.agx@sigxcpu.org/
> ---
>  drivers/iio/light/ltr501.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 64ba04c275e8..47d61ec2bb50 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -166,6 +166,7 @@ struct ltr501_data {
>  	struct regmap_field *reg_ps_rate;
>  	struct regmap_field *reg_als_prst;
>  	struct regmap_field *reg_ps_prst;
> +	uint32_t near_level;
>  };
>  
>  static const struct ltr501_samp_table ltr501_als_samp_table[] = {
> @@ -525,6 +526,25 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  	return -EINVAL;
>  }
>  
> +static ssize_t ltr501_read_near_level(struct iio_dev *indio_dev,
> +				      uintptr_t priv,
> +				      const struct iio_chan_spec *chan,
> +				      char *buf)
> +{
> +	struct ltr501_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u\n", data->near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = ltr501_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct iio_event_spec ltr501_als_event_spec[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -609,6 +629,7 @@ static const struct iio_chan_spec ltr501_channels[] = {
>  		},
>  		.event_spec = ltr501_pxs_event_spec,
>  		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
> +		.ext_info = ltr501_ext_info,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> @@ -1531,6 +1552,10 @@ static int ltr501_probe(struct i2c_client *client,
>  	if ((partid >> 4) != data->chip_info->partid)
>  		return -ENODEV;
>  
> +	if (device_property_read_u32(&client->dev, "proximity-near-level",
> +				     &data->near_level))
> +		data->near_level = 0;
> +
>  	indio_dev->info = data->chip_info->info;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->no_channels;

