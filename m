Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076064561FA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKRSL5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 13:11:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4108 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhKRSL5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 13:11:57 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw74P2Sj9z67GTC;
        Fri, 19 Nov 2021 02:05:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 18 Nov 2021 19:08:54 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 18:08:54 +0000
Date:   Thu, 18 Nov 2021 18:08:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: expose shared parameter in IIO_ENUM_AVAILABLE
Message-ID: <20211118180851.00001693@Huawei.com>
In-Reply-To: <20211118141709.64450-1-antoniu.miclaus@analog.com>
References: <20211118141709.64450-1-antoniu.miclaus@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Nov 2021 16:17:09 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The shared parameter should be configurable based on its usage, and not
> constrained to IIO_SHARED_BY_TYPE.
> 
> This patch aims to improve the flexibility in using the
> IIO_ENUM_AVAILABLE define and avoid redefining custom iio enums that
> expose the shared parameter.
> 
> An example is the ad5766.c driver where IIO_ENUM_AVAILABLE_SHARED was
> defined in order to achieve `shared` parameter customization.
> 
> The current state of the IIO_ENUM_AVAILABLE implementation will imply
> similar redefinitions each time a driver will require access to the
> `shared` parameter. An example would be admv1013 driver which will
> require custom device attribute for the frequency translation  modes:
> Quadrature I/Q mode and Intermediate frequency mode.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I'm fine with the change subject to comments below,

Jonathan

> ---
>  drivers/iio/accel/bma180.c                |  2 +-
>  drivers/iio/accel/mma9553.c               |  2 +-
>  drivers/iio/adc/ad7192.c                  |  2 +-
>  drivers/iio/adc/hi8435.c                  |  2 +-
>  drivers/iio/dac/ad5064.c                  |  4 ++--
>  drivers/iio/dac/ad5380.c                  |  2 +-
>  drivers/iio/dac/ad5446.c                  |  2 +-
>  drivers/iio/dac/ad5504.c                  |  2 +-
>  drivers/iio/dac/ad5624r_spi.c             |  2 +-
>  drivers/iio/dac/ad5686.c                  |  2 +-
>  drivers/iio/dac/ad5766.c                  | 13 ++-----------
>  drivers/iio/dac/ad5791.c                  |  2 +-
>  drivers/iio/dac/max5821.c                 |  2 +-
>  drivers/iio/dac/mcp4725.c                 |  8 ++++----
>  drivers/iio/dac/stm32-dac.c               |  2 +-
>  drivers/iio/dac/ti-dac082s085.c           |  2 +-
>  drivers/iio/dac/ti-dac5571.c              |  2 +-
>  drivers/iio/dac/ti-dac7311.c              |  2 +-
>  drivers/iio/magnetometer/hmc5843_core.c   |  4 ++--
>  drivers/iio/trigger/stm32-timer-trigger.c |  4 ++--
>  include/linux/iio/iio.h                   |  5 +++--
>  21 files changed, 30 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 2edfcb4819b7..09496f358ad9 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -658,7 +658,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
>  
>  static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
>  	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
> -	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
> +	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
>  	{ }
>  };
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ba3ecb3b57dc..0570ab1cc064 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -917,7 +917,7 @@ static const struct iio_enum mma9553_calibgender_enum = {
>  
>  static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
>  	IIO_ENUM("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
> -	IIO_ENUM_AVAILABLE("calibgender", &mma9553_calibgender_enum),
> +	IIO_ENUM_AVAILABLE("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
>  	{},
>  };
>  
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 2121a812b0c3..7cb1bd3ea375 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -257,7 +257,7 @@ static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
>  	},
>  	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
>  		 &ad7192_syscalib_mode_enum),
> -	IIO_ENUM_AVAILABLE("sys_calibration_mode", &ad7192_syscalib_mode_enum),
> +	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE, &ad7192_syscalib_mode_enum),

Please wrap the lines to 80 chars unless strong reason not to do so.


> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index f08726bf5ec3..4364d7fa066e 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -246,7 +246,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
>  
>  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
>  	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
> -	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> +	IIO_ENUM_AVAILABLE("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>  	{ }
>  };
> @@ -261,7 +261,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
>  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
>  	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
>  	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, IIO_SHARED_BY_TYPE, hmc5843_get_mount_matrix),
Wrong macro.  (I cheated on this as 0-day already spotted it :)

>
Thanks,

Jonathan
