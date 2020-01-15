Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFF13CAC9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAORUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 12:20:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:9254 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgAORUy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Jan 2020 12:20:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 09:20:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="226188020"
Received: from efgreve-mobl2.amr.corp.intel.com ([10.254.8.33])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 09:20:51 -0800
Message-ID: <df95e688271b4cc0e2313daeeae85507c566fc04.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] iio: accel: kxcjk1013: Support orientation matrix
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jan 2020 09:20:05 -0800
In-Reply-To: <20200112203301.30235-1-digetx@gmail.com>
References: <20200112203301.30235-1-digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-01-12 at 23:33 +0300, Dmitry Osipenko wrote:
> Hardware could be physically mounted in any possible direction and
> userpspace needs to be aware of the mounting orientation in order to
> process sensor's data correctly. In particular this helps iio-sensor-
> proxy
> to report display's orientation properly on a phone/tablet devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/accel/kxcjk-1013.c       | 27 +++++++++++++++++++++++++-
> -
>  include/linux/iio/accel/kxcjk_1013.h |  3 +++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c
> b/drivers/iio/accel/kxcjk-1013.c
> index fee535d6e45b..c9924a65c32a 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -130,6 +130,7 @@ struct kxcjk1013_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
> +	struct iio_mount_matrix orientation;
>  	struct mutex mutex;
>  	s16 buffer[8];
>  	u8 odr_bits;
> @@ -983,6 +984,20 @@ static const struct iio_event_spec
> kxcjk1013_event = {
>  				 BIT(IIO_EV_INFO_PERIOD)
>  };
>  
> +static const struct iio_mount_matrix *
> +kxcjk1013_get_mount_matrix(const struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info kxcjk1013_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE,
> kxcjk1013_get_mount_matrix),
> +	{ }
> +};
> +
>  #define KXCJK1013_CHANNEL(_axis) {					
> \
>  	.type = IIO_ACCEL,						
> \
>  	.modified = 1,							
> \
> @@ -999,6 +1014,7 @@ static const struct iio_event_spec
> kxcjk1013_event = {
>  		.endianness = IIO_LE,					
> \
>  	},								
> \
>  	.event_spec = &kxcjk1013_event,				\
> +	.ext_info = kxcjk1013_ext_info,					
> \
>  	.num_event_specs = 1						
> \
>  }
>  
> @@ -1267,11 +1283,18 @@ static int kxcjk1013_probe(struct i2c_client
> *client,
>  	data->client = client;
>  
>  	pdata = dev_get_platdata(&client->dev);
> -	if (pdata)
> +	if (pdata) {
>  		data->active_high_intr = pdata->active_high_intr;
> -	else
> +		data->orientation = pdata->orientation;
> +	} else {
>  		data->active_high_intr = true; /* default polarity */
>  
> +		ret = iio_read_mount_matrix(&client->dev, "mount-
> matrix",
> +					    &data->orientation);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (id) {
>  		data->chipset = (enum kx_chipset)(id->driver_data);
>  		name = id->name;
> diff --git a/include/linux/iio/accel/kxcjk_1013.h
> b/include/linux/iio/accel/kxcjk_1013.h
> index 8c3c78bc9f91..ea0ecb774371 100644
> --- a/include/linux/iio/accel/kxcjk_1013.h
> +++ b/include/linux/iio/accel/kxcjk_1013.h
> @@ -7,8 +7,11 @@
>  #ifndef __IIO_KXCJK_1013_H__
>  #define __IIO_KXCJK_1013_H__
>  
> +#include <linux/iio/iio.h>
> +
>  struct kxcjk_1013_platform_data {
>  	bool active_high_intr;
> +	struct iio_mount_matrix orientation;
>  };
>  
>  #endif

