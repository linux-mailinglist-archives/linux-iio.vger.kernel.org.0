Return-Path: <linux-iio+bounces-19896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B11AC350E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACE2189378C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09181F4615;
	Sun, 25 May 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/dv+asP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FC28EA
	for <linux-iio@vger.kernel.org>; Sun, 25 May 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182171; cv=none; b=Y8lbIBeweuREkBCPTZxJrumDe9grcrmrZ7FSKpBG8ff4tM4DAosen6Y83NjCppBimjcUKknARR2GFcJbwHH3+RLqvR+lF06x6iLQ2mOvK7RSPlnpuoF0flylukO3gCzN/nfeSSE7eenxLJ6lI+kY2ekpoKVlepH3TgTC3F7qfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182171; c=relaxed/simple;
	bh=mkhtnHnRo0KSw0Dgb8PHBeI8y13SWbNqqKn0ueyZ+0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2NwAFacxUGEIJ2Hng4COciSlKS27fMXk3IQYqRuSZ2CCH0VIWHzgL+12FW/mXAUJN2peBuHtRYU9AznGddLH7VCBK0x4N5bQYKOqAUmybc+0R38JFJDeZ93b+BwttRqifj+Yt3ba38n8ozNw9xU4MIeNWLzpl6GrWeBrt4KGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/dv+asP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCA1C4CEEA;
	Sun, 25 May 2025 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182170;
	bh=mkhtnHnRo0KSw0Dgb8PHBeI8y13SWbNqqKn0ueyZ+0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A/dv+asP8x/KfU4d97l8YzitoZpZa4DQmrfewmnOr5Tc76Hp7bh0Qp+kO2VfYewt0
	 f1GY55ASK92Fh/qDyUG9UF/Edx6yOxvX1ffNmPVoOBjFA9UdOUJZnKzq56f1ajVaqV
	 4C13xGbk3tJAGa9ma/s/byizuJZYw2jf8gVV8SrSf+3S3jGKQi1cyO4ziZnVyHVxMV
	 o+gOi/uYEVrvG+LpZnd4QRW+QkWKdzftibAoZPxMhewaYiXm3QSiwPf1NPiBqTxAbc
	 QwjPCwAekDSUjiU+WxSZfaY3VDZxyHaJFrWG0g0y6PoYASOZwdkSIe1L1XqK7XRfxn
	 quIldXFPZ4B+A==
Date: Sun, 25 May 2025 15:09:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
Cc: linux-iio@vger.kernel.org, Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: Re: [PATCH v3] iio: adc: Modernize single regulartor call
Message-ID: <20250525150925.727aa0ad@jic23-huawei>
In-Reply-To: <20250521185807.139828-1-gabrielfsouza.araujo@gmail.com>
References: <20250521185807.139828-1-gabrielfsouza.araujo@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 15:54:03 -0300
Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com> wrote:

> Replace a single instance of legacy regulator with devm_regulator_get_enable().
> This change improves code clarity and aligns with modern kernel APIs.
Typo in patch title (regulator)

> 
> Signed-off-by: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
> Co-developed-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>

Getting better, but you need to do a little more reading on how device managed
cleanup works.

Jonathan

> ---
> The first version [1] did not compile due to incorrect use of pointers and improper
> parameterization of the devm_regulator_get_enable() function. 
> These issues have been fixed, and the code now compiles successfully.
> Additionally, version two [2] had an incomplete patch, which has also 
> been addressed in this version.
> 
> [1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/
> [2] https://lore.kernel.org/linux-iio/20250514185239.10078-1-gabrielfsouza.araujo@gmail.com/
> 
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 31f88cf7f7f1..a37ba6fad146 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -911,11 +911,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  	adc->map = map;
>  
>  	/* Bring up regulator */
> -	adc->vref = devm_regulator_get(dev, "xoadc-ref");
> -	if (IS_ERR(adc->vref))
> -		return dev_err_probe(dev, PTR_ERR(adc->vref),
> -				     "failed to get XOADC VREF regulator\n");
> -	ret = regulator_enable(adc->vref);
> +	ret = devm_regulator_get_enable(dev, "xoadc-ref");

Have a read up on what this is doing.   Hint, it is both about simplifying error
paths and about simplifying remove paths - you only deal with changes needed
for the error path here.

>  	if (ret) {
>  		dev_err(dev, "failed to enable XOADC VREF regulator\n");
>  		return ret;
> @@ -925,7 +921,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
>  	if (ret) {
>  		dev_err(dev, "unable to request IRQ\n");

Consider a follow up to use return dev_err_probe() in places like this to
simplify the code.

> -		goto out_disable_vref;
> +		return ret;
>  	}
>  
>  	indio_dev->name = variant->name;
> @@ -936,7 +932,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
Given this is all that is not manually cleaned up, please add a second patch
to use devm_iio_device_register() for this.

>  	if (ret)
> -		goto out_disable_vref;
> +		return ret;
>  
>  	ret = pm8xxx_calibrate_device(adc);
>  	if (ret)
> @@ -948,9 +944,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  
>  out_unreg_device:
>  	iio_device_unregister(indio_dev);
> -out_disable_vref:
> -	regulator_disable(adc->vref);
> -
>  	return ret;
>  }
>  


