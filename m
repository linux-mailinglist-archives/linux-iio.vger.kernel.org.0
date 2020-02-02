Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDF14FC95
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgBBKY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 05:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBBKY1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 05:24:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F1920679;
        Sun,  2 Feb 2020 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580639066;
        bh=yXimWEEizT/Z9z5o6OXIdlNZvMX9GLHJjq4vpo6ES0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V02sxsl3G1YQwEGbgaEHifaCdY1UZKXPFpjsz8UMhL3HrzLf4ZrMP6IxZv+1XMcdv
         tuaKuP9D/p4GNKTKzXHcW+hTR3jTsUZhRtKK+ZyYSg4I8Getlaty6sDExQGvIFK2xK
         sLWh6i6dvDTsOnFkrPrWeOOClbikFU+rHK5EBPHs=
Date:   Sun, 2 Feb 2020 10:24:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 6/7] iio: light: al3320a implement suspend support
Message-ID: <20200202102422.1369536d@archlinux>
In-Reply-To: <20200201180024.328700-7-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
        <20200201180024.328700-7-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Feb 2020 19:00:23 +0100
David Heidelberg <david@ixit.cz> wrote:

> AL3320a is fairly simple chip, so for suspend is enough to disable and
> later enable it again.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3320a.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 613830b7df6e..d99f9d139b5f 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -7,6 +7,9 @@
>   * IIO driver for AL3320A (7-bit I2C slave address 0x1C).
>   *
>   * TODO: interrupt support, thresholds
> + * When the driver will get support for interrupt handling, then interrupt
> + * will need to be disabled before turning sensor OFF in order to avoid
> + * potential races with the interrupt handling.
>   */
>  
>  #include <linux/module.h>
> @@ -84,13 +87,19 @@ static const struct attribute_group al3320a_attribute_group = {
>  	.attrs = al3320a_attributes,
>  };
>  
> +static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
> +{
> +	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
> +	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
> +}
> +

One blank line is almost always enough.

> +
>  static int al3320a_init(struct al3320a_data *data)
>  {
>  	int ret;
>  
> -	/* power on */
> -	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG,
> -					AL3320A_CONFIG_ENABLE);
> +	ret = al3320a_set_pwr(data->client, true);
> +
>  	if (ret < 0)
>  		return ret;
>  
> @@ -208,10 +217,21 @@ static int al3320a_probe(struct i2c_client *client,
>  
>  static int al3320a_remove(struct i2c_client *client)
>  {
> -	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG,
> -					 AL3320A_CONFIG_DISABLE);
> +	return al3320a_set_pwr(client, false);
> +}
> +
> +static int __maybe_unused al3320a_suspend(struct device *dev)
> +{
> +	return al3320a_set_pwr(to_i2c_client(dev), false);
> +}
> +
> +static int __maybe_unused al3320a_resume(struct device *dev)
> +{
> +	return al3320a_set_pwr(to_i2c_client(dev), true);
>  }
>  
> +SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, al3320a_resume);
> +
>  static const struct i2c_device_id al3320a_id[] = {
>  	{"al3320a", 0},
>  	{}
> @@ -221,6 +241,7 @@ MODULE_DEVICE_TABLE(i2c, al3320a_id);
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
> +		.pm = &al3320a_pm_ops,
>  	},
>  	.probe		= al3320a_probe,
>  	.remove		= al3320a_remove,

