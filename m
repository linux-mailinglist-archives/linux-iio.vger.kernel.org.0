Return-Path: <linux-iio+bounces-18024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56256A86E88
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578BA440565
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4A205513;
	Sat, 12 Apr 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC52n3cV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899619CD1E;
	Sat, 12 Apr 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744480936; cv=none; b=t9XNzBgUGB1dPjiOGaQjr/7fGagZ2XhhHh/o4UuKVr+RPZr8TkR2lf/RVGidQV4ITWM8kcJ7iSbBvdp9fNYcVEOjqh3gwWx744m/z4IoPiQEVZdRJbmv0fAbeCjyrRBF3sxv9Sn1g+Q1aeYZN8VaO+hB6lyote8WYoXXve2yS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744480936; c=relaxed/simple;
	bh=hVTDMIQCxS+GFFPwVJ64C7rwJD3SSWBVHTshL/ti+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjhSx0yl2Pqbtomq2bVqKDcugq0fLTo5+J1NBI4yXpWdgaHmy20LOpTS7L1qmV93jCE2Vpky7feG04vfeoVBKfizAGV9MQS62J67YOrK1dx/IK5+/ZWYvDPMI0M2hxFaSaqmjZhTMVUtYFgXyOQ5SIoutyet55V8g6T6xXdl16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC52n3cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36EEC4CEE3;
	Sat, 12 Apr 2025 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744480934;
	bh=hVTDMIQCxS+GFFPwVJ64C7rwJD3SSWBVHTshL/ti+yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MC52n3cVhNZSo5YbXsIDApqtwYc4to0SIljaG+21SS56q0dOvMQWqzC6boyzfu12E
	 2n7N6j8xIxaywBWiz85bqC4Py/4QWJu6rJdrZQZgwZG/JKI1LmS4nuPIetv/DziCw0
	 7ixhILBHo6rivvW31gEu6di3AEgzr6dRTidIpjL9p8Hyz3hGZ74L2ruym+UY/xBFNw
	 q/7tjJqR7EX9+a5nQRWBCsDpeRKIL3f8B3fUgzq0htdxJ3XdM4j0GimDMNXz+kCB8R
	 ndCUQgHsaGTuxOi+XHGGjHlAMo910vWjStMlVCl2RkEeODqlLAhSunJXHHYy0k83hI
	 DYyRIxMyLwd0A==
Date: Sat, 12 Apr 2025 19:02:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v5 08/14] iio: adc: ad7768-1: add regulator to control
 VCM output
Message-ID: <20250412190203.731aa10d@jic23-huawei>
In-Reply-To: <7753dcd690f07f855100fc28e7b8ae746082de1c.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
	<7753dcd690f07f855100fc28e7b8ae746082de1c.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:57:42 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Just one question from me inline.

> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 66087fabe181..13d17a13b6ea 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c

> +static const struct regulator_desc vcm_desc = {
> +	.name = "ad7768-1-vcm",
> +	.of_match = of_match_ptr("vcm-output"),
> +	.regulators_node = of_match_ptr("regulators"),
I see this use of of_match_ptr() is common but not universal in regulator
drivers.  Any idea if it really is just to save a string or if there
some more fundamental reason to make these go away when device
tree support is not built?

We spent a while getting other uses of this out of IIO so  I'd like to know
more about this one!

Jonathan

> +	.n_voltages = ARRAY_SIZE(vcm_voltage_table),
> +	.volt_table = vcm_voltage_table,
> +	.ops = &vcm_regulator_ops,
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +};

