Return-Path: <linux-iio+bounces-8392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDF94DBFE
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788EE282164
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2E14D6F5;
	Sat, 10 Aug 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8bgch89"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9643ACB;
	Sat, 10 Aug 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282598; cv=none; b=LneaoW24pD6xhWqkifYIumfh3O1B+JKK9oGG53XIOk+eAKR9S0orzBLTXWgR4XhVUa7C0KVYOsj4zbTwf/fZ0eG1wnL8ig/Gs+v6S5jeEBDp6W70KDy0nGtdhiD3+svNWaio7ToZgNCO7a9vpmt89/Nldt+du27OYLte1bg7r2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282598; c=relaxed/simple;
	bh=3lUjB1WK9Fne6VB6kxW11s7MxDtScbkXERRd3Pzikik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5D4gnrfjOolCwMUC2zINvUYmaN5Pi6mwk6PKEwgRIa4pwM76eOOX3COoLSYFdjlxABieDZ+u049J9r6En2ZvHfPF/vzjBESuhHWDwxGMkumBq0hivWuBboYP3V47uu2fa3IyNjj0LwGv3l1ksMeb0imxNo2qliHI40LIZIofKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8bgch89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D1C32781;
	Sat, 10 Aug 2024 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723282597;
	bh=3lUjB1WK9Fne6VB6kxW11s7MxDtScbkXERRd3Pzikik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s8bgch89+qX06X6lJgCo0rvqjc0VJeEc0N8u7RFX/T+Wjo4Umoe6RY9ftC7G4KswR
	 rIcPCRZNny+dQ8c5CeG2HBpCN1vEsNd5Ol7v+lox1ZUCkzO+hRqc33zyfFdAOAdHxD
	 HZlZGimTJBR2JsNrqF0CSj27oBTllDO9c/a424lQIK7cEvvKoSrF4FGpXmfZ1ctVT/
	 dDhGjtljGKjQ8JJj0vsHlz6F4iNvftFskSeMWwNGrt5fY5RqCOEUTnd/9SRQhpXRMU
	 nuDTws3EWJBIurHLKlVCXaoKh9HZd5frgGEjzXRz1GgfoOdfpxrLXE4GSw1TcnT5XI
	 5VqxOzddY5Z6g==
Date: Sat, 10 Aug 2024 10:36:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: iio: ad4695: document buffered read
Message-ID: <20240810103630.0fbe8610@jic23-huawei>
In-Reply-To: <20240807-iio-adc-ad4695-buffered-read-v1-2-bdafc39b2283@baylibre.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
	<20240807-iio-adc-ad4695-buffered-read-v1-2-bdafc39b2283@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 15:02:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The ad4695 driver has a quirk where the temperature channel can't be
> enabled on its own for buffered reads, so we should document this.
> 
> Also, since there are 4 possible modes of reading conversion data, it
> is useful to know which one is actually being used, namely the advanced
> sequencer mode.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/iio/ad4695.rst | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
> index a33e573d61d6..af76ce2d0702 100644
> --- a/Documentation/iio/ad4695.rst
> +++ b/Documentation/iio/ad4695.rst
> @@ -147,9 +147,19 @@ Unimplemented features
>  ----------------------
>  
>  - Additional wiring modes
> -- Buffered reads
>  - Threshold events
>  - Oversampling
>  - Gain/offset calibration
>  - GPIO support
>  - CRC support
> +
> +Device buffers
> +==============
> +
> +This driver supports hardware triggered buffers. This uses the "advanced
> +sequencer" feature of the chip to trigger a burst of conversions.
> +
> +Due to hardware constraints, the temperature channel cannot be read on its own
> +for buffered reads. At least one voltage channel must also be enabled.
As per driver review, userspace shouldn't care about that.
We can always read too much and throw the extra away :)

Jonathan

> +
> +Also see :doc:`iio_devbuf` for more general information.
> 


