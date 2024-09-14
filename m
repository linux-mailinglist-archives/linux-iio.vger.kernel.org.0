Return-Path: <linux-iio+bounces-9576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F549791F8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2271F221B9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DF1D0DD1;
	Sat, 14 Sep 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F83e812r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD021D017F;
	Sat, 14 Sep 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329991; cv=none; b=lWvVicgLenW3OvAbzcJqreWcvIm92q7byCO2Z3q5foCaeEpiUez4ac82Oo95UMB7H5j5bRSqQinmvAomBjbZGMg6hy4oCbYpEQ3dM9iFVjReH9GQ0tk2MTwVscAqemvFjDO9txJOrdDImnzS49UAJUWYvVw3+hWIi+9pi6wZs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329991; c=relaxed/simple;
	bh=ifewKtXDDSzBHBaLKq1ugJVVgHAeaiWFeGyekN8Mw2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRlxIQU3TaD0g1Wq2jHRW2b9VZdOEmcOCUwOqWrDUHpEbIM0uRCsFj/UnqtxTRcTIG9IxlpOSIC0/pscW8JEm5C1QNxyUad3lnnnJmKqOA1yjuMLSM8HTjx1v1i1L9LvH4ctgEGUnDFYZ+qZt6zrr0nfIXxnrFccwHoGWkp+Kaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F83e812r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78477C4CEC0;
	Sat, 14 Sep 2024 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726329990;
	bh=ifewKtXDDSzBHBaLKq1ugJVVgHAeaiWFeGyekN8Mw2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F83e812rl3HrSn6UeU1K+uuqaT0GjnoZNXpvL/qnqIXWIILBQKljcmaz0Qrg+CNPv
	 NaaZ9O3j88y7+gMldkWpAkPT209YrrOSVWo/jj8q5T130rZaP0az3OEo70O41AFVTw
	 we7Ivjd9P7qs9W+AGYBTnr7onFGSmC8wCDhNGyxadSB6+Fj7RiqtoLHAWCUj1nUcEO
	 qgu5oBfAPWcoAmSVXnoT1ePBcdiCVEDxO7F+1uuqNUbd2DzNCSVhM5CmtfRa537yIs
	 AXDyISBEAudohTClj1FpJ2FO+wXUIJDTQX1Uy/ZzkQnF9Nv1D+X+JBSifbtgcExjjY
	 M70snPA4cv/Qw==
Date: Sat, 14 Sep 2024 17:06:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 1/3] iio: light: opt3001: add missing full-scale
 range value
Message-ID: <20240914170622.227911f8@jic23-huawei>
In-Reply-To: <20240913-add_opt3002-v2-1-69e04f840360@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
	<20240913-add_opt3002-v2-1-69e04f840360@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 11:57:02 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> The opt3001 driver uses predetermined full-scale range values to
> determine what exponent to use for event trigger threshold values.
> The problem is that one of the values specified in the datasheet is
> missing from the implementation. This causes larger values to be
> scaled down to an incorrect exponent, effectively reducing the
> maximum settable threshold value by a factor of 2.
> 
> Add missing full-scale range array value.
> 
> Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
I'll probably send a pull request with this in shortly after rc1.

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


