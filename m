Return-Path: <linux-iio+bounces-23970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8DB52705
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 05:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F2368580C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D322AE45;
	Thu, 11 Sep 2025 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Jlp7dF8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E1DED5B;
	Thu, 11 Sep 2025 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561371; cv=none; b=LC71QNg5sAdlZ8lQnWkaeQaQOzvg0DEy8a7YNEgr2Mc96hnfawzJAuLlmmUsPMrBsDxoVDTNochhMoWq8GQILXXJOJv0k+7p9x4YgORwYx3zobz8sMC5HmqnKBy2Q8/ifi8Eto1S8YQXULeDBAWuKl3TpHoa5SC0LMNvqVJ6i8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561371; c=relaxed/simple;
	bh=Crvb4ep+GzTDz3FDPezKf4ke3jvPh9XZQQA1JHuL748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJxLX7bMHD7V3GPrnmWp4Lygd1cPiaksMHAnfScq+cGJLLZtt1a4Uy8Fr9l7ioqhXj0p708Af7iWkDmTTaVtaRZBNxUsoESNYBrpxLn02HUkmy0W8CGUn46L6hJukCqyiMxdyaEz7Z90oyv677yxFcAza5/Rsm1+zATTGb8Iics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Jlp7dF8E; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=kRKVgwVlrlHXeIoAjUG+Ao956AyTqlrUkOb9mlU6Ixg=;
	b=Jlp7dF8EOQYNqnkO1u9td6C//tmb4qlxpPHsH/IXxv1Dt/BebJxWc0u8tGlbWa
	e9Ls9z3IWnJ49ymg76TH+VfVM9Hh85RXc8Fw8CGI7x84oZZhk2t1B4JsVWaqu6+L
	1Rrp0OpJg1nUlKsbQqE2mKmVzXfqXRHGFMnuHAe04rvT4=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3v_mdQcJoEpRgBA--.45504S3;
	Thu, 11 Sep 2025 11:27:27 +0800 (CST)
Date: Thu, 11 Sep 2025 11:27:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93-phyboard-nash:
 Current sense via iio-hwmon
Message-ID: <aMJBnc3p08VxrkhQ@dragon>
References: <20250905065503.3022107-1-primoz.fiser@norik.com>
 <20250905065503.3022107-2-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905065503.3022107-2-primoz.fiser@norik.com>
X-CM-TRANSID:Ms8vCgD3v_mdQcJoEpRgBA--.45504S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7cdbUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNx9Cp2jCQZ8yPAAA33

On Fri, Sep 05, 2025 at 08:55:03AM +0200, Primoz Fiser wrote:
> Commit 21179eae56de ("arm64: dts: freescale: imx93-phyboard-nash: Add
> current sense amplifier") added information about the current sensing
> circuitry found on the board. Now, lets provide current sense reading
> also via IIO-hwmon subsystem. This way, SoM current can be read directly
> via sysfs property more conveniently for the customers. No need for them
> to manually apply scaling factor calculations anymore.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks!


