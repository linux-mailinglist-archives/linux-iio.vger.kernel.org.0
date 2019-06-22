Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238114F543
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFVKdF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKdF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:33:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6930E2075E;
        Sat, 22 Jun 2019 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561199585;
        bh=40GYrpL9jToZjUrodxDIUvIONMWEPllVKM/HDee0PQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e20ERHBcGsZWvmpjJQ+WWq1HW5y9yEcV+GfEq+TBTg5inrI9VYqG091QxkfTOvLhh
         nICStk3huTlaeic70dBJ0QVUT6DTqWPr92Hz6lQRDK1w6K0Fp4DH/G50dbf9/ZBbIb
         rHLTjjEjfzIVoRVwio9z8GGvM32YiMsdzWs0JT8M=
Date:   Sat, 22 Jun 2019 11:33:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <lorenzo@kernel.org>
Subject: Re: [PATCH 2/7] iio:accel: introduce st_accel_multiread_bit()
 function
Message-ID: <20190622113301.1fcec2d7@archlinux>
In-Reply-To: <20190617234943.10669-3-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
        <20190617234943.10669-3-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:49:38 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This function is introduced as a preparation for regmap usage.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
This is fine, just a quick query from me inline to ensure I'm
understanding things correctly!

Jonathan

> ---
>  drivers/iio/accel/st_accel.h      |  1 +
>  drivers/iio/accel/st_accel_core.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 979ab9679b99..0f0e5e8c8661 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -68,6 +68,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> +bool st_accel_multiread_bit(const char *name);
>  int st_accel_common_probe(struct iio_dev *indio_dev);
>  void st_accel_common_remove(struct iio_dev *indio_dev);
>  
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index e02b79931979..5029b399efa8 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1147,6 +1147,22 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  #endif
>  }
>  
> +/*
> + * st_accel_multiread_bit() - check if device requires multi-read bit.
> + * @name: device name buffer reference.
> + */
> +bool st_accel_multiread_bit(const char *name)
> +{
> +	int index = st_sensors_get_settings_index(name,
> +					st_accel_sensors_settings,
> +					ARRAY_SIZE(st_accel_sensors_settings));
> +	if (index < 0)
> +		return false;

Slightly odd path given we effectively don't know.  This only works
I guess because we will error out elsewhere if the above can fail?

> +
> +	return st_accel_sensors_settings[index].multi_read_bit;
> +}
> +EXPORT_SYMBOL(st_accel_multiread_bit);
> +
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);

