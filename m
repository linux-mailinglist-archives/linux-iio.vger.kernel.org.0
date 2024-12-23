Return-Path: <linux-iio+bounces-13759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFE9FAE40
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783A1162042
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFB1A8F70;
	Mon, 23 Dec 2024 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXL48oLA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2A188A0C;
	Mon, 23 Dec 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956594; cv=none; b=jVz1XVrEkn6cHMxbSU8lA8eUfNQmmMcNEnI1KCggnkO0xmz7PJsh3aZQM15D8MuofcfQQcUFNoI63dx9ODizSNnt7Si/dVWtcuewOZGIsftIvEDJf7wF8mwW28Sspn35MU9RNIlJgbYdjeD9D9+ZlsoTTsXhsAsB8Ydvq2URVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956594; c=relaxed/simple;
	bh=3ac1dto8gjpFnedlNilVdfNKt8p3GLknSxdDr+SpZZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPmxf4SNk9SCFOcwWzKFWn45jxSE4HToyGoutHUdlYR8d9Z802p6JBci0Iw0beF5Fs6zXDoJyXfmsln/JtZBc8XERyd5bgW8nXmI12+oHhg6SRA1DHaU6M7C6toI4g/M6IrhLvziGgKgJTFcvnTd5eAsr/UeGwA2XfsvvOOzDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXL48oLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9708C4CED3;
	Mon, 23 Dec 2024 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734956593;
	bh=3ac1dto8gjpFnedlNilVdfNKt8p3GLknSxdDr+SpZZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXL48oLABheVh/kA+q8NkwScEMFH9wWcB1wAtxHxtTh5hd7eFbgs5LsIVAzjTV+Zq
	 x9A2okat3i3TjxGYp/zDjOSBWJy/uQatQHNZHI9uPyjUIH1NMA8HFEtqIpYy6iFXH6
	 QcGWz2twS7bTExR+ux7Lk+63VSpcbpfTAcst0vHe/M+HbANyJya8KEqm+CkpwEot69
	 ajhDNLRGUqFhCpL+xX8xXkhfSSpZT23kock9/Xd2dWFZtRnrj872R6Gkzq/6sPTbLw
	 BhAvEPTBdVNVdv+laKp1ewgM9uhqBrWaUTd9yWljL8ADYx+T10pjMkzlJoVNZ3NwkB
	 eKLWXg0fulpWw==
Date: Mon, 23 Dec 2024 12:23:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 6/6] docs: iio: ad4030: add documentation
Message-ID: <20241223122303.06f81eb3@jic23-huawei>
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-6-f36e55907bf5@baylibre.com>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
	<20241219-eblanc-ad4630_v1-v2-6-f36e55907bf5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 17:10:41 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new page to document how to use the ad4030 ADC driver
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  Documentation/iio/ad4030.rst | 181 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 183 insertions(+)
> 
> diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..41ce5ca5c710c46a0995d1b127fa1c10fca4c1eb
> --- /dev/null
> +++ b/Documentation/iio/ad4030.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4030 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD4030 and similar devices. The module name
> +is ``ad4030``.
> +
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD4030-24 <https://www.analog.com/AD4030-24>`_
> +* `AD4032-24 <https://www.analog.com/AD4032-24>`_

I don't see this one in the driver. It's in the bindings but
not the ID tables. Got lost somewhere or should have a fallback compatible?
A very quick glances suggests it might just be a down rated version
of AD4030-24


> +* `AD4630-16 <https://www.analog.com/AD4630-16>`_
> +* `AD4630-24 <https://www.analog.com/AD4630-24>`_
> +* `AD4632-16 <https://www.analog.com/AD4632-16>`_
> +* `AD4632-24 <https://www.analog.com/AD4632-24>`_

Other than that this looks good as do patches 3-5.

Thanks,

Jonathan



