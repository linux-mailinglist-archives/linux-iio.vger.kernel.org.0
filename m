Return-Path: <linux-iio+bounces-12703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD49D9D97
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448221681E8
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4411DED68;
	Tue, 26 Nov 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkXeZtXY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9371DE8AC;
	Tue, 26 Nov 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646596; cv=none; b=WeC74bw2EdoM1j8ipNh3UJi+aGVBD1P/hyeknjZS0wj4eFZe71eOhy1TSr3tCG+Vkzgw802nN0sJ2nmpiWpq0/i6Vk7O9O8XMFFOTD5eEZ1tQtfH5MZk1pGBpIP0qY1qSPTeAFRi/wf7gSvuUa1MkVSFOKP6WieVPSQ0VXL0pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646596; c=relaxed/simple;
	bh=o4PAzCITcB2wHXj0Z8I936KqEftgZZOHh/Iustv4gBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=no0Q7qUTuuNw7McEgLqn7GhoDpXArPQBOrKk2s3jPSUkZfeb78PAq3cJ0YF/uZ03ymlFdJGKfPj/CQBCXO5JOoUq+y6rarLWZYywQBcMbVl95QLVAPTVCpv0tnHXDKZGifmW6jni9FMQA/5ua819zhEywlNdziAUWXnQnXwVwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkXeZtXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142DCC4CECF;
	Tue, 26 Nov 2024 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732646596;
	bh=o4PAzCITcB2wHXj0Z8I936KqEftgZZOHh/Iustv4gBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkXeZtXY4hda+G+D1St4o5DPH2vs+FWGprYCbueRvh9CvribBprfZoUOMXmrnUjtG
	 Qi7YWcey2T+Cxjp9vhFBvYFVyjUhX2Vgwg5/QTeecg53mhVnUCv7xBKsiNHXq0KqQb
	 lw4l1FQKBokU9lkxo9eXPjvNaP+9k2W8FYp4sOWQCAwTX4NzTh0viaa1sH3GUPiubx
	 kIULYjIh/WG2mryWEPyQw9aFbGcrpBh8BxWq+M4P4Q/j+1OK3vySBfnSSpsACGLObK
	 52RpAP24tmOJMZy9IVh94d6x2uG12s1CEDfs37UsvtShKLVUMpPwQFbeosPAiaIpq5
	 +aEU+DBTyoyUg==
Date: Tue, 26 Nov 2024 18:43:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 6/9] iio: adc: adi-axi-adc: Add support for AD7606
 register writing
Message-ID: <20241126184307.0a675530@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-6-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-6-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:28 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since we must access the bus parallel bus using a custom procedure,
> let's add a specialized compatible, and define specialized callbacks for
> writing the registers using the parallel interface.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Trivial comments inline.

Thanks,

J
> +
> +static int ad7606_bi_reg_write(struct iio_backend *back, u32 reg, u32 val)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 buf;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Read any register to switch to register mode */
> +	buf = 0xaf00;
> +	axi_adc_raw_write(back, &buf, 4);

sizeof(buf) for these.


>  static void axi_adc_free_buffer(struct iio_backend *back,
>  				struct iio_buffer *buffer)
>  {
> @@ -487,9 +573,22 @@ static const struct axi_adc_info adc_generic = {
>  	.backend_info = &adi_axi_adc_generic,
>  };
>  
> +static const struct ad7606_platform_data ad7606_pdata = {
> +		.bus_reg_read = ad7606_bi_reg_read,
> +		.bus_reg_write = ad7606_bi_reg_write,

One less tab on indent.

> +};

