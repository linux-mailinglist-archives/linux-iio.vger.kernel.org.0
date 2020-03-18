Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2B18A18A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 18:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRRah (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 13:30:37 -0400
Received: from www381.your-server.de ([78.46.137.84]:37426 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCRRah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 13:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8jXKOPcxkZWvkP619eIGDOeVHZThU9Ay4Wk8qdDv3GE=; b=h9wETDcSthKR491wqOMm3gB4uS
        QoAUqbBXc1eFodJ5UfZwryUF3sGMkN1mNN73RDUNjeQksi/g/SFuyW7j87HfUkAxBXESLlSBBYP3s
        aoqGUuueCEcIHyXdf18cdVGzbKsgoVRoOwgesyu9AjAgXStvpuf+FboHqdl+5ZZflvi0/n97xKeYb
        2yKlvcV3zPMdCKSnJkatQDCM8iznQq9IaXjoIWcaHiHKJ5FU+8O8HlES+Lb3PKSBGmZNv7OsB3/J6
        xfM4qa1oESEw8UvZa8aqzyO6c8o+FN8t6oI7HQFWAckEkq40ieQJJYvoLbc4+KyDwy3Gf72WbavXJ
        dctoPVeg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEcWU-0004OJ-HI; Wed, 18 Mar 2020 18:30:30 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEcWU-0003Wr-6y; Wed, 18 Mar 2020 18:30:30 +0100
Subject: Re: [PATCH 1/3] iio: dac: ad5686: add support for AD5338R
To:     Michael Auchter <michael.auchter@ni.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200318153434.62833-1-michael.auchter@ni.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <461dc314-87b9-fa40-e407-4bff9a95205b@metafoo.de>
Date:   Wed, 18 Mar 2020 18:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318153434.62833-1-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 4:34 PM, Michael Auchter wrote:
> The AD5338R is a 10-bit DAC with 2 outputs and an internal 2.5V
> reference (enabled by default). The register configuration is nearly
> identical to the AD5696R DAC that's already supported by this driver,
> with the channel selection bits being the only thing different.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>

Patch looks good, thanks. I just have one wish, which is to keep 
everything sorted by device ID. This will improve the longterm 
maintainability of the driver. AD5338R should be after AD5311R.

Also consider updating the Kconfig entry.

> ---
>   drivers/iio/dac/ad5686.c     | 13 +++++++++++++
>   drivers/iio/dac/ad5686.h     |  1 +
>   drivers/iio/dac/ad5696-i2c.c |  1 +
>   3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e06b29c565b9..bbcac0e44837 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -210,6 +210,12 @@ static struct iio_chan_spec name[] = {				\
>   		AD5868_CHANNEL(0, 0, bits, _shift),		\
>   }
>   
> +#define DECLARE_AD5338R_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 1, bits, _shift),		\
> +		AD5868_CHANNEL(1, 8, bits, _shift),		\
> +}
> +
>   #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
>   static struct iio_chan_spec name[] = {				\
>   		AD5868_CHANNEL(0, 1, bits, _shift),		\
> @@ -262,6 +268,7 @@ DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
>   DECLARE_AD5693_CHANNELS(ad5693_channels, 16, 0);
>   DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
>   DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
> +DECLARE_AD5338R_CHANNELS(ad5338r_channels, 10, 6); >
>   static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>   	[ID_AD5310R] = {
> @@ -413,6 +420,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>   		.num_channels = 4,
>   		.regmap_type = AD5686_REGMAP,
>   	},
> +	[ID_AD5338R] = {
> +		.channels = ad5338r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 2,
> +		.regmap_type = AD5686_REGMAP,
> +	}, >   };
>   
>   int ad5686_probe(struct device *dev,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 70a779939ddb..02eb196fcf0f 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -77,6 +77,7 @@ enum ad5686_supported_device_ids {
>   	ID_AD5695R,
>   	ID_AD5696,
>   	ID_AD5696R,
> +	ID_AD5338R,
>   };
>   
>   enum ad5686_regmap_type {
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index ccf794caef43..f100a5fe4219 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -83,6 +83,7 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
>   	{"ad5695r", ID_AD5695R},
>   	{"ad5696", ID_AD5696},
>   	{"ad5696r", ID_AD5696R},
> +	{"ad5338r", ID_AD5338R},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
> 

