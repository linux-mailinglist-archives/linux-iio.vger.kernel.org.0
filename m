Return-Path: <linux-iio+bounces-4400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4598ABC1F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EB281AF8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DD26291;
	Sat, 20 Apr 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBPwjYGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D025625;
	Sat, 20 Apr 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625358; cv=none; b=HMhJmVd940Blqlhj6SdBF6rJkZ5eAkG2vHjsS1pCKKRthNcbZoFvUCWq/aCitoR5SFXxoi4enMvAFRhvUg5oyQlGtya5Py3sp/rp5oVCGDB04nlATc8e5ZCDvhsz0ZgcTG3aT9TOrsvjjfBSPZJ3BeuGuq/znByyHsJS3aCe/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625358; c=relaxed/simple;
	bh=M0hJ++t3zPzJ1x0oBXKRPVTje5D0VytVxiYpWNu8Ye0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz2dU3FKsDCPkarh2jRR9oMgtLEv8DjEgDRfUQjFOoPB4WyD5tPTsWDAbd+2EVYUoe2gFjuwFrvDmATnoCg4z9hErXLHJoA431tBp4LgWqpcFpFCC/ykyIXvSayD4SSRiJneJcLDvWZep44ROxlhwPFFJuv9BxSSPTG9auDC9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBPwjYGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEA9C072AA;
	Sat, 20 Apr 2024 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713625357;
	bh=M0hJ++t3zPzJ1x0oBXKRPVTje5D0VytVxiYpWNu8Ye0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBPwjYGyR5T7MfeHZ/zfYto0tKlIxLhinu79tsErvjGh40GpzxHjGkCzvSsgVtycv
	 Enh5EWNjswdot8h0MASbs3YMMvD/scstqmSrqV45PFKKq/SRo8g3l27Af7JXqK2ecW
	 9XtHnAGonROTMVLABEcgyPJMZWuBA8T2qE6RjLg2wnuCokSYfG/aoTC1A48OBlbwOU
	 jy4mT1JQDwrCuL/UNP6tDIwdCEULSczwMkLuPd59HgGtN+QPViidYplOst1m4scSzN
	 luh5HDfQqcwS0p22ddr4qKqMU3oRhWmkGHbmc9c5M0rQP/fDX5N2t8HTSpiPvd+fSl
	 Rhrrepj/qdYXw==
Date: Sat, 20 Apr 2024 16:02:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 2/8] iio: adc: adi-axi-adc: only error out in major
 version mismatch
Message-ID: <20240420160225.270f804b@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-2-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-2-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:45 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> The IP core only has breaking changes when there major version changes.
> Hence, only match the major number. This is also in line with the other
> core ADI has upstream. The current check for erroring out
> 'expected_version > current_version"' is then wrong as we could just
> increase the core major with breaking changes and that would go
> unnoticed.
> 
> Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
You did point out in the cover letter that there were some unrelated
changes in this series.   Would have been better to just pull the out as
a precursor and hence not have to mention it!

Anyhow, I'll pick at least this one up now but I'm not rushing it in as
doesn't feel urgent.  Applied to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 4156639b3c8bd..a543b91124b07 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -207,9 +207,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (*expected_ver > ver) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
>  		dev_err(&pdev->dev,
> -			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> +			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
>  			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
>  			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
>  			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> 


