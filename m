Return-Path: <linux-iio+bounces-22136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD7B1530C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D1F18A4290
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA46298CAF;
	Tue, 29 Jul 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jncYX2xJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4E218E99;
	Tue, 29 Jul 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814586; cv=none; b=H6ZKbEJW7pUBNgCtcFBzhsb5+0QowWtFKFMRs9iCTOYFEz/ru7C/MpWPFWYm1J1ApQGWbeCLfFRI1fKH5xEc4rwM+eH8/3e4rcA6XYuLDEoorhPnyaU9YTaG9ds3AqsVCv2b4DcvWDl5lv+HUUnUKSK4LoeMZQRZ4Xnp2UOKJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814586; c=relaxed/simple;
	bh=XMjv1/pcPe9I64tu4cNjJSZqAGbdSEIvHVL6rlw+Iz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsI4hRQ0zjnI9CRLUTOK+eaNj9HLJQmvKWbnSse2u1qSKunkcZ4lVCtx6U3Ez+IAbdOk90LBhsWnaBHKarezbvqz/IKb0Eq8tgfPF4SODGRBoORhQDYMyiycCvktyJ/9wExbXQXG/U9suE6bO12oSs9UGvLmUAbBHfbXGDdNUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jncYX2xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D83DC4CEEF;
	Tue, 29 Jul 2025 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814585;
	bh=XMjv1/pcPe9I64tu4cNjJSZqAGbdSEIvHVL6rlw+Iz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jncYX2xJODV8pVtukBUGL+VrQamEHs0Bw7yZc4606raN7XR3JVohwrS+w4XJgPjOf
	 keWcnwp1lsUmehOkz8qmAS5yywZQAnFXOP+Y5gezqKPPxpGQFxt69hFqIHpe094ziV
	 9ZP19MxnLKZVwGZkuJHpm8gxfsP3KdWqobG1fq4FKfOv4hsiAkTneCeLmAOssWZOzw
	 eP3P7jXLnXAo7xDxth9cPT/dmDuh5OS1z8COw4+V8g3iwUccGxibO909cyUyk0Xm9r
	 eC7KcJpRZstAZCMJcm0Z3B/GOWbq3hRDTu40RqTgLzXOKM+aGcy/j7XLfTT/LMXw28
	 31gMqvpQ/ndyA==
Date: Tue, 29 Jul 2025 19:42:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad7124: do not require mclk
Message-ID: <20250729194257.7bf2893c@jic23-huawei>
In-Reply-To: <1c897cf7-dc31-4e39-84c1-f8ab4b3e0aa8@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
	<20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
	<20250727132143.35a44547@jic23-huawei>
	<1c897cf7-dc31-4e39-84c1-f8ab4b3e0aa8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 11:08:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/27/25 7:21 AM, Jonathan Cameron wrote:
> > On Thu, 24 Jul 2025 18:25:23 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> 
> ...
> 
> >> @@ -1111,21 +1112,49 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
> >>  static int ad7124_setup(struct ad7124_state *st)
> >>  {
> >>  	struct device *dev = &st->sd.spi->dev;
> >> -	unsigned int fclk, power_mode;
> >> +	unsigned int power_mode;
> >> +	struct clk *mclk;
> >>  	int i, ret;
> >>  
> >> -	fclk = clk_get_rate(st->mclk);
> >> -	if (!fclk)
> >> -		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
> >> +	/*
> >> +	 * Always use full power mode for max performance. If needed, the driver
> >> +	 * could be adapted to use a dynamic power mode based on the requested
> >> +	 * output data rate.
> >> +	 */
> >> +	power_mode = AD7124_ADC_CONTROL_POWER_MODE_FULL;
> >>  
> >> -	/* The power mode changes the master clock frequency */
> >> -	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
> >> -					ARRAY_SIZE(ad7124_master_clk_freq_hz),
> >> -					fclk);
> >> -	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
> >> -		ret = clk_set_rate(st->mclk, fclk);
> >> -		if (ret)
> >> -			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
> >> +	/*
> >> +	 * HACK: This "mclk" business is needed for backwards compatibility with  
> > 
> > I'd drop the HACK bit of this. Whilst I understand the spirit of the comment
> > that term tends to make people try to 'fix' things ;)
> >   
> >> +	 * old devicetrees that specified a fake clock named "mclk" to select
> >> +	 * the power mode.
> >> +	 */
> >> +	mclk = devm_clk_get_optional_enabled(dev, "mclk");
> >> +	if (IS_ERR(mclk))
> >> +		return dev_err_probe(dev, PTR_ERR(mclk), "Failed to get mclk\n");
> >> +
> >> +	if (mclk) {
> >> +		unsigned long mclk_hz;
> >> +
> >> +		mclk_hz = clk_get_rate(mclk);
> >> +		if (!mclk_hz)
> >> +			return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
> >> +
> >> +		/*
> >> +		 * This logic is a bit backwards, which is why it is considered
> >> +		 * a hack and is only here for backwards compatibility. The
> >> +		 * driver should be able to set the power mode as it sees fit
> >> +		 * and the f_clk/mclk rate should be dynamic accordingly. But
> >> +		 * here, we are selecting a fixed power mode based on the given
> >> +		 * "mclk" rate.  
> > 
> > My assumption is that someone had a board with a fixed rate clock on this pin.
> > So it might not be possible to have the driver do that adjustment.
> > If anyone ever adds that support, we'll have to be careful about handling fixed
> > clocks.  
> 
> In order to use an external clock, you have to program a register field to
> allow that. Since the driver isn't doing that, we can be sure that even if
> someone had an external clock, the driver was still using the internal clock.
Ah. That indeed solves this!

> 
> > 
> > This looks fine though.
> >   
> >> +		 */
> >> +		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
> >> +			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
> >> +
> >> +		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
> >> +			ret = clk_set_rate(mclk, mclk_hz);
> >> +			if (ret)
> >> +				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
> >> +		}
> >>  	}  
> 


