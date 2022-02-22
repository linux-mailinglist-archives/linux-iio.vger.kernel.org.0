Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF94BFF6E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Feb 2022 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiBVQ5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Feb 2022 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiBVQ5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2022 11:57:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B742DD4F
        for <linux-iio@vger.kernel.org>; Tue, 22 Feb 2022 08:56:43 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K350F2kJmz67bS5;
        Wed, 23 Feb 2022 00:55:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 17:56:41 +0100
Received: from localhost (10.47.30.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 16:56:40 +0000
Date:   Tue, 22 Feb 2022 16:56:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <haibo.chen@nxp.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-imx@nxp.com>
Subject: Re: [PATCH] iio: imu: fxos8700: few bug fix for fxos8700
Message-ID: <20220222165638.0000243a@Huawei.com>
In-Reply-To: <1645502822-5585-1-git-send-email-haibo.chen@nxp.com>
References: <1645502822-5585-1-git-send-email-haibo.chen@nxp.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.92]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Feb 2022 12:07:02 +0800
<haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> 1, z raw data always 0, regmap_buk_read use the wrong length. fix it
> and optmize read the only need data.
> 2, use the correct register address when try to read raw data.
> 3, before set scale, need to set the sensor to standby mode. otherwise
> the scale set is not work.
> 4, give the correct offset when config odr bit.

Sounds like 4 patches to me. Whenever you have a list of what a patch
does you should probably split it up.  Would be a lot easier to review as one
patch per issue.  For now I've just take a quick general look.


> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/iio/imu/fxos8700_core.c | 66 +++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index ab288186f36e..1896d6db6d77 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -162,12 +162,11 @@
>  
>  #define FXOS8700_DEVICE_ID          0xC7
>  #define FXOS8700_PRE_DEVICE_ID      0xC4
> -#define FXOS8700_DATA_BUF_SIZE      3
>  
>  struct fxos8700_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
> -	__be16 buf[FXOS8700_DATA_BUF_SIZE] ____cacheline_aligned;
> +	__be16 buf ____cacheline_aligned;
>  };
>  
>  /* Regmap info */
> @@ -345,7 +344,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
>  static int fxos8700_set_scale(struct fxos8700_data *data,
>  			      enum fxos8700_sensor t, int uscale)
>  {
> -	int i;
> +	int i, ret, val;
> +	bool active_mode;
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> @@ -354,6 +354,23 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  		return -EINVAL;
>  	}
>  
> +	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	active_mode = val & FXOS8700_ACTIVE;
> +
> +	if (active_mode) {
> +		/*
> +		 * The device must be in standby mode to change any of the
> +		 * other fields within CTRL_REG1
> +		 */
> +		ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +				   val & ~FXOS8700_ACTIVE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < scale_num; i++)
>  		if (fxos8700_accel_scale[i].uscale == uscale)
>  			break;
> @@ -361,8 +378,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	if (i == scale_num)
>  		return -EINVAL;
>  
> -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
>  			    fxos8700_accel_scale[i].bits);

Realign these parameters with the opening bracket.

> +	if (ret)
> +		return ret;

blank line here.

> +	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
> +				  FXOS8700_ACTIVE, active_mode);
>  }
>  
>  static int fxos8700_get_scale(struct fxos8700_data *data,
> @@ -393,23 +414,29 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
>  static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
>  			     int axis, int *val)
>  {
> -	u8 base, reg;
> -	int ret;
> +	u8 base, offset;
>  	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
> +	u8 tmp_data[2];
We loop around this every now and then. It 'happens' to be the case that
currently (or last time I checked) regmap_bulk_read always copied the
data and hence uses a dma safe buffer internally. That is not guaranteed
by the interface however so when we last asked Mark Brown he suggested
we should assume that it requires the same level of dma buffer safety
as the bus subsystems being used.

Thus for any driver doing bulk accesses to SPI device, you need a DMA safe
buffer.  Which is what the __cacheline_aligned buffer in iio_priv() is for
in this driver.

> +	u16 native_data;
> +	int ret;
>  
> -	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> +	base = type ? FXOS8700_M_OUT_X_MSB : FXOS8700_OUT_X_MSB;
> +	offset = axis - IIO_MOD_X;
>  
> -	/* Block read 6 bytes of device output registers to avoid data loss */
> -	ret = regmap_bulk_read(data->regmap, base, data->buf,
> -			       FXOS8700_DATA_BUF_SIZE);
> +	ret = regmap_bulk_read(data->regmap, base + offset, &tmp_data[0], 2);
>  	if (ret)
> -		return ret;
> +		return -EIO;

Why eat the error return of the bulk_read and replace it with a potentially
less informative one?

>  
> -	/* Convert axis to buffer index */
> -	reg = axis - IIO_MOD_X;
>  
> +	data->buf = ((tmp_data[1] << 8) & 0xff00) | tmp_data[0];

tmp_data[1] is a u8 so that masking isn't doing anything other than
possibly fixing some type conversion issues.

However, this is an endian operation, so express it as such
get_unaligned_be16(tmp_data); or similar.  Maybe even just use a __be16
and be16_to_cpu() directly on that.


>  	/* Convert to native endianness */
> -	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
> +	native_data = be16_to_cpu(data->buf);

This looks wrong.  You've already done a be to cpu conversion (via
the shifts above) now y ou are doing it again. Why?

> +
> +	/*accel raw data only has 14 bit */

/* Accel ...

> +	if (!type)
> +		native_data = native_data >> 2;
> +
> +	*val = sign_extend32(native_data, 15);
>  
>  	return 0;
>  }
> @@ -462,6 +489,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  		return ret;
>  
>  	val &= FXOS8700_CTRL_ODR_MSK;
> +	val = val >> 3;

FIELD_GET() would be easier to read for this.

>  
>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)
> @@ -592,14 +620,14 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +	/* Set for max full-scale range (+/-8G) */
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
>  	if (ret)
>  		return ret;
>  
> -	/* Set for max full-scale range (+/-8G) */
> -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
> +	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +			   FXOS8700_CTRL_ODR_MAX << 3 | FXOS8700_ACTIVE);

Preference for FIELD_PREP() to make ti clear what you are shifting left and why.
Given you have FXOS8700_CTRL_ODR_MSK that is easy to add here.
Mind you it's a noop as ODR_MAX == 0 anyway :)


>  }
>  
>  static void fxos8700_chip_uninit(void *data)

