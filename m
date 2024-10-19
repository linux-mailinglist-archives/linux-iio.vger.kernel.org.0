Return-Path: <linux-iio+bounces-10788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B3D9A4E95
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1511C225CC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9893BB50;
	Sat, 19 Oct 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGmjSfsp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E715C3;
	Sat, 19 Oct 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347525; cv=none; b=AH37vGRxjhim5pdyz0gYkWOlfnx3azmyYhKRmTN3PtHgtKGdDQnjGSABmpv0qyR6MLDljA4hl1x9Q4PL7mD4ledzfzF3uNPMc7hs/wGCbam93WZG2//7VkIIGl7EJ3umtHaC2fNuV5s1VsK6ZeMx135wBiwe+fKPEnz4+bQDYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347525; c=relaxed/simple;
	bh=FoB3f3cbdhsCpDvMeAP0ESyBwjXzV5M/yFi+NyuiCSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn+wfLAxjAMQsWemf2mEvpczT9ANYLLvandGzTGULd+U0K1dWz44MDSICYZZQJ3dj3FZ9i4j/hVZOsnGKvDSYNPf0mp9yLFwmbeN6jq3BApz9HjlIUs8VLa4/2RWkqLFv9LoVdcPRyx5f10oyZ0ixGfWWXAHc2NKofw3v8wf3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGmjSfsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF61C4CEC5;
	Sat, 19 Oct 2024 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347524;
	bh=FoB3f3cbdhsCpDvMeAP0ESyBwjXzV5M/yFi+NyuiCSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGmjSfspzlaEwBo1bayAImq2gWQKbLmrMniCTcDDipRRMAY3xrS2z8mQb+U9znhw3
	 59Nja4up1YST5HA3//qZ2heiCSyq0Es/dPjBS8xzZfzDQi9BxqnpcYFDcgD7SxO2jz
	 bE1TL4rVr6gVoutt2z9g1jX4CDgmuC8s+ixPqAP4tXeuvQgTTw5YgA2alwak/osj3q
	 Q4M9KkF2Hn17Ohm20UvvYmoiTN4z7yXN2dnMI7ONCJeKmXzT/77MkEeeWBvTrLl1uQ
	 t22MkHvXs2I2pnz+lrb0L99b/PXCf+ULlu0WUeNoWQf/M8YDtFj1+DlC8ozycdyBAR
	 bSS1n0ZsdnfnQ==
Date: Sat, 19 Oct 2024 15:18:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: light: veml6070: use unsigned int instead of
 unsigned
Message-ID: <20241019151809.5d2052cf@jic23-huawei>
In-Reply-To: <20241017-veml6070-integration-time-v1-1-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
	<20241017-veml6070-integration-time-v1-1-3507d17d562a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 23:39:25 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Trivial modification to use the recommended keyword 'int' after
> 'unsigned' for unsigned integers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

> ---
>  drivers/iio/light/veml6070.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index 898e285322d4..484b767df481 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -87,14 +87,14 @@ static const struct iio_chan_spec veml6070_channels[] = {
>  	}
>  };
>  
> -static int veml6070_to_uv_index(unsigned val)
> +static int veml6070_to_uv_index(unsigned int val)
>  {
>  	/*
>  	 * conversion of raw UV intensity values to UV index depends on
>  	 * integration time (IT) and value of the resistor connected to
>  	 * the RSET pin (default: 270 KOhm)
>  	 */
> -	unsigned uvi[11] = {
> +	unsigned int uvi[11] = {
>  		187, 373, 560, /* low */
>  		746, 933, 1120, /* moderate */
>  		1308, 1494, /* high */
> 


