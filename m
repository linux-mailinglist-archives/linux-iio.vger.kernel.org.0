Return-Path: <linux-iio+bounces-799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2880BB1A
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6234B280E2F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6BD2E6;
	Sun, 10 Dec 2023 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+u5501+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA4C12A;
	Sun, 10 Dec 2023 13:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE144C433C8;
	Sun, 10 Dec 2023 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702215552;
	bh=avQGx1khJq85b1wqGdR8Nraqua+bOgRavFBFOL0oL0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c+u5501+Z7AkUNDfgRWa6dbaByLXiqMukJRuFtnLzBvS69MfOyQRkAM+xGjeeWelk
	 S9Bx5gJ1HA+LuhPzWiJ9bcUCmR1ep71GdfXK06Q+MxJOwYdmXkp3MD4EwrsPdGOVta
	 Uhk4ETWGtDWRX9GFuuArs7uHGE1OJXTsBVEQMMTEhqf6RKXFGrOQb1hSHBWeJn94ZN
	 D2VePs2y/Dd6igp1wBhV1B/9CyDadpTyRYncVay7PE8VUSLipEYo7OCsw4W1WqiJ/w
	 1NCHHH7kXT14eHmCRyifkEqcHda3VrRqe+1CuPqSIXm1+DJ8CIRQMQCJ1izU1UbO1l
	 4thf5+f1Ee2Tg==
Date: Sun, 10 Dec 2023 13:39:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <20231210133906.3050a145@jic23-huawei>
In-Reply-To: <20231208102211.413019-2-anshulusr@gmail.com>
References: <20231208102211.413019-1-anshulusr@gmail.com>
	<20231208102211.413019-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 15:52:10 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Implements driver for the Ambient/UV Light sensor LTR390.
> The driver exposes two ways of getting sensor readings:
>   1. Raw UV Counts directly from the sensor
>   2. The computed UV Index value with a percision of 2 decimal places
> 
> [NOTE] Ambient light sensing has not been implemented yet.
> 
> Driver tested on RPi Zero 2W
> 
> Datasheet: https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

I fixed up the case where you use dev_err_probe() in a path called from
places other than the probe() callback.

Applied to the togreg branch of iio.git and initially pushed out as testing for 0-day
to take a look and see if it can find things we missed

Thanks,

Jonathan


> +
> +static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +	u8 recieve_buffer[3];
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
> +			       sizeof(recieve_buffer));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
dev_err_probe() is only intended for use in probe() and functions that are
only called from probe()
> +				     "failed to read measurement data");
> +
> +	return get_unaligned_le24(recieve_buffer);
> +}


