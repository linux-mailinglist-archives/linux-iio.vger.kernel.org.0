Return-Path: <linux-iio+bounces-3572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D140F87DB6D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 21:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6731F21B06
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1F1C6AF;
	Sat, 16 Mar 2024 20:14:46 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4971C68D
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710620086; cv=none; b=gbXQjGdLFNXIhseaEDljH5lJlv4o98LOM2khbm1Gxw/WC9uVoceRmiZXdVE+KDy3S2dSnF/VMB8sFFiXWekm2czS+JsvpOUL95E5wVrsCtBhNGkEhUy+Rmmdw6Wk2w4Hp7dJVk8J4QgYpA2tktSlBGk/00FztlEndVQeao63hFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710620086; c=relaxed/simple;
	bh=RauXkEzmN7SZO4F1m+jEV8VKhQgNgAvhOgY28JNq/wk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl4bOOEHzToiAnZoFfxAptq8Sz1UtKno1Iq7++J5ve6sPcds4Xee8ItIOa0WzhFHDdHxb0eTNfZAUFO2TwJpt+qb3XCuJT/9oY6uS52qO/QYpJUNm4xFtCKMxulLcoDe6mzVnWT3brl/sL3LM2C8NI89aGeCiorBDbkhAxrR0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id cf37add6-e3d1-11ee-abf4-005056bdd08f;
	Sat, 16 Mar 2024 22:14:36 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 22:14:35 +0200
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <ZfX9qyFUPwARjCVT@surfacebook.localdomain>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>

Wed, Feb 28, 2024 at 02:12:54PM +0900, Dominique Martinet kirjoitti:
> From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> 
> When using dtb overlays it can be difficult to predict which iio device

DTB
IIO

> will get assigned what index, and there is no easy way to create
> symlinks for /sys nodes through udev so to simplify userspace code make
> it possible to request fixed indices for iio devices in device tree.

IIO

> 
> For platforms without device trees of_alias_get_id will just fail and

We refer to functions as func():
of_alias_get_id()

> ida_alloc_range will behave as ida_alloc currently does.

Ditto.

> For platforms with device trees, they can not set an alias, for example
> this would try to get 10 from the ida for the device corresponding to
> adc2:
> aliases {
>   iio10 = &adc2
> };

> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Guido G�nther <agx@sigxcpu.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Please, make sure you don't pollute commit message with these.
Either use specific --to and --cc when formating patch or move
them into comment block (after '---' line below).

> Signed-off-by: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

...

> +#include <linux/of.h>

What about ACPI?
Please try avoid hard to use OF-specific code for the new features.

-- 
With Best Regards,
Andy Shevchenko



