Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED5139B55
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMVXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:23:31 -0500
Received: from www381.your-server.de ([78.46.137.84]:38710 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMVXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 16:23:31 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1ir6mD-0002hu-Mv; Mon, 13 Jan 2020 21:57:33 +0100
Received: from [93.104.104.184] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ir6mD-000VBg-Bg; Mon, 13 Jan 2020 21:57:33 +0100
Subject: Re: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A
 step attenuator with gpio interface
To:     Beniamin Bia <beniamin.bia@analog.com>, jic23@kernel.org
Cc:     Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        biabeniamin@outlook.com, knaack.h@gmx.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5ae63616-5749-da51-b0b2-85cdcaa948f3@metafoo.de>
Date:   Mon, 13 Jan 2020 21:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200113141555.16117-1-beniamin.bia@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25694/Mon Jan 13 14:35:35 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/13/20 3:15 PM, Beniamin Bia wrote:
[...]
> +static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +	int i, *values;
> +
> +	values = kmalloc_array(st->chip_info->num_gpios, sizeof(int),
> +			       GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->chip_info->num_gpios; i++)
> +		values[i] = (value >> i) & 1;
> +
> +	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
> +				       values);

This API got changed a while ago in upstream, see
https://github.com/analogdevicesinc/linux/commit/b9762bebc6332b40c33e03dea03e30fa12d9e3ed

> +	kfree(values);
> +	return 0;
> +}
[...]
> +static int hmc425a_probe(struct platform_device *pdev)
> +{
[...]
> +
> +	platform_set_drvdata(pdev, indio_dev);

drvdata is never accessed, no need to set it.

> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = np->name;

I know ADI likes to do this in its non upstream drivers, but the above
is not IIO ABI compliant. The name is supposed to identify the type of
the device, which means for this driver should be static "hmc425a".
Maybe consider adding a field to the hmc425a_chip_info for this.

> +	indio_dev->info = &hmc425a_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}

