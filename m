Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7851DFEBA
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEXLoB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 07:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXLoA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 07:44:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2D32075F;
        Sun, 24 May 2020 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590320640;
        bh=o6SJToLu6ZDHu0wWMseTOeGzHfMogzrCv91Eoa763Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YS4MpGLgOLIA+60LS/zs1BAG3NBBNsopgHBdArXjgNa+lq30E+6bEsbVVIEsXhD7h
         Jgl7hkEBfMnwmZ0ElCV29eniU2a4cvhoP4oyvXXKY8Hl3FpzI7Z250jc+Fk6aALKvX
         uEXIwvdQYNmA6Cx4clOyQvm2TD3Qhfxkv76GaLys=
Date:   Sun, 24 May 2020 12:43:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 5/5] iio: imu: bmi160: added mount-matrix support
Message-ID: <20200524124355.526af9d9@archlinux>
In-Reply-To: <20200520194656.16218-6-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
        <20200520194656.16218-6-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 21:46:44 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Add mount-matrix binding support. As chip could have different orientations
> a mount matrix support is needed to correctly translate these differences.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Other than those bits for the binding doc, the rest of the series
looks good to me.   Given timing this will only go into mainline in the
next cycle now anyway so we have plenty of time to tidy up the corners.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160.h      |  1 +
>  drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 923c3b274fde..a82e040bd109 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -9,6 +9,7 @@ struct bmi160_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
>  	struct regulator_bulk_data supplies[2];
> +	struct iio_mount_matrix orientation;
>  };
>  
>  extern const struct regmap_config bmi160_regmap_config;
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index d3316ca02fbd..26d586daee26 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -110,6 +110,7 @@
>  		.storagebits = 16,				\
>  		.endianness = IIO_LE,				\
>  	},							\
> +	.ext_info = bmi160_ext_info,				\
>  }
>  
>  /* scan indexes follow DATA register order */
> @@ -265,6 +266,20 @@ static const struct  bmi160_odr_item bmi160_odr_table[] = {
>  	},
>  };
>  
> +static const struct iio_mount_matrix *
> +bmi160_get_mount_matrix(const struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info bmi160_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmi160_get_mount_matrix),
> +	{ }
> +};
> +
>  static const struct iio_chan_spec bmi160_channels[] = {
>  	BMI160_CHANNEL(IIO_ACCEL, X, BMI160_SCAN_ACCEL_X),
>  	BMI160_CHANNEL(IIO_ACCEL, Y, BMI160_SCAN_ACCEL_Y),
> @@ -839,6 +854,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> +				    &data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	ret = bmi160_chip_init(data, use_spi);
>  	if (ret)
>  		return ret;

