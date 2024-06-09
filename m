Return-Path: <linux-iio+bounces-6108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58D9015DE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C561F215D5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D02C6AE;
	Sun,  9 Jun 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0guh2gv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8624B2A;
	Sun,  9 Jun 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931355; cv=none; b=M8UJ4sza+0wZ5MEXCwuGwZJSZoroEBB6eQflC+mQReBrMiVu6LS7EvCTB4rm4aFn2OPagce46eDT46/Xz1+LNMmCN9iearSp5lxCscxnjNzT8/AVFyLmmmrhslLCx2X4E7GOYlkmaIpADuo68G+P4YeaZEMYtEkmVveHJ6LXpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931355; c=relaxed/simple;
	bh=bnKI0I/ZgBZ3bANyIua2ElOt9f9c5DpMNagJgwv4QNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7QQ58yGRQNwqHAL8C8GtBCypiHM7fmbcxRg5dHoijFwyDIom9UpP3l6mh05NSVaHtyyWux2Anc+xl6NfHK5+rR5qnYgBnzBdC48HCu52fGDhnfuTQD3VWeRYYKTYaovIe4UlQTfDnwXxi7UiYcUphwOSgijoU+67z7jhITJVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0guh2gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC7DC2BD10;
	Sun,  9 Jun 2024 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717931355;
	bh=bnKI0I/ZgBZ3bANyIua2ElOt9f9c5DpMNagJgwv4QNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0guh2gvOQy034WXmgsAnoWR4XXyopwCoLjdvLq3K9ywaU16VOwrWBNrCeirN3mR9
	 zpJn9JHmfr2ZKU5L9fa3QmNdM2dXYIBKbHKbFBmQTCB/GGOWymnD0ABTqRUaL/ByVs
	 xo5/1klQIIpnaWhZkYRdzXv9+dK6h6IMYWJ8QVkNzVpZtAR+9eWg/58olQKYwm5Y3S
	 2yzTmfUmRS80QLEQPOvevIePXpnqPZOuXswLb4dR/ULdiBkuVTxt9ATf36BPqfaYou
	 jQ5kdirpdlbeLWqkcZTbyzdY09W67KjRmb8vle7NzmSmNWrZNqLkc5/+6DGKMLw8rf
	 xONpwKuqtWHIg==
Date: Sun, 9 Jun 2024 12:08:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 17/19] iio: chemical: bme680: Remove redundant gas
 configuration
Message-ID: <20240609120836.269584b3@jic23-huawei>
In-Reply-To: <20240606212313.207550-20-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-20-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:23:11 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> There is no need to explicitly configure the gas measurement
> registers every time a gas measurement takes place. These are
> initial configurations which are written in the beginning and
> they are not changed throughout the lifetime of the driver.
> 
> If in the future, the device starts to support multiple
> configuration profiles with variable heater duration and
> heater temperature, then they could become members of
> the ->read_avail().
Similar oddly short line wrap. Fix them all up for v3.

Thanks

Jonathan

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 1cf375904b8d..76b96993120f 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -683,13 +683,6 @@ static int bme680_read_gas(struct bme680_data *data,
>  	u16 adc_gas_res, gas_regs_val;
>  	u8 gas_range;
>  
> -	/* Set heater settings */
> -	ret = bme680_gas_config(data);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to set gas config\n");
> -		return ret;
> -	}
> -
>  	/* set forced mode to trigger measurement */
>  	ret = bme680_set_mode(data, true);
>  	if (ret < 0)


