Return-Path: <linux-iio+bounces-10109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04C98FD6C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 08:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A652832D3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6F12E1CA;
	Fri,  4 Oct 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RJsQeV3Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8E78B50;
	Fri,  4 Oct 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024042; cv=none; b=aF67BZnoDfjvb+9ntcPDrjjK8XTwv4eL3alq7JezroKlRQeFveZPilRchMZ8KSu7KsYj+Y2F5ub2khpVHJmQsbRBOD6xeCfQSthNQ1KinsvPvzw3Fok+7kmDJWnqO5eRWwjsk2hTrc+mEpQyQNCN3ifb58tOwEEUd4I9AxvePMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024042; c=relaxed/simple;
	bh=aeqM4bGEyzcSGiWEjHJ0vDOg/qG3bm++QBg+9vzMSDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7W7ofuqMwQVqA7d+3Ay/e6thr7k9LhMH6PFtG48TLsPBe/o4vOnUZfJw7tT5H47vTc8wLNvs2U6t9nidBO7aQoXFP91NA4n65zVHICgjUxzAky/xxiDn/Z0hkoMcSgBgoCXOrEWgGCCrrDxBzFqQqqNEnTwwKQSGq3qbpOmCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=RJsQeV3Z; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=1+xGLWpo1UDnHsytYp4SmFQVYRTjpu0Kwx3ROkcCuIY=; b=RJsQeV
	3ZJg3dcs4pBJMdiwh0OMxs8PjFlLDypR4O+/+EL6FxlsLekj7TCtPLp6HqiQhVLZrkwybA0JwUL7l
	mJBcp+rO4G4zDnlaBUBtJ5xl6UzTm+zQbqB7+Qojz+xVDBjvPGAp40bh4CVzM4Sfvirn4p9AahT+m
	GMLkZLxpnmQ1lVs2K832qT+De8kfFHoGorseYsEfuB8KDEdLvoGjkN/FIfKpx6un5NZujuvEIpVLj
	U6jT+n8m8FUWO8EM12fyDY/xKgKEWV/1RuMu9MvXpw64fWNVYTshqNPJU7GNoaz/AlaJwir1sZvXE
	zuIbGz5mHnkniVUeazYJngJrCRiQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1swbzI-000ENQ-BQ; Fri, 04 Oct 2024 08:40:28 +0200
Received: from [2a06:4004:10df:0:2881:4d66:6bd8:1d63] (helo=Seans-MBP.snzone.dk)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1swbzH-000Cfg-0x;
	Fri, 04 Oct 2024 08:40:27 +0200
Date: Fri, 4 Oct 2024 08:40:23 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, 
	Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris <mihail.chindris@analog.com>, 
	Alexandru Ardelean <ardeleanalex@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, 
	Shoji Keita <awaittrot@shjk.jp>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
	Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, 
	Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 04/13] iio: adc: ti-ads8688: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <4zckpahlrr7odq35gnlsjrae5lmkx3idexj7p67waibfhbooph@c5iwni4b643v>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-4-67c0385197cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-iio-select-v1-4-67c0385197cd@gmail.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27416/Thu Oct  3 10:37:25 2024)

On Thu, Oct 03, 2024 at 11:04:50PM UTC, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 45872a4e2acf..e6be1f1ec79f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1483,6 +1483,8 @@ config TI_ADS8344
>  config TI_ADS8688
>  	tristate "Texas Instruments ADS8688"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS8684 and
>  	  and ADS8688 ADC chips
> 
> -- 
> 2.43.0
> 

