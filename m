Return-Path: <linux-iio+bounces-23957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F63B51FA8
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BC11896BD9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F633438E;
	Wed, 10 Sep 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktShncOj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07F1E3DD7;
	Wed, 10 Sep 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527322; cv=none; b=Mo2NsPDmaj0n/Px1Gd/hzQytJCW8/+oS2CJVhcdRcUrdBYEG68HbN1Ckzfk4SjKcA+lpn8iSgok92GjEtRp/RWR/6w/hPPLsQ7hXiFdayHIhQaebvxtREzvZM8UTWxvaggwGgGZ9zzWIraalstObXz9Al5sZSrOinul+jbXYu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527322; c=relaxed/simple;
	bh=kvm3hMWUOuOY5DDurnpAR7I7+H/TSB9Py1JhO6s39sI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmrvxQVRZqW+a0xPf8Bwu4V+M6Tz5kEo69mX1iPP7vKiCcoxgP3EArLgczPGJv+89D/K8as/x2uNSeN6emPaAeu4LbKMrjauOc675vdhxlvpb9VDtad9yFEHR9pbrCcHu1DFubeelyYilGsrH2zzwcvRASJaZUiX9G6kkJ8A/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktShncOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31119C4CEEB;
	Wed, 10 Sep 2025 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527322;
	bh=kvm3hMWUOuOY5DDurnpAR7I7+H/TSB9Py1JhO6s39sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ktShncOjjXHrEH8T3TSP60lZseKI6FNbJwRx2l+jx+dHM7kL2LQGF/ry9Z/YL4dKq
	 t7lFOikwEg20ZS8e2ZbYkMw2j3j5HjuVv7I6msm92UPB9cgizQMotd3U3tgtM2P5fS
	 TavlyzNdXNHtRZ3Noe0NLdfTWW/7pdDYju1L2vWb9g+5bAQQ7lRmse9HKjJBBuzrzD
	 b28PSi5lxaMmAo4o26CVRgWoncQU8MeTcUAAO33MNaS2C65AvaY0j68xmx0timeALr
	 5zdVtsQVkudAPBiy+6Ra7JFJm6MP9Ub8Q6zdkNznajisf/K5AAyNP7q3CQZoN6MIEw
	 U3mc8UHAjsjNg==
Date: Wed, 10 Sep 2025 19:01:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during
 init stage
Message-ID: <20250910190154.0c5ab461@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:12 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Bring all configuration registers to default values during device probe().
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre

One comment on code you happened to be moving.  The patch itself looks good
to me so this is a 'whilst we are here' type comment, though should be addressed
in a separate patch.

thanks,

Jonathan

> +static int bma220_init(struct spi_device *spi)
> +{
> +	int ret;
> +	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> +
> +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
> +
> +	ret = bma220_read_reg(spi, BMA220_REG_ID);
> +	if (ret != BMA220_CHIP_ID)
> +		return -ENODEV;

Not relevant to this patch as such, but we should relax this constraint so that
fallback compatibles work in device tree.  Convention is to just print a
dev_info() message if we get a wrong ID and carry on.

> +
> +	/* Make sure the chip is powered on and config registers are reset */
> +	ret = bma220_power(spi, true);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to power-on chip\n");
> +
> +	ret = bma220_reset(spi, true);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to soft reset chip\n");
> +
> +	return 0;
> +}


