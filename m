Return-Path: <linux-iio+bounces-11364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E419B1A36
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222F8282537
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710E1D3628;
	Sat, 26 Oct 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQKJuZGd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D94538A;
	Sat, 26 Oct 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729965487; cv=none; b=TEdWZIG6mdECYkcwdUVluDiswjzDoBTQ3AqctXQNDkaVWzjSad+EEMrAaN+p7Xe6bAABVHOl5uzL8C0jStOLePjH14wPqEBsqOduGV9C3kdhAI1uSSjcytM15fhppK0WQC2jV1kjdVOseEOSUvwgZX4yJvPcPj15pEpzJZEm8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729965487; c=relaxed/simple;
	bh=M87z23jSPeioI44sjRMgAaGcyWOo5qKOQuk/rn6unzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmjrjh8YWD9f+tvJYiO0N5p2JVUxC4277eabP1b9R+YfQ/rNxdDB92ILCmT9fMnTY7pBn0qr1TR/xZi8YY0/Zh/5+FM7ijf62PdYgLyu4Q7js2IDYk9zQhMe6VF6sKtuxa0a9VBxnroOWeAMOFO31CQHizrKi/FpsK5EUwXai4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQKJuZGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985DAC4CEC6;
	Sat, 26 Oct 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729965486;
	bh=M87z23jSPeioI44sjRMgAaGcyWOo5qKOQuk/rn6unzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQKJuZGdKwY9QmpMNK0cyVjvO+jUN7g8cYTbPwV3h+FB3/Erb11vSHYLTx+HnTAE5
	 xRGdyleZFyU/gC7zxddQxpmcyBma93jfmypG78byunc7caPkKK4t8+MOK43EuP3CFu
	 UH0UFAfLzwhJ/P5YxOV6waeDt0GzMuN007bFDgSZ4i82nOwc7cXE1x2VMZCaedFq2M
	 iAt4QM0aJZKqIROHoMrGEjrTskVwMUKvO2i4flFdBcSzQHsik5GLRLQcWlm6bIUP3w
	 mE3k5j9TWPSSgkPfvrrmNac9oqdzXlRuyboZupYx+YF9q1VHoBKjbTsJFDt/6KUFWF
	 sIxPt51d+Wr/Q==
Date: Sat, 26 Oct 2024 18:57:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, dlechner@baylibre.com
Subject: Re: [PATCH v8 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241026185740.4144f6c8@jic23-huawei>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 11:49:40 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add High Speed ad3552r platform driver.
> 
> The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> through the current AXI backend, or similar alternative IIO backend.
> 
> Compared to the existing driver (ad3552r.c), that is a simple SPI
> driver, this driver is coupled with a DAC IIO backend that finally
> controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> maximum transfer rate of 33MUPS using dma stream capabilities.
> 
> All commands involving QSPI bus read/write are delegated to the backend
> through the provided APIs for bus read/write.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Hi Angelo,

I'd missed a build issue in previous reviews. :(

>  drivers/iio/dac/Kconfig      |  14 ++
>  drivers/iio/dac/Makefile     |   1 +
>  drivers/iio/dac/ad3552r-hs.c | 530 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r-hs.h |  19 ++
>  drivers/iio/dac/ad3552r.h    |   4 +
>  5 files changed, 568 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 26f9de55b79f..f76eaba140d8 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -6,6 +6,20 @@
>  
>  menu "Digital to analog converters"
>  
> +config AD3552R_HS
> +	tristate "Analog Devices AD3552R DAC High Speed driver"
> +	select ADI_AXI_DAC
> +	help
> +	  Say yes here to build support for Analog Devices AD3552R
> +	  Digital to Analog Converter High Speed driver.
> +
> +          The driver requires the assistance of an IP core to operate,
> +          since data is streamed into target device via DMA, sent over a
> +	  QSPI + DDR (Double Data Rate) bus.

Tabs and space mix that needs fixing.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad3552r-hs.
> +
>  config AD3552R
>  	tristate "Analog Devices AD3552R DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index c92de0366238..d92e08ca93ca 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o ad3552r-common.o
>  obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o

This causes all sorts of issues. The same code should not be linked into two
separate drivers.  Try building one as a module and one built in.

The trick is a hidden symbol in Kconfig and an extra line in here
obj-$(CONFIG_AD3352R_LIB) += ad3552-common.o

and 
//note no text as we don't want this to be user selectable

config AD3352R_LIB
	tristate

config AD3552R_HS
	tristate "Analog Devices AD3552R DAC High Speed driver"
	select ADI_AXI_DAC
	select AD3352R_LIB
	help
	  Say yes here to build support for Analog Devices AD3552R
	  Digital to Analog Converter High Speed driver.

	  The driver requires the assistance of an IP core to operate,
	  since data is streamed into target device via DMA, sent over a
	  QSPI + DDR (Double Data Rate) bus.

	  To compile this driver as a module, choose M here: the
	  module will be called ad3552r-hs.


config AD3552R
 	tristate "Analog Devices AD3552R DAC driver"
 	depends on SPI_MASTER
	select AD3352R_LIB
	help
	  ...

The pressure/mpl115 is done like this.


>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o

Anyhow, to me the code looks ready to go subject to this.

If nothing else comes up I'm almost confident enough of the fix to just
do it (and the few trivial things in previous review), but probably quicker
and less prone to error if you have time to spin a v9, perhaps after letting others
have a day or two to review v8 next week.

rc5 is tomorrow, so we have a little time left this cycle.

Jonathan

