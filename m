Return-Path: <linux-iio+bounces-10233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A84991E5E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11D11F21BB6
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10120176ABB;
	Sun,  6 Oct 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0uu4XCo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD413C908;
	Sun,  6 Oct 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219936; cv=none; b=MjJGA1JjrPMTehQNMq02s4zq305wXeyvA8AZ+DKK91pTmCNiXuxpRUDSwVjvNihlnvO84ZLdinlenuiM1elL6qslR0GUye9Co8pbFyycXx9cDYdy3ARUH3iPz+bECj80Iuw0/Jsq2+Q0IzYhW7xr98/UzzhVYkAUI+UqKAPHt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219936; c=relaxed/simple;
	bh=snuEqpkwiIlr2gA5eRHM9nmVH5FfF38QLtajK7OLh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3Vs2r5GU078FZfoCvOps7WejKGckm+XuPCaHehB7pSCMxJ78oiHxm9f1P3LFAyLUB8cgx/Ou0SrC5J3wINJpxg+feIncJ0NnA026m7WbGhoZEgnUVfmdWhmChBW7p846PTqAw4L6SRGsB6LwDZIlS49jC42o5742sAEcfJhStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0uu4XCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D04AC4CEC5;
	Sun,  6 Oct 2024 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728219935;
	bh=snuEqpkwiIlr2gA5eRHM9nmVH5FfF38QLtajK7OLh8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V0uu4XCo7+eZGIWwPBey0epupClafF6GrZs33XB7xJ5X+9N+g0V9wzEd15qGRGoPb
	 KUquAVVo7ZiGNRC4g7of8z/ZU79DIXrLL7/7GWSMN+bA3YHlEIFNGI2CMc01giqBv1
	 SFUBfYmu4GABQ7bHY5PAyKwFds6N5iQUZtJEE67CVKfZdrupeTsDYiqDtqPbYyQpPH
	 UPYUJQVdd6QoK7N88uZH0uBuJor1lLW+CStg1nz1/f8AtPfwUXWj+kzFv+xtB+Q4Ib
	 hwSh0tJlkXnjSutfG7f+9hyDuIKrz1q2JWFrqsipMsYIsAxcsu3yx4HvOclaGZTCND
	 LoWraX42i4Knw==
Date: Sun, 6 Oct 2024 14:05:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/4] iio: adc: Add support for the GE HealthCare PMC
 ADC
Message-ID: <20241006140520.5b955b76@jic23-huawei>
In-Reply-To: <cdc27a53-281d-41d7-a9b5-196f2650c468@baylibre.com>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
	<20241003114641.672086-4-herve.codina@bootlin.com>
	<cdc27a53-281d-41d7-a9b5-196f2650c468@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 08:39:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/3/24 6:46 AM, Herve Codina wrote:
> > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> > (voltage and current), 16-Bit ADC with an I2C Interface.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---  
> 
> ...
> 
> 
> > +
> > +static int pmc_adc_probe(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct pmc_adc *pmc_adc;
> > +	struct clk *clk;
> > +	s32 val;
> > +	int ret;
> > +
> > +	ret = devm_regulator_bulk_get_enable(&client->dev, ARRAY_SIZE(pmc_adc_regulator_names),
> > +					     pmc_adc_regulator_names);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
> > +
> > +	clk = devm_clk_get_optional_enabled(&client->dev, "osc");
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(&client->dev, PTR_ERR(clk), "Failed to get osc clock\n");
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*pmc_adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	pmc_adc = iio_priv(indio_dev);
> > +	pmc_adc->client = client;
> > +
> > +	val = i2c_smbus_read_byte_data(pmc_adc->client, PMC_ADC_CMD_REQUEST_PROTOCOL_VERSION);
> > +	if (val < 0)
> > +		return dev_err_probe(&client->dev, val, "Failed to get protocol version\n");
> > +
> > +	if (val != 0x01)
> > +		return dev_err_probe(&client->dev, -EINVAL,
> > +				     "Unsupported protocol version 0x%02x\n", val);
> > +
> > +	indio_dev->name = "pmc_adc";
> > +	indio_dev->info = &pmc_adc_info;
> > +	indio_dev->channels = pmc_adc_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(pmc_adc_channels);  
> 
> I don't think the core code actually checks this, but for
> correctness we should add:
> 
> 	indio_dev->modes = INDIO_DIRECT_MODE;
True.  This is a bit of an oddity of history :(
Maybe at somepoint we'll just drop this but for now it should be there.

Given everything else looks good I've added that whilst
applying the series.  Applied to the togreg branch of iio.git and
pushed out as testing for 0-day to poke at it.

Thanks,

Jonathan


> 
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +  
> 
> With that...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

