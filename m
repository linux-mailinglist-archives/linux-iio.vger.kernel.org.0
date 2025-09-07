Return-Path: <linux-iio+bounces-23852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE4B47B0B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD4F17A79D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147D264F81;
	Sun,  7 Sep 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbkKtJIa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E03223DF9;
	Sun,  7 Sep 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245342; cv=none; b=BTCOALVV2Z/jccYGvrTFXO2XyMAeXmevh/eHtzecOWLv8nJ2+xGxooxCPItdNMduGLkDl9qRM2W9AD84ux0LxSO4zRc6dNQhrOk5NrkfzqQmz+czss4T5w9/QaeShPRbNEYnK42sNY9+RRjtCTVgITRgjePlQEryBz2/7xZ1sgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245342; c=relaxed/simple;
	bh=D1pphOsaMdhq2bWMXgzDFH9Cssa9L/A8eW+GFydLUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghnssK6MnTTMZY8XBZFmtOhT4cihYV3BCm6f9iNujTYww1JQn7YHCwm7NOaClMKfiC2NZlJEDZ+oRZMOR7OqvgPARPhXsOMYJ1QIlqUEQJwa1mlDMi+J5swRQjlDmrIDwbqMEMepfxRMQ+rfmqNADmPMw1eEiIWkjkPNGxJs3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbkKtJIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E095C4CEF0;
	Sun,  7 Sep 2025 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757245341;
	bh=D1pphOsaMdhq2bWMXgzDFH9Cssa9L/A8eW+GFydLUsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YbkKtJIaBwgZCAB/zJJ6OMsTMkKqKdde36YiaKxyZls1NTkiCtuKaVjfhpJAc6KHZ
	 yNncNyi6NDOwiHIsYMXC+qJ3OmJ1bhdW+kr+dc+YR3plU7fiWIHah0OapKIScbYvfQ
	 27qM+Y+c2WapzjJW5c380UuGoDzOlXXV3AOqj8HCZvv9QoIQ8xyhtxtLy2ffXbDYMB
	 dNEg/cMEoYMGjikD5hNXBfXj0OAA0vjfAs9q6TZoHfi2n3DSHm1hPB9+Jk/RNi7bhy
	 zRWD/0YUG/E9668WSo9werCIGGW+aOj10EY6pZJeIIhge9XByVihNdB3KDkvkGgBK5
	 FQ1T72J+6Y6HQ==
Date: Sun, 7 Sep 2025 12:42:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, Herve Codina
 <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250907124207.2fe64214@jic23-huawei>
In-Reply-To: <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
	<3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 09:42:31 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> The IC does also support CRC but it is not implemented in the driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

Just one trivial additional comment from me.

Jonathan

> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> new file mode 100644
> index 000000000000..8acd1e5f105d
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79112.c





> +
> +/* ADC channels as named in the data-sheet */
> +static const char * const bd79112_chan_names[] = {
> +	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",	/* 0 - 4 */
> +	"AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",	/* 5 - 9 */
> +	"AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",	/* 10 - 14 */
> +	"AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",	/* 15 - 19 */
> +	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",	/* 20 - 24 */
> +	"AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",	/* 25 - 29 */
> +	"AGIO14B", "AGIO15B",					/* 30 - 31 */
> +};

> +	/* Let's assign data-sheet names to channels */
Not seeing any value in this comment given the code that follows.
Probably drop it

> +	for (i = 0; i < iio_dev->num_channels; i++) {
> +		unsigned int ch = cs[i].channel;
> +
> +		cs[i].datasheet_name = bd79112_chan_names[ch];
> +	}


