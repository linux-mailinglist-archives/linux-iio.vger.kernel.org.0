Return-Path: <linux-iio+bounces-9307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A297035F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65580B226F3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D97165EE4;
	Sat,  7 Sep 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPoIIQ7F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE128F0;
	Sat,  7 Sep 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725730153; cv=none; b=VE2n5AtO3mGL01Gy47WOxsR0bXoAHqcd/KWSUfksWEhKUpyZSIUSH+edWWqxQ1xM5GvkrjVCfyjBZ8ojykJrnsnHNLoxrcCDq4+liYoFsN04g6Hx4UTh7I4k1N6VYUiT90Vq9mwZMnNHxvNVPvs+jPca8jnQSzjgGINQ8pJjyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725730153; c=relaxed/simple;
	bh=/sepxEGXe2L2xJqbo1Jnr1eCbJMeeadrfK8tK6w3jiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=refv1Nn8H5YrpL0i7F+Zdu3bjI2KZDAM3/peOW3nVaQyrg5mImdJ5MYsLGyPq2UNp53tzPXL6bV2wUCAooKN+KPuRnRs2gljtQZV1ySaiNZCM3hhwgLPOFgPusbzrbwcnr6rWpoSQ1vh+/L+u/b2YJyafbsU8N8fAVbi3eITHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPoIIQ7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DDAC4CEC2;
	Sat,  7 Sep 2024 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725730152;
	bh=/sepxEGXe2L2xJqbo1Jnr1eCbJMeeadrfK8tK6w3jiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPoIIQ7F5v1F2d1lfpXNkHi8G0dxncDjJxy+Q8APkVOSvOTjoR9LdE9n8OUzAM0Rr
	 uKz6v+7shEA1FYwMfwYpEoDP7/JrPBq87M8lpMOMoiVQQG8lpdNMjNbVfSvDzSoYGf
	 Cnla4OXg0TX6ZDqe054ff20HZJtRjWiJRp7zLUi3vkTE25trGtd25CVUu5hIokCvWD
	 dhiG+3vJnHRjoRLPiCXa2e842fNZGnHNyDfxvcUbl8NwvHNlaJnqAQQA+V+UHP//hQ
	 Te10fmcOJv1oZVgjMHvxIUWqOaQtqmz1LGCMZDweMza9pynrWmfrz6Dl5AG96Mrqgf
	 B5U6wWmw3LUFw==
Date: Sat, 7 Sep 2024 18:28:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 1/3] iio: light: opt3001: add missing full-scale range
 value
Message-ID: <20240907182824.56396b0a@jic23-huawei>
In-Reply-To: <20240905-add_opt3002-v1-1-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	<20240905-add_opt3002-v1-1-a5ae21b924fb@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 12:20:45 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> The opt3001 driver uses predetermined full-scale range values to
> determine what exponent to use for event trigger threshold values.
> The problem is that one of the values specified in the datasheet is
> missing from the implementation, causing a big gap in settable values.
> 
> Add missing full-scale range array value.
> 
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
I assume this has more of an impact in that if you write values beyond this one
the index will be off by one and the value written to the register
will be incorrect?

Please clarify if that is the case and also add a fixes tag
to the commit that introduced this bug.

Thanks,

Jonathan

> ---
>  drivers/iio/light/opt3001.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 887c4b776a86..176e54bb48c3 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -138,6 +138,10 @@ static const struct opt3001_scale opt3001_scales[] = {
>  		.val = 20966,
>  		.val2 = 400000,
>  	},
> +	{
> +		.val = 41932,
> +		.val2 = 800000,
> +	},
>  	{
>  		.val = 83865,
>  		.val2 = 600000,
> 


