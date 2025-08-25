Return-Path: <linux-iio+bounces-23218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BBB33E26
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113303A8211
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F92EA756;
	Mon, 25 Aug 2025 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvDuF3H6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363A2E63C;
	Mon, 25 Aug 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121723; cv=none; b=ddxoP9dPvs+Q1buK4XMeuqp2nR3ZmC+Rr1hN9jO1dHtWHpYbENP5xZINGFfv1KJWmSjdAbVwH5AYA3bbqaAj3meDSGeXucIQ41WchSpvO7iB6GVa+25WL5iuBoRdJA2DAe40vZ2UxreXlAnaQrDJWuNI5xpyuyJITnAdYcKCO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121723; c=relaxed/simple;
	bh=G/61tsIfBpP7VYIx9gVTeDZEHhYHjn2CEFnLTjnYXG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ko76YTeBt2nxnTiVMN4burrOSg0b1YV9TJrjSnaJq+bpWaHkh42kkKYNJP/bpfAgjrJd67FYCdrgdHRZIqduSWvDFIoJA0mRAq+x37KtuLOfpee9uKl4DsDTrEd8owhauzClyESIFw1HdpBnLZDFyzoZ/KdmP8oi+cs3t7rAOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvDuF3H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C408C4CEED;
	Mon, 25 Aug 2025 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121723;
	bh=G/61tsIfBpP7VYIx9gVTeDZEHhYHjn2CEFnLTjnYXG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvDuF3H6+1NBwrq7nZs/ZMfcyEsTv0fFs/ZGXeBCsb37uLyju05gFfzD//QLGlI6k
	 dN5TLXERIujUDB7a11P+FR9WpiDdaT+rdNC/SxeiC8E7q7ZJMOs2SnNRalD5wq4oJ2
	 GfD60mM6gf3O35IKU0qXi+39/nFXFqF8KObK26Ms4aLRiDkSe1wrjXfTrbuWuCfnQF
	 yhK5zdjN+hHyKEHEChellx6Y+VKnIvrQIJaO5OifVqw+Y/TFH5PW2vPHSdLcbUUCXN
	 xmwaU56ZZ3e7t5NnKD4P8uVz4EJuGe63faWTe5HhcnmpxjyDyMjVu4CgFnsTHSgFuh
	 RIHHXiOP8pK0g==
Date: Mon, 25 Aug 2025 12:35:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Ray
 Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen
 <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andreas Klinger <ak@it-klinger.de>, Crt
 Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 04/10] iio: health: Drop unnecessary -ENOMEM messages
Message-ID: <20250825123508.7f9e9271@jic23-huawei>
In-Reply-To: <20250822-enomam_logs-v1-4-db87f2974552@gmail.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
	<20250822-enomam_logs-v1-4-db87f2974552@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:19:52 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
Some code movement in here so I had applied the equivalent.

J
> ---
>  drivers/iio/health/afe4403.c | 4 +---
>  drivers/iio/health/afe4404.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 1582cfc03579..8e5db2235de0 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -531,10 +531,8 @@ static int afe4403_probe(struct spi_device *spi)
>  						   "%s-dev%d",
>  						   indio_dev->name,
>  						   iio_device_id(indio_dev));
> -		if (!afe->trig) {
> -			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> +		if (!afe->trig)
>  			return -ENOMEM;
> -		}
>  
>  		iio_trigger_set_drvdata(afe->trig, indio_dev);
>  
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 99ff68aed27c..11a0f465fd68 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -538,10 +538,8 @@ static int afe4404_probe(struct i2c_client *client)
>  						   "%s-dev%d",
>  						   indio_dev->name,
>  						   iio_device_id(indio_dev));
> -		if (!afe->trig) {
> -			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> +		if (!afe->trig)
>  			return -ENOMEM;
> -		}
>  
>  		iio_trigger_set_drvdata(afe->trig, indio_dev);
>  
> 


