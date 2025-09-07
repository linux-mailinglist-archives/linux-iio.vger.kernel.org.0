Return-Path: <linux-iio+bounces-23869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF6B47BA1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEFC189C7FE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1918BBAE;
	Sun,  7 Sep 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnxQecJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F719156C40;
	Sun,  7 Sep 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252062; cv=none; b=nUBFzoo7nrdYpLDMWjqNgeOlyKOKYR5PcyoErxBENHtmjHAshO9s2lmKIm/+v6uAzx/pnWJaVWi5Z26vxMHCamiTuxdSp8FA5b/Cp7v/9k0e2xUsE1I3e3rTM2ozsvzGudNcK3GXAHRIcu5ypZRsEAF/q2/7yo45VzYsvnuMpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252062; c=relaxed/simple;
	bh=pY4sM7731rLtwtWx7SHDocVcVir4gsRth9pnp3LRSW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WenWSUQ1Hvku4dt/5RHqO9D1VyHjdA6o/FdT9Fu/Fipqe7WT1iaqeC+DKd1AxqT6tbdJaXh6L5RG0NixIA0eJ2rDj8uVq0udG/1eX1a9a+vicxtTmXmE458Za0EilrnYxVpntTkASBcO2ZrfEv6n2wdjFWUnNHABby0BGD4MuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnxQecJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF7AC4CEF0;
	Sun,  7 Sep 2025 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757252061;
	bh=pY4sM7731rLtwtWx7SHDocVcVir4gsRth9pnp3LRSW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnxQecJLscRbDrg6MjfmWR2Jwaq2SbimZZOHTCSKAMytDpq8ue6KQn2jrDtkmm/eg
	 Xz9GozlgksnhAeffwqh31H+tKiG9zTZfzzJj6H+TVzTC+VblcNvdJggnbUkMCSfsI0
	 +l4BzORL30IOurvB4NzNuX9P9BxxQk/Sa0S2sBmgd2/2M7GxeB0zpUCZEMbq2sBWcC
	 0/x2imxsfWMu+zXGYYZskFfRKG40SByaRkngPo+O9/RcEzs0gW1RsnvCXdbnVZhXbe
	 AKaDkmRhm6vV+95fsYHautteJUNOPC9zKM8zeagwBacb09UusmSvBsMwcGEDwHL938
	 6gTU6cyub3aew==
Date: Sun, 7 Sep 2025 14:34:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250907143411.043fa23f@jic23-huawei>
In-Reply-To: <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
	<aKbk9WYtfb5L5la4@smile.fi.intel.com>
	<FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
	<aLmY2mKg_FsPOpsq@smile.fi.intel.com>
	<FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  
> >> >> +#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES {U8_MAX, U8_MAX, U8_MAX, U8_MAX, }  
> >> >
> >> >When one line, no need to have inner trailing comma, besides that missed
> >> >space.  
> >> The trailing comma was a request from Jonathan Cameron on the v2 of patchset.
> >> Let me know, if you disagree with him and I'll fix.  
> >
> >I see, then let's ask him, because it's a usual pattern for
> >the one-line arrays like this to have no inner trailing commas.  
> Ok let's wait Jonathan Cameron's feedback.

Definitely ignore me on this.  For one line arrays any change means that
line changes anyway so, unlike multiline arrays there is no reduction in noise
by having the trailing comma.

