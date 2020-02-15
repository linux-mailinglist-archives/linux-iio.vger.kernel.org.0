Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57315FF7C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgBORU1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgBORU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:20:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0102082F;
        Sat, 15 Feb 2020 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581787226;
        bh=Z+XmmfwTfKE1+XwjmhS6yEAMBpXsWGEfVEm0MS0B1+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w4/vpu68Y2NkYmJeVhtpqzZYE72JehEJXeJ1m6t6vPt8XE73afULUDF4oGkNg8gRo
         Gh/TgInpSq6J68GJk0mC0grA6jgFlhbjVeI2fmTllTM7kaXParoxUiCh8j+EZVzOAq
         BF7G5r4f2j4VFnGXEoXAVI5Qv6+Eu+h97ennCO5w=
Date:   Sat, 15 Feb 2020 17:20:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: light: al3320a implement suspend support
Message-ID: <20200215172021.5a26d5ec@archlinux>
In-Reply-To: <20200211191201.1049902-6-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-6-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:59 +0100
David Heidelberg <david@ixit.cz> wrote:

> AL3320a is fairly simple chip, so for suspend is enough to disable and
> later enable it again.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3320a.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 89b935b4fe9e..affa4c6c199a 100644
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
>  #include <linux/bitfield.h>
> @@ -78,13 +81,18 @@ static const struct attribute_group al3320a_attribute_group = {
>  	.attrs = al3320a_attributes,
>  };
>  
> +static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
> +{
> +	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
> +	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
> +}
> +
>  static int al3320a_init(struct al3320a_data *data)
>  {
>  	int ret;
>  
> -	/* power on */
> -	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG,
> -					AL3320A_CONFIG_ENABLE);
> +	ret = al3320a_set_pwr(data->client, true);

data doesn't exist.  I've fixed up this as well, but please take a quick
look.

> +
>  	if (ret < 0)
>  		return ret;
>  
> @@ -203,10 +211,21 @@ static int al3320a_probe(struct i2c_client *client,
>  
>  static int al3320a_remove(struct i2c_client *client)
>  {
> -	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG,
> -					 AL3320A_CONFIG_DISABLE);
> +	return al3320a_set_pwr(client, false);
>  }
>  
> +static int __maybe_unused al3320a_suspend(struct device *dev)
> +{
> +	return al3320a_set_pwr(to_i2c_client(dev), false);
> +}
> +
> +static int __maybe_unused al3320a_resume(struct device *dev)
> +{
> +	return al3320a_set_pwr(to_i2c_client(dev), true);
> +}
> +
> +SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, al3320a_resume);
> +
>  static const struct i2c_device_id al3320a_id[] = {
>  	{"al3320a", 0},
>  	{}
> @@ -216,6 +235,7 @@ MODULE_DEVICE_TABLE(i2c, al3320a_id);
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
> +		.pm = &al3320a_pm_ops,
>  	},
>  	.probe		= al3320a_probe,
>  	.remove		= al3320a_remove,

