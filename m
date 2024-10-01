Return-Path: <linux-iio+bounces-9973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43198C5FD
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E71C23ABC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DB1CCEDD;
	Tue,  1 Oct 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxfQMjzF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2091B5820;
	Tue,  1 Oct 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810680; cv=none; b=tU9I/H0Di1bHH+KMeYd1yYo8jIAVjZUsCIr07JRPcYviWIIhsEzxfCdo/RydYNmdj0WVC2i7AjozEFrheFxbxwOtV8clDEOBULRmjf5wq32srCqib8jEIBlYHkE/6vdl25p7CPVTcoAQpXdsVzOvCVaOGBnKXnwBiqUlVrPOAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810680; c=relaxed/simple;
	bh=2X6COEEOr+jQyAqWmgKhGt8pGYVzeO/1tIoyLG/hPus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAfBxP+GwH029NVJrv83QIyrk7491jhwc1uPBCCmmu8gMrcS4q+M9CR/dWOJ8nRurUQeq093ExyKlI7H/C3e1RzVCm6am4HJ+xyUOYCO4oBZnoA2pakLC1mrCtS7nQB3BWtV4v2qkWBVnQ+mYyPWIrcS5y7aL8VRAwZPG6/oWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxfQMjzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFFEC4CEC6;
	Tue,  1 Oct 2024 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727810680;
	bh=2X6COEEOr+jQyAqWmgKhGt8pGYVzeO/1tIoyLG/hPus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HxfQMjzF7p9u6ffk7JTB1+zy24/+jFdHfndGwus1/rFoBojxk6fZKf7t7k7k9VmsF
	 FdN1E6QcdvlWnxvhVH9j6xvJw810jwRmJb2fbO3eskmRVOYBEj1Tq7krZjNp+zBtn9
	 P/KEZR5is9gAlnXSG6T+D6QC3Hxr9QWh5WjN30o47wnZlOGkI02B27g9hIxTy7OsUp
	 TBrhF04rJfi1im0ec6Hb5nwzkBmwMA4OpfWOkOJGzwfmXNQj9UFGDpLOMhAy8vc+tx
	 px0MbdZkOYiwmJ16CNiO4ZQUQXn6+rpiPxtrfjTmwnN92TWzAjR4lQ9Zoiw705XJ+g
	 4qkpXYIVA9QeA==
Date: Tue, 1 Oct 2024 20:24:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Ian Ray <ian.ray@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Message-ID: <20241001202430.19bfc666@jic23-huawei>
In-Reply-To: <20241001074618.350785-4-herve.codina@bootlin.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-4-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:46:17 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> (voltage and current), 16-Bit ADC with an I2C Interface.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Just one thing to add to David's review.

I'm going to guess this isn't a general purpose ADC? Can you share any info
on what sort of device it is used in?

No problem if not - I'm just curious as I've not seen GE HealthCare I2C parts
before!

> diff --git a/drivers/iio/adc/gehc-pmc-adc.c b/drivers/iio/adc/gehc-pmc-adc.c
> new file mode 100644
> index 000000000000..c46c2fb84d35
> --- /dev/null
> +++ b/drivers/iio/adc/gehc-pmc-adc.c
> @@ -0,0 +1,233 @@


> +
> +static int pmc_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pmc_adc *pmc_adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pmc_adc_read_raw_ch(pmc_adc, chan->address, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1; /* Raw values are directly read in mV or mA */

Drop this scale and make the channels processed. That saves userspace even applying
the *1 this indicates.  Rare to find a device that outputs in our base units
but might as well take advantage of one that does :)

> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

