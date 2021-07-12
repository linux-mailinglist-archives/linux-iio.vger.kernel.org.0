Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5F3C4D3C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhGLHMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 03:12:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55990 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243921AbhGLHGH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Jul 2021 03:06:07 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m2pxp-0002Ud-R1; Mon, 12 Jul 2021 09:02:49 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonathan Cameron <jic23@kernel.org>, Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH v2 2/2] iio: adc: rockchip_saradc: add support for rk3568 saradc
Date:   Mon, 12 Jul 2021 09:02:48 +0200
Message-ID: <3451680.Hrl0x5LGn1@diego>
In-Reply-To: <20210712014507.97477-1-xxm@rock-chips.com>
References: <20210712014437.97427-1-xxm@rock-chips.com> <20210712014507.97477-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Montag, 12. Juli 2021, 03:45:07 CEST schrieb Simon Xue:
> It is similar to other devices, but with 8 channels.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


If a previous version received such a Reviewed-by or similar
please add them to subsequent new versions that you send.
[Not needed here as I sent them again, but to keep in mind :-) ]

Thanks
Heiko

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
> 




