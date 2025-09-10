Return-Path: <linux-iio+bounces-23959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1984DB5201B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E985444E9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5ED23D7E6;
	Wed, 10 Sep 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMSZDK4Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCB3C17;
	Wed, 10 Sep 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528131; cv=none; b=WOkbY2XplGSIHu2/vKBP/28nT+Drr4iUrv0E3ox4oatdhJsKy8cT5PAsqYKb3Ji89OINCsmJ8jVTV7tulumH0urvjFBWGa2yZ66PWictmfm+JyogvJ9vp/rvSeSGb7hUKVZQ0gJZprj/ZbsEvU3JuT9h931YNuOm/J00tjx3Yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528131; c=relaxed/simple;
	bh=RaWXN2G0EWbsO+tbl19p9lPiGcIAv2XyHKhKHF1ECSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXWj1W9GIVGrupnmW5c3tGbW9DtP9Oxvgw5co7VqXj/vfcwKWCJaF+44ydZ/L+dV6ta8BHUB92PpG14uXlMqhQU7s94BVSW8nnOuMpGuS8ZBGT915Hwf5sfrVmkt9MWVDFmd2XucW7z0OorSQKl5yNgppa18uELemVAikTqkjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMSZDK4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E72C4CEFA;
	Wed, 10 Sep 2025 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528130;
	bh=RaWXN2G0EWbsO+tbl19p9lPiGcIAv2XyHKhKHF1ECSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMSZDK4Y7MdCD/nxkqNbzZiTYFk64l4o2rGcVkUTyXExUvn5FvzmIy6J48B5N2NVD
	 53g1XXbkgy+gBVTehdNb02bLByU93VSZjDsFA/d2feP8d6c4PvBkKOFZE8rcsW/okG
	 xy5foDXoqOsXkZVdzK8EndlGKvMzu0MJ1/fZ+s/B3RBA7UlH0HQ98S8lgNenVBubqd
	 mH8mBNSDWLLLNibLvhePuMpu6beOh8dAObJ64e6RlX6/bOlWsePsVO7sP7Ai6FzkGe
	 xFwr0loUO8lnJxy6go3NWRCpGkYR/Hkp1MShqo12MvaQ7i8ZxrZ9qFBR6av6ulEESM
	 Dl4iIowVjLWRg==
Date: Wed, 10 Sep 2025 19:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] iio: accel: bma220: add interrupt trigger
Message-ID: <20250910191520.69d2427e@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-11-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-11-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:16 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add interrupt trigger.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

One small thing inline,

Thanks,

Jonathan


>  static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  {
>  	int ret;
> @@ -418,6 +437,25 @@ static void bma220_deinit(void *data_ptr)
>  			 ERR_PTR(ret));
>  }
>  
> +static irqreturn_t bma220_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int rv;
> +	u8 bma220_reg_if[2];
> +
> +	guard(mutex)(&data->lock);
> +	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
> +			      sizeof(bma220_reg_if));

Given SPI needs DMA safe buffers and theory at least regmap could
have optimizations that don't bounce data in bulk accesses, please
use a DMA safe buffer here.  Put one at the end of iio_priv().
Can share a cacheline with the scan.

> +	if (rv)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if[1]))
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}



