Return-Path: <linux-iio+bounces-5575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A745E8D6FD9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5043E1F21E68
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539C150999;
	Sat,  1 Jun 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5h+ccwz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025507EF;
	Sat,  1 Jun 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246912; cv=none; b=uIc01p69cZS5TuPZc/GTT0ZPtUmVWPjKKyKKEZxXb8DERJdD9h5zvBA1OfjZwdcWMRAvLkGoi9TLuRW4NqbNGM6QcW/RCx4ERZYl8CyU7zwv53FpP01iFZSIb611DFzrfjGulYJGQ1yBqAlSSQDUifkiHj2idyRhX8qz9LKjT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246912; c=relaxed/simple;
	bh=/ZL+QsOgXoSDRVVKHsuowmlYl090GokdsLFAjZvNNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB2bSJVNke6NdYJchciBea3yss9CY+F2XCQqO7PMC6oF7XB0lTBTDVSkoHebC6T7xVQT578ZYipDZgVjV/rExVdoekY0XDqB1wdHZJvA6kvUEjDkfVHmc32VhJUw1+OdiCLfVoGTXSRZALxvOhXli4+X0kfjYnkhb0QQ/x7UN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5h+ccwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1961C116B1;
	Sat,  1 Jun 2024 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717246911;
	bh=/ZL+QsOgXoSDRVVKHsuowmlYl090GokdsLFAjZvNNIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5h+ccwzI6CjGc9XT9WWo6HYlT03YhlaYlB4VNPmkCgQafIDAeF7nNJ3i8beK2tfl
	 JZ5yl7G2Vfych/aStegTquvQ/PQOyj9l/WqiSkCIgPyIEqkE6yEh9odKihZ6UDBmyb
	 5bn73AxJlaMfxmjw7hXPrbiodBNBGq7ReywKFCOjts1DbYuK/qMd6H3dX94WXuK33+
	 M4H/OMpaLycwBQ43jyN/cm4RPf7JV93cAgmFBhAGZOajL9Ua0HzcY8uW30u2CgModN
	 SLBzjHXC62WnDRsOy1F2eqJkI4kxmKQUkE3Jw50eFza8KbCo7XJqfE+FFrlN+XFJ/9
	 t7d3jcPQnMLoA==
Date: Sat, 1 Jun 2024 14:01:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adc: ad7944: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240601140139.3166dcaf@jic23-huawei>
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-5-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
	<20240531-iio-adc-ref-supply-refactor-v1-5-4b313c0615ad@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 16:19:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A possible corner case inline.

Patches 2-4 lgtm.
> ---
>  drivers/iio/adc/ad7944.c | 62 +++++++++++++++---------------------------------
>  1 file changed, 19 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index e2cb64cef476..42bbcb904778 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -464,23 +464,16 @@ static const char * const ad7944_power_supplies[] = {
>  	"avdd",	"dvdd",	"bvdd", "vio"
>  };
>  
> -static void ad7944_ref_disable(void *ref)
> -{
> -	regulator_disable(ref);
> -}
> -
>  static int ad7944_probe(struct spi_device *spi)
>  {
>  	const struct ad7944_chip_info *chip_info;
>  	struct device *dev = &spi->dev;
>  	struct iio_dev *indio_dev;
>  	struct ad7944_adc *adc;
> -	bool have_refin = false;
> -	struct regulator *ref;
>  	struct iio_chan_spec *chain_chan;
>  	unsigned long *chain_scan_masks;
>  	u32 n_chain_dev;
> -	int ret;
> +	int ret, ref_mv, refin_mv;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>  	if (!indio_dev)
> @@ -531,47 +524,30 @@ static int ad7944_probe(struct spi_device *spi)
>  	 * - external reference: REF is connected, REFIN is not connected
>  	 */
>  
> -	ref = devm_regulator_get_optional(dev, "ref");
> -	if (IS_ERR(ref)) {
> -		if (PTR_ERR(ref) != -ENODEV)
> -			return dev_err_probe(dev, PTR_ERR(ref),
> -					     "failed to get REF supply\n");
> -
> -		ref = NULL;
> -	}
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret == -ENODEV)
> +		ref_mv = 0;
> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> +	else
> +		ref_mv = ret / 1000;
>  
> -	ret = devm_regulator_get_enable_optional(dev, "refin");
> -	if (ret == 0)
> -		have_refin = true;
> -	else if (ret != -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "failed to get and enable REFIN supply\n");
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret == -ENODEV)
> +		refin_mv = 0;
> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
> +	else
> +		refin_mv = ret / 1000;
How does refin_mv get used?  Previously we never queried it's voltage (I assume
because it supplies an internal reference?

Are there any regulators that are real enough to enable but for which a voltage
can't be queried?  I think fixed regulators with gpio control are in this
category...

>  
> -	if (have_refin && ref)
> +	if (ref_mv && refin_mv)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "cannot have both refin and ref supplies\n");
>  
> -	if (ref) {
> -		ret = regulator_enable(ref);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> -					     "failed to enable REF supply\n");
> -
> -		ret = devm_add_action_or_reset(dev, ad7944_ref_disable, ref);
> -		if (ret)
> -			return ret;
> -
> -		ret = regulator_get_voltage(ref);
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret,
> -					     "failed to get REF voltage\n");
> -
> -		/* external reference */
> -		adc->ref_mv = ret / 1000;
> -	} else {
> -		/* internal reference */
> +	if (ref_mv)
> +		adc->ref_mv = ref_mv;
> +	else
>  		adc->ref_mv = AD7944_INTERNAL_REF_MV;
> -	}
>  
>  	adc->cnv = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
>  	if (IS_ERR(adc->cnv))
> 


