Return-Path: <linux-iio+bounces-12701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61239D9D5D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DA6284066
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AC1DDC05;
	Tue, 26 Nov 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekiUFx4i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F21D618E;
	Tue, 26 Nov 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645769; cv=none; b=C/4EVVqGdpbhoePbov7g4Zsz2axhJlAMbksHyVlEUYT1Dv0kkRGWqqDl5z4iN5xFWXmNfSYjXQDFNp0fn4XW3Euw0lMo3GkKXaQqbWHRCuGtc5ak0BoOZRvT+RsL0j0D/hAN/BGGRRf6blNz5XSQcAOroyC0INcaKpisubaTf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645769; c=relaxed/simple;
	bh=mlBR4SaoE+u827nLxsWeIfa91R887W+zu/bZR0OStBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPfWWDa8GjLuwU/gbylBPafwAWUkUxnltsMhjzlk0uZVz3Xe0mZdFXP+3K14kzzfITGEdzlZhVCscTyVSwwTCAHPMj4fyAbXnbrn6TuilfzIfyzYOf/cxvpxCfJC219dUfxB4IsaBwfw5Ws2r1hCHhBBlzdpOBCYcmnx2v3lLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekiUFx4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042D2C4CECF;
	Tue, 26 Nov 2024 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732645768;
	bh=mlBR4SaoE+u827nLxsWeIfa91R887W+zu/bZR0OStBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekiUFx4ij69pFLk75OW+EO/3UgEswc3vhCXMSE8YWKlemV3IbMcKlEGiYTgJs/GZ3
	 ZbTCV4Uz0mR3bZn+EQ79IL9obhOyt8vUboEK/UzaXICyL/P++oEL3PrrUxBVpnFjjy
	 R8lwL7J8PNK8rTAMkMwhQeVWwBYA+kPpqPHq5/QYURSq+cQxnL5qQzXZBH62OLyPD+
	 6WClbIN9eDTzyJiZnAjzFJW5nz+YBvUpOq1lKX1ge7JLrtBRxzRJ3loZpACYpmRqOA
	 ol2xHwljgyGMdMyeL4QNCVaJxqGGkRjQ0HQQ7ggzFBjq9XWcIZH9runA+ppqK1K/ZY
	 fXdE26TDwpz/w==
Date: Tue, 26 Nov 2024 18:29:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 4/9] iio: adc: ad7606: Move software functions into
 common file
Message-ID: <20241126182919.2b0aabb6@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-4-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-4-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:26 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since the register are always the same, whatever bus is used, moving the
> software functions into the main file avoids the code to be duplicated
> in both SPI and parallel version of the driver.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c     | 128 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/iio/adc/ad7606.h     |  37 ++++++++++--
>  drivers/iio/adc/ad7606_spi.c | 131 +------------------------------------------
>  3 files changed, 156 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 828603ed18f6..df0e49bc4bdb 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -85,6 +85,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
>  	1, 2, 4, 8, 16, 32, 64,
>  };
>  
> +static const unsigned int ad7606B_oversampling_avail[9] = {

Same in original code, but why capital B?

I think you didn't remove this as intended from ad7606_spi.c
so we have a duplicate.


> +	1, 2, 4, 8, 16, 32, 64, 128, 256
> +};
> +
>  static const unsigned int ad7616_oversampling_avail[8] = {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  };
> @@ -187,6 +191,8 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch);
>  static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch);
> +static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
> +static int ad7606B_sw_mode_setup(struct iio_dev *indio_dev);
Similar question. Why capital B?  We make ad lowercase, so I'd think it makes
sense for the B as well.



> +
> +static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
> +				     AD7616_OS_MASK, val << 2);
> +}
> +
> +static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_write_mask(st,
> +				     AD7606_RANGE_CH_ADDR(ch),
> +				     AD7606_RANGE_CH_MSK(ch),
> +				     AD7606_RANGE_CH_MODE(ch, val));

Odd alignment.

> +}


