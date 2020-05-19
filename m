Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB41D9E53
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgESR5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:57:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgESR5k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 13:57:40 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 443DF7086CFE94E725B2;
        Tue, 19 May 2020 18:57:39 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 18:57:38 +0100
Date:   Tue, 19 May 2020 18:57:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: bmi160: added mount-matrix support
Message-ID: <20200519185711.00003308@Huawei.com>
In-Reply-To: <20200519075111.6356-5-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-5-jonathan.albrieux@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 09:51:00 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Add mount-matrix binding support. As chip could have different orientations
> a mount matrix support is needed to correctly translate these differences
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Hi Jonathan,

Looks good to me. I'll pick this up once 1-3 are tidied up and
we have a device tree review in for the binding doc.  I'm rubbish
at reviewing those as Rob will certify so may well have missed something!

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
> index 9bbe0d8e6720..78c8ca962359 100644
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
> @@ -840,6 +855,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
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


