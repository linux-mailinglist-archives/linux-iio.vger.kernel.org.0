Return-Path: <linux-iio+bounces-15173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03DA2D6FE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAB3A8F31
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC12500D4;
	Sat,  8 Feb 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAPLefS+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1552500C1;
	Sat,  8 Feb 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029526; cv=none; b=Y2IxeOOpCSbDl4D5jYoWvCBgXCnmlHI2egiKLKhqq26IR1gFEPRNkON9wm5L9Jy1Z3JQ/nV4g6v66cwSf/2/ob8rK2ulDJY+zOvWkj4D5qwV6MWUqEMe+unfajUjh6RM1ySfLWkJwoFkQP7v9pEJ6grb6Grup8BMO+8qiPmicUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029526; c=relaxed/simple;
	bh=oK0sbYoW2codnkgKE8TJXICuUgdVjFuVlOwWG1Ldw3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzWNHfdLrC0hcdH7sWIrglO0HPq5YSQn3BREqra5iJtJGxz+d5ICZyOjFHb6moxdNwbd0e8/WbLQtg07cG42u1N3m22EFhh8vWkoed9G5tKiPPDQm3TAiw0Wh0i+zKmSP03IoOE/rV4lieDEDB3bO2MDT7wqpljSh6CwUFxnx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAPLefS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07928C4CED6;
	Sat,  8 Feb 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739029525;
	bh=oK0sbYoW2codnkgKE8TJXICuUgdVjFuVlOwWG1Ldw3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAPLefS+Y2tFTkGIhsX5II0LAzgF4SEQtMyRy7lMN/BDiQwlM0piO1ZwRN4YOvuS4
	 xSXEDuhU5GrcCDIQrWrpILG1lrChLZca1cWIZy4M4nE4ZCJ4z5omfKPc3mxjRtMShk
	 p9jPDUXQ7ZAvMb7dUO6oPt+UbJb330NMYbB/wHXQ6SznwkgNPeprlMPwzySas4DN+G
	 VgUnIgGo4wW1qXF6tNAZhsJmu3wLVUO4h7K/CyrOY4G+j4fMIPF1I5IHhf8+4txI4p
	 WdP8sJR8P2Hj7Fap1BAvd7odWYMkzwcisFuai4S3FnwGv2dUNBy40tEAaeUkEh/uhF
	 WLeZt6xFUubeQ==
Date: Sat, 8 Feb 2025 15:45:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
Message-ID: <20250208154521.193da461@jic23-huawei>
In-Reply-To: <20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
References: <20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 09:36:14 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Drop mode check, producing the following robot test warning:
> 
> smatch warnings:
> drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
>   warn: always true condition '(mode >= 0) => (0-u32max >= 0)'
> 
> The range check results not useful since these are the only
> plausible modes for enum ad3552r_io_mode.
> 
> Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Ah. I missed this.  Anyhow made the same change directly so all is well
than ends well!

Thanks,

Jonathan

> ---
>  drivers/iio/dac/adi-axi-dac.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index ac4c96c4ccf3..bcaf365feef4 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -728,9 +728,6 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
>  	struct axi_dac_state *st = iio_backend_get_priv(back);
>  	int ival, ret;
>  
> -	if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))
> -		return -EINVAL;
> -
>  	guard(mutex)(&st->lock);
>  
>  	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> 
> ---
> base-commit: c667ed738d7d1a01e9b946ef47cae113b0a05bee
> change-id: 20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-070ecab6a52a
> 
> Best regards,


