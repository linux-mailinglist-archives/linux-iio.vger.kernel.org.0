Return-Path: <linux-iio+bounces-13488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4889F23A0
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA852165A02
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0417B50F;
	Sun, 15 Dec 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf270ICS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61151119A;
	Sun, 15 Dec 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264769; cv=none; b=AmogKU2EjM1lrF3YsuRfMvQTVsKZu6ePPlrL3zVuY4j1gXwwm3l44B09j9J01udEJJLeg6EdEZ2Pypc2X2hEEZD4veNv6g6brFaw90Gx5qHcsC7qM9oywkh4EnEC6jTkrp3q25xGfkxGjmySWK5FzEfj78wLgNLBq12/mdd82Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264769; c=relaxed/simple;
	bh=y4YVhyoN2ufUxLJzDHKA4NzFIiBoIAH7gqZ1QytFXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPoceMxIN+YKRREH0sdmuzr9n8P8nqFz+95IffBrwJrYczHFOpWdFR+xQQRtio16vDsohK5vEHY/90b4aX/nlJmSJNBTGJ0wotOC7nl0iFtYnt+Ptjf0S/lyLhSgj23SIapnAUJWGL1nFLEm0zy2CEVlgr0a1Wja5yVF0KEhl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf270ICS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33016C4CECE;
	Sun, 15 Dec 2024 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734264768;
	bh=y4YVhyoN2ufUxLJzDHKA4NzFIiBoIAH7gqZ1QytFXeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kf270ICS26nWHeMdTOBTZw3tw9so5/jfEv4z8Ygl3BPtp4ynXvFqvVes7enArqUbM
	 CM23ETLuqcXqpkZoIfw1S9QTbooTM7UfUnmOPWFU89kRvj4Cg5G/9XOTl3c0zPL0z/
	 eJ8w0/zkXKQvKpDl5ByRObPgeyaEEWnN5/hSXCL6YpIj1jU3i+nmor/lzNeOFm6ZKN
	 DeONHIAe2wVsWCEFYfzIU9q1tfDxStYMc0TathjI71W1jIzV9HiOyuINK9GLTkrsKi
	 MKRlb4gajZjyNy34oQRIFpcXEZutKW/ggIYCnJO7pQ1O1kQHswxp4u6wCAHYttHl2X
	 wBRqXIEBjIjKw==
Date: Sun, 15 Dec 2024 12:12:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH v2 9/9] iio: adc: ad7606: Add support for writing
 registers when using backend
Message-ID: <20241215121239.10a29743@jic23-huawei>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-9-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
	<20241210-ad7606_add_iio_backend_software_mode-v2-9-6619c3e50d81@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:46:49 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Adds the logic for effectively enabling the software mode for the
> iio-backend, i.e enabling the software mode channel configuration and
> implementing the register writing functions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Hi Guillaume,

Main thing in here is really about not adding more cases of
iio_device_claim_direct_scoped() given the problems we are having with it
and lack of a clean replacement.

My current thinking is that it's just not worth the pain of weird
compiler quirks etc and readability issues (even though I for one have
gotten used to that bit!)

Jonathan

> ---
>  drivers/iio/adc/ad7606.h     | 15 ++++++++++++
>  drivers/iio/adc/ad7606_par.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index ada8065fba4e..9da39c2d5d53 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -96,6 +96,21 @@
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
>  		0, 0, 16)
>  
> +#define AD7606_BI_SW_CHANNEL(num)			\
> +	AD760X_CHANNEL(num,				\
> +		/* mask separate */			\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		/* mask type */				\
> +		0,					\
> +		/* mask all */				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		/* mask separate available */		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		/* mask all available */		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		16)
> +
>  struct ad7606_state;
>  
>  typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index 64733b607aa8..c159cd4f7802 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -13,12 +13,14 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>

Why the addition of this?  If it was simply missing previously spin a
separate patch.

>  #include <linux/types.h>
>  
>  #include <linux/iio/backend.h>
>  #include <linux/iio/iio.h>
>  
>  #include "ad7606.h"
> +#include "ad7606_bi.h"
>  
>  static const struct iio_chan_spec ad7606b_bi_channels[] = {
>  	AD7606_BI_CHANNEL(0),
> @@ -31,6 +33,17 @@ static const struct iio_chan_spec ad7606b_bi_channels[] = {
>  	AD7606_BI_CHANNEL(7),
>  };
>  
> +static const struct iio_chan_spec ad7606b_bi_sw_channels[] = {
> +	AD7606_BI_SW_CHANNEL(0),
> +	AD7606_BI_SW_CHANNEL(1),
> +	AD7606_BI_SW_CHANNEL(2),
> +	AD7606_BI_SW_CHANNEL(3),
> +	AD7606_BI_SW_CHANNEL(4),
> +	AD7606_BI_SW_CHANNEL(5),
> +	AD7606_BI_SW_CHANNEL(6),
> +	AD7606_BI_SW_CHANNEL(7),
> +};
> +
>  static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -86,9 +99,52 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>  	return 0;
>  }
>  
> +static int ad7606_bi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
As below. Let's go back to
	ret = iio_device_claim_direct_mode(indio-dev)
	if (ret)
		return ret;

	ret = ....

	iio_device_release_direct_mode()
	if (ret < 0)
		return ret;

	return val;
> +		ret = pdata->bus_reg_read(st->back,
> +					addr,
> +					&val);
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	return val;
> +}
> +
> +static int ad7606_bi_reg_write(struct iio_dev *indio_dev,
> +			       unsigned int addr,
> +			       unsigned int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +	ret = pdata->bus_reg_write(st->back,
Quite a few things wrong with indentation here.

Also a small request.   Don't use iio_device_claim_direct_scoped.
It's proved a PITA for all sorts of reasons so one of my possible projects
for when I get bored is to look at just how bad it would be to rip it out.

One of those things that seems cool and useful but turns out it's not worth it.

Jonathan


> +					addr,
> +					val);
> +	}
> +	return ret;
> +}


