Return-Path: <linux-iio+bounces-9862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC99894D2
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96902853DB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CE14D6E6;
	Sun, 29 Sep 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6Xe5zQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6C3C00;
	Sun, 29 Sep 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606336; cv=none; b=S/7xk1DEIfvhExXvESv9C4R/62FaPCeoI1r8wDbbo7sWLQdCxFvRkOopbOk/YAw0r/Ci4PxSTdhvY4ul/vN7v5B4xyQWfdRLRoKVU2kFK24Pq4KkuSlq48wJHNAK+jz0Zr0nfEy4h+a/F1GaRVBO8tehNrSjJ/8roTzCJt9yWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606336; c=relaxed/simple;
	bh=YBpyBquEfJujqvJ1DdB/62ACgpbbhxGwQxCwC79CJUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEnC2cZ+p2AgnvL33+BPzS+TkDA4lr44WNLdfM6jOiUx7ULHvL9KSYoxvqfU3FI/3pZCU2CGms4sqT/xSLwJVfFt3F8WiAGIKzjq5LnSemqigbvujCMh9/g3gsoZFJbzQAYExmthAEThaYwSuuDjoxES4EShbAhfhUC7wIsxu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6Xe5zQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23050C4CEC5;
	Sun, 29 Sep 2024 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727606335;
	bh=YBpyBquEfJujqvJ1DdB/62ACgpbbhxGwQxCwC79CJUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6Xe5zQcSNpJrai5WSdTaQKuLyH7K2x6JGZcC5KMeS2zNOVKIWhWbBkGLoepwwbNa
	 A1+UE7ivRiGEHW1zDQPswCi+jD/WBXSZpb5TW75WN0day5MI87xrL+0nXMhZIhOxxg
	 ceQFChQ33EIeJ5VdhgO2b7/TypsSXN/gzMcMFBY+IJj7wHFMF2TMoRC3Ic/EgsEgRU
	 u8s+c4LLWd64A4nm2UlEb6ueVE8SowQF3WSevQLieCni2xEGTvis6EDR51BPwdIHbq
	 cYonGyMepbHWJXtHysY6KJ1vCqqjJfFQittmG0HYzgBhycaRSjb8Bk5qGzNLugWrFc
	 X7mxNxEkzNlNg==
Date: Sun, 29 Sep 2024 11:38:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH v3 01/10] iio: backend: adi-axi-dac: fix wrong register
 bitfield
Message-ID: <20240929113848.6d3affb2@jic23-huawei>
In-Reply-To: <c247b5dab409475633ea8dac5ad23fb75aecb1ef.camel@gmail.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-1-a17b9b3d05d9@baylibre.com>
	<c247b5dab409475633ea8dac5ad23fb75aecb1ef.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Sep 2024 14:45:42 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-09-19 at 11:19 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.
> >=20
> > Both generic DAC and ad3552r DAC IPs docs are reporting
> > bit 5 for it.
> >=20
> > https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

Can also turn these into Link: tags though that isn't particularly
important for reference links like these.  If you do, they are
part of the main tags block so no blank line between them
and your SoB.

> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > --- =20
>=20
> Ouch... Missing Fixes tag. With that,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 0cb00f3bec04..b8b4171b8043 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -46,7 +46,7 @@
> > =C2=A0#define AXI_DAC_REG_CNTRL_1		0x0044
> > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_SYNC			BIT(0)
> > =C2=A0#define AXI_DAC_REG_CNTRL_2		0x0048
> > -#define	=C2=A0 ADI_DAC_R1_MODE		BIT(4)
> > +#define	=C2=A0 ADI_DAC_R1_MODE		BIT(5)
> > =C2=A0#define AXI_DAC_DRP_STATUS		0x0074
> > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_LOCKED		BIT(17)
> > =C2=A0/* DAC Channel controls */
> >  =20
>=20


