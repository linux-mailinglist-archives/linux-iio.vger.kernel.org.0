Return-Path: <linux-iio+bounces-15356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFFA314DE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00FE3A6AE7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EC261369;
	Tue, 11 Feb 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQX02oHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25D1E7640;
	Tue, 11 Feb 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301548; cv=none; b=G1Mn+qlXHJ8MmfREGSTAiOx0gE3yG6YnNGKk3khfwVoylx3eBZaIUM7JDkZ5JKqOiZG9BsRTvPcE8xSP1rlNKoJ6923RpazZtGWXnHFl7fbkaZjKkDdfiuSpFpSJ1DKyge6iI1b9shRcgQM5K0uE2/YI4JjQ/qEu0YRPZbjtd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301548; c=relaxed/simple;
	bh=/hW5W36UdT8Apezp2RQD3C7kf97Gk1bp0dsFZaEjFr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK6ceXj9aYaE7If+SoU62Wlp8T6xoVnpv1di/dYgIFQoWxNVwx+XuitLbXttWieQJ8xBgwGai0gGExJ+DaQkOiguSBLVtHwXSyHervbbaslmhbKMIcv1sL7W4XyCpNlHAd41G97IARpdg23Q8mHQJCpo8FJTyC/YX/lHdBqLCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQX02oHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34828C4CEE7;
	Tue, 11 Feb 2025 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301548;
	bh=/hW5W36UdT8Apezp2RQD3C7kf97Gk1bp0dsFZaEjFr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQX02oHlPKT5WixhS6vjlWhChhz28rkN3NoPKvNNy2pXhszYuGynSh5RPKyKzQVC1
	 GGEEZUoEHRWitR50kKzlaXhakZSTl9sxupHLrqwXlr3jRBxVfLgDfZUcSlYOG3XuGN
	 1kOgQYrZY/rncqbsjgUrRmWpMWYFNrapinS+AVltts1hQL5Ndg+LJmKNXSPHERKg7B
	 +gAzJpDg9ZvlDGtHsebghZvVWeXnasTUHSPpoyKrvAaJnXCwnLrMYV+oW5c4vP6M/e
	 EYkVPdEykLWftk8UGCLQGCtMQdPt2K2zVS/go+zFm3O0A09ME8TUWRF0qRWhz+LGX/
	 W/L1uLGsX67bw==
Date: Tue, 11 Feb 2025 19:19:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250211191900.36fdd4d9@jic23-huawei>
In-Reply-To: <87b712f9-6191-4626-b031-0234379a166c@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
	<4781e1b1f074ca6c84ecc084b152885d08e826cc.1738761899.git.mazziesaccount@gmail.com>
	<20250208165208.3560237f@jic23-huawei>
	<87b712f9-6191-4626-b031-0234379a166c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +
> >> +static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int channel)
> >> +{
> >> +	int ret, evbit = BIT(IIO_EV_DIR_RISING);
> >> +
> >> +	if (!(data->alarm_suppressed[channel] & evbit))
> >> +		return;
> >> +
> >> +	data->alarm_suppressed[channel] &= (~evbit);
> >> +
> >> +	if (!(data->alarm_monitored[channel] & evbit))
> >> +		return;  
> > This lot is very similar to the lo variant. Can we combine them or
> > use some helper for both?  
> 
> Initially I did this.
> 
> But the code looked a bit dull because the evbitm, alarm-limit array and 
> prints depend on the direction. Furthermore, the caller already knows 
> the direction (as the caller does also handle directions separately), so 
> doing:
> 
> foo(dir)
> {
> 	if (dir == bar)
> 		...
> 	else
> 		...
> }
> 
> ...
> 
> if (dir == bar)
> 	foo(dir);
> else
> 	foo(dir);
> 
> started to feel just a bit, meh. Hence I separated the stuff to own _lo 
> and _hi functions.
Hmm. I was thinking of something like

static void bd79124_re_enable_xx(struct bd79124_data *data, unsigned int channel,
				 unsigned int reg, u16 limit,
				 enum iio_event_dir dir)
{
	int ret, evbit = BIT(dir);

	if (!(data->alarm_suppressed[channel] & evbit))
		return;

	data->alarm_suppressed[channel] &= (~evbit);

	if (!(data->alarm_monitored[channel] & evbit))
		return;

	ret = bd79124_write_int_to_reg(data, reg, limit);
	if (ret)
		dev_warn(data->dev, "Low limit enabling failed for channel%d\n",
			 channel);
}

static void bd71924_reenable_hi(struct bd79124_data *data, unsigned int channel)
{
	return bd71924_reenable_x(data, channel, BD79124_GET_HIGH_LIMIT_REG(channel)
				  data->alarm_r_limit[channel], IIO_EV_DIR_RISING);
}

static void bd71924_reenable_lo(struct bd79124_data *data, unsigned int channel)
{
	return bd71924_reenable_x(data, channel, BD79124_GET_LOW_LIMIT_REG(channel)
				  data->alarm_f_limit[channel], IIO_EV_DIR_FALLING);
}

But I guess not really a saving in the end.

> 
> 
> >> +
> >> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel),
> >> +				       data->alarm_r_limit[channel]);
> >> +	if (ret)
> >> +		dev_warn(data->dev, "High limit enabling failed for channel%d\n",
> >> +			 channel);
> >> +}  
> >   
> 
> Yours,
>    -- Matti
> 
> 


