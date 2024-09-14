Return-Path: <linux-iio+bounces-9555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8D97912A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723551F22D0D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D781CF2A0;
	Sat, 14 Sep 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H50Xks3a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03641805E;
	Sat, 14 Sep 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322094; cv=none; b=LIdQJk5WyuW4QUYXNpUGuJocih9l8xk1aTINCm+ubIJlApM9RtzMfbmLRPuURaGjghlOqmkNOQ96HywGYzohlBJPagLjxDHc0C/6Fi/WOqAE7E7TOqDbqEZjJ3dZwGxi8tlVoEKXAcKbFn5oHTQUQqAAhYBG4PNFXXv66JY9jLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322094; c=relaxed/simple;
	bh=JrebZ837oqXThXWh5gHfZwkNjkE9AsmhlzJxcIgo9P8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoei4EL2HFwOUiIL59LzHaZ6GWKtLNQ9jwW7994puFzmXfA9eC8qkSTs+NnVF3UgwSzb7r+O7oD/b67IUaKMB/QT6YlAsOAEG8UQUYZY3+pEQfAVw2HGfR5L7Mtatz+gtT42WhO31BLrXIvTJCaoZ17zdlAV49K7cTdCGmGIaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H50Xks3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74670C4CEC0;
	Sat, 14 Sep 2024 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726322094;
	bh=JrebZ837oqXThXWh5gHfZwkNjkE9AsmhlzJxcIgo9P8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H50Xks3aTGWr2g3X77sUjxdqsIWMn7okkp9/8fhZM8bZfHJ31Gcpy6axz5aXnVEaP
	 6zZKw119c5HAWCJLaEBbgdxezj35SlEiJs/rB5o4pEsZfSBL2d9Wh/CCy5U10AmQE/
	 VC78dw3YHCUx7ImM1i4D9Bh0ycniSdUYoCVrVLOZlyoR/2WWbmCuFpOABddblqX71q
	 gjPzLB5lha9RNHxKr10ZREsIXBHLuevKCfJ2d1x72e0stogjWxe3rp7YNHA1YZoyw8
	 EQt9tfl4I9oeUHjrlMcH03DzhPVgvrI9wiFZktHPf6EHRkZrnYl9JZyYXbfnsX4PoZ
	 4zYx8Rv8i9DWg==
Date: Sat, 14 Sep 2024 14:54:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: ltr390: Add interrupt persistance
 support
Message-ID: <20240914145446.21dfddec@jic23-huawei>
In-Reply-To: <20240910045030.266946-5-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
	<20240910045030.266946-5-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:20:29 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support to configure the threshold interrupt persistance value by
> providing IIO_EV_INFO_PERIOD attribute. The value written to the
> attribute should be in miliseconds and should be greater than the
> sampling rate of the sensor.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/light/ltr390.c | 66 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 8a8a118ca..9706105c6 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -40,6 +40,7 @@

>  
> -static int ltr390_get_samp_freq(struct ltr390_data *data)
> +static int ltr390_get_samp_freq_or_period(struct ltr390_data *data, enum ltr390_meas_rate option)

Wrap this as the line is getting too long.

Otherwise LGTM

Thanks,

Jonathan

