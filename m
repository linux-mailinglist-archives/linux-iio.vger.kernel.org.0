Return-Path: <linux-iio+bounces-5115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9F8C9540
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F10F281B45
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905A4F5FB;
	Sun, 19 May 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdsRavyb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C345BF9;
	Sun, 19 May 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716135290; cv=none; b=jMcxYjHFT0ZV9wdTdFCZK84K3+zI0M6FiQ+PUr+9J2kmB0+zPxa2VeAQyeTfjSNlSHKAD6/c+p21G0cGApbeWl3ONuw6ChRGnJU3fF3eZSCJrPLlKOWyGTKNfsokVvJ4fx6wqfeaC3V4G+/+eGC91YanDGqYrlNQgs4xKejFXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716135290; c=relaxed/simple;
	bh=aQvXmZMW77qc8tNgoHxBHcZ4dYBBQ/RlOSDN1pdnJAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9nEg6cJFVsZ4x3ybUNckPeZMgId5x/rannURhrUr76e6nyMnzdkPIf/h/YWTp2nusL5Jb3lJqntL8vMYp/1WTJYFaT+S7jBS2G+6WCqejWecBFYMpjIIUn3duRpX2P4WoDAK0d/z2oDOMhwrk9XgdTQlkw3DHC0KmvxQ7yg7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdsRavyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A83C4AF0D;
	Sun, 19 May 2024 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716135289;
	bh=aQvXmZMW77qc8tNgoHxBHcZ4dYBBQ/RlOSDN1pdnJAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdsRavybRhyl1N4rxKMHALpswrTaWdeis5Ujm7sdFLpdehH9AABSVMk0U2o47LZ8w
	 JotiUKEyaY6XLMadtgsyCBF09tA3h2ddWGMLX35pfutMlY1g1e7SEtxPvZib5+pKAK
	 x6lZStnNTD4Yt78fef0LMNIy17coLfkt8/wUq/n6NR8YJsGuMsc7hIKI1woOP1w1OB
	 e/omRDQtXqeuoXUcZNiWwwlWPAEdA4FJ/TPqimAWfArtrdDs9D+iRbc+JTIWtw5Oqu
	 oQ8HNLfLBwhYRtfS4tWW0GmVdTDuQKMVv8i9RHgpw/BC5unbtmRDVoUBavN7oQdGG5
	 sgTWENbNa9Vsw==
Date: Sun, 19 May 2024 17:14:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for
 both channels
Message-ID: <20240519171438.08810789@jic23-huawei>
In-Reply-To: <20240517081050.168698-2-dima.fedrau@gmail.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
	<20240517081050.168698-2-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:10:49 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The mapping from cold junction to ambient temperature is inaccurate. We
> provide an index for hot and cold junction temperatures.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Hi Dmitri,

I'm not sure you replied to the question in previous review of what
sysfs files exist for this device.  Whilst I am at least a little
open to changing the ABI, I'd like to fully understand what
is currently presented and why iio_info is having trouble with it.

I also want an ack from Andrew on this one given might break it existing
usage.

The current interface is perhaps less than ideal, but I don't think it
is wrong as such. Whilst I wasn't particularly keen on the cold junction
== ambient I'm not sure moving to just indexed is an improvement.
Hence looking for input from Andrew. +CC Nuno as someone who is both
active in IIO and has written thermocouple front end drivers in
the past.

Jonathan


> ---
>  drivers/iio/temperature/mcp9600.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 46845804292b..22451d1d9e1f 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -14,6 +14,9 @@
>  
>  #include <linux/iio/iio.h>
>  
> +#define MCP9600_CHAN_HOT_JUNCTION	0
> +#define MCP9600_CHAN_COLD_JUNCTION	1
> +
>  /* MCP9600 registers */
>  #define MCP9600_HOT_JUNCTION 0x0
>  #define MCP9600_COLD_JUNCTION 0x2
> @@ -25,17 +28,19 @@
>  static const struct iio_chan_spec mcp9600_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> +		.channel = MCP9600_CHAN_HOT_JUNCTION,
>  		.address = MCP9600_HOT_JUNCTION,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
>  	},
>  	{
>  		.type = IIO_TEMP,
> +		.channel = MCP9600_CHAN_COLD_JUNCTION,
>  		.address = MCP9600_COLD_JUNCTION,
> -		.channel2 = IIO_MOD_TEMP_AMBIENT,
> -		.modified = 1,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
>  	},
>  };
>  


