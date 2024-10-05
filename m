Return-Path: <linux-iio+bounces-10205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69F991918
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24DA1C2120A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642A158DA0;
	Sat,  5 Oct 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVlGu9re"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736611581E1;
	Sat,  5 Oct 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151027; cv=none; b=L7+Yx3//4DyyHMtO2agMFSpxhARdkX2icCd/lnLFFk/qHCVbiGUeTxaZZ2TkHvravRNjMfVgCfrhYXJjljyb1Q/VzxfuqIqIWcjRjZ/IggiR+h66I/6UnkpxNUqXe7BauG5gywLLGzfKT4NTBBTVbLRAz6k9UnwrilzYf1u9t0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151027; c=relaxed/simple;
	bh=mtH4gSy9l8tE8uzzYtbITtxmrnPW0f5zDCiE8Pebsxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfiJTRYHIHItLEr5JqEpnJrFbPulb41qO8haK0wTgrPImblS0niRsgmkNmZ6EIQEg8GAcgUPseR4+0LENy7V1spQNQ8Kgn9oNXRKDzZlqNUTFBSR8LTvGSg5E9VXX5H/jpVlefgoOZTOib5S7B24P0dZNvk875Fe4UFAC9ubSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVlGu9re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D827C4CEC2;
	Sat,  5 Oct 2024 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151027;
	bh=mtH4gSy9l8tE8uzzYtbITtxmrnPW0f5zDCiE8Pebsxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVlGu9retiOaZiUSQkaVuyTk7Y5XTY5UwFUrtaSRuMymz7l5oCCzsrdJ1fFz3jsm+
	 RtHTwwcvkXBpQGQjEMAwN6XXt7rWTpNEqfLZYn2fydGNRu+Tr02lWxeveb+a+7JOs2
	 QVP1/2jM3QXBi8RodrTOckQtlG2jdmE55KaEKpV/mmBMh6zecuh9ztg3SWrjBSpPIS
	 gbgZRPaCXwuHfNmJq35IEy+GFv4IuR0sDknEBR58n0VllfDIVqMJx4AKlpUKBsqBO/
	 U2ka675KeY+gZATDKv4JJQwJHzGHf+AgaOy52zSRx24d7DeUUX1hND9MvZBi3AoAW7
	 8OfEBhdWtMoMA==
Date: Sat, 5 Oct 2024 18:56:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Dan
 Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris
 <mihail.chindris@analog.com>, Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Dalton Durst
 <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 10/13] iio: light: bu27008: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185633.5869e14d@jic23-huawei>
In-Reply-To: <c30c46c5-7f6d-4230-be7f-d7fd766bc1c9@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-10-67c0385197cd@gmail.com>
	<c30c46c5-7f6d-4230-be7f-d7fd766bc1c9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 11:16:05 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 04/10/2024 00:04, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: 41ff93d14f78 ("iio: light: ROHM BU27008 color sensor")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

