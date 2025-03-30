Return-Path: <linux-iio+bounces-17359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFEA75B0B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F641663FA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B951D89E4;
	Sun, 30 Mar 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmNxCI+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54B13C9A3;
	Sun, 30 Mar 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743353433; cv=none; b=JlVHFWcVSlggI7cQWRb8OiLd69JzaCJAQcxC3swfc1K09jEoMlWsey9f9XAMzYZVhC/YmaQi/teEosrP6a8dnC0AJmIZWx0mlRwzB3E2jvuuDb6vRLfDIrhwbebSCJmiH6s/cHb85RKqfd028YihnXo9bN8cXfCaq2y56T5mIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743353433; c=relaxed/simple;
	bh=T2nZgkmBO2IAZub8uryRdB9Li1xQtqd5x+s1ykAv2wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHO4pSeIfF4/H8+1cwLNRd4qIU9g70708x+y8YtR52pPLTeUSZ+UnAQXvx77G3kRZBum0mhU5be770Og4LM39/DJPS/6rqnFQ2Km0d0GzMNQ0KOWP2eGlwGgQ0esiGIgQW6X9f3rEw6rpVC9EgiaeSVPEBxeL+g2V3sB3K+FZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmNxCI+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8DC4CEDD;
	Sun, 30 Mar 2025 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743353432;
	bh=T2nZgkmBO2IAZub8uryRdB9Li1xQtqd5x+s1ykAv2wU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmNxCI+Plibu7TQjH0YW7pC1zWuSm/AASoGx/Vgn8+apYn42fmFJY7TrohgTafFNQ
	 JVPqHdsFeJxX7wleXERD+krYYKbF0I3qAICBTekwBOHOGLTZdAVPQZ1EAM+rspIIwU
	 rmDqqTIN0U7GswP7Rvl3Rt7yx3W8ziLzVuSUR0H8VKPLctmirLnkYoMP0aPrg3UsE/
	 1TwhlHNVbwa9ThRGPCnT8EwoGtF/833xOfNp86i9KwEkXKJTJo/W/hSu2cHl78nM33
	 GuWGcbZ7ttq0SYTPBzBJUiVmoPAFfgEwadmofvKZIInvS9nFrdw4cI+d8iPmG/vdKX
	 bboLhHpFacdvg==
Date: Sun, 30 Mar 2025 17:50:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: iio: add documentation for ad3552r driver
Message-ID: <20250330175024.2319b8eb@jic23-huawei>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	<20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Mar 2025 21:28:48 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add documentation for ad3552r driver, needed to describe the high-speed
> driver debugfs attributes and shows how the user may use them.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/iio/ad3552r.rst | 65 +++++++++++++++++++++++++++++++++++++=
++++++
>  Documentation/iio/index.rst   |  1 +
>  MAINTAINERS                   |  1 +
>  3 files changed, 67 insertions(+)
>=20
> diff --git a/Documentation/iio/ad3552r.rst b/Documentation/iio/ad3552r.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..638a62c99fb876cca026a0b1d=
f469c81ba39ff29
> --- /dev/null
> +++ b/Documentation/iio/ad3552r.rst
> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AD3552R driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device driver for Analog Devices Inc. AD35XXR series of DACs. The module=
 name
> +is ``ad3552r``.
> +With the same module name, two different driver variants are available, =
the
> +``generic spi`` variant, to be used with any classic SPI controllers, an=
d the
> +``hs`` (high speed) variant, for an ADI ``axi-dac`` (IP core) based cont=
roller
> +that allows to reach the maximum sample rate supported from the DACs, us=
ing the
> +DMA transfer and all the SPI lines available (D/QDSPI)..
> +The high speed driver variant is intended to be used with the ``adi-axi-=
dac``
> +backend support enabled, that is enabled by default when the driver is s=
elected.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `AD3541R <https://www.analog.com/en/products/ad3541r.html>`_
> +* `AD3542R <https://www.analog.com/en/products/ad3542r.html>`_
> +* `AD3551R <https://www.analog.com/en/products/ad3551r.html>`_
> +* `AD3552R <https://www.analog.com/en/products/ad3552r.html>`_
> +
> +Wiring connections
> +------------------
> +
> +::
> +
> +    .-----------------.                .-------.
> +    |                 |--- D/QSPI -----|       |
> +    |   DAC IP CORE   |--- SPI S_CLK --|  DAC  |
> +    |                 |--- SPI CS -----|       |
> +    |                 |--- LDAC -------|       |
> +    |                 |--- RESET ------|       |
> +    |_________________|                |_______|
> +
> +
> +High speed features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device attributes
> +-----------------
> +
> +The following table shows the ad35xxr related device debug files, found =
in the
> +specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
> +
> ++----------------------+------------------------------------------------=
-------+
> +| Debugfs device files | Description                                    =
       |
> ++----------------------+------------------------------------------------=
-------+
> +| data_source          | The used data source,                          =
       |
> +|                      | as ``iio-buffer`` or ``backend-ramp-generator``=
.      |
> ++----------------------+------------------------------------------------=
-------+
Hmm. I'm not convinced yet that this is something that belongs in debugfs b=
ut will
read on through the series.

> +
> +Usage examples
> +--------------
> +
> +. code-block:: bash
> +	root:/sys/bus/iio/devices/iio:device0# cat data_source
> +	iio-buffer
> +	root:/sys/bus/iio/devices/iio:device0# echo -n backend-ramp-generator >=
 data_source
> +	root:/sys/bus/iio/devices/iio:device0# cat data_source=E2=8F=8E

Not sure what the trailing character is.

> +	backend-ramp-generator
> +
> +
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index bbb2edce8272e7483acca500d1a757bbcc11c1e0..2d6afc5a8ed54a90cd8d5723f=
0dc5212b8593d16 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
>  .. toctree::
>     :maxdepth: 1
> =20
> +   ad3552r
>     ad4000
>     ad4030
>     ad4695
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57eaab00f6cb53df52a4799eb2c1afbbd1e77a1e..52bc56a9ee22c66b90555681c=
4757ea4399adae1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1295,6 +1295,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +F:	Documentation/iio/ad3552r.rst
>  F:	drivers/iio/dac/ad3552r.c
> =20
>  ANALOG DEVICES INC AD4000 DRIVER
>=20


