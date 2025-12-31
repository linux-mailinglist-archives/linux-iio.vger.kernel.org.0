Return-Path: <linux-iio+bounces-27445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22640CEC6D8
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03322300B680
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A12F1FCF;
	Wed, 31 Dec 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6yfYu81"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81B1EEE6;
	Wed, 31 Dec 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204067; cv=none; b=FQEtYaUbYgFuh89jT1yQ2VZHSWzHDNbHIFQvGtphaBTz+qxy1meH+p9dy0sh2PD2FE4eEFpmnc/h6wPJOeRoSdbSX2JXgoY3b/oHOz2YlUDgMh95FvSflOvEQk+YZPk5NvyF4mrtI7YuKXubXnxittqYgAeT9TbdyAVC5RE9pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204067; c=relaxed/simple;
	bh=/JUAVuEmQnPRLOOrpsu9HYFaAs5yrYb5Mj8cMTlUK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Reks7gh0KxBC/exL0OfmoMaAnp1ztTSx7OclK0nzTgJJQNdcM4KMefth5f7j43vcN6AwuaWU2od5pfhKjvqlyV8e+zKK9s+QovLqk4FI8GE5AEMfOKm9UQOptr3qliLeFPGJAaA4mucrDXe0/K7UwI1NFsRP0gdOhzv7kxbFeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6yfYu81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFCC113D0;
	Wed, 31 Dec 2025 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204064;
	bh=/JUAVuEmQnPRLOOrpsu9HYFaAs5yrYb5Mj8cMTlUK4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L6yfYu811L7qyATLwGj9wW+RHjvw0j3EVY3aUeXpIg4NaPgki9Cs4wjGwNErb6Txo
	 Ia0qL+Qr2r3uw0jYEMi7x7gUcsBf/mA3G88cYpfbwm5G6p0biM3oNUqIZH1QsQJoKK
	 vEVF63TCfu2/huRnmoYngh4hG04msyN2ZYsuATI05ptyX7TQ2jQP2ZxVmB7MkygaRl
	 LIYMwRgZCSVtxYAurOLT5Q+aGqVpxJqnGLWzF3ivbY2nMVwIBCzZk6RLsoJ+mrzPIf
	 /M+SdL45UtSmXgcjaeNqxoCoewd6QUutCuznvTBmewkB1upgbd/wXJjKW0BI2x4+HH
	 qfNS3PFEWMwHw==
Date: Wed, 31 Dec 2025 18:00:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Cc: linux-kernel@vger.kernel.org, Jose Javier Rodriguez Barbarin
 <dev-josejavier.rodriguez@duagon.com>, Jorge Sanjuan Garcia
 <dev-jorge.sanjuangarcia@duagon.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
Message-ID: <20251231180057.7be409a8@jic23-huawei>
In-Reply-To: <20251230215928.62258-4-josejavier.rodriguez@duagon.com>
References: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
	<20251230215928.62258-4-josejavier.rodriguez@duagon.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 22:59:26 +0100
Javier Rodriguez <josejavier.rodriguez@duagon.com> wrote:

> From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
>=20
> The MODULE_ALIAS() is redundant since the module alias is now
> automatically generated from the MODULE_DEVICE_TABLE().
>=20
> Remove the explicit alias.
>=20
> No functional change intended.
>=20
> Fixes: 1f4ea4838b13 ("mcb: Add missing modpost build support")

=46rom the patch description I'm not seeing how this is a fix?
Seems like cleanup of unnecessary code given what you have written above.

> Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@d=
uagon.com>
> ---
>  drivers/iio/adc/men_z188_adc.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_ad=
c.c
> index cf8a8c0412ec..90919d282e7b 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -171,5 +171,4 @@ module_mcb_driver(men_z188_driver);
>  MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("IIO ADC driver for MEN 16z188 ADC Core");
> -MODULE_ALIAS("mcb:16z188");
>  MODULE_IMPORT_NS("MCB");


