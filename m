Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9623E0EE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHFSjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgHFS34 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D58423110;
        Thu,  6 Aug 2020 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738559;
        bh=4Gk7D0MO/sNh3nZnLY13LdzWLPNi69k9gLeAgtM/VQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f3OdALKW3CQXK9/2MfkNE1i+JDefpBiKHak75OTvoddwQOFByg+S9NxHQ+yGkHNJp
         zjhmkHvol1lk86n8MFOmPJT4PqceteXsA9ZXCS0EFmNBAk88Qm55vNcoNhC89hSLjk
         W2CXV1wvhZwIM3OdDpW8rNKWEb2GtfMdmaZdQpLE=
Date:   Thu, 6 Aug 2020 19:29:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 05/15] iio: sx9310: Change from .probe to .probe_new
Message-ID: <20200806192914.71bfec22@archlinux>
In-Reply-To: <20200803175559.v5.5.Ieb5fdf7381764835dad0b3099c7b19ba754e4c47@changeid>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.5.Ieb5fdf7381764835dad0b3099c7b19ba754e4c47@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 17:58:05 -0600
Daniel Campello <campello@chromium.org> wrote:

> Uses .probe_new in place of .probe. Also uses device_get_match_data()
> for whoami matching.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Applied,

Thanks,

Jonathan

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>  - Added '\n' to dev_err()
> 
>  drivers/iio/proximity/sx9310.c | 39 ++++++++++++----------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 9daf2b8591a0a0..66ecdd309e0ddc 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -139,7 +139,7 @@ struct sx9310_data {
>  	struct completion completion;
>  	unsigned int chan_read, chan_event;
>  	int channel_users[SX9310_NUM_CHANNELS];
> -	int whoami;
> +	unsigned int whoami;
>  };
>  
>  static const struct iio_event_spec sx9310_events[] = {
> @@ -858,24 +858,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>  
>  static int sx9310_set_indio_dev_name(struct device *dev,
>  				     struct iio_dev *indio_dev,
> -				     const struct i2c_device_id *id, int whoami)
> +				     unsigned int whoami)
>  {
> -	const struct acpi_device_id *acpi_id;
> -
> -	/* id will be NULL when enumerated via ACPI */
> -	if (id) {
> -		if (id->driver_data != whoami)
> -			dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
> -				id->name);
> -	} else if (ACPI_HANDLE(dev)) {
> -		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -		if (!acpi_id)
> -			return -ENODEV;
> -		if (acpi_id->driver_data != whoami)
> -			dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
> -				acpi_id->id);
> -	} else
> +	unsigned int long ddata;
> +
> +	ddata = (uintptr_t)device_get_match_data(dev);
> +	if (ddata != whoami) {
> +		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
>  		return -ENODEV;
> +	}
>  
>  	switch (whoami) {
>  	case SX9310_WHOAMI_VALUE:
> @@ -885,15 +876,14 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>  		indio_dev->name = "sx9311";
>  		break;
>  	default:
> -		dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> +		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
>  		return -ENODEV;
>  	}
>  
>  	return 0;
>  }
>  
> -static int sx9310_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int sx9310_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -919,8 +909,7 @@ static int sx9310_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
> -					data->whoami);
> +	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1033,8 +1022,8 @@ static const struct acpi_device_id sx9310_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
>  
>  static const struct of_device_id sx9310_of_match[] = {
> -	{ .compatible = "semtech,sx9310" },
> -	{ .compatible = "semtech,sx9311" },
> +	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
> +	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
> @@ -1053,7 +1042,7 @@ static struct i2c_driver sx9310_driver = {
>  		.of_match_table = sx9310_of_match,
>  		.pm = &sx9310_pm_ops,
>  	},
> -	.probe		= sx9310_probe,
> +	.probe_new	= sx9310_probe,
>  	.id_table	= sx9310_id,
>  };
>  module_i2c_driver(sx9310_driver);

