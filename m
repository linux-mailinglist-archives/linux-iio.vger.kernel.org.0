Return-Path: <linux-iio+bounces-9284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802E9702D4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22604283EF8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE815E5BB;
	Sat,  7 Sep 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czK7tp7k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21028FC;
	Sat,  7 Sep 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720708; cv=none; b=sVdMbewWPNaCnHI3X6j/3G+12Wyfv/wQl/QgDPFT7NiPxEoGgK9/nnqAI4BN9m+YygbWfEE9Fgylgt7RR+Ok6boLvEqrXPDxRBFqMukg7Z2my+7HKBGgA/0yR3UOlCXE7PtzaPVdN45kolS81XxADfhPTwVMgVqkxBDBrfTcHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720708; c=relaxed/simple;
	bh=/klhqbeoppROdUpmCj19ZxE96fXck96LE2nlSmlnxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG+7RGZHiv0NOOtExIWBdErPUHS/+OiuTK+iiFseoy2geQHLAzSpcI5o5IRJRbIUiGXOfo51AfjgY0pI2kODdfQRIRgQ8Viqoy7N7wDibzMPwK45NImmzgLavMRo8bKdaafTA73kwfck9bCCdKLeVkdMFozKEpsI3cKxsDzqEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czK7tp7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D548C4CEC2;
	Sat,  7 Sep 2024 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725720707;
	bh=/klhqbeoppROdUpmCj19ZxE96fXck96LE2nlSmlnxw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czK7tp7kmYXEHx4IMJ9Zltg/zmm5wm/p+vZdXUH2sWsgZqqxdK6scsPzLLCYFWFtB
	 SaBhOf9/6KVSPbqvEraCpIdljLRQtu2ocLLJICUzHhDNzi9iQzeMM3mjz3fxnEWCYf
	 9Joq8FaQC0DIbYQlafX5+W/4acex/IWBt/OUdoc78NZhSMF7aTQSfqyMRmTK5njro9
	 8vZU6vrBTy7I0wtkgy0oi/WSibzqseefoXXl3B1AfDyx4IPcrVvC3ss1rsfsGAYQDP
	 eOXStluubtS51dgsO/Obar2WKYISy1SO0+0lry/63gv5Q/AToC2DpceYctjPOq9XKN
	 lEMgGuJ2ZkRuA==
Date: Sat, 7 Sep 2024 15:51:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com, Nuno Sa
 <nuno.sa@analog.com>, Stable@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 1/9] iio: adc: ad7606: remove frstdata check for
 serial mode
Message-ID: <20240907155139.67a296c7@jic23-huawei>
In-Reply-To: <20240907065043.771364-2-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
	<20240907065043.771364-2-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 09:50:34 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> From: Guillaume Stols <gstols@baylibre.com>
> 
> The current implementation attempts to recover from an eventual glitch
> in the clock by checking frstdata state after reading the first
> channel's sample: If frstdata is low, it will reset the chip and
> return -EIO.
> 
> This will only work in parallel mode, where frstdata pin is set low
> after the 2nd sample read starts.
> 
> For the serial mode, according to the datasheet, "The FRSTDATA output
> returns to a logic low following the 16th SCLK falling edge.", thus
> after the Xth pulse, X being the number of bits in a sample, the check
> will always be true, and the driver will not work at all in serial
> mode if frstdata(optional) is defined in the devicetree as it will
> reset the chip, and return -EIO every time read_sample is called.
> 
> Hence, this check must be removed for serial mode.
> 
> Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reference the fix patch in your cover letter, but don't include it in the series.

I'll just get confused when I pick this up.

