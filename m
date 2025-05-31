Return-Path: <linux-iio+bounces-20071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC473AC9B9A
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70003B3316
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C89155C87;
	Sat, 31 May 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWQZrisG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AA17BB6;
	Sat, 31 May 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707004; cv=none; b=jr+MDq2JawBAzcDF0cRgkb/aG56T9oPNnern+kNmp5Kbt6DQuF9MuxW3acpW16QnYmezC8Ya7uK9qysY7raHKpTdHT7b1geUIzFJlTn7n5xVqkCOfslDkEplRxt5COtF8zaaocIhX0vwdhI3j7vJMdwt96QsLdmq1ucguCZ/AWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707004; c=relaxed/simple;
	bh=Si0gaSTIfmA9UreI5SjdzlMFGHES65UvOtKJTsLJWeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+iGpWdtjCJ/it5MZVumjBOYmBGt+wxPSuhi1qekTx1g8/KBwIQN4CcH/yxypIXivhQZBrFRMxjE6AxKwYoEoSS6U7KMNY6RjQVQCs3MrQAE9ocCoyRGXtMNCJeTM81coYbQp/oALw2XobOMgFsieGmgXpPHGq7L01p1s2xA5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWQZrisG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90EBC4CEE3;
	Sat, 31 May 2025 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748707004;
	bh=Si0gaSTIfmA9UreI5SjdzlMFGHES65UvOtKJTsLJWeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWQZrisGAesr6zhFA4NExGYhOrZS8k5bUecjEphb+vIBGYHPwTBeqB50DJHsFf6g4
	 wJxcUDzXyg1sxo6zg2VhlpzelUyteHsGQe+xpjCMwTNt6RAtOIMqj3U8BWjIr/DyUT
	 IPhro+M4iwUH/6LIylWdCUwzGsn0F9dLfWkPG2TYSh7RTMG47E+L3rAByuJ0r4H2IF
	 tDBBmefxYoGefboyx6ohp3VOOuFovzk7k2hrr1+Bv9p97h0Avkiix4mJTt/tQj0YUk
	 Sz2d7f0wxpd54jYj04AszohRxesb3wcEnk1uA7PKDsRxNm57yZq/br3R+EVNXAH0ok
	 sxQwY08AnAQkw==
Date: Sat, 31 May 2025 16:56:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Chen Ni
 <nichen@iscas.ac.cn>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, <u.kleine-koenig@baylibre.com>,
 <tglx@linutronix.de>, <robh@kernel.org>, <jirislaby@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Fix race in installing chained
 IRQ handler
Message-ID: <20250531165635.262839dc@jic23-huawei>
In-Reply-To: <ab75c390-b172-4dbb-b46b-8cbf64d4600a@foss.st.com>
References: <20250515083101.3811350-1-nichen@iscas.ac.cn>
	<229cf78caaa7e9f2bb4cfa62c019acd51a1cd684.camel@gmail.com>
	<20250525120703.5dd89fc2@jic23-huawei>
	<ab75c390-b172-4dbb-b46b-8cbf64d4600a@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 17:48:31 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 5/25/25 13:07, Jonathan Cameron wrote:
> > On Thu, 15 May 2025 11:26:56 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> >> On Thu, 2025-05-15 at 16:31 +0800, Chen Ni wrote: =20
> >>> Fix a race where a pending interrupt could be received and the handler
> >>> called before the handler's data has been setup, by converting to
> >>> irq_set_chained_handler_and_data().
> >>>
> >>> Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
> >>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> >>> ---   =20
> >>
> >> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > Looks good to me and I've queued it up for after rc1.  If any
> > ST folk have time to take a look that would be great. =20
>=20
> Hi Jonathan,
>=20
> One minor comment at my end, not sure if that changes a lot...
> This could be a fix for the older commit:
> 1add69880240 ("iio: adc: Add support for STM32 ADC core")

Agreed. I've tweaked the message.  It won't apply cleanly all that way
but at least we flagged it for anyone who cares to backport past the code
movement in the Fixes tag Chen used.

>=20
> Apart from that, you can add my:
> Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Added.
>=20
> BR,
> Fabrice
>=20
> >=20
> > Jonathan
> >  =20
> >> =20
> >>> Changelog:
> >>>
> >>> v1 -> v2:
> >>>
> >>> 1. Add Fixes tag.
> >>> ---
> >>> =C2=A0drivers/iio/adc/stm32-adc-core.c | 7 +++----
> >>> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32=
-adc-
> >>> core.c
> >>> index bd3458965bff..21c04a98b3b6 100644
> >>> --- a/drivers/iio/adc/stm32-adc-core.c
> >>> +++ b/drivers/iio/adc/stm32-adc-core.c
> >>> @@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_d=
evice
> >>> *pdev,
> >>> =C2=A0		return -ENOMEM;
> >>> =C2=A0	}
> >>> =C2=A0
> >>> -	for (i =3D 0; i < priv->cfg->num_irqs; i++) {
> >>> -		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
> >>> -		irq_set_handler_data(priv->irq[i], priv);
> >>> -	}
> >>> +	for (i =3D 0; i < priv->cfg->num_irqs; i++)
> >>> +		irq_set_chained_handler_and_data(priv->irq[i],
> >>> +						 stm32_adc_irq_handler,
> >>> priv);
> >>> =C2=A0
> >>> =C2=A0	return 0;
> >>> =C2=A0}   =20
> >  =20
>=20


