Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC35F17CEFA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgCGPSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGPSI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:18:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F423E20674;
        Sat,  7 Mar 2020 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583594287;
        bh=AG2CUxbPh2NsM7GsY89dYs51ewd+GY5/lY5Euy3akzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xnr4P8ip6BEhNUZKECPwBgUi66nIxv6w7r1ppHU9C6v3kBX5kJPmh0AEeGi2YGPnX
         GeoFHROBuW8Oclt7dIynH8w3iih4NNJQX+TzBw+eCl/9aGOkerWJM7beEH9P2nrjIq
         ilA+rVBJ2MLGiShAlk9X4SMy8Zx7MVjAc5eLb+Y0=
Date:   Sat, 7 Mar 2020 15:18:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Goeppner <mikegoeppner@spotify.com>
Cc:     linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
        manivannanece23@gmail.com
Subject: Re: [PATCH 1/1] iio: light: vl6180: Add support for range ignore
Message-ID: <20200307151804.6ddb397e@archlinux>
In-Reply-To: <20200305141615.110423-2-mikegoeppner@spotify.com>
References: <20200305141615.110423-1-mikegoeppner@spotify.com>
        <20200305141615.110423-2-mikegoeppner@spotify.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Mar 2020 15:16:15 +0100
Mike Goeppner <mikegoeppner@spotify.com> wrote:

> This now makes it possible to configure and use the range ignore setting
> on the vl6180 sensor via sysfs. In order to do this, three new device files
> have been added, range_ignore_enable, range_ignore_threshold, and
> range_ignore_valid_height.
> 
> range_ignore_threshold and range_ignore_valid_height write to the
> corresponding registers on the sensor. range_ignore_enable sets the
> sysrange__range_ignore_enable bit in the SYSRANGE__RANGE_CHECK_ENABLES
> register.
> 
> Signed-off-by: Mike Goeppner <mikegoeppner@spotify.com>

The best way to consider new ABI is not really the code, but rather
the ABI documentation.  Add some docs to 
Documentation/ABI/testing/sysfs-bus-iio-light-vl6180

Having taken a quick look at the docs, this seems to be a feature
intended to avoid giving a reading from covering glass.
If that's so, why do we want to change it at runtime?
Seems like something that ought to be coming from device firmware
and always be applied.  (so put the controls in dt)

A few things inline, but I suspect we'll move this to dt and the
code will look rather different so feel free to not read them.

thanks,

Jonathan

