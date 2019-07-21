Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252496F478
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfGUSB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSB3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816D6208E4;
        Sun, 21 Jul 2019 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732088;
        bh=m2JZ0r33wXaomla1Em3MukPM/L891BZ50Z1x1E2eLuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x8mQhMEDtb1ZBFQQQQ5vD4EgRmnYoEBXnFg1c4hun+r3u8zcadgUQpsrBogxCAKXr
         f+2zP+GWakVGeZblUhQu/bjdHGRLuMHcfBD/Ud5YxjDydLzjtRtXhbOHpzBvi/POqi
         rHdRtru7/dqo5dfUQWEfFxtNbVy/dJ0sSS7rvCCo=
Date:   Sun, 21 Jul 2019 18:48:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] iio:accel: introduce st_accel_get_settings()
 function
Message-ID: <20190721184846.5f8c1b2e@archlinux>
In-Reply-To: <20190718225353.2078-3-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-3-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:44 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> The function is introduced to retrieve accel device settings. It will be
> used by probe in order to configure regmap.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied, thanks,

Jonathan

> ---
> Changes in v2:
>  not there in v1. This meant to replace "iio:accel:introduce st_accel_multiread_bit() function"
> 
>  drivers/iio/accel/st_accel.h      |  1 +
>  drivers/iio/accel/st_accel_core.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 979ab9679b99..af09943f38c9 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -68,6 +68,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> +const struct st_sensor_settings *st_accel_get_settings(const char *name);
>  int st_accel_common_probe(struct iio_dev *indio_dev);
>  void st_accel_common_remove(struct iio_dev *indio_dev);
>  
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index e02b79931979..6fc490ffef7e 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1147,6 +1147,24 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  #endif
>  }
>  
> +/*
> + * st_accel_get_settings() - get sensor settings from device name
> + * @name: device name buffer reference.
> + *
> + * Return: valid reference on success, NULL otherwise.
> + */
> +const struct st_sensor_settings *st_accel_get_settings(const char *name)
> +{
> +	int index = st_sensors_get_settings_index(name,
> +					st_accel_sensors_settings,
> +					ARRAY_SIZE(st_accel_sensors_settings));
> +	if (index < 0)
> +		return NULL;
> +
> +	return &st_accel_sensors_settings[index];
> +}
> +EXPORT_SYMBOL(st_accel_get_settings);
> +
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);

