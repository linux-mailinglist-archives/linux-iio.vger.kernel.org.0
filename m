Return-Path: <linux-iio+bounces-19865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD63AC33F2
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8703A5D0D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0814658D;
	Sun, 25 May 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFmcNN+A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF29367;
	Sun, 25 May 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169982; cv=none; b=iI8Q7CeXWqXDW+7tJOAVpM5tD9EJlehLLqXcvxSSvfzsnuB5FUdfK7y5PyGk6i2GsUrQiJPXLMQ5NQ+nab3myVyff+W2LxwXVbUEctH+GFH4OwVgw/8qawNdevrI1egAY9NRIgnEQAqClOHq8g0rfGoyXwBUDPceNCb8N/fQUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169982; c=relaxed/simple;
	bh=0e7hcSeO1+Z9kTiXiKNcVCBtmWFPCtQZba1kSfn1BSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvmENOLm8H/ETmmeZr67Ns8uXi+1Vlv8t5nPU432r6v58SWCUWiErbQ8ijlXiJDnJ8FQJXAmSFKkQ9Rw6+jwCOMGjaI0PT1N0FBmxLJNPkVp43WqSG+Yy6gEZfe+70as9e2gMZ1xEJ7v9ARNaX+XV/QvbNBNxAVKpOa5RQnZwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFmcNN+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC5CC4CEEA;
	Sun, 25 May 2025 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748169981;
	bh=0e7hcSeO1+Z9kTiXiKNcVCBtmWFPCtQZba1kSfn1BSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CFmcNN+AaYiQKjxGED59+fWfcC0rllxhRI2bh0nWae4IMoNWRS0i8LT7YHA8jOt0N
	 7qkVxco1QaAkG/tTSwR6X26EHwNOXsd7fQ6ZPebGxIkK084rFAmBu/49+g2fdrBaLB
	 xs6mFiP+8YQgq7DcHfzenyzx2xQ7NGBq8+7V/NpCgRXkDtf4ffNWWUagO88h/rVH1u
	 ZMGarE0ngF94Wv3ngkEhKBLPXF5vH+zwnt3IeaXZQMXM8y9QHqWUJ4clzue7P9bIXJ
	 ZGoSDRr9kmbwbqJMzW19EY6MeUtqEs09VE/xMKv8qRHkl5Kw1SgdE3iayNtVsOg+hk
	 cXBjlGsaF04FQ==
Date: Sun, 25 May 2025 11:46:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 06/10] iio: adc: ad4170: Add support for buffered
 data capture
Message-ID: <20250525114610.532f14a1@jic23-huawei>
In-Reply-To: <011bfbcda9f74c1c3853a664b961e7884c3c7333.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<011bfbcda9f74c1c3853a664b961e7884c3c7333.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:35:23 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend the AD4170 driver to allow buffered data capture in continuous read
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks if the aforementioned
> condition is met.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

I'm curious - why no timestamps?

> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 218f768042fe..e8856c911dfd 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c

>  
>  enum ad4170_ref_buf {
> @@ -309,9 +322,13 @@ struct ad4170_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> +	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
> +	struct spi_message msg;
> +	struct spi_transfer xfer;
> +	struct iio_trigger *trig;
> +	struct completion completion;
>  	int pins_fn[AD4170_NUM_ANALOG_PINS];
>  	u32 int_pin_sel;
> -	struct completion completion;

Probably better to move this to it's new location when it's introduced and
reduce noise a little here.

>  	/*


