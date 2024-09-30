Return-Path: <linux-iio+bounces-9918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74862989D72
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E9BB2403B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD91181B8F;
	Mon, 30 Sep 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgFPySr7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207F21105
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686595; cv=none; b=Sbs47J/+B7D7KhDhH4utQebA7LIvA/kgwvEJqIteVXu/xFZcJGv9TcDqTIWw2Vv2MAtOkQZFaV7wqSXHZwSMqHX7MI6ZrmeVbor+PMDR3EVdiAGJTnFLK+dYhB5qQ0Rx8Kg+/lKHAMoof4MfNYq/ie5DBtRZmrehrzIMhDtB6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686595; c=relaxed/simple;
	bh=0+B5vLVbzLn2rnQJZIG/n2IMRbWRTG1inq8Jri9+Uzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8gWVlPyDvgk1b3Wp/TOsp8hG8o003SZhvBp1zgVEYZl6oj/9vzuYf9JWXFKVGa2so6zwnkxtC41YaWUlpqhu01sKs9rqLgk+3TdV2IOL4hGRq2jfuSSElGnTVHqR1dQ2bVDJJNrjCy7uYJ5LS4NVbhzQ+8ApvQhBOoSMwagcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgFPySr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8212C4CEC7;
	Mon, 30 Sep 2024 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727686595;
	bh=0+B5vLVbzLn2rnQJZIG/n2IMRbWRTG1inq8Jri9+Uzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgFPySr7N07ou989JrhvEGSWNVyQzBVxEpDAxWxqPwGmRJEptRytkyWUI3dVIXMN5
	 +mhj3S1FG9EeisCbaei9+2VgzsKE8+Pg4Ux+RyLgscltTpkmWfowlAnmCea3emj5LC
	 l/CTvzDKa2G1IOGVjKrdsW2m2SZAFr/sHXY85owbxY2JmYxJfJkLC0gl/A2um0rAMA
	 Efbuy2bm6Bi6Q+NHf9F8y/144nbVNlVkU8+X6x0QcU/QNCojeqEOzjjvK0pzzPicgJ
	 W4S3hs11WsZQNMpnmQzBJVkXrnIN86cBsJt5kD88HWZJ6tiFLgzy+pRkmewtHZw4A+
	 moiiV5w7WDHng==
Date: Mon, 30 Sep 2024 09:56:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org, Petar Stoykov <pd.pstoykov@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: pressure: sdp500: Add missing select CRC8
Message-ID: <20240930095626.489f2ccd@jic23-huawei>
In-Reply-To: <a46869c6-57ce-456d-89ca-7bf01bcc2681@gmail.com>
References: <20240929172105.1819259-1-jic23@kernel.org>
	<a46869c6-57ce-456d-89ca-7bf01bcc2681@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 19:27:43 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 29/09/2024 19:21, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fix:
> >    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_probe':  
> >>> drivers/iio/pressure/sdp500.c:130:(.text+0xe8): undefined reference to `crc8_populate_msb'  
> >    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_read_raw':  
> >>> drivers/iio/pressure/sdp500.c:74:(.text+0x200): undefined reference to `crc8'  
> > 
> > by adding missing select.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409271341.0dhpXk7G-lkp@intel.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/pressure/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> > index ce369dbb17fc..df65438c771e 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -253,6 +253,7 @@ config MS5637
> >  config SDP500
> >  	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
> >  	depends on I2C
> > +	select CRC8
> >  	help
> >  	  Say Y here to build support for Sensirion SDP500 differential pressure
> >  	  sensor I2C driver.  
> 
> A good example where just including the header is not enough. I bet this
> is not the first time that something similar happens with CRC8, let
> alone before sending upstream :)
Indeed.  This is probably about the 5th time it has happened in IIO, yet
I still don't remember to check :(

Jonathan

> 
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>


