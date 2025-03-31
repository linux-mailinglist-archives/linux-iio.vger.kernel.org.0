Return-Path: <linux-iio+bounces-17422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC4A764CE
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8237A483B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F31E1E13;
	Mon, 31 Mar 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOS8xdNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F891E1A18;
	Mon, 31 Mar 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419634; cv=none; b=ctVMjNh+866Nrw8Y+lVlUVm8vVIp4ySdK1o467zSS14LfKehN000Thgo+YIAnc/wSI5CRYA44iXzf3nj3703X+LK8AbUQMKoTRYNEDTMYhSOcstP4jthaVl3rT6poWUlqtH9k9Q3anuCC5lad2gVweWujzTNXwRPlD93BP2igm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419634; c=relaxed/simple;
	bh=3rCkGOmOkhpyde92kwpKR8IpDoKL9jWkmNM0tJmN/r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkCD5DdMOFBX5asT/Dp11qT8edY1wvSY2YEra8bDtMI1BTzjRT/sfnk9RGotmNKfmkrTvno2P4RgVdBabtTdtDafx4zwYAxUCcT36LMD3vlp7plj4Go1iTz3M5ReOTgbr2dzISf/fEmTR0k01r+ADuERR/6rPw+nbsvnkUMPAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOS8xdNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B692CC4CEE3;
	Mon, 31 Mar 2025 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743419633;
	bh=3rCkGOmOkhpyde92kwpKR8IpDoKL9jWkmNM0tJmN/r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOS8xdNqz4igVY5Qaf0VUmsfy15E3hrWl6ScN4ynzKdYWNlDvyKhQTCmK6ehsh5Z6
	 Fyj2mqxvtvLzFRazN8r+e+lBPDVqMgsk9Pf84brEYX7v1o68hhDHLUIKqsKM//XId+
	 hIlqJX+2lBc8UB70aPij+SF3Hn8JQsoyhsXrmOzl5p0bZB3q3M6kfFyPdf7Yfl7o0y
	 WqjHMkl1buseU/KFXi1ip2wb+RNw8rMjsG34HlRZFbXl5Ym1p0zjJ8cRwbAuHddvhA
	 3v0zZ/fOcLChkURvTnhr5RL96pPR3cyBGjKU08glUHiUxiQXXOMtUV7zOoj0N8dGD1
	 xqTWEdLUCg+Uw==
Date: Mon, 31 Mar 2025 12:13:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: adc: ti-adc128s052: Use devm_mutex_init()
Message-ID: <20250331121344.0d4af6a7@jic23-huawei>
In-Reply-To: <c424b2c234fb82faf40a7832dc410e0178a3a8fd.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<c424b2c234fb82faf40a7832dc410e0178a3a8fd.1742474322.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:03:30 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Quoting Jonathan:
> "Whilst it doesn't bring huge advantage, now we have devm_mutex_init()
> it seems reasonable to use it and maybe catch a use after free for the
> lock"
> 
> Switch to use devm_mutex_init() while working on this file.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index dd1e405bf172..90b23c68daea 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -172,7 +172,7 @@ static int adc128_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	mutex_init(&adc->lock);
> +	devm_mutex_init(&spi->dev, &adc->lock);
	ret = devm_mutex_init(&spi->dev, &adc->lock);
	if (ret)
		return ret;

>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }


