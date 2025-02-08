Return-Path: <linux-iio+bounces-15166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D307A2D6AB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C076188C392
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE49248174;
	Sat,  8 Feb 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTHnha+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A4182BC;
	Sat,  8 Feb 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739025718; cv=none; b=WJke2LIm9l4N8SD0TNBYrDEL1kr1l3jwvbX1G+2o9IVzj+cOa3lWyeydksOdB98/WHiqR97+3/ms0kZxfSkRmVoWvhYdCmOlYhMDzNsbUtZZVgdufRZGWgVaDb0a6GK7PD1T9ppvE4yAO68WtTayUr2G1UYCPjIdDmNJvSa5c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739025718; c=relaxed/simple;
	bh=v6O0wHCS7tYjG+Hrj1O45g6uXfFBsmmLZ1PFGkMFSak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czjDH2ZwN6Dgdu+MXzTsq2axU9RS8oyn8OOAc8TZWwk5Ck1ftrC0/1MQ8zvRTSGHekWjWh+8bJyrRUuQAotEYPr6gvehIY9Q8fIk+zq8myjGO4LzCcaL03UICASfAbwHmlyv/l+Vd2z9MkLNg3CoPP+n68etrfalK2V5CLdAHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTHnha+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742DAC4CED6;
	Sat,  8 Feb 2025 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739025717;
	bh=v6O0wHCS7tYjG+Hrj1O45g6uXfFBsmmLZ1PFGkMFSak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JTHnha+1/tR5LX550fPcj+oJG7b8wGiClq5QDHB4FSArhO4ksqF0kHAP74hhRq9DJ
	 FxJ1d2ualCmlm7gLbAkCCl5EBKDKWlJ8jFMApkBFVOVqJFf7LKBus702WZVzKWly7v
	 kcOjFSZCb90xsaQslYvpnPlunH1fANauCNwdSDMLg3I2f7odXbFcbGqtk2naDuuN+k
	 Q0MERC0Sx9/9oz2+GjhcTy+gIXbpSksol4Hw59pb9G2Fy6RmnH06uaH/2sgD4FAmwD
	 8ZyySbgywUSDBwECDlIC5dAjXQSW7fmpokplUOGxCD2oJi6oCx99xPXkgQUua5bmhT
	 sFmY5P2F7Uq4Q==
Date: Sat, 8 Feb 2025 14:41:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH v4 2/3] iio: adc: ad7191: add AD7191
Message-ID: <20250208144147.14be0d4c@jic23-huawei>
In-Reply-To: <20250203133254.313106-3-alisa.roman@analog.com>
References: <20250203133254.313106-1-alisa.roman@analog.com>
	<20250203133254.313106-3-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 15:31:27 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi,

Just one trivial additional comment from me as you'll be doing a v5
anyway.  If it had just been this I'd have tweaked it whilst applying.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..4a9e66853294
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c

> +static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)

dev isn't used, so drop that parameter.

> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_config_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return ad7191_clock_setup(st);
> +}



