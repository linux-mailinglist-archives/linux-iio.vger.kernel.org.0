Return-Path: <linux-iio+bounces-9889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124B989682
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CEC1F21892
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9025225D7;
	Sun, 29 Sep 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbeocwxz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859822231C
	for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630618; cv=none; b=l+c8w5KFp10xqWLT5d1mejtwrFyeV4qT3PjRf0wr93VIxi7+FTunK8Jr00F+R4K3SVuWf/8Vy9ZMy1nAk/8JjZVUo/Rccqbftm91ArVm4T5vPNyzkKZ0+wEpnpVZhv6s4+h5qvG8uJOTHb8EcE6yQ8NdJkwNrGqF5DrB8yCJjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630618; c=relaxed/simple;
	bh=RzEJ/AsZtB7KXVUt54YC6rGCMQnwS016SvyDtTIX4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8jdSTDM2fLL3B/XxXsQJL05SE6FR0O1KaC5koh0dgizw9xh3Df2gR8RPp820Ct0atP03Mf0twYvJBbx6APWLvHk0TtYw96v+49zCSO+CTNqn25HgnZM3eO8fJPeiTOpHJ2+4PExdL5MV2bRUuqrcQH4PKXhGvjtEZZwcD61+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbeocwxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA76C4CEC5;
	Sun, 29 Sep 2024 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727630617;
	bh=RzEJ/AsZtB7KXVUt54YC6rGCMQnwS016SvyDtTIX4O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BbeocwxzrHbCacmSOrdxsAbsgc1AjZxj2Xig1BQr/u21vvPSKANA43G7cEcM3KhgZ
	 7UJb1pjSn5IpeoNZtj206zJ9IWHfJzZ+N2P7JmW/rwOYZU4a3LRJfR0VUimTvwgfNU
	 g+OMuD8D+TT3A0IW5CszRwRzuND1+t7SsQU/yV6lf846nAYX0nP0qbqB8hTgXskb2y
	 WXHWOyDWFOjaz3zcAZsk0IfnGWGdRvK8VSaOvaSRQcw1Y4wzNPTV9VD2ycBKiOoT/E
	 cBzVN8hob+N87cvJ7VQmWFNnAJIvj3U+aV/G12ITdUXwnQRE1SCbcOIH6P4He6Clvu
	 HOwnfnVnFKZdg==
Date: Sun, 29 Sep 2024 18:23:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: pressure: sdp500: Add missing select CRC8
Message-ID: <20240929182331.2d532cd9@jic23-huawei>
In-Reply-To: <20240929172105.1819259-1-jic23@kernel.org>
References: <20240929172105.1819259-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 18:21:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fix:
>    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_probe':
> >> drivers/iio/pressure/sdp500.c:130:(.text+0xe8): undefined reference to `crc8_populate_msb'  
>    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_read_raw':
> >> drivers/iio/pressure/sdp500.c:74:(.text+0x200): undefined reference to `crc8'  
> 
> by adding missing select.

I've applied this one to the fixes-togreg branch of iio.git so the build issue
stops occuring in linux-next.

I'll be rebasing that on rc1 shortly anyway so if anyone wants to review that
would be ideal!

Jonathan

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409271341.0dhpXk7G-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/pressure/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index ce369dbb17fc..df65438c771e 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -253,6 +253,7 @@ config MS5637
>  config SDP500
>  	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
>  	depends on I2C
> +	select CRC8
>  	help
>  	  Say Y here to build support for Sensirion SDP500 differential pressure
>  	  sensor I2C driver.


