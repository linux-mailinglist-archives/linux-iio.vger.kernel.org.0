Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498153430ED
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 06:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCUFIH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 01:08:07 -0400
Received: from www381.your-server.de ([78.46.137.84]:44210 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCUFHh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Mar 2021 01:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Jks5ta4y+3q9mJRz/Bx4bb41R4Rxu6P7ARvWnNtXXOY=; b=KRerUw58hGPjrNoXFte5PE2KH5
        7OO5dSmXsWfIIoH7yqUoElXXipTDNz57ByqVDEJKlQGPxHdkrkQ87VJAH3yGWMp3R+8NY3UXCNnOq
        nc2w2CRJuMOAcJ23Q8WoOixr+tLUGnCIhhdcelI0wNDWRI/BoUnq/+UQJOJDs2PXY8rP8obbwOzaN
        68nxmY+XT1g2TfaSB1Nnfwdv1Y4PTLMpPwFEFAxAc0BpuhzOBT8HqBjIeJhdXNlEYAMFME4ItuII6
        h0yvgV+k5Q+RaivgYRySs/or9vQ6cj7EWXyjl11EyL7lhU3qLRztPzIujUS5D00CmfqYxcnv+kJWF
        jog854vg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNqJI-00098Y-Dh; Sun, 21 Mar 2021 06:07:32 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNqJI-000XTx-8T; Sun, 21 Mar 2021 06:07:32 +0100
Subject: Re: [PATCH v1 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210320064509.119878-1-puranjay12@gmail.com>
 <20210320064509.119878-3-puranjay12@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <760dccc2-b098-71ce-037b-b667dbc05f57@metafoo.de>
Date:   Sun, 21 Mar 2021 06:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210320064509.119878-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26115/Sat Mar 20 12:03:55 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/20/21 7:45 AM, Puranjay Mohan wrote:
> TMP117 is a Digital temperature sensor with integrated NV memory.
>
> Add support for tmp117 driver in iio subsystem.
>
> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

This looks good to me. Just two small bits I overlooked during the first 
review, sorry for that.

> +};
> +
> [...]
> +static int tmp117_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int *val,
> +		int *val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	u16 tmp, off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
> +		*val = tmp;
No need for tmp here. Just directly assign to val.
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
> +		*val = ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 10000000;
> +		*val2 = ((int16_t)off * (int32_t)TMP117_RESOLUTION) % 10000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = TMP117_SCALE;
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tmp117_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	u16 off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = ((val * 10000000) + (val2 * 10))
> +						/ (int32_t)TMP117_RESOLUTION;

This needs some input validation. Writing a too large or too small value 
will cause an overflow/underflow and a bogus value will be written to 
the register.

You can either reject invalid values by returning -EINVAL or clamp them 
into the right range. Up to you how you want to handle this.

> +		return tmp117_write_reg(data, TMP117_REG_TEMP_OFFSET, off);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

