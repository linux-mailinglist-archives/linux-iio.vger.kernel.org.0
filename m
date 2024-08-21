Return-Path: <linux-iio+bounces-8658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CB95A5E5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E480B244C1
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBA172BD0;
	Wed, 21 Aug 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5jaUs2I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A3171658;
	Wed, 21 Aug 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272132; cv=none; b=mmx27DWuSupm1dJVNHfPixbwnczB/73bLnfxY8Ue7VRbpJmA49eHaSbLJD0lKurvclfBszHJE25QUgomvvr4yn1PXmVf2PzrG9voLmviTw/93dGfdbRQ1xq12uKJTdTwXVtSnza4NETAysoI81VRVzAa+SvQWQtLeKWB5Rg4kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272132; c=relaxed/simple;
	bh=pAJ3vsnTquZn4zyqJdU4qiDeSYiNUoJM1TTdLseJYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYiqHJn3byAMXp57GfZW9Ur/9mk5kBapi9E+Uvbeuggbpuv89LQ0+1+HXltrW1sBht/lY7iWOrh+pMAldeuPri7LUetHzP9DF07npxTRf+jY2ZkmYTWFSN77QAjinNCIGGMYVGZMCtaH7WHRz5RgW/GFhcIU3HtjNkBIYYEoCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5jaUs2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FCAC32781;
	Wed, 21 Aug 2024 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724272132;
	bh=pAJ3vsnTquZn4zyqJdU4qiDeSYiNUoJM1TTdLseJYvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5jaUs2IWd3Oh5igPiseu1z1Ihx9JjoZa7C+J1c5fnRMqvaTpNMXi6+DBRnhP5cZe
	 rsWT447JdLLORvnq2c86T2vVae8NikS9nRxXWhRpUBijKE3tkwobVbUEEszaxo3jN+
	 m7ziQakZy64wyIdIfIcJiaM/qLxOLp63+n+waC45abC/4PL4vZ4kBn2HvzZB303Wwp
	 qbKgJa2P2nvXIOtFagN6zxlmI9s5tKRD4O9EgY6v7BbUX7YrqrePCFdk8tDRA5PUtP
	 SleSB4Za2bJJotcn/38Q8mCuF5xaF4QA0scOpOIfIv02CV70H0064Qlbe8P/j5z8E/
	 c4q77ia4sAhgA==
Date: Wed, 21 Aug 2024 21:28:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: David Lechner <dlechner@baylibre.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sgp40: retain documentation in driver
Message-ID: <20240821212827.1d5e85ad@jic23-huawei>
In-Reply-To: <ZsWdFOIkDtEB9WGO@mail.your-server.de>
References: <ZsWdFOIkDtEB9WGO@mail.your-server.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 09:53:56 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Retain documentation on how the voc index is actually calculated in
> driver code as it'll be removed in Documentation.
> 
> This is a follow up on patch "[PATCH] iio: ABI: remove duplicate
> in_resistance_calibbias" from David.
Applied both patches.  Thanks to you both for sorting this.

Jonathan

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/chemical/sgp40.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index 7f0de14a1956..07d8ab830211 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -14,11 +14,16 @@
>   * 1) read raw logarithmic resistance value from sensor
>   *    --> useful to pass it to the algorithm of the sensor vendor for
>   *    measuring deteriorations and improvements of air quality.
> + *    It can be read from the attribute in_resistance_raw.
>   *
> - * 2) calculate an estimated absolute voc index (0 - 500 index points) for
> - *    measuring the air quality.
> + * 2) calculate an estimated absolute voc index (in_concentration_input)
> + *    with 0 - 500 index points) for measuring the air quality.
>   *    For this purpose the value of the resistance for which the voc index
> - *    will be 250 can be set up using calibbias.
> + *    will be 250 can be set up using in_resistance_calibbias (default 30000).
> + *
> + *    The voc index is calculated as:
> + *      x = (in_resistance_raw - in_resistance_calibbias) * 0.65
> + *      in_concentration_input = 500 / (1 + e^x)
>   *
>   * Compensation values of relative humidity and temperature can be set up
>   * by writing to the out values of temp and humidityrelative.


