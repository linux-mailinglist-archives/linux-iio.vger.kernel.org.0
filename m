Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB23BA99B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGCRAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhGCRAH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:00:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A9561627;
        Sat,  3 Jul 2021 16:57:29 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:59:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: rockchip_saradc: add support for rk3568
 saradc
Message-ID: <20210703175952.238e6218@jic23-huawei>
In-Reply-To: <20210702021527.146343-1-xxm@rock-chips.com>
References: <20210702021403.146293-1-xxm@rock-chips.com>
        <20210702021527.146343-1-xxm@rock-chips.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  2 Jul 2021 10:15:27 +0800
Simon Xue <xxm@rock-chips.com> wrote:

A small amount of info on the device is always useful in a commit like this.
Here, perhaps you could call out that it is similar to some other device, but
with 8 channels?

Otherwise, looks good to me.  DT patch is fine as well.  I'll let them sit
a little longer though to give others time to comment.

The dtsi change requested by Johan goes via a different tree anyway so doesn't
need to be part of this series.

Jonathan

> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  drivers/iio/adc/rockchip_saradc.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 12584f1631d8..f3eb8d2e50dc 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -35,7 +35,7 @@
>  #define SARADC_DLY_PU_SOC_MASK		0x3f
>  
>  #define SARADC_TIMEOUT			msecs_to_jiffies(100)
> -#define SARADC_MAX_CHANNELS		6
> +#define SARADC_MAX_CHANNELS		8
>  
>  struct rockchip_saradc_data {
>  	const struct iio_chan_spec	*channels;
> @@ -192,6 +192,23 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>  	.clk_rate = 1000000,
>  };
>  
> +static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
> +	SARADC_CHANNEL(0, "adc0", 10),
> +	SARADC_CHANNEL(1, "adc1", 10),
> +	SARADC_CHANNEL(2, "adc2", 10),
> +	SARADC_CHANNEL(3, "adc3", 10),
> +	SARADC_CHANNEL(4, "adc4", 10),
> +	SARADC_CHANNEL(5, "adc5", 10),
> +	SARADC_CHANNEL(6, "adc6", 10),
> +	SARADC_CHANNEL(7, "adc7", 10),
> +};
> +
> +static const struct rockchip_saradc_data rk3568_saradc_data = {
> +	.channels = rockchip_rk3568_saradc_iio_channels,
> +	.num_channels = ARRAY_SIZE(rockchip_rk3568_saradc_iio_channels),
> +	.clk_rate = 1000000,
> +};
> +
>  static const struct of_device_id rockchip_saradc_match[] = {
>  	{
>  		.compatible = "rockchip,saradc",
> @@ -202,6 +219,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
>  	}, {
>  		.compatible = "rockchip,rk3399-saradc",
>  		.data = &rk3399_saradc_data,
> +	}, {
> +		.compatible = "rockchip,rk3568-saradc",
> +		.data = &rk3568_saradc_data,
>  	},
>  	{},
>  };

