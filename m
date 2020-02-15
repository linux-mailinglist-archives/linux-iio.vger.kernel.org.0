Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D1115FFB6
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgBOSia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOSia (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:38:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C4B2072D;
        Sat, 15 Feb 2020 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581791909;
        bh=Vn6EMKEHrAlFXsbzoMOmCsGT35CduBMj1nJoHPtQDLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nhfqwatlu7MaA89FPxhKcJPFm3Xah+2BhcRwXk4FD3Y8+BYuaDyZPKqENELBy0gTS
         SzQlh+/7imAY751HgVjpadK0Gmv+oaQ/57CDJuB8wV7z601rAfNHcJFdsCKullXTv0
         njA7LBUIq/auwg/XwlQz9g5AH4OrSFuwaPewnCBw=
Date:   Sat, 15 Feb 2020 18:38:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: light: al3320a implement
 devm_add_action_or_reset
Message-ID: <20200215183825.77bda8a8@archlinux>
In-Reply-To: <20200211191201.1049902-7-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-7-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:12:00 +0100
David Heidelberg <david@ixit.cz> wrote:

> Use devm_add_action_or_reset to automatically disable the device
> and allow you to get rid of the remove function entirely.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

This doesn't build as is.  I've fixed up but please take a close
look at the result.

> ---
>  drivers/iio/light/al3320a.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index affa4c6c199a..49e73e24fff6 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -87,6 +87,13 @@ static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
>  	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
>  }
>  
> +static void al3320a_set_pwr_off(void *_data)
> +{
> +	struct al3320a_data *data = _data;
> +
> +	al3320a_set_pwr(data->client, false);
> +}
> +
>  static int al3320a_init(struct al3320a_data *data)
>  {
>  	int ret;
> @@ -206,12 +213,14 @@ static int al3320a_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "al3320a chip init failed\n");
>  		return ret;
>  	}
> -	return devm_iio_device_register(&client->dev, indio_dev);
> -}
>  
> -static int al3320a_remove(struct i2c_client *client)
> -{
> -	return al3320a_set_pwr(client, false);
> +	ret = devm_add_action_or_reset(&client->dev,
> +					al3320a_set_pwr_off,
> +					data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static int __maybe_unused al3320a_suspend(struct device *dev)
> @@ -238,7 +247,6 @@ static struct i2c_driver al3320a_driver = {
>  		.pm = &al3320a_pm_ops,
>  	},
>  	.probe		= al3320a_probe,
> -	.remove		= al3320a_remove,
>  	.id_table	= al3320a_id,
>  };
>  

