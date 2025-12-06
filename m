Return-Path: <linux-iio+bounces-26850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84232CAAC93
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37E5D3007D8C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39A2BCF5D;
	Sat,  6 Dec 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Musbaw/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460413AC39;
	Sat,  6 Dec 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765047822; cv=none; b=GUAD2nfucuiKMJe9rbb2x7oGQQiLmdZylOzTt4qOTHpJS3IvAMETEhHReA2kFHMR0c/f6nCkVjikDWP9fAF2dew9kepK/M1e5otsWtBx7w+Xp0fQSppDkiJ7se1tOX5QYA+b31veNmTeEDxBcQQDhZtxtjAdXiwof4wfBXEGFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765047822; c=relaxed/simple;
	bh=LwpCpejsF/BnoeaACK/QZOn+UqmeQX2sHgaXpZEhxUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1SA2DPeW4REvrxkCUcGVTj14jHu0PXOfMXrGOQZIilmlRWUZKPgwyC1e6mDu9ULHsyuKgtROEzNsqAO2aonieTT/SClSlo7XTxFpvOgFbSKN6xI3jDSfbEJpKFEaTAqYaRJyxZR08I3bTzOUQxvohnf0xfQDYKMQxfR1TGqtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Musbaw/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D063C4CEF5;
	Sat,  6 Dec 2025 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765047821;
	bh=LwpCpejsF/BnoeaACK/QZOn+UqmeQX2sHgaXpZEhxUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Musbaw/MtdMBvcXuPMW1mBpnFMP6/6Aw60gc/fUaVf1/hLRrUvpdUHL9W0i8iNjEV
	 QxhlWGKk+zvsyo09jRWZUci85lqGnR+nf/skbxaXazRMAQzp5e03Wq2ob29izaDrXE
	 3nfdEiQyXYAIom8exDVjV3P+YAQYb8qg+t7qBnImSOm4bEnP/59nF3FRxVBK8IhPL3
	 n1s+TUBobd1uKMvKMkCuG/S2pQBrRvQpTPwT+8fsW6jJadtRW2jYgwtRCYwexWGhFF
	 xRAkgxwUh212pAn03lUTdHXIEF63f9yzWw4NvqVi9DXim0i88GlgNNvAi32DIrQnbs
	 bYQffkltU990A==
Date: Sat, 6 Dec 2025 19:03:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <20251206190332.53874d41@jic23-huawei>
In-Reply-To: <20251205144058.1918-3-antoniu.miclaus@analog.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
	<20251205144058.1918-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:40:41 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Hi Antoniu,

> no changes in v6.
Given I assume you just missed Andy's prior review I'll take
a look at this version with assumption both sets of comments will be
sorted for v7.

A few things inline.

> diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
> new file mode 100644
> index 000000000000..eed5fe69280b
> --- /dev/null
> +++ b/drivers/iio/amplifiers/adl8113.c

> +struct adl8113_gain_config {
> +	enum adl8113_signal_path path;
> +	int gain_db;
> +	int va;
> +	int vb;

What are va and vb for?  Currently seem unused because you derive
them from path at use point.

> +};



> +
> +static const struct iio_info adl8113_info = {
> +	.read_raw = adl8113_read_raw,
> +	.write_raw = adl8113_write_raw,
> +};
> +
> +static int adl8113_init_gain_configs(struct device *dev, struct adl8113_state *st)
> +{
> +	int external_a_gain, external_b_gain, i = 0, j;

Preference for not hiding initializations in a list where only one is initialized.

	int external_a_gain, external_b_gain, j;
	int i = 0;

makes it easier to spot.

> +
> +	/*
> +	 * Allocate for all 4 possible paths:
> +	 * - Internal amp and bypass (always present)
> +	 * - External bypass A and B (optional, or INT_MIN for testing)
> +	 */
> +	st->gain_configs = devm_kcalloc(dev, 4,
> +					sizeof(*st->gain_configs), GFP_KERNEL);

Slightly odd wrap. I'd move the sizeof() up a line.

> +	if (!st->gain_configs)
> +		return -ENOMEM;
> +
> +	/* Always include internal amplifier (14dB) */
> +	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
> +	st->gain_configs[i].gain_db = 14;

Could do this as something like:

	st->gain_configs[i++] = (struct adl8113_gain_config) {
		.path = ADL8113_INTERNAL_AMP,
		.gain_db = 14,
	};

	st->gain_configs[i++] = (struct adl8113_gain_config) {
		.path = ADL8113_INTERNAL_BYPASS,
		.gain_db = -2,
	};

etc.

> +	i++;
> +
> +	/* Always include internal bypass (-2dB insertion loss) */
> +	st->gain_configs[i].path = ADL8113_INTERNAL_BYPASS;
> +	st->gain_configs[i].gain_db = -2;
> +	i++;
> +
> +	/* Add external bypass A if configured */
> +	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
> +				      &external_a_gain)) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
> +		st->gain_configs[i].gain_db = external_a_gain;
> +		i++;
> +	}
> +
> +	/* Add external bypass B if configured */
> +	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
> +				      &external_b_gain)) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
> +		st->gain_configs[i].gain_db = external_b_gain;
> +		i++;
> +	}
> +
> +	/*
> +	 * If there's a free external bypass path, add one with INT_MIN gain
> +	 * to represent "nothing connected" for testing purposes

I don't follow this one.  What sort of testing purpose?  Something we want
in a real system?

> +	 */
> +	if (!device_property_present(dev, "adi,external-bypass-a-gain-db")) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
> +		st->gain_configs[i].gain_db = INT_MIN;
> +		i++;
> +	} else if (!device_property_present(dev, "adi,external-bypass-b-gain-db")) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
> +		st->gain_configs[i].gain_db = INT_MIN;
> +		i++;
> +	}
> +
> +	st->num_gain_configs = i;
> +
> +	/* Check for duplicate gain values */
> +	for (i = 0; i < st->num_gain_configs - 1; i++) {
> +		for (j = i + 1; j < st->num_gain_configs; j++) {
> +			if (st->gain_configs[i].gain_db == st->gain_configs[j].gain_db)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "Duplicate gain values not allowed: %d dB\n",
> +						     st->gain_configs[i].gain_db);

What happens if we just don't bother enforcing this? I assume the second of the duplicates
can't be selected?  Do we care beyond it being silly?

> +		}
> +	}
> +
> +	return 0;
> +}

