Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3783BB9A2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGEIyk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:54:40 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:43544 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEIyj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:54:39 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 04:54:39 EDT
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id BF8FC12F8;
        Mon,  5 Jul 2021 16:44:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12341T139824151373568S1625474670595314_;
        Mon, 05 Jul 2021 16:44:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <003f08735e52a5842aba1f29514b94e6>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: linux-iio@vger.kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v1 1/2] iio: adc: rockchip_saradc: add support for rk3568
 saradc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210705011755.3408-1-xxm@rock-chips.com>
From:   xxm <xxm@rock-chips.com>
Message-ID: <510d23f8-05b3-85a5-a753-40ec9e6c0d09@rock-chips.com>
Date:   Mon, 5 Jul 2021 16:44:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705011755.3408-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

This patch is broken, discard. Resend in other patch set.

Simon Xue.

ÔÚ 2021/7/5 9:17, Simon Xue Ð´µÀ:
> It is similar to other devices, but with 8 channels.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 12584f1631d8..f3eb8d2e50dc 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -35,7 +35,7 @@
>   #define SARADC_DLY_PU_SOC_MASK		0x3f
>   
>   #define SARADC_TIMEOUT			msecs_to_jiffies(100)
> -#define SARADC_MAX_CHANNELS		6
> +#define SARADC_MAX_CHANNELS		8
>   
>   struct rockchip_saradc_data {
>   	const struct iio_chan_spec	*channels;
> @@ -192,6 +192,23 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.clk_rate = 1000000,
>   };
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
>   static const struct of_device_id rockchip_saradc_match[] = {
>   	{
>   		.compatible = "rockchip,saradc",
> @@ -202,6 +219,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
>   	}, {
>   		.compatible = "rockchip,rk3399-saradc",
>   		.data = &rk3399_saradc_data,
> +	}, {
> +		.compatible = "rockchip,rk3568-saradc",
> +		.data = &rk3568_saradc_data,
>   	},
>   	{},
>   };


