Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A023FD59
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHIIeS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 04:34:18 -0400
Received: from first.geanix.com ([116.203.34.67]:56104 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHIIeS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 04:34:18 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id CCCCDEE7961;
        Sun,  9 Aug 2020 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1596962056; bh=LP3lM5QUSkZ1oiMVObirrCTZoz8mT5VmmerO8Y88QPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XA/yLBOzrGQoAt4BpDGSIt2h4YPqHlZ5PwnQWwKB5nIrki57v7XRnVIWkZkOnnRqm
         Ki+3VlYhXLOSoeHZbyWoA1ZVdGPG+OY5sfLHyp6pf5n7vy6zY+T7j61KEa5l3FwjjA
         2z2nTw5e9yTd7xAUPj80esFP9kclYNqxfaO6F+Mhke/nZtz/IlVVd47L6GjBCUl7FA
         oVPs7hRUOsmXbQHGbxtmFKX7oJFPufKL5b682K4ia9a0TnYVuCzNiEGxynGgCGX0CQ
         KOraix64HcUanESaljI4vtMgNq1n1pvSipsakwrXo+aA189VFBcoiYoAf8NSnh9cJF
         xT87pMMBqxSjA==
Subject: Re: [PATCH] iio: dac: dac5571: Support powerdown for multi-channel
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org
References: <20200804093138.2114-1-vincent.whitchurch@axis.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9648e22b-6f46-1a61-9928-965a8d047827@geanix.com>
Date:   Sun, 9 Aug 2020 10:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804093138.2114-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 04/08/2020 11.31, Vincent Whitchurch wrote:
> The driver currently only allows channel 0 to be powered down but the
> multi-channel variants of the hardware allow each channel to be powered
> down separately and with separate power down modes.  Add support for
> this.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/dac/ti-dac5571.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 3a2bb0efe50d..ce8c3d646fb1 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -47,8 +47,8 @@ struct dac5571_data {
>   	struct mutex lock;
>   	struct regulator *vref;
>   	u16 val[4];
> -	bool powerdown;
> -	u8 powerdown_mode;
> +	bool powerdown[4];
> +	u8 powerdown_mode[4];
>   	struct dac5571_spec const *spec;
>   	int (*dac5571_cmd)(struct dac5571_data *data, int channel, u16 val);
>   	int (*dac5571_pwrdwn)(struct dac5571_data *data, int channel, u8 pwrdwn);
> @@ -125,7 +125,7 @@ static int dac5571_get_powerdown_mode(struct iio_dev *indio_dev,
>   {
>   	struct dac5571_data *data = iio_priv(indio_dev);
>   
> -	return data->powerdown_mode;
> +	return data->powerdown_mode[chan->channel];
>   }
>   
>   static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
> @@ -135,17 +135,17 @@ static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
>   	struct dac5571_data *data = iio_priv(indio_dev);
>   	int ret = 0;
>   
> -	if (data->powerdown_mode == mode)
> +	if (data->powerdown_mode[chan->channel] == mode)
>   		return 0;
>   
>   	mutex_lock(&data->lock);
> -	if (data->powerdown) {
> +	if (data->powerdown[chan->channel]) {
>   		ret = data->dac5571_pwrdwn(data, chan->channel,
>   					   DAC5571_POWERDOWN(mode));
>   		if (ret)
>   			goto out;
>   	}
> -	data->powerdown_mode = mode;
> +	data->powerdown_mode[chan->channel] = mode;
>   
>    out:
>   	mutex_unlock(&data->lock);
> @@ -167,7 +167,7 @@ static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
>   {
>   	struct dac5571_data *data = iio_priv(indio_dev);
>   
> -	return sprintf(buf, "%d\n", data->powerdown);
> +	return sprintf(buf, "%d\n", data->powerdown[chan->channel]);
>   }
>   
>   static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
> @@ -183,19 +183,20 @@ static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
>   	if (ret)
>   		return ret;
>   
> -	if (data->powerdown == powerdown)
> +	if (data->powerdown[chan->channel] == powerdown)
>   		return len;
>   
>   	mutex_lock(&data->lock);
>   	if (powerdown)
>   		ret = data->dac5571_pwrdwn(data, chan->channel,
> -			    DAC5571_POWERDOWN(data->powerdown_mode));
> +			    DAC5571_POWERDOWN(data->powerdown_mode[chan->channel]));
>   	else
> -		ret = data->dac5571_cmd(data, chan->channel, data->val[0]);
> +		ret = data->dac5571_cmd(data, chan->channel,
> +				data->val[chan->channel]);
>   	if (ret)
>   		goto out;
>   
> -	data->powerdown = powerdown;
> +	data->powerdown[chan->channel] = powerdown;
>   
>    out:
>   	mutex_unlock(&data->lock);
> @@ -209,9 +210,9 @@ static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
>   		.name	   = "powerdown",
>   		.read	   = dac5571_read_powerdown,
>   		.write	   = dac5571_write_powerdown,
> -		.shared	   = IIO_SHARED_BY_TYPE,
> +		.shared	   = IIO_SEPARATE,
>   	},
> -	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &dac5571_powerdown_mode),
>   	IIO_ENUM_AVAILABLE("powerdown_mode", &dac5571_powerdown_mode),
>   	{},
>   };
> @@ -276,7 +277,7 @@ static int dac5571_write_raw(struct iio_dev *indio_dev,
>   		if (val >= (1 << data->spec->resolution) || val < 0)
>   			return -EINVAL;
>   
> -		if (data->powerdown)
> +		if (data->powerdown[chan->channel])
>   			return -EBUSY;
>   
>   		mutex_lock(&data->lock);

