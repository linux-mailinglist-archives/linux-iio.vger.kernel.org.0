Return-Path: <linux-iio+bounces-16549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE0A57A89
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E0716BD1E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C51C84AD;
	Sat,  8 Mar 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxRncr6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B72CAB;
	Sat,  8 Mar 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441133; cv=none; b=Xq2yYwKG1rIFT9lMyD9G45+Y6FwqucY/15FTgUB6smTWgO7UPX41ggDrY7RXshMAtUAw8exR6XZdeS0szyW+mUMPhrUc1MZcCzVaJ06WknH5pyFCttKtv7rZQwXpntlmOGAEOHzI7R09SpNIHwcMClag9xtJHRM9NIqKo2Zq0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441133; c=relaxed/simple;
	bh=YNI+llb9gBYtQbN0ihkpgMdd3AVM7l9QkkiYTUqCjwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAo2LUISv/uRxig7DnI/BevL/KbZP3/pi01GuwmrFIkRrM9xbx4If2qbTz6wZvL/5c9r7oPzNFYNw+Wq0TuNkCSdJhNn/2LOv7awemwoc6hf/pd+XdFuP/iczSgbD85Qo5j6KaUC+Eq1OiZRGseYjo2ggfFJn+a/xsL6Odc88i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxRncr6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5452C4CEE0;
	Sat,  8 Mar 2025 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741441132;
	bh=YNI+llb9gBYtQbN0ihkpgMdd3AVM7l9QkkiYTUqCjwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HxRncr6XgG3KMwhLMzjEK+zdHN7s6yCUybxb1Mh+MardBLMxDyZLslouuAo9kTszx
	 TehxjYbaO2QY619ldtzVjOtjIviNO2JUzv0iPiPKM+TilyAyd28lQaE0uT9fKbioP5
	 /zYpZ0wtitHZgI+QgRANuZP2rj0cso6BDBHN3hhme40eM9qsdVA6O9h9bDO1lcOcvh
	 Z6d1NVBhDNn1eT/PtDCy3UwwPgjkFyU6yjP28lkG5ZWuGxgciedzs3tUkeFLP1o/RX
	 YKPBBnhP1r0/v3/CnlfS87arK9PqgJS0bPn2Ujzq7PnU7W1lNOF/zCHvKxUMaW4BfO
	 Dp8hcXN0iKLGA==
Date: Sat, 8 Mar 2025 13:38:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 11/17] iio: adc: ad7768-1: add regulator to control
 VCM output
Message-ID: <20250308133840.30112a8b@jic23-huawei>
In-Reply-To: <40c586006b5cee0570ae577db2b58e6e7e36a6e6.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<40c586006b5cee0570ae577db2b58e6e7e36a6e6.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:02:59 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Looks fine but as likely you will be doing a v5, please switch
to the new iio_device_claim/release_direct() functions.
If I had applied up to here I'd probably just have tweaked this whilst
applying but given a few other tweaks needed, please do this one
as well for v5.

Thanks,

Jonathan

> @@ -644,6 +654,172 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
>  					       &ad7768_buffer_ops);
>  }
>  
> +static int ad7768_vcm_enable(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, regval;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As below.

> +	if (ret)
> +		return ret;
> +
> +	/* To enable, set the last selected output */
> +	regval = AD7768_REG_ANALOG2_VCM(st->vcm_output_sel + 1);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, regval);
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_vcm_disable(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As looks likely you'll be doing a v5 for other minor stuff please
rebase on the testing branch of iio.git (as I've picked up some of this
series) or togreg once that is pushed out and use
	if (!iio_device_claim_direct(indio_dev))
		return -EBUSY;
+ iio_device_release_direct()
to get the variants adjusted to play better with sparse.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As above.
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	ret = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) != AD7768_VCM_OFF;
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As above.
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +				 AD7768_REG_ANALOG2_VCM_MSK, regval);
> +	iio_device_release_direct_mode(indio_dev);
> +	st->vcm_output_sel = selector;
> +
> +	return ret;
> +}
> +
> +static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!indio_dev)
> +		return -EINVAL;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As above.
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val);
> +	ret = clamp(val, 1, (int)rdev->desc->n_voltages) - 1;
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}


