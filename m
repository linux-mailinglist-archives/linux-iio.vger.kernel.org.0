Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5226C3562C6
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 06:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhDGE44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 00:56:56 -0400
Received: from www381.your-server.de ([78.46.137.84]:52080 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhDGE44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 00:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=RZpzEYNWECUZqfBw+gAEQrRFLyNX8MYV6WVB9KFUMAM=; b=ljurMm0bLm2UA+fsWpfK8+lYzs
        hXyFghRNLDUguBDrBG5KNUud4/JtgAcxuwrsS0HeWnjbQO4NVG1XzWI4JonNg3KGbsmZi/M0jfKdA
        RMRV+Bok4xYBCrt+5GXfmEjXW2NyjpLwK9ip4N53zUzra13rHNb2IxxCy+pwmLg8lscJixdBd45bo
        c2Fxt/3HdIvBeceExVRriEZ+SeP7VdV13nUrOzzpL2saXmh4S/hyPSPMEkisH/24udUMuzI7xBStF
        K5akFnS54y+N3W+2EwIEdaClHZbNuUkB3Dn3jSG+UUi+iHy+Z+Od7LmN6fu1jKfc0zy9FFLdoqQMa
        xFn5ZS/g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lU0F9-0008Mx-SU; Wed, 07 Apr 2021 06:56:43 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lU0F9-0004Ey-MJ; Wed, 07 Apr 2021 06:56:43 +0200
Subject: Re: [PATCH v3 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
References: <20210406182852.263605-1-puranjay12@gmail.com>
 <20210406182852.263605-3-puranjay12@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3d840334-2c26-5748-8370-54cef6262e02@metafoo.de>
Date:   Wed, 7 Apr 2021 06:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406182852.263605-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26132/Tue Apr  6 13:06:05 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/6/21 8:28 PM, Puranjay Mohan wrote:
> +
> +static int tmp117_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	s16 off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = clamp(val, -32768, 32767);
> +		if (off == data->calibbias)

data->calibbias is only set in probe() and always 0. I'm not sure we 
need to cache the value. Reading it back from the device seems fine.

> +			return 0;
> +		return i2c_smbus_write_word_swapped(data->client,
> +						TMP117_REG_TEMP_OFFSET, off);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

