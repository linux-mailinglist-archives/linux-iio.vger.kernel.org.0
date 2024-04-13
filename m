Return-Path: <linux-iio+bounces-4218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D78A3BF8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4863B21381
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A11E515;
	Sat, 13 Apr 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMyHjA8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50B321B4
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001008; cv=none; b=mKqf7UK49GQgk34kRaO2KYgz+6jf/r4KWKp4Rb/mrng6yKN0J88YYWNZYB9anNv05E4mLL7f1EBR/9Jtu2AJNvzuaqF8COerI3uu1G5qXO69ZsFsS6pyetqd+fnNJLCPiZHEhw4ikEbEnVjtsF0wBzulMChpH+oHSIp+pzRGP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001008; c=relaxed/simple;
	bh=W93DaJNz7OtsaEntpd5Lidj86gt3tWqmEz+Qye5V4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBr0SsMyfx9VemXtl2VZsLOW2a66p9yDYj/znDvdfvjfL5X0gzaYW7NLkssTLmF2NrBktT9065tP0nllD+i4QG+b6rKtymupVFQ7wO13u6zVtyIZ4Ut2uQ3/ebkUiMw4CWspvXvMu4bHlWDA2y6Gaku4Fv9XWLn4H3khUuGz7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMyHjA8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597CC113CD;
	Sat, 13 Apr 2024 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001007;
	bh=W93DaJNz7OtsaEntpd5Lidj86gt3tWqmEz+Qye5V4xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RMyHjA8o5rjGJkTIrtsXnyZMRpAxgqi4YdGDlSBdXy5QzjaQyX1Q+3s3zvYdXQAZQ
	 zWlQ4P5P29B6Bl181RA3q3PrHLqlhQWoCQbG50GcncF3S223P/tf94k0EN/l6u3bCD
	 9DHg7+Niea1ond5ArAL/6CNM86mWyNecMAcZ9QvzT59mn322zXrqFxoX+mEa5Yl90f
	 Gz7zzNZTSQJRz3u/2B2SCJerjKfw7iccnjf7sCQtutHN5y5XjxUfte6L3qntZI1KHh
	 X8ehDqsZVzPwZ5EMKgryi4HDsKwFXwGDEbeKO6JJV1icLdu8xEBZSAD9obwtYpnYKm
	 GUWEYR3YClIeQ==
Date: Sat, 13 Apr 2024 10:36:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/8] iio: adc: qcom-spmi-adc5: Use
 device_for_each_child_node_scoped()
Message-ID: <20240413103631.6ffb90c4@jic23-huawei>
In-Reply-To: <20240330185305.1319844-3-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
	<20240330185305.1319844-3-jic23@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 18:52:59 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> A slightly less convincing usecase than many as all the failure paths
> are wrapped up in a call to a per fwnode_handle utility function.
> The complexity in that function is sufficient that it makes sense to
> factor it out even if it this new auto cleanup would enable simpler
> returns if the code was inline at the call site. Hence I've left it alone.
> 
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'm not sure why I didn't pick this one up before now given it has
an RB from Dmitry. Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index b6b612d733ff..9b69f40beed8 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -825,7 +825,6 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
>  	const struct adc5_channels *adc_chan;
>  	struct iio_chan_spec *iio_chan;
>  	struct adc5_channel_prop prop, *chan_props;
> -	struct fwnode_handle *child;
>  	unsigned int index = 0;
>  	int ret;
>  
> @@ -849,12 +848,10 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
>  	if (!adc->data)
>  		adc->data = &adc5_data_pmic;
>  
> -	device_for_each_child_node(adc->dev, child) {
> +	device_for_each_child_node_scoped(adc->dev, child) {
>  		ret = adc5_get_fw_channel_data(adc, &prop, child, adc->data);
> -		if (ret) {
> -			fwnode_handle_put(child);
> +		if (ret)
>  			return ret;
> -		}
>  
>  		prop.scale_fn_type =
>  			adc->data->adc_chans[prop.channel].scale_fn_type;


