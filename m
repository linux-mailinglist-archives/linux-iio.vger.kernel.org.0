Return-Path: <linux-iio+bounces-23246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1DDB34473
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033171882771
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617FE2FB61D;
	Mon, 25 Aug 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7NvvyM6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5A23ABBE;
	Mon, 25 Aug 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133254; cv=none; b=Ufp2Wfs5RAmKENGSujpC5MP93zvhfVhzhoOStY7b6V+oyPsi2iUyh+AehQoM7MqrxCE9n58UbmS7FOTdUwBis7ZhqQEP/Xuh2wTz0TSxUDnRvw37a1d79AsApVdKDpKdfJj8c3543Xn4T6IgOmkeLY+HUNbXASCuaNRe7YHmsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133254; c=relaxed/simple;
	bh=Rxbs9p9UUi4Oga7hFBAGxbsLCRu7q5IO0hgDjC0xm1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmIzOthg+QO8k0OspVi9QeF+SNhUv3ObUD28UqGq0lnLERMd9szpOlyTB+VpmLPUAZaynY+Cdg7gt/cieBSmTo6mhOqAHutg5N8LH0kJTBmKYKZSemcsJyXtX2LD6bvWcP3ILibaZB7Synx3WY3zF636P3cCGhH/P7siafLbHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7NvvyM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC2C4CEED;
	Mon, 25 Aug 2025 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133253;
	bh=Rxbs9p9UUi4Oga7hFBAGxbsLCRu7q5IO0hgDjC0xm1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d7NvvyM60yyVz5ADaJ/PU7M0ob9W5Jem1CUdFE/dsMJRsLz+9DbmJ/rIPrPmeX+mR
	 ee736R+Yp3t+MCevbCHiSRiXQeGYey65c3IFw4niK96/dgsc8Gk1pTUXJMIy1nv+gQ
	 R99WMswWvnzSQd+bmasa88E0BEh+yaaWtUwCgBeggtvbhzneFtPx+VwjgI8SG4dYTa
	 zJLi+IQ2EYBQaYnwQG9t0hXuGCAwf3b9CssZ4zFukVI9mxrP16lgEXeRdJA2mcI44X
	 jU7Sjj7DjBJ9y0jTcWCfWaTc859vbrkT0tVoM+6EfcOwZM/upg0FNg8vlXwIltJ8Xp
	 B7Rh9yYKHUo6Q==
Date: Mon, 25 Aug 2025 15:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] iio: adc: update ad7779 to use IIO backend
Message-ID: <20250825154723.2ba512d0@jic23-huawei>
In-Reply-To: <20250825105121.19848-5-Ioana.Risteiu@analog.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
	<20250825105121.19848-5-Ioana.Risteiu@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 13:51:19 +0300
Ioana Risteiu <Ioana.Risteiu@analog.com> wrote:

> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
> changes in v5:
>  - fix indentation 
>  - change num_lanes variable from int to u32 type
>  - use unsigned int in for loop declaration
>  drivers/iio/adc/ad7779.c | 115 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index b4e56983201c..3776af1c65e9 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -25,6 +25,7 @@
>  #include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -116,6 +117,12 @@
>  #define AD7779_CRC8_POLY			0x07
>  DECLARE_CRC8_TABLE(ad7779_crc8_table);
>  
> +enum ad7779_data_lines {
> +	AD7779_1LINE = 1,
> +	AD7779_2LINES = 2,
> +	AD7779_4LINES = 4,

Probably crossed with the review I did earlier.
This enum doesn't add anything that I can see over just using the value inline.
If anything it hurts readability.

> +};

> +static int ad7779_set_data_lines(struct iio_dev *indio_dev, u32 num_lanes)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (num_lanes != AD7779_1LINE &&
> +		num_lanes != AD7779_2LINES &&
> +		num_lanes != AD7779_4LINES)
> +		return -EINVAL;
	if (num_lanes != 4 && num_lanes != 2 && num_lanes != 1)
is much clearer to my eyes without the macros.