> ---
>  drivers/iio/light/vl6180.c | 180 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 177 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 192c77ef3608..4cc308de97f2 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -41,10 +41,18 @@
>  #define VL6180_OUT_OF_RESET 0x016
>  #define VL6180_HOLD 0x017
>  #define VL6180_RANGE_START 0x018
> +#define VL6180_RANGE_CHECK_ENABLES 0x02d
> +#define VL6180_RANGE_IGNORE_VALID_HEIGHT 0x025
> +#define VL6180_RANGE_IGNORE_THRESHOLD 0x026
>  #define VL6180_ALS_START 0x038
>  #define VL6180_ALS_GAIN 0x03f
>  #define VL6180_ALS_IT 0x040
>  
> +/* Range check enable configuration */
> +#define VL6180_ALS_EARLY_CONVERGENCE_ENABLE (1 << 0)
> +#define VL6180_RANGE_IGNORE_ENABLE (1 << 1)
> +#define VL6180_SIGNAL_TO_NOISE_ENABLE (1 << 4)
> +
>  /* Status registers */
>  #define VL6180_RANGE_STATUS 0x04d
>  #define VL6180_ALS_STATUS 0x04e
> @@ -128,7 +136,7 @@ static const struct vl6180_chan_regs vl6180_chan_regs_table[] = {
>  };
>  
>  static int vl6180_read(struct i2c_client *client, u16 cmd, void *databuf,
> -		       u8 len)
> +			   u8 len)
>  {
>  	__be16 cmdbuf = cpu_to_be16(cmd);
>  	struct i2c_msg msgs[2] = {
> @@ -207,6 +215,76 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
>  	return 0;
>  }
>  
> +static ssize_t vl6180_show_register_byte(struct device *dev, u16 cmd,
> +		char *buff)
> +{
> +	int ret;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = vl6180_read_byte(client, cmd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buff, "%d\n", ret);
> +}
> +
> +static ssize_t vl6180_store_register_byte(struct device *dev, u16 cmd,
> +		const char *buff, size_t len)
> +{
> +	int ret;
> +	u8 val;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = kstrtou8(buff, 0, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = vl6180_write_byte(client, cmd, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t vl6180_show_register_word(struct device *dev, u16 cmd,
> +		char *buff)
> +{
> +	int ret;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = vl6180_read_word(client, cmd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buff, "%d\n", ret);
> +}
> +
> +static ssize_t vl6180_store_register_word(struct device *dev, u16 cmd,
> +		const char *buff, size_t len)
> +{
> +	int ret;
> +	u16 val;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = kstrtou16(buff, 0, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = vl6180_write_word(client, cmd, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
>  static int vl6180_measure(struct vl6180_data *data, int addr)
>  {
>  	struct i2c_client *client = data->client;
> @@ -343,8 +421,104 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
>  
>  static IIO_CONST_ATTR(als_gain_available, "1 1.25 1.67 2.5 5 10 20 40");
>  
> +static ssize_t vl6180_show_range_ignore_threshold(struct device *dev,
> +		struct device_attribute *attr, char *buff)
> +{
> +	return vl6180_show_register_word(dev, VL6180_RANGE_IGNORE_THRESHOLD,
> +			buff);
> +}
> +
> +static ssize_t vl6180_store_range_ignore_threshold(struct device *dev,
> +		struct device_attribute *attr, const char *buff, size_t len)
> +{
> +	return vl6180_store_register_word(dev, VL6180_RANGE_IGNORE_THRESHOLD,
> +			buff, len);
> +}
> +
> +static IIO_DEVICE_ATTR(range_ignore_threshold,
> +		0644,
> +		vl6180_show_range_ignore_threshold,
> +		vl6180_store_range_ignore_threshold,
> +		0);
> +
> +static ssize_t vl6180_show_range_ignore_valid_height(struct device *dev,
> +		struct device_attribute *attr, char *buff)
> +{
> +	return vl6180_show_register_byte(dev, VL6180_RANGE_IGNORE_VALID_HEIGHT,
> +			buff);
> +}
> +
> +static ssize_t vl6180_store_range_ignore_valid_height(struct device *dev,
> +		struct device_attribute *attr, const char *buff, size_t len)
> +{
> +	return vl6180_store_register_byte(dev, VL6180_RANGE_IGNORE_VALID_HEIGHT,
> +			buff, len);
> +}
> +
> +static IIO_DEVICE_ATTR(range_ignore_valid_height,
> +		0644,
> +		vl6180_show_range_ignore_valid_height,
> +		vl6180_store_range_ignore_valid_height,
> +		0);
> +
> +static ssize_t vl6180_show_range_ignore_enable(struct device *dev,
> +		struct device_attribute *attr, char *buff)
> +{
> +	int ret;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = vl6180_read_byte(client, VL6180_RANGE_CHECK_ENABLES);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buff, "%d\n", !!(ret & VL6180_RANGE_IGNORE_ENABLE));
> +}
> +
> +static ssize_t vl6180_store_range_ignore_enable(struct device *dev,
> +		struct device_attribute *attr, const char *buff, size_t len)
> +{
> +	int ret;
> +	bool val;
> +
> +	struct vl6180_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct i2c_client *client = data->client;
> +
> +	ret = kstrtobool(buff, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = vl6180_read_byte(client, VL6180_RANGE_CHECK_ENABLES);
> +	if (ret < 0)
> +		return ret;
> +

It's worth checking if you are actually making a change.  Saves
on bus transfers which might be better deployed for something else.

> +	if (val)
> +		ret = vl6180_write_byte(client,
> +				VL6180_RANGE_CHECK_ENABLES,
> +				ret | VL6180_RANGE_IGNORE_ENABLE);
> +	else
> +		ret = vl6180_write_byte(client,
> +				VL6180_RANGE_CHECK_ENABLES,
> +				ret & ~VL6180_RANGE_IGNORE_ENABLE);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(range_ignore_enable,
> +		0644,
> +		vl6180_show_range_ignore_enable,
> +		vl6180_store_range_ignore_enable,
> +		0);
> +
>  static struct attribute *vl6180_attributes[] = {
>  	&iio_const_attr_als_gain_available.dev_attr.attr,
> +	&iio_dev_attr_range_ignore_enable.dev_attr.attr,
> +	&iio_dev_attr_range_ignore_threshold.dev_attr.attr,
> +	&iio_dev_attr_range_ignore_valid_height.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -416,8 +590,8 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  }
>  
>  static int vl6180_write_raw(struct iio_dev *indio_dev,
> -			     struct iio_chan_spec const *chan,
> -			     int val, int val2, long mask)
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
Make sure to clean out any unrelated white space changes before sending a patch
out.  If they make sense and you want to do them then do it in a separate
patch.  In here they are just distracting noise whilst people try
to figure out if there were real changes...

>  {
>  	struct vl6180_data *data = iio_priv(indio_dev);
>  

