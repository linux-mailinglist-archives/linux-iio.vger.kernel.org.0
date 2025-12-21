Return-Path: <linux-iio+bounces-27278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D86CD4388
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C053007612
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BB0303C9E;
	Sun, 21 Dec 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV9CD+4C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C7279324;
	Sun, 21 Dec 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766339582; cv=none; b=QT4Wi9VVeoQ0v3LXYGvcooONe4DDyys8BQFRBLHeISouyNtqawVduSMZQeGE5tOAP3+TPWseYNXByR9gTO0sLcF70aNsy8sNC5kUzofSEzd/HtF3e+LPmfOip6EkfoRZ0aYTB/W/EKLFQ/mGzT/8IrANLmdJv2HoEOQjj+IvB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766339582; c=relaxed/simple;
	bh=wdHkkwC4VoaF097HPdNtR5bpIgJOD+CnDzEoYOnTbJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLqB9G3jJX+TOQP0K4bNd3B+Sjip7SSFexZZCjS+MNpoycDptpt94EoTREdavJRKXpzLTxK24WL6gL74Qj6TQSL0j68gEIzxfRbsNcYh9VLTCJ66DO8QasGHMpvQyjdSYTHZERWrDf0XbhuLPbshff+wdzkt0e7vWNNH/DY9H08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV9CD+4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C05FC4CEFB;
	Sun, 21 Dec 2025 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766339581;
	bh=wdHkkwC4VoaF097HPdNtR5bpIgJOD+CnDzEoYOnTbJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tV9CD+4CJ3TVA1Lts7hgUB38izIaktO/MXsV6MZLAu8uaiEaMqRL3wH54lrjpyze+
	 91x5Cs72LKl+q1CutSEOnHsk0dTLZr5UvlR9IgAldAhGQwgzzeGdQTCp2t1iKrAwMb
	 xpnjgpHdS1DeBTsRrLBKQ8sDWE7joMXGoJ1SltXDtKooleDxSGJI5scaiDN/9iwUYM
	 IM4K0pI2Viq5TK/2KkcJccv6MQ75KXByID3wv7yjd6tdmJEuoGFxzX0Xt/JIDx7dmp
	 3+7zEQePE1rqVGxn80Juv+NDqM8c20S7qkbHGgBSaODwDBW4akVYY7zH8x6Uf6SFs1
	 x7rjrlU+/4EuQ==
Date: Sun, 21 Dec 2025 17:52:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 6/6] Documentation: ABI: testing: add support for
 ADF41513
Message-ID: <20251221175249.11b5ff02@jic23-huawei>
In-Reply-To: <20251219-adf41513-iio-driver-v2-6-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-6-be29a83d5793@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 12:34:53 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation for ADF41513 PLL sysfs interfaces
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Do this in the patches that add the ABI, or in a patch before them.

Also try building docs.  Unless something changed recently that will
moan about duplication.

When ABI is generalized from one driver to many we have to move
the documentation (and make it generic) such that is is shared by
the relevant drivers. In this case
sysfs-bus-iio-frequency is probably the appropriate file.

> ---
>  .../ABI/testing/sysfs-bus-iio-frequency-adf41513   | 27 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
> new file mode 100644
> index 000000000000..11ffd248eedb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
> @@ -0,0 +1,27 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> +KernelVersion:	6.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores channel Y frequency resolution/channel spacing in Hz.
> +		The value given directly influences the choice of operation:
> +
> +		- integer-N: requested frequency is a multiple of the Phase Detector
> +		frequency.
> +		- fixed modulus: fractional-N mode with fixed modulus.
> +		- variable modulus: dual-modulus fractional-N mode with extra variable
> +		modulus added on top of the fixed one.
> +
> +		It is assumed that the algorithm that is used to compute the various
> +		dividers, is able to generate proper values for multiples of channel
> +		spacing.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
> +KernelVersion:	6.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sets channel Y REFin frequency in Hz. In some clock chained
> +		applications, the reference frequency used by the PLL may change during
> +		runtime. This attribute allows the user to adjust the reference
> +		frequency accordingly.
> +		To avoid glitches in the RF output, consider using out_altvoltageY_powerdown
> +		to power down the PLL and its RFOut buffers during REFin changes.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c536c3afc1ae..48fa1011b797 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1606,6 +1606,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
>  F:	Documentation/iio/adf41513.rst
>  F:	drivers/iio/frequency/adf41513.c
> 


