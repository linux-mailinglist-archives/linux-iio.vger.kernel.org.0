Return-Path: <linux-iio+bounces-19868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B630AAC3411
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5773B614D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAB1EDA2C;
	Sun, 25 May 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trQwOgRO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AED43ABC;
	Sun, 25 May 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171235; cv=none; b=lBmZjQCmRaG9W07ewKiX4PlVvZaAFxP55HJAMMhcfiDUmAzkXsQabBuoVo8HKE/fpi34nqj3KrVuSFMDgp0jRaUoQM2FE3Y/mUELhLA6A/awxubsQaoBYRnWStugdoCoRTuDtc/Cr0ui90n7kPureAU+e2XpjS8inURYbx6uY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171235; c=relaxed/simple;
	bh=qpXaGvujtarEfKk3BiIc4HM0wrXt417FYc6nr/MLq9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry0fsFa16bI1qLDm160jcgyz6c2MYouDu2CR4FShwsO9xQxc58uEU28EedPZP2pN1+lmBqMOhC9q7rbGKpeFK3EqQSHllSWljs8SeWPkUGcqAJsfsPGK7dG6JzFFLo/exrAeQCAyNTQI2NrX3QG3Uaw8ywOmQFlBeMq4puXqyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trQwOgRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71763C4CEEA;
	Sun, 25 May 2025 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748171233;
	bh=qpXaGvujtarEfKk3BiIc4HM0wrXt417FYc6nr/MLq9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=trQwOgRO3ZBurIDEXNGoXPzj74AfvQE1XK6bGsrIANWvbrjZnmGyGFYMeopZANPnE
	 KmYX19dVAgxqsH3yI2zkZJh3mH/1zP48IP3bSQIBL4TS+0B0ooRou05sO69obTLaHN
	 68bbcSKlAAWdjz2wXUVrtI6/N8p8NUn8GOL0PUnrSwwN5/WBL9iIMOfS8F3maHrAJR
	 KEBLoYrZKtv8c5diphgYPxAJHdYs6LBlXv+ULmf4LrbZ5pJ/TkUFz/Y2aUu8OvWZ4A
	 RkCvmOrCOpfCY/r3c/pJt83E5n8Qw9gMp1hHfqUK6gPbmb+8rZk3c81NprMUwhdF+Y
	 Bios84jblFpKw==
Date: Sun, 25 May 2025 12:07:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 u.kleine-koenig@baylibre.com, tglx@linutronix.de, robh@kernel.org,
 jirislaby@kernel.org, fabrice.gasnier@foss.st.com,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Fix race in installing chained
 IRQ handler
Message-ID: <20250525120703.5dd89fc2@jic23-huawei>
In-Reply-To: <229cf78caaa7e9f2bb4cfa62c019acd51a1cd684.camel@gmail.com>
References: <20250515083101.3811350-1-nichen@iscas.ac.cn>
	<229cf78caaa7e9f2bb4cfa62c019acd51a1cd684.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 May 2025 11:26:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-05-15 at 16:31 +0800, Chen Ni wrote:
> > Fix a race where a pending interrupt could be received and the handler
> > called before the handler's data has been setup, by converting to
> > irq_set_chained_handler_and_data().
> >=20
> > Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Looks good to me and I've queued it up for after rc1.  If any
ST folk have time to take a look that would be great.

Jonathan

>=20
> > Changelog:
> >=20
> > v1 -> v2:
> >=20
> > 1. Add Fixes tag.
> > ---
> > =C2=A0drivers/iio/adc/stm32-adc-core.c | 7 +++----
> > =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-a=
dc-
> > core.c
> > index bd3458965bff..21c04a98b3b6 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_dev=
ice
> > *pdev,
> > =C2=A0		return -ENOMEM;
> > =C2=A0	}
> > =C2=A0
> > -	for (i =3D 0; i < priv->cfg->num_irqs; i++) {
> > -		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
> > -		irq_set_handler_data(priv->irq[i], priv);
> > -	}
> > +	for (i =3D 0; i < priv->cfg->num_irqs; i++)
> > +		irq_set_chained_handler_and_data(priv->irq[i],
> > +						 stm32_adc_irq_handler,
> > priv);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0} =20


