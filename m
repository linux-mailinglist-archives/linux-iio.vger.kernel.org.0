Return-Path: <linux-iio+bounces-10185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFE99189F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704A41C212DB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B358288B1;
	Sat,  5 Oct 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqesga/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCC13C8F6;
	Sat,  5 Oct 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147597; cv=none; b=h5vXccFwn5UkwcjzbptTePtbn5f9CLjmIM9/1HnUqrHKU2A7+b2xta62/WIzMo8Mdzi+q560JjRod8ZDUaA3s9Hh5CBP2zxY2UgnWncYzu8FSgcAA9DKL/SB74F+hUoO9thH96gp2RlE18Rqvxz2uoRO0V3o82ZPg3gUse03/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147597; c=relaxed/simple;
	bh=isTFNFa31awuyRVaSq2pjIs0n78CXI1IdCLC6lSYdFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHkSlSKjXT1k6Mya7/9ORC0METx3IUEzS6hKOil4/ExPX8tf/29tyw6cNIzhhlYeBBb981Tmwq4ZcarvQVR47xn/ZCXhY8l5jwDr5Z0WJ3YQUg+ZA/AEzslxRSJDi0Y68LpH2iA5dtd6IihoCl6z2F0jp/6wgHfoLsM70+jI2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqesga/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935DCC4CEC2;
	Sat,  5 Oct 2024 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728147596;
	bh=isTFNFa31awuyRVaSq2pjIs0n78CXI1IdCLC6lSYdFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqesga/NdUB/olZ8qmjdMRmIdV2EHkhj9v0APGVvUpsuffF/mjQ9t3mgqn2TLXC17
	 F/4gOcGqvCGnRL7S52YccR2tk+DikFno3JJxmya6X88K+fn9jG4rnqnHxm9k/RkY7b
	 0k2EhEN/sNXP6v0hY6cn1CM+QzrzhcOYYxba7GgXNlZsiIJX1v0m19AhnGXDYVCA0Z
	 BNUK0aFEQbxSrUL1YH1fUBuOcfFYKFsuZZfxtk5KwmL0ZPFJOzdf3JyGkZ/LJTXUf8
	 ED/32ohu7zrTMd30iF51b19Rew6TiA/XB1n+SGdxUbE+jXi0hlO8o5DLp+Tvu1RuEg
	 ySLSiGe+rEGxg==
Date: Sat, 5 Oct 2024 17:59:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: vl6180: Add support for Continuous Mode
Message-ID: <20241005175932.00438b0f@jic23-huawei>
In-Reply-To: <20241004150148.14033-4-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-4-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 20:31:48 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support for getting continuous readings from vl6180 using
> triggered buffer approach. The continuous mode can be enabled by
> enabling the buffer.
If you want multiple paragraphs, I'd use a blank line between them.
If not, then tighter wrapping makes sense.
> Also added a trigger and appropriate checks to see that it is used
> with this device.
Normally aim for 75 char wrap point for commit descriptions.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

Some comments below.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vl6180.c | 138 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 134 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 4c2b486e2..e724e752e 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -25,6 +25,10 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define VL6180_DRV_NAME "vl6180"
>  
> @@ -91,10 +95,16 @@ struct vl6180_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct completion completion;
> +	struct iio_trigger *trig;
>  	unsigned int als_gain_milli;
>  	unsigned int als_it_ms;
>  	unsigned int als_meas_rate;
>  	unsigned int range_meas_rate;
> +
> +	struct {
> +		u16 chan;
> +		aligned_u64 timestamp;

aligned_s64 as timestamps are (oddly) always signed.


> +	} scan;
>  };


> +
> +static irqreturn_t vl6180_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl6180_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	for (int i = 0; i < indio_dev->masklength; i++) {
> +		if (test_bit(i, indio_dev->active_scan_mask)) {
> +

Indent broken.  + see below for iio_for_each_active_channel()
which is how you should do this.

> +		ret = vl6180_chan_regs_table[i].word ?
		if (vl6180_chan_regs_table[i].word)
			ret = vl6180...
		else
			ret = v...

Preferred. The ternary is hard to read with such long legs.

> +			vl6180_read_word(data->client, vl6180_chan_regs_table[i].value_reg) :
> +			vl6180_read_byte(data->client, vl6180_chan_regs_table[i].value_reg);
> +		if (ret < 0)
> +			dev_err(&data->client->dev, "failed to read from value regs: %d\n", ret);
> +
> +		data->scan.chan = ret;

Only one bit set?  otherwise this overwrites the same channel each time.

> +		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +						iio_get_time_ns(indio_dev));

This is response to a trigger interrupt - so I'd guess the reading was earlier?
Better to grab a copy of current time nearer that point.

> +		}
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	/* Clear the interrupt flag after data read */
> +	ret = vl6180_write_byte(data->client, VL6180_INTR_CLEAR,
> +		VL6180_CLEAR_ERROR | VL6180_CLEAR_ALS | VL6180_CLEAR_RANGE);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "failed to clear irq: %d\n", ret);
> +
>  	return IRQ_HANDLED;
>  }
>  
> +static int vl6180_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
> +{
> +	struct vl6180_data *data = iio_priv(indio_dev);
> +
> +	return data->trig == trig ? 0 : -EINVAL;
> +}
> +
>  static const struct iio_info vl6180_info = {
>  	.read_raw = vl6180_read_raw,
>  	.write_raw = vl6180_write_raw,
>  	.attrs = &vl6180_attribute_group,
> +	.validate_trigger = vl6180_validate_trigger,

There is a helper for common case of the trigger parent is same as device
(very similar to the one you use below).  That should be enough here
as no other trigger will have that device as parent.

>  };
>  
> -static int vl6180_init(struct vl6180_data *data)
> +static int vl6180_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vl6180_data *data = iio_priv(indio_dev);
> +
iio_for_each_active_channel()

Note that if you build this on current tree it will give a
compiler error as we enforce not directly accessing the mask_length
field.


> +	for (int i = 0; i < indio_dev->masklength; i++) {
> +		if (test_bit(i, indio_dev->active_scan_mask))
> +			return vl6180_write_byte(data->client,
> +				vl6180_chan_regs_table[i].start_reg,
> +				VL6180_MODE_CONT | VL6180_STARTSTOP);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vl6180_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vl6180_data *data = iio_priv(indio_dev);
> +
> +	for (int i = 0; i < indio_dev->masklength; i++) {
iio_for_each_active_channel()
> +		if (test_bit(i, indio_dev->active_scan_mask))
> +			return vl6180_write_byte(data->client,
> +				vl6180_chan_regs_table[i].start_reg,
> +				VL6180_STARTSTOP);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> +	.postenable = &vl6180_buffer_postenable,
> +	.postdisable = &vl6180_buffer_postdisable,
> +};
> +
> +static const struct iio_trigger_ops vl6180_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int vl6180_init(struct vl6180_data *data, struct iio_dev *indio_dev)
>  {
>  	struct i2c_client *client = data->client;
>  	int ret;
> @@ -547,6 +658,12 @@ static int vl6180_init(struct vl6180_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +						&vl6180_trigger_handler,
> +						&iio_triggered_buffer_setup_ops);

Spacing looks wrong.  Align these last two lines with the & in the first one.

> +	if (ret)
> +		return ret;


