Return-Path: <linux-iio+bounces-19558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1642CAB8D84
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2971735DF
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F8218858;
	Thu, 15 May 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuOcpwVS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1741C63
	for <linux-iio@vger.kernel.org>; Thu, 15 May 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329477; cv=none; b=ThAhQ4iyLm4NbmzGOsYgtUcp128uCPGYJnG33yGJ4asP3dVp1LQwD0QQ6rogrB+TG72rZv/RA+jXd7NisYwYwb0wEsdBdEehS10k2UJr4W8W7HQokn2rU5wyY/qfBZqfsD09HZBDn5VGngTlsMns5EVH3BhtmG+yoXGiwpOZMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329477; c=relaxed/simple;
	bh=73hjrD+y61HXcgYHTNhNIJWljt7SwiYM31ab7tMPucs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJBJye1MQTssVBO6E9335RO1sRWoY3cbx1an5/NSmTMJUS9s77dZlSkKhcOHzItDBXJXphZQwyTa07LNBfn9ohZUEbD3zDHWBYQh9nsJ/Z32rMTLa22ydIKQboU8EES9XBZgM5Dfu27aWyfmL/uzkIom9TvYSoMIedlKCHx3BAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuOcpwVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A9DC4CEE7;
	Thu, 15 May 2025 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747329477;
	bh=73hjrD+y61HXcgYHTNhNIJWljt7SwiYM31ab7tMPucs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iuOcpwVSR4tweSD2cApBAg6v1iVaOe+0DrOrfQK7IGJtqeUMgyt48o7doJKf6BrD9
	 lTclI4rzcl1shhcMYUuhC9n022V3tRlRe7lhIzkA7VBxkCi+6b/K3trOcXKMbpL2Tz
	 OEEt8KJA7fTyiircbHFm5vQwDvHdRJ6T7y795TvFsAyoOTWG5jNTzn4YGxSuW6DU6/
	 Jovn05aCxndSU/sHwkbyTlr0L3if5lza+8Nv9PUHPl8EiEU3Vya6Ld+treypAdGogH
	 zMgzmmUyFAQgFfzk9uFm2SSWGK14xgiDo8XJuKgsKTyPzaHvJGourvV/kJKlaMvNba
	 2HkyWncrGGgcw==
Date: Thu, 15 May 2025 18:17:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
Cc: linux-iio@vger.kernel.org, Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: Re: [PATCH v2] iio: adc: Modernize single regulator call
Message-ID: <20250515181751.24afaf92@jic23-huawei>
In-Reply-To: <20250514185239.10078-1-gabrielfsouza.araujo@gmail.com>
References: <20250514185239.10078-1-gabrielfsouza.araujo@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 15:52:20 -0300
Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com> wrote:

> Replace a single instance of legacy regulator with devm_regulator_get_enable().
> This change improves code clarity and aligns with modern kernel APIs.
This description does not match the patch.

> 
> Signed-off-by: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
> Co-developed-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> ---
> The first version [1] did not compile due to incorrect use of pointers and improper 
> parameterization of the devm_regulator_get_enable() function. 
> These issues have been fixed, and the code now compiles successfully.
> 
> [1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/
> 
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 226285992..8b2e798d0 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -923,7 +923,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
>  	if (ret) {
>  		dev_err(dev, "unable to request IRQ\n");
> -		goto out_disable_vref;
> +		return ret;
>  	}
>  
>  	indio_dev->name = variant->name;
> @@ -934,7 +934,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto out_disable_vref;
> +		return ret;
>  
>  	ret = pm8xxx_calibrate_device(adc);
>  	if (ret)
> @@ -946,8 +946,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>  
>  out_unreg_device:
>  	iio_device_unregister(indio_dev);
> -out_disable_vref:
> -	regulator_disable(adc->vref);
>  
>  	return ret;
>  }


