Return-Path: <linux-iio+bounces-27369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499DCDFF02
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16674300DC91
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E793233FA;
	Sat, 27 Dec 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNgTDuW9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBC1A23B9;
	Sat, 27 Dec 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851885; cv=none; b=ds7yCTkhq60UIxqDZogLdlRCydMhVG/sc1jcausVumd77/vACZsj9QctMIyGEq1Kz6yQ4dPmpNnNwtvuWA+6Xj8TSDCsX9jkuWFojXSw4pjKCNQ5CBcAfpwEPOXnEFfcgxqGOM9/uYFMvBFPcdOJErapqfpMyphTdhBhrDxVNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851885; c=relaxed/simple;
	bh=/Z1HYkA3Z9nkZuzaX5+2e8tSWqn76PSoV2KdJ45cBo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBtxwfrMupQ0R2W8rRzRJmDXn3YeAZMzF+ct3q7nGpPAfHM443Dzko/BSuWDon+1DS269y9/tYOhPgfPpk4hc+EX6n7kIZ8OxzYbjVIIv0Cgepa1dRgiRNufVJw75Sxjh2OgED/6qwrRiqoVmo3xBuSdzHMC09JVNcoBIVt9sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNgTDuW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D427C4CEF1;
	Sat, 27 Dec 2025 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766851884;
	bh=/Z1HYkA3Z9nkZuzaX5+2e8tSWqn76PSoV2KdJ45cBo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNgTDuW9pgSJrAHP0F6bppK7UT/vcWpGXQeQKJYVNxjSaqCkXECdSSUO85uISz+ed
	 apV5tWa/739B7otIEvBxF9o8IUmOJBq9C2xopVwoZzH++K992PvaBXn5T8BiJSRZYY
	 XxJeuHGaRjhq5JOmk1r/uMkkgfXH1Gcdp7vcTVCOnCUocRDKhzqZnNeslXO2jH6AwX
	 njN1pq2PUoiSfDXXH9fWki5j/1SfymX7NVqP6pSk2nZ5K+mDDTrhzSR5sZ5BJN60kv
	 YYib1snTl2OYaLCHlG+0j4vN0Rp4HltClj1WCaCo6CgH+AfA7Q1BgXLYDx/Yq3AJJF
	 mzyOFF9PtfxNQ==
Date: Sat, 27 Dec 2025 16:11:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20251227161115.5e38e874@jic23-huawei>
In-Reply-To: <dab6e0ffc1a297d857f5a9c75184794c301d70f3.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
	<dab6e0ffc1a297d857f5a9c75184794c301d70f3.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 02:53:08 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is controlled by GPIOs provided in
> the device tree.
> 
> The AAF gain is defined by hardware connections and should be specified
> in the device tree.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Hi Jonathan

I noted one minor area where I think the code could be slightly cleaner.
If we didn't have the outstanding question about the comment in the BP definitions
patch I'd just have merged it as it stands. I don't mind that much if you
prefer the current form.

Jonathan

>  
> +static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
> +{
> +	bool aaf_gain_provided;
> +	u32 val;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
> +	if (ret == -EINVAL)
> +		aaf_gain_provided = false;
> +	else if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get AAF gain value\n");
> +	else
> +		aaf_gain_provided = true;
> +
> +	if (!aaf_gain_provided) {
> +		if (st->chip->has_variable_aaf)
> +			st->aaf_gain = AD7768_AAF_IN1;
> +		return 0;
> +	}
> +
> +	if (aaf_gain_provided && !st->chip->has_variable_aaf)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "AAF gain not supported for %s\n", st->chip->name);
> +

Might be simpler if we just did the actions for aaf_gain at the point of detecting it.

	if (ret == -EINVAL) {
		/* If controllable, use default */
		if (st->chip->has_variable_aaf)
			st->aaf_gain = AD7768_AAF_IN1;
		return 0;
	}
	if (ret)
		return dev_err_probe(dev, ret, "Failed to get AAF gain value\n");

	if (!st->chip->has_variable_aaf)
		return dev_err_probe(dev,, -EOPNOTSUPP,
		     "AAF gain provided, but variable AFF gain not supported for %s\n", ...)

or maybe make the gain number obvious as the default by doing.

	if (ret == -EINVAL) {
		if (!st->chip->has_variable_aaf)
			return 0;

		val = 10000; /* Matches the default from DT */
	} else if (ret) {
		return dev_err_probe(dev, ret, "Failed to get AAF gain value\n");
	} else if (!st->chip->has_variable_aaf) {
		return dev_err_probe(dev,, -EOPNOTSUPP,
		     "AAF gain provided, but variable AFF gain not supported for %s\n", ...)
	}

The first option is simpler, bu the second makes it easier to align with DT binding.


> +	switch (val) {
> +	case 10000:
> +		st->aaf_gain = AD7768_AAF_IN1;
> +		break;
> +	case 3640:
> +		st->aaf_gain = AD7768_AAF_IN2;
> +		break;
> +	case 1430:
> +		st->aaf_gain = AD7768_AAF_IN3;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Invalid firmware provided AAF gain\n");
> +	}
> +
> +	return 0;
> +}

