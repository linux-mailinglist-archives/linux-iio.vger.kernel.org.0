Return-Path: <linux-iio+bounces-17656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37523A7CD70
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7B61890AAC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7919EED3;
	Sun,  6 Apr 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PScU6WIa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85B2E62A3;
	Sun,  6 Apr 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931217; cv=none; b=THvtN1iAZZ/skT1pcJCLqxCoMQz5rcONyOT2dXyFrj2wDy5cWs96FQeVsBD82oo4Y+5O+uVNXc85fblPWw19GunaOkDhJ06sAHhZr1ev35GfmmkLqiFTmdqw+IfhKaUrFO2ssL+8V5b8ClhkMIg3inRfwg2m1uszEkLjUMSN7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931217; c=relaxed/simple;
	bh=+Xi0wvd8YJiX9gXZtcQ8e0NOX+GT/jiQzN6sl847BHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aba0xxp/07uagouJG8Bwf6hTcq3+hmMQlO+8UioaIDl1yvQ3vAjlVAzQg78wKu+6K5/6ofip9NJXhF1x0rMvpjUN7SP+UDLqHH7OmYa4TNMEmLm+NVowoBgKi5NbN+67FT3oi2wBYy0sDK443ti/a2JygzTg0kwouwwA5tITMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PScU6WIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1C3C4CEE3;
	Sun,  6 Apr 2025 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743931216;
	bh=+Xi0wvd8YJiX9gXZtcQ8e0NOX+GT/jiQzN6sl847BHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PScU6WIaVXgxLaF7OqMGcsJFDC4uqMk1q6WUgm5msoyCo3NBrcPS3BX6BdrYk8yIs
	 5xLWSScWJdpPDBJKJAsjNlG3tlgrEjLsvo4J+JTtdgsZUnigVcAeW9d84d+A6QNM/d
	 xsyo9jKT1Po7S4JiHgowt6vJWszOJ4yszQ+rSYUkanHZ2CvIt+1Pju9u7xoWucLNuX
	 DaTjDhFuPJbRoUoNQ7yaBu3HXf+3V+ZnGhUwgwBRQAf1P1iAJMd3/1seTMQbYSfFDN
	 LkzWzWJE8H9KpQNvrXpNn4n3eaQkymDQoypJApUiC1/5y3qFhR5dAMOrdYHX00sbUS
	 dZv59vqi7ceag==
Date: Sun, 6 Apr 2025 10:20:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: dac: ad3552r-hs: add support for internal
 ramp
Message-ID: <20250406102008.0ebcbf9e@jic23-huawei>
In-Reply-To: <20250331-wip-bl-ad3552r-fixes-v2-5-cdedb430497e@baylibre.com>
References: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
	<20250331-wip-bl-ad3552r-fixes-v2-5-cdedb430497e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 21:02:48 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

A couple of really minor things inline.

> ---
>  drivers/iio/dac/ad3552r-hs.c | 122 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 116 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 37397e188f225a8099745ec03f7c604da76960b1..d4f50b33565f99b90859e30571dc59038d01361c 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/backend.h>
> @@ -54,8 +55,12 @@ struct ad3552r_hs_state {
>  	struct ad3552r_hs_platform_data *data;
>  	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
>  	u32 config_d;
> +	struct mutex lock;

Minor thing but all locks need comments.  What data is this lock protecting?

>  };
...

>  static int ad3552r_hs_probe(struct platform_device *pdev)
>  {
>  	struct ad3552r_hs_state *st;
> @@ -705,7 +806,16 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return devm_iio_device_register(&pdev->dev, indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
For new code, I'd prefer

	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

Brings only a small advantage, but give the complexity cost is also small
we might as well use it!

> +
> +	ad3552r_hs_debugfs_init(indio_dev);
> +
> +	return ret;
> +
>  }
>  
>  static const struct of_device_id ad3552r_hs_of_id[] = {
> 


