Return-Path: <linux-iio+bounces-26068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB99C43F4D
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA633AD785
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2982FB968;
	Sun,  9 Nov 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCF42VMg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13081CFBA;
	Sun,  9 Nov 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696658; cv=none; b=rx8BT+SWNkqUEgZSRvD9bODSlkbrno1IVjJWFFQc0TQFCz4vg+LXe2hbP2S5uwfnCbryqBVFepInVLRZVEkKyvHiT1fKte/IyDESJwxzBx58B+tNjbdUe2riN+e6CsIAHOEHY0Trvr0VmJOzSMBO6TC+N9nNrj6DI9fJMK4L7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696658; c=relaxed/simple;
	bh=sqCExe7TvzBIlrizfDnjeq9qTbAz4DDhCt3BiP31r3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZBMNiUhPCN/OBjUoqLEq6azZnXI5SWq85IY9mogyoyLDEtsOvanUQYiMchi55PVUovJ0m9fu68mCPzye9dpGFtOgfU/F9M8Znf2Es0idzy3sGliGesg75ngkW5KowE9UjP7+HR7cubKKya5Bl5jyxuFbTsD8INWxWMYr/rLJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCF42VMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CBC4CEFB;
	Sun,  9 Nov 2025 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762696657;
	bh=sqCExe7TvzBIlrizfDnjeq9qTbAz4DDhCt3BiP31r3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCF42VMgrNTEJSwJI9nVyj1xVoa9C8Ec+DDNCfCCVvK2K2Hb02oAAdYyEU/c+N7Yo
	 0WTZXStAS8Ac9tB1HMeeA55W61N7L1JuQlzfSuk3o4zaA/JdY8BVk2TYEMW3AqerZL
	 /Cn0lzdAzictXV6gHm+jrUTcl1Rf1J/N3RCfdI/NeLle9maxwPjcOlj04S4XyJ0IIK
	 6nk/7EceagZuwTL6FFJN3Pta384gOpOjA0T3wwM5KVL9ROaUxXKBCHyKTBzLRviK4D
	 wQ6a+wdYk0EoOlMG9kiPpDHSomklmr/jSd0Z6a2yu6jJQQnILF7KOOThgrIq1sbX0i
	 WGiAHXPaayIzA==
Date: Sun, 9 Nov 2025 13:57:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, linux@roeck-us.net, Carlos Song
 <carlos.song@nxp.com>, Adrian Fluturel <fluturel.adrian@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v11 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251109135728.223d3857@jic23-huawei>
In-Reply-To: <20251106-i3c_ddr-v11-6-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
	<20251106-i3c_ddr-v11-6-33a6a66ed095@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Nov 2025 12:36:05 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v11
> - add andy shevchenak's reviewed by tag
> - use unsigned int for regmap
> - compact mmc5633_read_avail arg list to few lines
> - move check condition to one line for read_poll_timeout()
> - leave i3c_xfer as size 1 array to align existed code style in kernel
> tree, git grep -r i3c_priv_xfer drivers/, leave to jonathan to do decide.
I don't feel strongly either way, so fine with just having it as
you have it here.

I'm assuming there will either be an immutable branch that I can
pick up to get the i3c changes, or that we'll split this across cycles
(so i3c bit goes in this cycle, driver next).

So I'll keep an eye open for how that part merges if everyone is happy
with it.  Feel free to poke me if I look like I missed it.

Jonathan

