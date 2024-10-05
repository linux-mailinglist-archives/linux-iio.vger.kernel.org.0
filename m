Return-Path: <linux-iio+bounces-10168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFD99167F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959511C22376
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725414830D;
	Sat,  5 Oct 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7GvsiMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962C231CA6;
	Sat,  5 Oct 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728128052; cv=none; b=thIlAxo64ZACEtDV7ayASUoRKg9TSai06+qeBrp6Hz7PBOyt5XU0S2tfU3XNyit1UdiRMCyeMXw7uGTBTMJvFkmbKuzJW8+LWi4pTJVfjns/h9Jb39TkUWECLq//3qWKtP7fsxZaHIUGS7Vwg9GPGiayynDSyG+FE1F1TFp33kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728128052; c=relaxed/simple;
	bh=acmCayqR3svjUNR7zkQF5et/wWsmvhGVMoOBMhcSfG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRvBCyCDF+xagSDtboK1D3hSJLUT2uBC9bzsqHGAi89TDQaDK6lmWQ03Pr1RGvWQ12/JRgb3oS54keyDia3Vf5WfWBYtCvmZLhM6XYGuywtUTi6jHFAFvevkQ28h/qSDGg3SyPCesRu+djyl1NZn09T/QqgB6fTjIu/WVRDY4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7GvsiMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF3EC4CEC2;
	Sat,  5 Oct 2024 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728128051;
	bh=acmCayqR3svjUNR7zkQF5et/wWsmvhGVMoOBMhcSfG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l7GvsiMV0tyuUDYJOTRdB7gxbz1CEUv+pcrT0KPQ62YwOpBpoPTPbxvuoHxKDPCtg
	 fJUIlpIn21kEYONI8jbcQJ25ir3H+nrJZCSu484Ao8z8VvHPSF7QsxsjBM5OCUgBC+
	 aErTXrVHpRCkTIarp69KPF6XQIfU3gm9VSwQ2oAxOWIMuevy4cqRLKxh9L95aP7XGn
	 OU9Y/YO71WmaZfMlbGM+jscYJbkrVo1jnYDgJZ9ixHTUcB+n548OPpAf8y8xB4iHr2
	 bofp4PP9ccfkRtZidQAGLLrly336BjJGY+furI4M6KDD1/j+yyNfwpBiJKibwLdDLP
	 gbFAkm9JDhSfg==
Date: Sat, 5 Oct 2024 12:34:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Tidy up adc5_get_fw_data()
 error messages
Message-ID: <20241005123403.616697f3@jic23-huawei>
In-Reply-To: <20241004-spmi-adc5-no-channel-error-v1-1-1a43d13ae967@oss.qualcomm.com>
References: <20241004-spmi-adc5-no-channel-error-v1-1-1a43d13ae967@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 16:11:01 -0700
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com> wrote:

> In the event that no channels (child nodes) are defined, the adc5 driver
> will provide a generic error message indicating that adc5_get_fw_data()
> returned -EINVAL. In all other error cases we get two error messages,
> one helpful and the generic one.
> 
> Add a specific error message for the no channels case, and drop the
> generic one, in order to improve the generates log prints in both cases.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

In general this seems sensible.  There seem to be prints in all other paths that
aren't -ENOMEM which is fine.
For consistency it might be nice to have a follow up that uses
dev_err_probe() in adc5_get_fw_channel_data() but that can be handled separately.

Applied to the togreg branch of iio.git and initially pushed out as
testing for 0-day to take a look.

Thanks,

Jonathan



> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 9b69f40beed8..af3c2f659f5e 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -830,7 +830,7 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
>  
>  	adc->nchannels = device_get_child_node_count(adc->dev);
>  	if (!adc->nchannels)
> -		return -EINVAL;
> +		return dev_err_probe(adc->dev, -EINVAL, "no channels defined\n");
>  
>  	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
>  				       sizeof(*adc->iio_chans), GFP_KERNEL);
> @@ -903,7 +903,7 @@ static int adc5_probe(struct platform_device *pdev)
>  
>  	ret = adc5_get_fw_data(adc);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "adc get dt data failed\n");
> +		return ret;
>  
>  	irq_eoc = platform_get_irq(pdev, 0);
>  	if (irq_eoc < 0) {
> 
> ---
> base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
> change-id: 20241004-spmi-adc5-no-channel-error-8c3203391103
> 
> Best regards,


