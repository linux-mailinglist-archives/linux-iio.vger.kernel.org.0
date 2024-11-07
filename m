Return-Path: <linux-iio+bounces-12006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D629C0F14
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD9B1C24368
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAC217F36;
	Thu,  7 Nov 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="W2Vp3uB9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146C186E58;
	Thu,  7 Nov 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008374; cv=none; b=rTQCYa4K9UoPRqQvaSniTyZ+6T1BMG5Szofwf2I1wqlyf3voeSqfyUJc/Cwc6j6ZX3ay6uiAOpuvSJBXgvWG3KQg+2JGPCpQ8E5KKVgQ3R8fEwHQ9muzVxxH5mM2r9E8dKpW10wXiIK/7Y7GyN6WLxcCOp0wWVaZ8ixLgv1IQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008374; c=relaxed/simple;
	bh=a0V4ZAX1uXH7Q8uG1fWn9rcEYNMN1igKOsPXDjSlMVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=iXZ0N+G2dBStPpokNShr+0BJztzqNG0CV9eyYiAkRLMtY4QVyMi9+gnRe72VGP/1kzATRIdS0I4osOCLveSJzlKeq28XRT5F3hw8x8Qm1VtUTVNmdRdpyD4K8CJ3ZaOq9gOQfKb6KFG/zBfrzrpv6qh3CKKU7CnqeH7n0qL8wT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=W2Vp3uB9; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 98KjtS5UwLh3P98KjtGfY0; Thu, 07 Nov 2024 20:38:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731008302;
	bh=KQrN8ZfDGEPmTxbn63U6Uo/Ca02SoRadPI1etr8OWXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=W2Vp3uB955uj8QfxlIP1bEOE1eqKlbdZE70RH2xiFfYksIb+hHyzlU3RG3SEf6RJb
	 Rg3uCU4Apbf9Kbf1240w3Iu9xLFXzEhxDT5WYRpZMzTPUS5NqTl9eFUkxQGgCQLGxG
	 54P90zQ6sA31suRAYimt7kk0LsK/bQ9s1rC8KKDQKzjOkEv3jrDuYtk/Fdasnqvp/8
	 WubU3ClY43wanWDtEfY2+aCBiAcfmuDlA/k6/Y9tbVLOkjZAhpgHvZIW+ZvncnsN5W
	 fgxyJnjEMu/MvL6VtdecJxFxKb2AgBU6m4Ljd6OPhhSCniwfLso5hYiIihPpwplTFc
	 okWBBQQmymQNw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 07 Nov 2024 20:38:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
Date: Thu, 7 Nov 2024 20:38:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
To: Frank Li <Frank.Li@nxp.com>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 imx@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20241107191842.3002319-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/11/2024 à 20:18, Frank Li a écrit :
> Use devm_* and dev_err_probe() simplify probe function and remove
> vf610_adc_remove(). Change type of 'vref_uv' to int because
> regulator_get_voltage() return type is int.
> 
> Reviewed-by: Haibo Chen <haibo.chen-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> ---
> Change from v2 to v3
> - change vref_uv to int from u32 to fix below warning
> | Reported-by: kernel test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org/
> smatch warnings:
> drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.
> 
> vim +857 drivers/iio/adc/vf610_adc.c
> 
> Change from v1 to v2
> - add Haibo's review tag
> ---
>   drivers/iio/adc/vf610_adc.c | 79 ++++++++++---------------------------
>   1 file changed, 20 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 4d83c12975c53..a6a0ada8a102f 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -160,7 +160,7 @@ struct vf610_adc {
>   	/* lock to protect against multiple access to the device */
>   	struct mutex lock;
>   
> -	u32 vref_uv;
> +	int vref_uv;
>   	u32 value;
>   	struct regulator *vref;
>   
> @@ -823,10 +823,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> -	if (!indio_dev) {
> -		dev_err(&pdev->dev, "Failed allocating iio device\n");
> -		return -ENOMEM;
> -	}
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
>   
>   	info = iio_priv(indio_dev);
>   	info->dev = &pdev->dev;
> @@ -842,27 +840,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
>   	ret = devm_request_irq(info->dev, irq,
>   				vf610_adc_isr, 0,
>   				dev_name(&pdev->dev), indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);

missing return?

>   
> -	info->clk = devm_clk_get(&pdev->dev, "adc");
> -	if (IS_ERR(info->clk)) {
> -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> -						PTR_ERR(info->clk));
> -		return PTR_ERR(info->clk);
> -	}
> +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> +				     "failed getting clock, err = %ld\n",
> +				     PTR_ERR(info->clk));

No need to add an extra PTR_ERR(info->clk)

>   
>   	info->vref = devm_regulator_get(&pdev->dev, "vref");

With the change to devm_regulator_get_enable_read_voltage(), is it still 
needed?

CJ

>   	if (IS_ERR(info->vref))
>   		return PTR_ERR(info->vref);
>   
> -	ret = regulator_enable(info->vref);
> -	if (ret)
> -		return ret;
> -
> -	info->vref_uv = regulator_get_voltage(info->vref);
> +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
> +	if (info->vref_uv < 0)
> +		return info->vref_uv;
>   
>   	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
>   

...


