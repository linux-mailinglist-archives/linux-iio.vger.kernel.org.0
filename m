Return-Path: <linux-iio+bounces-6286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B159097BB
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FD9281D38
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740C381BA;
	Sat, 15 Jun 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXgWhd6w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDF1B285
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448766; cv=none; b=CTPydXXG6WmklvGSvGv8EJaphCI4AlVw87AAvyg7nEOwPH7ZNCIuesm32jx+HcWZJ0q5Ul8J8v4u/cBHcKzBZq1mQq84RBs+3Gzase1gkS+ra8C4Jkod3VqdKvk4D6ZigNP3t9kOuGKQwnh6sL0ubYS5UUl1RrBO7Jk3jn/skRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448766; c=relaxed/simple;
	bh=Ba/yU6I1kXLYXQeWCLoj/h8xuORVv43wW7jBnn5m8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAvl99SbWGEm1PIpsU/hOy+m2HyDAZ3XAe0KwPtvG55Zf8qQT35iH3t9gABG9NZGTuHCupsJyVX5QIJaqHjjRY27wr1zLF6g4F8y0AlmvVHBYPxGfR4MEnCZ7iIqD6Kyl5vy2evtXZBFwuGn4tAfukL49Lh/+V76mtWEwgipSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXgWhd6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F0CC116B1;
	Sat, 15 Jun 2024 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718448765;
	bh=Ba/yU6I1kXLYXQeWCLoj/h8xuORVv43wW7jBnn5m8D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXgWhd6wS0D6XPdDT20eMdihftzKTAP2cw96cRkZ0ggDHE3IruJpUbbCkjhrksmkZ
	 Sn9wk24GKlOeLPlPkBaA3XLqvRPS3VbFapj+sxnAnuMksqSPvu5l/qBlnVsPCGXIuP
	 gS4rwF2vmI5KcXF84VdHdSrO47mdbqFEGG7Ua8h11TIOE/1tr/Ybo/XyRxJHlVBO+3
	 +a7hsTmoM6dczkO2bEYXvK5wa9ZfTmR4Wwn1Iq/Er8qaC2SkaMck48ZfPC+GRh1Lix
	 qB0Eq7JIAERK7zH1j00XV1YDJt1a9z+46APMHvBNkWZe6hZ5KGzcB/h2ITDjAZusXQ
	 g7jlXI2w3IlCQ==
Date: Sat, 15 Jun 2024 11:52:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eduardo Figueredo
 <eduardofp@usp.br>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: ad7266: Fix variable checking bug
Message-ID: <20240615115238.2ecadd28@jic23-huawei>
In-Reply-To: <20240613153920.14647-2-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
	<20240613153920.14647-2-hagisf@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 12:39:18 -0300
Fernando Yang <hagisf@usp.br> wrote:

> The ret variable was not checked after iio_device_release_direct_mode(),
> which could possibly cause errors
> 
> Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")
> 
No blank line here as Fixes is very much part of the tag block.

> Signed-off-by: Fernando Yang <hagisf@usp.br>
Also I've just sent a pull request with this included.

I mentioned it was queued in reply to v2.
Once a patch is queued, don't resend it as it just confuses people :(

Jonathan


> ---
>  drivers/iio/adc/ad7266.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 353a97f9c..13ea8a107 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  		ret = ad7266_read_single(st, val, chan->address);
>  		iio_device_release_direct_mode(indio_dev);
>  
> +		if (ret < 0)
> +			return ret;
>  		*val = (*val >> 2) & 0xfff;
>  		if (chan->scan_type.sign == 's')
>  			*val = sign_extend32(*val,


