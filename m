Return-Path: <linux-iio+bounces-1206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57F81BD9B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED1B1F25AE6
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22299634E6;
	Thu, 21 Dec 2023 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNYLadlx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D9BA2F;
	Thu, 21 Dec 2023 17:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A227FC433C8;
	Thu, 21 Dec 2023 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703181146;
	bh=lyzByyIGtJtbvQNXSj6a4JRBMqzOy5OV7zShwLWFESA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PNYLadlx3HDnL6+8gp9DHHqBZbtRXTVtlvGpzBic8ktqW5eRZowkQnD9eOvRot157
	 9b3h3pRmzx156HM1tEYsjIRKa6ERu1Z3mxijp8sT9N4CTxaSZdzwkjJe2F7B06agR2
	 GGmqmnI8EcL0a8uzpcG2MEqxuBz2axr2fjWFMzYL+RCeYgTjt6bL2t9WWseQAlbMj9
	 jQ7LywkTSOulEeIcPPw5c0KfH8/BwtqPC6UlOsmtKaib4FJOfFt3S2V9b38Iuh5i3I
	 F4TVMKlfJgFON55737HPEF7xaFzFiUGn64B+ldkZeo5Jghe33Mt8w0J4CQkaEFe1RQ
	 Eq24f93LV7/Kw==
Date: Thu, 21 Dec 2023 17:52:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 7/8] iio: adc: ad9467: convert to backend framework
Message-ID: <20231221175209.457664b5@jic23-huawei>
In-Reply-To: <20231220-iio-backend-v4-7-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-7-998e9148b692@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:34:10 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).
> 
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

A few minor comments. Looks good to me.

Jonathan

> +static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad9467_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +
> +	for (c = 0; c < st->info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

>  static int ad9467_reset(struct device *dev)
> @@ -443,25 +475,63 @@ static int ad9467_reset(struct device *dev)
>  	return 0;
>  }
>  
> +static int ad9467_iio_backend_get(struct ad9467_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct device_node *__back;
> +
> +	st->back = devm_iio_backend_get_optional(&st->spi->dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);

As per the comment on previous patch I'd just get it using the normal
function and handle PTR_ERR(-ENOENT) here as meaning we need to
try the old way.

> +	if (st->back)
> +		return 0;
> +	/*
> +	 * if we don't get the backend using the normal API's, use the legacy
> +	 * 'adi,adc-dev' property. So we get all nodes with that property, and
> +	 * look for the one pointing at us. Then we directly lookup that fwnode
> +	 * on the backend list of registered devices. This is done so we don't
> +	 * make io-backends mandatory which would break DT ABI.
> +	 */
> +	for_each_node_with_property(__back, "adi,adc-dev") {
> +		struct device_node *__me;
> +
> +		__me = of_parse_phandle(__back, "adi,adc-dev", 0);
> +		if (!__me)
> +			continue;
> +
> +		if (!device_match_of_node(dev, __me)) {
> +			of_node_put(__me);
> +			continue;
> +		}
> +
> +		of_node_put(__me);
> +		st->back = devm_iio_backend_get_from_fwnode_lookup(dev,
> +								   of_fwnode_handle(__back));
> +		of_node_put(__back);

If it lands first the patch
RFC PATCH 1/4] of: Add cleanup.h based autorelease via __free(device_node) markings.
will get rid of this manual handling for you for both the continue and return.
This will make a very nice example for that :)

> +		return PTR_ERR_OR_ZERO(st->back);
> +	}
> +
> +	return -ENODEV;
> +}


