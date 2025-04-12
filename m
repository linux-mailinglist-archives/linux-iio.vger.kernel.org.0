Return-Path: <linux-iio+bounces-18005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E7A86CD2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DBC17443C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E61DF975;
	Sat, 12 Apr 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm5JAmTT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B201DB13A;
	Sat, 12 Apr 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744458158; cv=none; b=C1eEX4RxPjbEdmgZiwLUrhRLW5+6rWYCHroIgNGF/0CV6fmaOKIS116ViQozVRpa/+Tb0+N3uJj0bN2tMBSu+C1ff8lV5AqIU81LUiYivvzNFFm406JuFz6ITGikSmKP+gbdgPWFYdnY9LbEENz8Jd/qJ/JuVZB60SrflJLih6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744458158; c=relaxed/simple;
	bh=HS9BffI3qqC4JoBQVgCoiOiCi+evWrXoorn+7+Ndd2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Mso09sCBcGyvpb53TmH7ImL+HNKT5dVH7gOwAckLtzoiFGHBRER5QBSfm4wAqZhm3DwL6JUsl12W34XbeTQU/qJqo35cqSLVzHqqf0Kl09XGpiwyrc21vTyuc+ys1kEZ6a4mhsMDiomXUMwLl8fAfpjUet9P9ZPF2E3qmvHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm5JAmTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0949CC4CEE3;
	Sat, 12 Apr 2025 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744458157;
	bh=HS9BffI3qqC4JoBQVgCoiOiCi+evWrXoorn+7+Ndd2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hm5JAmTThx7NtaYDGMtFzaXfNnyC7j3SGhOYl/eJvfwXZSAuo1n0ZuO1C3rExj+JW
	 3lTuVYExTRXMbPJQXUIg9Rilw9wc4RWJ8cslwhTQX5QhyZEB+ePzcnjaBFPP/tpMgl
	 Xst8XdyWHsh8NOs28TUFcO8RQREbIynfyL2hzd/qukNaBiFK7J2HXGeg+4e2aciXmY
	 Rj/x4pyTFyYUzqw6EZctwnHuHhbVzDZgdDDQfU+nd9i77M1GwL2931sj65z4nEW1et
	 YXP3EdSL1gRucZrkrmvwIkg/8WgJK/0wKb520LASVs3Ma92tvNrFQQYXztppaiR51R
	 7wva6g+9NhbuA==
Date: Sat, 12 Apr 2025 12:42:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 8/8] iio: ti-adc128s052: Drop variable vref
Message-ID: <20250412124229.7917e2df@jic23-huawei>
In-Reply-To: <78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
	<db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
	<78d17b05-3f0d-4903-afe3-8051d4bd051d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 08:34:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/7/25 6:37 AM, Matti Vaittinen wrote:
> > According to Jonathan, variable reference voltages are very rare. It is
> > unlikely it is needed, and supporting it makes the code a bit more
> > complex.
> > 
> > Simplify the driver and drop the variable vref support.
> > 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---  
> 
> ...
> 
> >  static int adc128_probe(struct spi_device *spi)
> >  {
> >  	const struct adc128_configuration *config;
> > @@ -183,17 +173,12 @@ static int adc128_probe(struct spi_device *spi)
> >  	indio_dev->channels = config->channels;
> >  	indio_dev->num_channels = config->num_channels;
> >  
> > -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
> > -	if (IS_ERR(adc->reg))
> > -		return PTR_ERR(adc->reg);
> > +	adc->vref_mv = devm_regulator_get_enable_read_voltage(&spi->dev,
> > +							   config->refname);
> > +	if (adc->vref_mv < 0)
> > +		return adc->vref_mv;
> >  
> > -	ret = regulator_enable(adc->reg);
> > -	if (ret < 0)
> > -		return ret;
> > -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
> > -				       adc->reg);
> > -	if (ret)
> > -		return ret;
> > +	adc->vref_mv /= 1000;  
> 
> In other drivers, we've been doing:
> 
> ret = devm_regulator_get_enable_read_voltage(...);
> if (ret < 0)
> 	return dev_err_probe(dev, ret, "failed to read '%s' voltage, ...);
> 
> adc->vref_mv = ret / 1000;
> 
> It can be easy to make a typo or forget to specify the voltage when creating
> a .dts, so I think the error message is helpful to catch that.
> 
> And we use ret to avoid having adc->vref_mv temporarily holding a
> value with the wrong units (and can make it have an unsigned type).

Good idea. 
Applied patches 1-7. I did tweak this one as well but then couldn't make
up my mind on whether to change the type of vref_mv so I'll avoid making
a decision and will leave patch 8 for a v4 from Matti :)

Jonathan



> 
> >  
> >  	if (config->num_other_regulators) {
> >  		ret = devm_regulator_bulk_get_enable(&spi->dev,  
> 


