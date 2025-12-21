Return-Path: <linux-iio+bounces-27283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640FCD43C5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D89ED30073D9
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78922259F;
	Sun, 21 Dec 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmkdAq6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BF186E2E;
	Sun, 21 Dec 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341116; cv=none; b=h1RXBnaDgwqMejp3QWZFXMK18vFvCbXPRHSO3LDL1rhjo9+KWLwJBwpr49a14LSM+ZFFxmpP0wFDaacs8YPB0koEw5oHUY9z/2bMqFBEpc4B4n2LfGMupLi1NP8kg2yVk+3QNNPgOolkwKGj28LouNsleifSJIhxHNkP2o1hkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341116; c=relaxed/simple;
	bh=dLpl0VUOqbbFNc6IWgbRH9CNTZwgLl2+v4oQF4L/N6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu0Ia5pt121qNtiOfCXd10gaGRov9ZNM/AqrADwDGVnspATJAJCVpVQdhzbdvfPDsyfmEeGHdtwdQj1BnvxXd40ZBDd1dXkpIphddw4XJddNPB9Coe2+VCdqIRi2DVu0fpREEzQQLNolly6+4o/DZNmVGBySeexTUHKfhI1Q45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmkdAq6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115EEC4CEFB;
	Sun, 21 Dec 2025 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766341116;
	bh=dLpl0VUOqbbFNc6IWgbRH9CNTZwgLl2+v4oQF4L/N6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmkdAq6XT2bid6cD4ZHCQpBXvzfu6YIqoJ/7O0HwUjRtpKQoDMcjHLisgImj9Bn40
	 nQ1bf5ddbPFOdvjGJ2suFXLNCItKy2kGmRQ6Ow9B3d3c624/93r/6Jl7h/gwtHzR/J
	 0RwWOJ+zQtX0V3rCbTh3JXwUFgch9pZ02kgfrsY0B9F8DRE+0mcRNfW2xXgnjz2qae
	 Cp13SAgyT4HLgBRBf34UvBlFd395QV2qLyUNbnwcnRTM2q5bB+9fSXedwyP6VR9wjH
	 ADAGqChanjI9gGDlhxVNYEJopXObFimrU1j2QE2VKL6XZBVJuQV7nmsI++154fcarx
	 rQI28D6r5zSbw==
Date: Sun, 21 Dec 2025 18:18:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andreas Klinger
 <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/14] iio: pressure: mprls0025pa: zero out spi_transfer
 struct
Message-ID: <20251221181829.64fcdf70@jic23-huawei>
In-Reply-To: <20251218-mprls_cleanup-v1-5-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-5-b36a170f1a5c@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 13:05:47 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Make sure that the spi_transfer struct is zeroed out before use.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre

Good catch.

Smells like a bug to me. Probably want to drag this to the start of the
patch set and add an appropriate fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/mprls0025pa_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
> index 021c0ed812c0..73f0714f66ca 100644
> --- a/drivers/iio/pressure/mprls0025pa_spi.c
> +++ b/drivers/iio/pressure/mprls0025pa_spi.c
> @@ -21,7 +21,7 @@
>  static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
>  {
>  	struct spi_device *spi = to_spi_device(data->dev);
> -	struct spi_transfer xfer;
> +	struct spi_transfer xfer = { };
>  
>  	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
>  		return -EOVERFLOW;
> 


