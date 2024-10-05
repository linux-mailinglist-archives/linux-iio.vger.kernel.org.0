Return-Path: <linux-iio+bounces-10206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82F99191E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6593D283063
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB450158D94;
	Sat,  5 Oct 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwHg71Jt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25A288B1;
	Sat,  5 Oct 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151098; cv=none; b=CLdzCrKtvIWBchsrt+gPcwrZ1GKU1rUtrdLeV6iXhFVgDa3FObT7A9Ldx8n6BXWlQz6K6Z8RKaCdoJ81NJxESEnvMv/DfC4MZlwWS7/USw328YA+0Ndl2BIeJ2tH9mUOqQ8DFm/WwMzMoC5hbVT9LShlVSfunE24g14+bg1gmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151098; c=relaxed/simple;
	bh=jH2JcfiybZu7C5elFDABy8CKS07E7/dwAMgQkjKvDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miYcfi52TBtNDVB4BMViexgw1KrE19BBsV0LIlISXn5Z4n+KkrTmWA2o2WXxSX792LNm94r1FNON3m7LZzjyMpcMkrEiXRWTpV5ntsDMXuKa6iEI4BEk1xs4c2icCDOaW64bwO+QpCg5YfN4DlNG/bXlJOtt17q/s32zf0rskSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwHg71Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B872C4CECD;
	Sat,  5 Oct 2024 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151096;
	bh=jH2JcfiybZu7C5elFDABy8CKS07E7/dwAMgQkjKvDoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CwHg71Jt3/x/D638hZ/Vc8ZrDMzNUsQa9OzpAe4szdFSLfNUoES1e3VAhJnwTt6Ma
	 u1yxNnhCk+ymiNI4uzXafqF/Bc/tD+IavNdW+vAZkzB3wBovyvozGg6ofYJEtZdm6A
	 37uol65u6VoqtiHiL8OnlObmZzOM2Hbz5eMLFnjUahxzz1p7QLozJTVyCcigjtVjGT
	 83khuA7A/GAX4j9HurFLmSQA3ZSquyGCN3FKWP5y71ZcaRqAzq60HXw/rDie+kyl1Q
	 yH3vjEivPA/2MXAOEUYy4/X7CfhH2yqrQO2NQAX3UUz5RRPD68BIvHsO5ZRQ+3wIcD
	 zn+Drq99p/ZcA==
Date: Sat, 5 Oct 2024 18:57:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Dan Murphy
 <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, Leonard =?UTF-8?B?R8O2?=
 =?UTF-8?B?aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris
 <mihail.chindris@analog.com>, Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas
 Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 11/13] iio: magnetometer: af8133j: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185743.76b5c650@jic23-huawei>
In-Reply-To: <Zv-uJaMH4JFK_nvA@skv.local>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-11-67c0385197cd@gmail.com>
	<Zv-uJaMH4JFK_nvA@skv.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 11:58:13 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> On 24-10-03 23:04, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: 1d8f4b04621f ("iio: magnetometer: add a driver for Voltafield AF8133J magnetometer")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/magnetometer/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index 8eb718f5e50f..f69ac75500f9 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -11,6 +11,8 @@ config AF8133J
> >  	depends on I2C
> >  	depends on OF
> >  	select REGMAP_I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for Voltafield AF8133J I2C-based
> >  	  3-axis magnetometer chip.
> > 
> > -- 
> > 2.43.0
> >   
> 
> Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 

Applied to the fixes-togreg branch of iio.git

