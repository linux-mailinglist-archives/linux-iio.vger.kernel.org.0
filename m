Return-Path: <linux-iio+bounces-21933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC691B10528
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E793BEE22
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263C2750E2;
	Thu, 24 Jul 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kau44+7l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EAD2FB;
	Thu, 24 Jul 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347486; cv=none; b=TIn5udf6aS744cTHvmb+6uwvDSVc0wIyZ3KS5IOTVZynqfeP6LqQZReZAn6ohaCh3EiyDJd1YlZGZYwhnGtS4nIyNZbQKeOZ8lCgPxARd6rYcXdBejDDatqkoclaTQIoj5h0AeCbeB/9qY3jx8a53vNBt5TY5Z7HtdqrDP/SB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347486; c=relaxed/simple;
	bh=GuZPM20+5KNyABcyXSsAV2hVlyTNXPHB+gGjfUh/g9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzozTqJIjWs+qkJjyS8JCBZDAlbvTp/UG03+U1s/6Vsu5SI3wK5OFgvpGEN6oknXmW0LWV4iheT2u9f92jwRDOjXUAlzkfjb3ZY5ixCtszG7HLAjxN35JVfjXm+c63DNdshvDdLBs+vuog9SwXzhGEyhYLBdNzBIreGxc01ftrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kau44+7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD855C4CEED;
	Thu, 24 Jul 2025 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753347485;
	bh=GuZPM20+5KNyABcyXSsAV2hVlyTNXPHB+gGjfUh/g9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kau44+7laZSUwDctOmhk2uk5IS70MS4G8D9YzNuxq4XXoToKr5/pJuBxHCtxR4ohL
	 Xs1zl2+mKJQhpZCfVSNRvsnFiyjrBwqNEaBvTxn+U2OtTMf3RO6x7wXJ6yD3HYl7wp
	 R15X95pmBHOp5E1PAYxqi72BdBd2c0WqywQYzmIO/6mTZQeGWR91XUke7x4OgMTbnz
	 lH1HqNCEIMknPCh7BftDLNRF0TilEsFlBRtUwAxj2nODbVQV/PS3/CHxcz2DrfTlxz
	 p9U05DfFxVxUIP5SAa11caM12wFgNMTjRMU7ORxaLkAyV6JAm4mqIwHqz1PQ0Si9Y+
	 B/WCvpGjO21rA==
Message-ID: <e8b6a6bf-fe4a-4ff3-addf-142212368903@kernel.org>
Date: Thu, 24 Jul 2025 10:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor.
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, peterz@infradead.org,
 jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com, carlos.song@nxp.com,
 xiaoning.wang@nxp.com, haibo.chen@nxp.com
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
 <20250724083951.2273717-2-lakshay.piplani@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250724083951.2273717-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 10:39, Lakshay Piplani wrote:
> +
> +static void p3t1755_ibi_handler(struct i3c_device *dev,
> +				const struct i3c_ibi_payload *payload)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&dev->dev);
> +
> +	dev_dbg(&dev->dev, "IBI received, handling threshold event\n");

Drop

> +
> +	// Handle threshold event via helper
> +	p3t1755_push_thresh_event(indio_dev);
> +}
> +
> +/*
> + * Both P3T1755 and P3T1750 share the same I3C
> + * PID (0x011B:0x152A), making runtime differentiation
> + * impossible, so a common "p3t175x" name in sysfs
> + * and IIO for I3C based instances.
> + */
> +static const struct i3c_device_id p3t1755_i3c_ids[] = {
> +	I3C_DEVICE(0x011B, 0x152A, (void *)&p3t175x_channels_info),
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);
> +
> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct regmap_config p3t1755_i3c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	};
> +
> +	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, p3t1755_i3c_ids);
> +	const struct p3t17xx_info *chip = &p3t175x_channels_info;
> +	struct device_node *np = i3cdev->dev.of_node;
> +	bool alert_active_high = false;
> +	struct i3c_ibi_setup ibi_setup;
> +	struct regmap *regmap;
> +	bool tm_mode = false;
> +	int fq_bits = -1;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +			      "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);

Syntax is return dev_err_probe

> +	}
> +
> +	/* Parse optional device tree property for alert polarity */
> +	alert_active_high = of_property_read_bool(np, "nxp,alert-active-high");
> +
> +	/* Parse optional device tree property for thermostat mode */
> +	tm_mode = of_property_read_bool(np, "nxp,interrupt-mode");
> +
> +	/* Optional fault queue length */
> +	if (np) {
> +		u32 fq;
> +
> +		if (!of_property_read_u32(np, "nxp,fault-queue", &fq)) {
> +			fq_bits = p3t1755_fault_queue_to_bits(fq);
> +			if (fq_bits < 0) {
> +				dev_err_probe(&i3cdev->dev, fq_bits,
> +					      "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);

Syntax is return dev_err_probe

> +				return fq_bits;
> +			}
> +		}
> +	}
> +
> +	dev_info(&i3cdev->dev, "Using TM mode: %s\n", tm_mode ? "Interrupt" : "Comparator");
> +	dev_info(&i3cdev->dev, "Alert polarity: %s\n",
> +		 alert_active_high ? "Active-High" : "Active-Low");

Drivers should be silent on success. See coding style as well.

> +
> +	if (id && id->data)
> +		chip = (const struct p3t17xx_info *)id->data;
> +
> +	ret = p3t1755_probe(&i3cdev->dev, chip, regmap, tm_mode, alert_active_high, fq_bits);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!tm_mode) {
> +		dev_warn(&i3cdev->dev, "IBI not supported in comparator mode, skipping IBI registration\n");
> +		return 0;
> +	}
> +
> +	ibi_setup.handler = p3t1755_ibi_handler;
> +	ibi_setup.num_slots = 4;
> +	ibi_setup.max_payload_len = 0;
> +
> +	ret = i3c_device_request_ibi(i3cdev, &ibi_setup);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to request IBI: %d\n", ret);

Syntax is return dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = i3c_device_enable_ibi(i3cdev);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to enable IBI: %d\n", ret);

Syntax is return dev_err_probe

> +		i3c_device_free_ibi(i3cdev);
> +		return ret;
> +	}
> +
> +	dev_info(&i3cdev->dev, "IBI successfully registered\n");

Drivers should be silent on success. See coding style as well.

Same comments for all your other drivers here.


Best regards,
Krzysztof

