Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECD6C03F6
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCSS7u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Mar 2023 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCSS7t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 14:59:49 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C6FBDE9;
        Sun, 19 Mar 2023 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=gm+vwa4niTorHwn4WVT5rk7kngMTXqQx8Wa5rnhBg1U=; b=ibw7QCcHT6x5emBAFL/bCQkmjV
        CZhkM2YYTh7wDcqZRTtEsNtVOjWq8bY7+FFWG1ZbOxcFJwz00nq0ngwbogFaUQZIz2QE1cjXJws3Z
        Zr9ie2plRtro6iOezlzHAOh5Z3DF2mXd2rWqlVYUDgSZ9fYGi7NEU0l2NMIptJthB4fo01YcAhg0k
        kKCN/aa03LgLL+bOdoIeWxD3JcC5OfFCCQCSKUbp1UhDvjyCfYCIB3dPGbmNd97OnVigrclyLPbBT
        WuehhHeC5hFf4NUVmUUZQ5h0rBGB2FX9fHzonjVnC6C4QbSj33w8EXvkay03bpdxY2kRi5hIbP+Ad
        7DO9AuCg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pdyFo-0004yV-Ux; Sun, 19 Mar 2023 19:59:40 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pdyFo-000Sm1-Ih; Sun, 19 Mar 2023 19:59:40 +0100
Message-ID: <89271a29-5b02-34fe-409b-373e3b8044ef@metafoo.de>
Date:   Sun, 19 Mar 2023 11:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] iio: temperature: Add MCP9600 thermocouple EMF
 converter
Content-Language: en-US
To:     Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
 <20230319184728.49232-3-andrew.hepp@ahepp.dev>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230319184728.49232-3-andrew.hepp@ahepp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26848/Sun Mar 19 08:23:18 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This looks really good. I have some small comments, and I apologize for 
only having them so late in the review cycle.

On 3/19/23 11:47, Andrew Hepp wrote:
> Add support for the MCP9600 thermocouple EMF converter.

Would be nice to have a very short description of the capabilities of 
the sensor in the commit message.

>
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> ---
> [...]
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> new file mode 100644
> index 000000000000..b6d8ffb90c36
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0+
> [...]
> +static const struct iio_chan_spec mcp9600_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = MCP9600_HOT_JUNCTION,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.address = MCP9600_COLD_JUNCTION,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
If you do not have supported for buffered capture there is no need to 
include a timestamp in the channel spec. There is no way to read it 
without buffered support.
> +};
> +
> +struct mcp9600_data {
> +	struct i2c_client *client;
> +	struct mutex read_lock; /* lock to prevent concurrent reads */
> +};
> +
> +static int mcp9600_read(struct mcp9600_data *data,
> +			struct iio_chan_spec const *chan, int *val)
> +{
> +	__be16 buf;
buf does not seem to be used.
> +	int ret;
> +
> +	mutex_lock(&data->read_lock);
Do you actually need the custom lock? i2c_smbus_read_word_swapped itself 
should provide locking and there is only a single operation under your 
custom lock, which will already be atomic.
> +	ret = i2c_smbus_read_word_swapped(data->client, chan->address);
> +	mutex_unlock(&data->read_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> [...]
> +static int mcp9600_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mcp9600_data *data;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> +	if (ret < 0)
> +		return ret;

Might as well throw an error message in here for better diagnostics.

     return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");


