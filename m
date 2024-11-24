Return-Path: <linux-iio+bounces-12572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CF9D7029
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6591621A8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F015D1922E6;
	Sun, 24 Nov 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvgsWMVF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772D166F29;
	Sun, 24 Nov 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453370; cv=none; b=PgolANyi9rBFoyxkdqJ3LN/EMF9jEsevSUxWjNT1zXACpTPaq2n/wR76j32QqtQ/PZib1wNV3Bzh+GlysNuK61pHOiwRtcprU8uCYMlVo4m/lHQjoK61DC7yKTYSFiDhaoH69pBYGoMO9Q7MSB3ubWaVLNjusKyiI0XzikASJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453370; c=relaxed/simple;
	bh=V0Bs0Zy6s73HavYwwymncXPcs1ZrjCVcI3abEBI8kTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to86x1rKLSPGFXfYm3nLhy8zSS3TsYSnwXPTooreVM9bnAcPZD8Hsg9kCPNWNwm7AcETgrlnzCoyKLuOV8ThZzwRCponNjZQvkemVIIL/ZWxQC8z58thGSLUm4qsBWXSMSK3MJSGh6/sVWbile5BBxknZ07Tj6ELLP3rVbMayik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvgsWMVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B6DC4CECC;
	Sun, 24 Nov 2024 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453370;
	bh=V0Bs0Zy6s73HavYwwymncXPcs1ZrjCVcI3abEBI8kTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvgsWMVFDc8l3JAe/gPaphm8u9pGpy8kBrXIHOyFRUMmn6TtyoMF6OCneBCQSdacj
	 KsOz6wtjYSXlCCWByw1JHoT6gYN4b7nMm9eqnmYjV0Fs/A1T/1TnHU/oKnoimBro1o
	 b66ii7FId/S2qyMAlFrgv75ppIOA9xULNGtQFbDvWPCB9K4Wh4PsjIpsBk1M5XxYeA
	 oVYt2IYlIVlJNqnYIqF0Xvo5hUvGr1+9rQb2XrXncfUBrlJws11bdcxHg+rb8x7mXh
	 yKF3kL+GqsXuWto+2Es8l38TQKx9RLFtZMNAznpgglzFk6rvQqdUTi26hNL+EAuF/a
	 UkHh1s6pS05Sg==
Date: Sun, 24 Nov 2024 13:02:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: handle label as an optional
 property
Message-ID: <20241124130241.60e922ff@jic23-huawei>
In-Reply-To: <20241114102459.2497178-1-olivier.moysan@foss.st.com>
References: <20241114102459.2497178-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 11:24:59 +0100
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> The label property is defined as optional in the DFSDM binding.
> Parse the label property only when it is defined in the device tree.
> 
> Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bindings")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
This could be done by just ignoring the return of fw_node_property_read_string()
but your fix will do a little more such as report an error if the property is
the wrong type etc, so I'll take it.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 2037f73426d4..e304e3714020 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -691,11 +691,14 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
>  		return -EINVAL;
>  	}
>  
> -	ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev,
> -			" Error parsing 'label' for idx %d\n", ch->channel);
> -		return ret;
> +	if (fwnode_property_present(node, "label")) {
> +		/* label is optional */
> +		ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev,
> +				" Error parsing 'label' for idx %d\n", ch->channel);
> +			return ret;
> +		}
>  	}
>  
>  	df_ch =  &dfsdm->ch_list[ch->channel];


