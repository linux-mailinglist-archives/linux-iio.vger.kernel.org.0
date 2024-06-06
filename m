Return-Path: <linux-iio+bounces-5880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25358FDF3D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA571C21647
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7D7346A;
	Thu,  6 Jun 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ipXs7rL4"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBC1759F;
	Thu,  6 Jun 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657282; cv=none; b=Qg/sO9GLz7U3aGCfspphrrL8FzGpJhg/ENzX/vH0sQ9RJZ98O6K0tAzUl2x0XedXOcqTkpCw20IuFv+KR9JwmxtRAoXVaFofw/cRGUMewxuxvQ70dRXdjLxSF7OfUaegkVZINyqJgLvqS7JZUY/9PHTpAoIBlU9SrD/eKg6eip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657282; c=relaxed/simple;
	bh=8Hy+HCwbH5J4IOPU5GWj17/lZaRma3rg/Kxm8Kd/tBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e38OiDEmaw6PRMDx35mmMn898XKuPLrkrZmAmiTbD/2YW36bbs8+Pl+MmMTZO/XzKvvoWPWQXwq/ZqaS5/nNu5BNUR6BPKvTCmfOYfXQ3fLr4D98mJ/Bq/Ir4ida4j04eOQMFn7rKb2TAuj+1KSId39Myh7I7Q8k9O9V7d4UJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ipXs7rL4; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=tQej+T9pnqq3P5SIWfflEa+IdT6ZnzjAMSpJZ+7Tq5A=; b=ipXs7r
	L4HMp2TA3YX1inqNshlY524Wop3grBqEwkCt5gFtINEimxTFVgD5zmu9hTLjjObCPcmfA0nruo/VZ
	rWTd+pJ8i4ZDNFJLEllm6z0s/VHjmXQoUhty5hVEnl6/P5S/2vedlrOQmDzGP99eTeR9WJ82qN08r
	fL3ZzyVHTd1goTYyQI7ZpR+6vyv+bohRuCXIFYuxXUGbMmpJrsduyvoVeP7fBuZJ6Bq7vqutMUysk
	mnf0zifPN2Vpnrmdo2XKgL7yi3jBi7dGTVJMjJph//i27uVhl9tEz7933aHQkQ4oe8vGhHAzMTGla
	wXuQfyEyyF8IEmlCFw/V0fvn1m5g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sF77a-0007WA-RG; Thu, 06 Jun 2024 09:01:11 +0200
Received: from [185.17.218.86] (helo=Seans-MBP.geanix.com)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sF77X-000N8S-0t;
	Thu, 06 Jun 2024 09:01:10 +0200
Date: Thu, 6 Jun 2024 09:01:10 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF
Message-ID: <sdlebaxls5al3hzbhzeqnt6j3iijgobkxtljzpkn6how6cgywq@ipane3aqqdzv>
References: <20240605203810.2908980-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605203810.2908980-2-alexander.sverdlin@siemens.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27297/Wed Jun  5 10:30:56 2024)

On Wed, Jun 05, 2024 at 10:38:06PM UTC, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Provide missing symbols to the module:
> ERROR: modpost: iio_push_to_buffers [drivers/iio/accel/fxls8962af-core.ko] undefined!
> ERROR: modpost: devm_iio_kfifo_buffer_setup_ext [drivers/iio/accel/fxls8962af-core.ko] undefined!
> 
> Cc: stable@vger.kernel.org
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c2da5066e9a7b..80b57d3ee3a72 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -330,6 +330,8 @@ config DMARD10
>  config FXLS8962AF
>  	tristate
>  	depends on I2C || !I2C # cannot be built-in for modular I2C
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  
>  config FXLS8962AF_I2C
>  	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
> -- 
> 2.45.2
> 

