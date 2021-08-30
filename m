Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC713FB59F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhH3MGb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237276AbhH3MG2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:06:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5FF60F5C;
        Mon, 30 Aug 2021 12:05:33 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:08:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: add AK09116 support
Message-ID: <20210830130845.11a61ab1@jic23-huawei>
In-Reply-To: <20210825020738.35877-1-matt.ranostay@konsulko.com>
References: <20210825020738.35877-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 05:07:38 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add additional AK09116 to the magnetometer driver which has the same
> register mapping and scaling as the AK09112 device.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hi Matt,

There are a few odd bits of formatting and ordering in here, but they are in
keeping with the existing code so fair enough!

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to have fun with it.

Thanks,

Jonathan

> ---
>  .../iio/magnetometer/asahi-kasei,ak8975.yaml  |  2 ++
>  drivers/iio/magnetometer/Kconfig              |  2 +-
>  drivers/iio/magnetometer/ak8975.c             | 35 +++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> index a0a1ffe017df..c552b2b7751a 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -17,11 +17,13 @@ properties:
>            - asahi-kasei,ak8963
>            - asahi-kasei,ak09911
>            - asahi-kasei,ak09912
> +          - asahi-kasei,ak09916
>        - enum:
>            - ak8975
>            - ak8963
>            - ak09911
>            - ak09912
> +          - ak09916
>          deprecated: true
>  
>    reg:
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 74ad5701c6c2..565ee41ccb3a 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -28,7 +28,7 @@ config AK8975
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
> -	  AK09911 or AK09912 3-Axis Magnetometer.
> +	  AK09911, AK09912 or AK09916 3-Axis Magnetometer.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ak8975.
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 42b8a2680e3a..6e82dc54a417 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -78,6 +78,7 @@
>   */
>  #define AK09912_REG_WIA1		0x00
>  #define AK09912_REG_WIA2		0x01
> +#define AK09916_DEVICE_ID		0x09
>  #define AK09912_DEVICE_ID		0x04
>  #define AK09911_DEVICE_ID		0x05
>  
> @@ -208,6 +209,7 @@ enum asahi_compass_chipset {
>  	AK8963,
>  	AK09911,
>  	AK09912,
> +	AK09916,
>  };
>  
>  enum ak_ctrl_reg_addr {
> @@ -345,6 +347,31 @@ static const struct ak_def ak_def_array[] = {
>  			AK09912_REG_HXL,
>  			AK09912_REG_HYL,
>  			AK09912_REG_HZL},
> +	},
> +	{
> +		.type = AK09916,
> +		.raw_to_gauss = ak09912_raw_to_gauss,
> +		.range = 32752,
> +		.ctrl_regs = {
> +			AK09912_REG_ST1,
> +			AK09912_REG_ST2,
> +			AK09912_REG_CNTL2,
> +			AK09912_REG_ASAX,
> +			AK09912_MAX_REGS},
> +		.ctrl_masks = {
> +			AK09912_REG_ST1_DRDY_MASK,
> +			AK09912_REG_ST2_HOFL_MASK,
> +			0,
> +			AK09912_REG_CNTL2_MODE_MASK},
> +		.ctrl_modes = {
> +			AK09912_REG_CNTL_MODE_POWER_DOWN,
> +			AK09912_REG_CNTL_MODE_ONCE,
> +			AK09912_REG_CNTL_MODE_SELF_TEST,
> +			AK09912_REG_CNTL_MODE_FUSE_ROM},
> +		.data_regs = {
> +			AK09912_REG_HXL,
> +			AK09912_REG_HYL,
> +			AK09912_REG_HZL},
>  	}
>  };
>  
> @@ -425,6 +452,7 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  	/*
>  	 * Signature for each device:
>  	 * Device   |  WIA1      |  WIA2
> +	 * AK09916  |  DEVICE_ID_|  AK09916_DEVICE_ID
>  	 * AK09912  |  DEVICE_ID |  AK09912_DEVICE_ID
>  	 * AK09911  |  DEVICE_ID |  AK09911_DEVICE_ID
>  	 * AK8975   |  DEVICE_ID |  NA
> @@ -452,6 +480,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  		if (wia_val[1] == AK09912_DEVICE_ID)
>  			return 0;
>  		break;
> +	case AK09916:
> +		if (wia_val[1] == AK09916_DEVICE_ID)
> +			return 0;
> +		break;
>  	default:
>  		dev_err(&client->dev, "Type %d unknown\n", type);
>  	}
> @@ -1057,6 +1089,7 @@ static const struct i2c_device_id ak8975_id[] = {
>  	{"AK8963", AK8963},
>  	{"ak09911", AK09911},
>  	{"ak09912", AK09912},
> +	{"ak09916", AK09916},
>  	{}
>  };
>  
> @@ -1071,6 +1104,8 @@ static const struct of_device_id ak8975_of_match[] = {
>  	{ .compatible = "ak09911", },
>  	{ .compatible = "asahi-kasei,ak09912", },
>  	{ .compatible = "ak09912", },
> +	{ .compatible = "asahi-kasei,ak09916", },
> +	{ .compatible = "ak09916", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ak8975_of_match);

