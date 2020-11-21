Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF42BC02D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgKUPOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgKUPOD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:14:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF22D22226;
        Sat, 21 Nov 2020 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605971643;
        bh=rIFonc7S/eB3grYG9+/4RIEm0y1bcFaPNuAZyBZJ7GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qlqut1x0GTnsaybAftICR2r9eMj3ABlcjY6Vz+Hox6fHOlHsRUEf9oG6csOM+3h4x
         +e70Q7woymIuL5TgsAPlc+aub20PGDA3j4wRcko432J9+O9LKZexlfuNeGUvjWPotR
         rLX4iboy2RI0DbBckieothF57cQ6iBrtUWXME9Us=
Date:   Sat, 21 Nov 2020 15:13:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     lars@metafoo.de, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] HID: mcp2221: add ADC support
Message-ID: <20201121151358.5b82798a@archlinux>
In-Reply-To: <20201121072833.40326-1-matt.ranostay@konsulko.com>
References: <20201121072833.40326-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Nov 2020 09:28:33 +0200
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for the three 10-bit ADC channels registered via
> the IIO subsystem.
> 
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> CC: Rishi Gupta <gupt21@gmail.com>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

If we do decide to go this way, I'd rather see this done via a separate
.c file and appropriate ifdefs all confined to a header.

You'll need to stub out a few more things, but will probably end up
with a cleaner architecture as a result.

I'm still unconvinced this shouldn't be an MFD...
+CC Lee for his view on that option.

Jonathan

> ---
> 
> Changes from v1:
> 
> * Removed 'select IIO' from Kconfig
> * Removed useless iio/sysfs.h include
> * Add IS_REACHABLE checks for IIO subsystem 
> 
>  drivers/hid/hid-mcp2221.c | 89 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index 0d27ccb55dd9..36fa9336c4c5 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -16,6 +16,7 @@
>  #include <linux/hidraw.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/iio/iio.h>
>  #include "hid-ids.h"
>  
>  /* Commands codes in a raw output report */
> @@ -56,6 +57,7 @@ enum {
>   */
>  struct mcp2221 {
>  	struct hid_device *hdev;
> +	struct iio_dev *indio_dev;
>  	struct i2c_adapter adapter;
>  	struct mutex lock;
>  	struct completion wait_in_report;
> @@ -67,6 +69,11 @@ struct mcp2221 {
>  	struct gpio_chip *gc;
>  	u8 gp_idx;
>  	u8 gpio_dir;
> +	u16 adc_values[3];
> +};
> +
> +struct mcp2221_iio {
> +	struct mcp2221 *mcp;
>  };
>  
>  /*
> @@ -712,6 +719,7 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  				break;
>  			}
>  			mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
> +			memcpy(&mcp->adc_values, &data[50], 6);
>  			break;
>  		default:
>  			mcp->status = -EIO;
> @@ -791,6 +799,79 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	return 1;
>  }
>  
> +#if IS_REACHABLE(CONFIG_IIO)
> +
> +static int mcp2221_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +
> +	struct mcp2221_iio *priv = iio_priv(indio_dev);
> +	struct mcp2221 *mcp = priv->mcp;
> +	int ret;
> +
> +	mutex_lock(&mcp->lock);
> +
> +	/* Read ADC values */
> +	ret = mcp_chk_last_cmd_status(mcp);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = le16_to_cpu(mcp->adc_values[channel->channel]);
> +
> +	mutex_unlock(&mcp->lock);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info mcp2221_info = {
> +	.read_raw = &mcp2221_read_raw,
> +};
> +
> +#define MCP2221_ADC_CHANNEL(idx) \
> +	{ \
> +		.type = IIO_VOLTAGE, \
> +		.indexed = 1, \
> +		.channel = idx, \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +		.scan_index = -1, \
> +	}
> +
> +static const struct iio_chan_spec mcp2221_channels[] = {
> +	MCP2221_ADC_CHANNEL(0),
> +	MCP2221_ADC_CHANNEL(1),
> +	MCP2221_ADC_CHANNEL(2),
> +};
> +
> +static int mcp2221_register_adcs(struct device *dev, struct mcp2221 *mcp)
> +{
> +	struct mcp2221_iio *iio;
> +
> +	mcp->indio_dev = devm_iio_device_alloc(dev, sizeof(*iio));
> +	if (!mcp->indio_dev)
> +		return -ENOMEM;
> +
> +	iio = iio_priv(mcp->indio_dev);
> +	iio->mcp = mcp;
> +
> +	mcp->indio_dev->name = "mcp2221_adc";
> +	mcp->indio_dev->modes = INDIO_DIRECT_MODE;
> +	mcp->indio_dev->info = &mcp2221_info;
> +	mcp->indio_dev->channels = mcp2221_channels;
> +	mcp->indio_dev->num_channels = ARRAY_SIZE(mcp2221_channels);
> +
> +	return iio_device_register(mcp->indio_dev);
> +}
> +
> +#else
> +
> +static int mcp2221_register_adcs(struct device *dev, struct mcp2221 *mcp)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  static int mcp2221_probe(struct hid_device *hdev,
>  					const struct hid_device_id *id)
>  {
> @@ -869,6 +950,10 @@ static int mcp2221_probe(struct hid_device *hdev,
>  	if (ret)
>  		goto err_gc;
>  
> +	ret = mcp2221_register_adcs(&hdev->dev, mcp);
> +	if (ret)
> +		goto err_gc;
> +
>  	return 0;
>  
>  err_gc:
> @@ -884,6 +969,10 @@ static void mcp2221_remove(struct hid_device *hdev)
>  {
>  	struct mcp2221 *mcp = hid_get_drvdata(hdev);
>  
> +#if IS_REACHABLE(CONFIG_IIO)
> +	iio_device_unregister(mcp->indio_dev);
> +#endif
> +
>  	i2c_del_adapter(&mcp->adapter);
>  	hid_hw_close(mcp->hdev);
>  	hid_hw_stop(mcp->hdev);

