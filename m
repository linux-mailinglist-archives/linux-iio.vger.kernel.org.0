Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9734F529
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVKSd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfFVKSd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:18:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAACE20665;
        Sat, 22 Jun 2019 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561198712;
        bh=X8hyEcMmcXqPuo+a/NbwR1P2ZlES7nFnwsZGCafU0jU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ei/trMngktPgLnGPEyEvSJ9jeDMankudhU6zw2ZKrmfDLilhfRMmpfcA8xNXyyVaK
         ehC0wODbTNnit4Buu1rT9X4799Ys0HnMTuQs5dpHTOcn4taW6KZmwxeuAicYxysayQ
         tlsa3tcDsGEhdsHbZ1hnNPWsoui2ApKD/nBfmB5w=
Date:   Sat, 22 Jun 2019 11:18:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: common: cros_ec_sensors: add sysfs
 attribute for frequencies
Message-ID: <20190622111827.54ebe9a9@archlinux>
In-Reply-To: <ee20a9b8d1700a3987570d2edd28fe9ac9e73123.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
        <ee20a9b8d1700a3987570d2edd28fe9ac9e73123.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 11:06:38 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> Embedded controller return minimum and maximum frequencies, unfortunately
> we have no way to know the step for all available frequencies.
> Even if not complete, we can return a list of known values using the
> standard read_avail callback (IIO_CHAN_INFO_SAMP_FREQ) to provide them to
> userland.
> 
> Now cros_ec_* sensors provides frequencies values in sysfs like this:
> "0 min max".
> 
> 0 is always true to disable the sensor.

Hmm. 0 frequency feels like a kind of non standard use of the ABI.
I suppose it's fairly logical and it does no harm if userspace never uses
it so I guess we can let this use in without updating the docs.

I'd like some feedback from the chromeos side on whether this is a sensible
way of representing things?  Note that generic userspace will only pick
one of those values, it won't magically decide to go for somewhere inbetween.

Jonathan

> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 22 +++++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 2ce077b576a4..8df82b675752 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -86,6 +87,26 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  
> +static int cros_ec_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals,
> +			      int *type,
> +			      int *length,
> +			      long mask)
> +{
> +	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*length = 3;
> +		*vals = (const int *)&state->frequency_range;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      int num_channels,
>  			      bool physical_device)
> @@ -161,6 +182,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  	}
>  
> +	state->info.read_avail = cros_ec_read_avail;
>  	indio_dev->info = &state->info;
>  
>  	/* Timestamp channel */
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 89937ad242ef..5fa9ba5332e0 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -140,7 +140,9 @@ int cros_ec_sensors_core_register(struct platform_device *pdev,
>  	channel[idx].scan_type.shift = 0;\
>  	channel[idx].scan_index = idx;\
>  	channel[idx].ext_info = cros_ec_sensors_ext_info;\
> -	channel[idx].scan_type.sign = 'u';
> +	channel[idx].scan_type.sign = 'u';\
> +	channel[idx].info_mask_shared_by_all_available = \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  
>  /**
>   * cros_ec_motion_send_host_cmd() - send motion sense host command

