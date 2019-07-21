Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019B76F47E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGUSBi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33A7208E4;
        Sun, 21 Jul 2019 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732098;
        bh=jITOuOAQnzPkR77Dksu3tMsVKIDs/YLV+2LW/cbk+L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XpXYeimZ+dWj8zBz6msXqlimV94CgBKxaXxBhT/rQZ2t/v7iJ1rYfYn557969MTw5
         oVde2KY4MADp35AfkuIaXF6XNVxyxW5c2jH/1sGHE0teRh8QNPD+Lzk+z695rxsRAo
         nhu/AwecZwwPpe41UU7mZ7YuqNcpSMt4BFlZdZ5w=
Date:   Sun, 21 Jul 2019 18:52:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iio:pressure: introduce
 st_press_get_settings() function
Message-ID: <20190721185241.082a9a83@archlinux>
In-Reply-To: <20190718225353.2078-6-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-6-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:47 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> The function is introduced to retrieve press device settings. It will be
> used by probe in order to configure regmap.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied,

Thanks,

Jonathan
> ---
> Changes in v2:
>  not there in v1. This meant to replace "iio:pressure:introduce st_press_multiread_bit() function"
> 
>  drivers/iio/pressure/st_pressure.h      |  1 +
>  drivers/iio/pressure/st_pressure_core.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index 6a720cfb5686..c2e47a6c3118 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -41,6 +41,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> +const struct st_sensor_settings *st_press_get_settings(const char *name);
>  int st_press_common_probe(struct iio_dev *indio_dev);
>  void st_press_common_remove(struct iio_dev *indio_dev);
>  
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index b960e76f7dfd..35d80ff27464 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -664,6 +664,24 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>  #define ST_PRESS_TRIGGER_OPS NULL
>  #endif
>  
> +/*
> + * st_press_get_settings() - get sensor settings from device name
> + * @name: device name buffer reference.
> + *
> + * Return: valid reference on success, NULL otherwise.
> + */
> +const struct st_sensor_settings *st_press_get_settings(const char *name)
> +{
> +	int index = st_sensors_get_settings_index(name,
> +					st_press_sensors_settings,
> +					ARRAY_SIZE(st_press_sensors_settings));
> +	if (index < 0)
> +		return NULL;
> +
> +	return &st_press_sensors_settings[index];
> +}
> +EXPORT_SYMBOL(st_press_get_settings);
> +
>  int st_press_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);

