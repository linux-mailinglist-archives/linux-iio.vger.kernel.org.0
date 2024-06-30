Return-Path: <linux-iio+bounces-7075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C991D101
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B89B1F21557
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C798132113;
	Sun, 30 Jun 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq41M4E6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054342AF04;
	Sun, 30 Jun 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741578; cv=none; b=lshL4U/VVdi3kW9IKT+4PixfICX9M9QhfQiKLATyAIbJNKKYxEsf8gK6v07UD6RQii6w6C2u6VTtspjAr6Trrh+HicauYXkSf+KTDYsiYz/I6m/ssK9UtK4lxYzp4hy5/VAaZa9ZiKzafxy/OaJCTMMvvTDhYuqy0409P+K/res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741578; c=relaxed/simple;
	bh=wjQ6UgVxjg9/waYG0NDm9wl5dx/o2lUYiGYyMHBQe3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlbCZG30i1IGkwKN29GQNdMGsZzus1mDQyxgJ1cYCQf6Y2XI9U2fYbrg5LOpzFxT13+EcYgBwhpIsHfnSotymY8sfs8uxzHqRkB7tpfX5H64ULB+QI/2JARjLhuAlqjwJUHjcdK5um7wvU2EODQ9nqwUvBt1O7hBlotiAzYFQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq41M4E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE9CC2BD10;
	Sun, 30 Jun 2024 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719741577;
	bh=wjQ6UgVxjg9/waYG0NDm9wl5dx/o2lUYiGYyMHBQe3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rq41M4E6vrkD5CxsbnvLVc9VsYNoTV80uuhwFYVvYCmM5uu3a5aic/k57BMaJnXWZ
	 RTuzGW1fjWDB/i9k9AiNmJzqhUHtgqLYud/pHtFcMGKlfqdeZZmzIsD7edSpAeNlRI
	 Jb7gIOM7gRtKJrC9LgsIBlDedTRS6pWgpXhngTkkpLFaFqfiO2jCQ5d7BY+HHWPmoW
	 GPpwmBtJXbhlbLN4Q75mBD5XkrrL0Vp2GQ15+6JrOuvgZ7+XEhfnRPD1k0IOWlnqN9
	 Ur+OglYcXmjfgn1UppfpsypxI4MTNjJYFHqBXhM314NkeNzLra17x1zp51BY6XdeXN
	 Iuq0Gmwn91Uow==
Date: Sun, 30 Jun 2024 10:59:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 6/6] MAINTAINERS: Update AD7192 driver maintainer
Message-ID: <20240630105928.1e3aa6bf@jic23-huawei>
In-Reply-To: <20240624124941.113010-7-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	<20240624124941.113010-7-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:49:41 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Alexandru Tachici has not been active. Also the email address included
> is not reachable anymore. I was assigned to work on the driver instead.
> 
> Remove Alexandru Tachici and add myself as maintainer of AD7192 driver.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
I'll pick this one up as well.

Applied to the togreg branch of iio.git and pushed out as testing because
other stuff on the tree needs build tests.  

Jonathan

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9517093d889d..ab1e82fd3b76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1217,7 +1217,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
>  F:	drivers/iio/adc/ad7091r*
>  
>  ANALOG DEVICES INC AD7192 DRIVER
> -M:	Alexandru Tachici <alexandru.tachici@analog.com>
> +M:	Alisa-Dariana Roman <alisa.roman@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers


