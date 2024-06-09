Return-Path: <linux-iio+bounces-6103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61A9015CD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51587B2107D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C42E633;
	Sun,  9 Jun 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9vSjn8z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B813FF6;
	Sun,  9 Jun 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930837; cv=none; b=Y23B7ITb6EBXdkuEAzcnGoDhVKJBsttQoAlUNupk/vUE9YkYJVcy060pLg466mqb8+j06TXNfsiixVhilIf2m6PYo4ov/1Qr6UHC/kHuscdyfJdKp9QZbYIS75GxL1OOx4a1oh6/EbR2bGiJkhnn0LvQyV2tfwVF60Zrk7jdHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930837; c=relaxed/simple;
	bh=euMqjpcZz9MbqRBYSk5fpAa39YqveKEm1qqxBzZ/UYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDsvqUyeEt+QzNiobA8rptLjukKq182t0p1gc27KrniMe74mErDYqwaC/LQhKMUlMZNJgtOhTLhhgEWGYRwHKTV3RcJyTtRSB+rx2h81IEx/r9GSiBxYyln5k5J96n/htEg5kH1ndEiU1Sj37lpttV+uGxVrE02jKhGtaL9mC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9vSjn8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57949C2BD10;
	Sun,  9 Jun 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717930837;
	bh=euMqjpcZz9MbqRBYSk5fpAa39YqveKEm1qqxBzZ/UYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9vSjn8zO1t1aW0pe3zvrW4VcEhiDbQRDrDyfrz+UMICh3FqSBIithD4vdnnuOJSz
	 dy1FJoqsFkz8RaOgiI9O7AFrmZrulm0sq5T/ThUtuaaadt0t661UWgcNFpGCkJlr/2
	 bK6GTGmiw19ves1yRewWrxfx8gihoRGEcN2h+Y4RyikiVCxkFrDn4bnpE++KqUksiD
	 tLIv96HLx8BBWdFnJuGBprm2Lb4QqtD771fXD3MKFsiSonJwwyQF5E2OvjNIPCrnuA
	 rlLztkeiIHMA8kNtcQ0rX/h7n/xUvyqR8xpd0ezaEAE1QybAavzEGi15jpku7Y6Ki4
	 55ML0UfZXsgbg==
Date: Sun, 9 Jun 2024 12:00:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 01/19] iio: chemical: bme680: Fix pressure value
 output
Message-ID: <20240609120004.70325d88@jic23-huawei>
In-Reply-To: <20240606212313.207550-2-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:22:53 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The IIO standard units are measured in kPa while the driver
> is using hPa.
> 
> Apart from checking the userspace value itself, it is mentioned also
> in the Bosch API [1] that the pressure value is in Pascal.
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L742
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Given we are early in the cycle I'm going to take the fixes via
the fixes-togreg branch of iio.git.

Thanks will slow down the rest a little but we still have time that
that should not matter and we'll get these fixes into stable much sooner.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index ef5e0e46fd34..2c40c13fe97a 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -678,7 +678,7 @@ static int bme680_read_press(struct bme680_data *data,
>  	}
>  
>  	*val = bme680_compensate_press(data, adc_press);
> -	*val2 = 100;
> +	*val2 = 1000;
>  	return IIO_VAL_FRACTIONAL;
>  }
>  
> 
> base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd


