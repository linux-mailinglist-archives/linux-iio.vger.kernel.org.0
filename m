Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44F35464C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhDERxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 13:53:08 -0400
Received: from www381.your-server.de ([78.46.137.84]:32814 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDERxH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 13:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fdHVnmQZyYYbH9keyfBLgauaQbtyLfDW5S6y8rlvimU=; b=jl9ZjHEF2R1ekLsuoGs5gYqEIN
        0fR1guRgNVxwrWTZ524AcGXgaqYhKBM2rZDo8vHIIwuFvxZuJ/ZZdWGtel5Zm8GKm10+KXCwZUQBc
        pH4YH/wWuNhcKCJregkMmHRoWhTca54ocgdPvXfGUm8Gk10EEASxt5tPAjgvE/5aPerzTbkEPdDEI
        8Bxc1UV23og/vsofbb+xJU6ptfhc5kEx5WnWBQkyfBXUnwMdkbtWrNy/X3ly2hEQ5hNYFtdQFiDwL
        u9YpTR4t9PLkotOBq/1RrAdMTvg9I/MMm7CJAbPeCydIpkyxIAxdn5Ks2GIFPF7a1KoXprgle53Pe
        +aEo8UZg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lTTPG-000EWz-HT; Mon, 05 Apr 2021 19:52:58 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lTTPG-0002I0-C2; Mon, 05 Apr 2021 19:52:58 +0200
Subject: Re: [PATCH v2 1/2] iio:adc:ad7476: Handle the different regulators
 used by various parts.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
References: <20210405162325.627977-1-jic23@kernel.org>
 <20210405162325.627977-2-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d64902a6-51a8-746f-2e9f-163cd9960c40@metafoo.de>
Date:   Mon, 5 Apr 2021 19:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405162325.627977-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26131/Mon Apr  5 13:15:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/5/21 6:23 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Not all of the parts supported by this driver use single supply.
> Hence we add chip_info fields to say what additional supplies exist
> and in the case of vref, ensure that is used for the reference voltage
> rather than vcc.
>
> One corner case is the ad7091r which has an internal reference that
> can be over-driven by an external reference connected on the vref pin.
> To handle that force_ext_vref is introduced and set if an optional
> vref regulator is present.
>
> Tested using really simple QEMU model and some fixed regulators.
>
> The devm_add_action_or_reset() callback is changed to take the
> regulator as it's parameter so we can use one callback for all the
> different regulators without having to store pointers to them in
> the iio_priv() structure.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>   drivers/iio/adc/ad7476.c | 108 +++++++++++++++++++++++++++++++++------
>   1 file changed, 93 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 9e9ff07cf972..6867e96e3eda 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -32,12 +32,15 @@ struct ad7476_chip_info {
>   	/* channels used when convst gpio is defined */
>   	struct iio_chan_spec		convst_channel[2];
>   	void (*reset)(struct ad7476_state *);
> +	bool				has_vref;
> +	bool				has_vdrive;
>   };
>   
>   struct ad7476_state {
>   	struct spi_device		*spi;
>   	const struct ad7476_chip_info	*chip_info;
> -	struct regulator		*reg;
> +	struct regulator		*ref_reg;
> +	bool				force_ext_vref;
>   	struct gpio_desc		*convst_gpio;
>   	struct spi_transfer		xfer;
>   	struct spi_message		msg;
> @@ -52,13 +55,17 @@ struct ad7476_state {
>   };
>   
>   enum ad7476_supported_device_ids {
> +	ID_AD7091,
>   	ID_AD7091R,
> +	ID_AD7273,
> +	ID_AD7274,
>   	ID_AD7276,
>   	ID_AD7277,
>   	ID_AD7278,
>   	ID_AD7466,
>   	ID_AD7467,
>   	ID_AD7468,
> +	ID_AD7475,
>   	ID_AD7495,
>   	ID_AD7940,
>   	ID_ADC081S,
> @@ -145,8 +152,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>   			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_SCALE:
> -		if (!st->chip_info->int_vref_uv) {
> -			scale_uv = regulator_get_voltage(st->reg);
> +		if (!st->chip_info->int_vref_uv || st->force_ext_vref) {
Set set->reg_reg to NULL when not present and check for that instead of 
adding force_ext_vref?
> +			scale_uv = regulator_get_voltage(st->ref_reg);
>   			if (scale_uv < 0)
>   				return scale_uv;
>   		} else {
> @@ -187,13 +194,32 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>   		BIT(IIO_CHAN_INFO_RAW))
>   
>
>   static int ad7476_probe(struct spi_device *spi)
>   {
> [...]
> +	/* Either vcc or vref (below) as appropriate */
> +	st->ref_reg = reg;
> +
> +	if (st->chip_info->has_vref) {
> +
> +		/* If a device has an internal reference vref is optional */
> +		if (st->chip_info->int_vref_uv) {
> +			reg = devm_regulator_get_optional(&spi->dev, "vref");

I think we need to distinguish between -ENODEV and other errors, if not 
only to handle EPROBE_DEFER.

[...]
