Return-Path: <linux-iio+bounces-19090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC628AA92A8
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1671895107
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21303211A23;
	Mon,  5 May 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfoOYGKY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5F20F098;
	Mon,  5 May 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446696; cv=none; b=amFcAL3ZrmYRwp8Ji8A4XDPcPNF+B+WG39sK3jm/uwB+rB911ZWI5AhcvpubexoSoT7GvXSz8R6JXYLv/sYx8eg2aOLoY8MzZoH1v4hU7Xf86CX0SxUbwjIP0L6b00bNELDj74k7HgKUf+n9smcPPHsslpzdEkhMN3kUTYC0/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446696; c=relaxed/simple;
	bh=R9WlJifQRmfUPd0XmkKuNtBr7Si9/5o603rGPk5oPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqERUMyKgq/Op476CBWv1QDF8jNih38WTfxXHXk/31X1yaXYoEDlZ+r0lFWd5nYDfCKJEF3fH2xWd8BPb/bpT4SYdZ9+yQn2bSMNKkgS1n6cx8Ctrli6uVBqBj60gZx+r3DZNJgj9e5ytWkxWFkCF19/w28UWcErjA1OvlGcuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfoOYGKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7112C4CEE4;
	Mon,  5 May 2025 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746446695;
	bh=R9WlJifQRmfUPd0XmkKuNtBr7Si9/5o603rGPk5oPnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CfoOYGKYGIA2Sx8PZH371D4ghhP5D/ilTqAL1uz3IyP2UhQQhlAWJHcU5YwT7sQDJ
	 ScNCPiP88okyji4jYYKxbvgj8Y6EkLVwmz8BY4kCSu8ry2FunYgQg6XD1xRJXvrh/k
	 GMYTp3r3F8onOHnAKDCXqy/Yui+4LmY1G+S/dTzsHIqhuPP4sQjh6qmZnrCsfmrGfQ
	 mLybIIeCGyUdTKtfyJl/155dfB8UPot7AE6xu2c/DhlGUcnbJBPwS2L8UOApTOyfJq
	 y0XRySA7QoOTse1kd81Hwg4Zf9dZHZK82b1YnRZdZgcze8hOQZlUpKiMzCzMa2XTjT
	 AI85eaMTw93CA==
Date: Mon, 5 May 2025 13:04:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Convert atomic_t ->
 atomic_long_t
Message-ID: <20250505130448.49eb1a73@jic23-huawei>
In-Reply-To: <91c00e75bc25267d57863494d638f0a43e499ac4.camel@siemens.com>
References: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
	<91c00e75bc25267d57863494d638f0a43e499ac4.camel@siemens.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 May 2025 09:24:18 +0000
"Sverdlin, Alexander" <alexander.sverdlin@siemens.com> wrote:

> Dear maintainers,
>=20
> On Mon, 2025-03-31 at 17:22 +0200, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> >=20
> > Convert the internal counter type to atomic_long_t, which:
> > - doesn't change much for existing in-tree users as they are 32-bit any=
way
> > =C2=A0 (stm32/i.MX6)
> > - doesn't introduce performace penalty on 32-bit platforms
> > - provides 64-bit resolution on 64-bit platforms with virtually no
> > =C2=A0 preformance penalty
> >=20
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com> =20
>=20
> I've noticed that the patch has been marked as "Changes Requested" in
> the patchwork, could it be a mistake? Because I never received any
> change request.

Probably a miss click by me if you mean the IIO patchwork.
I tend to mark all counter stuff as handled elsewhere rather than keeping
track of it in that patchwork instance.=20

Jonathan

>=20
> > ---
> > =C2=A0drivers/counter/interrupt-cnt.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrup=
t-cnt.c
> > index 949598d51575a..8df5457b0a076 100644
> > --- a/drivers/counter/interrupt-cnt.c
> > +++ b/drivers/counter/interrupt-cnt.c
> > @@ -15,7 +15,7 @@
> > =C2=A0#define INTERRUPT_CNT_NAME "interrupt-cnt"
> > =C2=A0
> > =C2=A0struct interrupt_cnt_priv {
> > -	atomic_t count;
> > +	atomic_long_t count;
> > =C2=A0	struct gpio_desc *gpio;
> > =C2=A0	int irq;
> > =C2=A0	bool enabled;
> > @@ -29,7 +29,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *d=
ev_id)
> > =C2=A0	struct counter_device *counter =3D dev_id;
> > =C2=A0	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> > =C2=A0
> > -	atomic_inc(&priv->count);
> > +	atomic_long_inc(&priv->count);
> > =C2=A0
> > =C2=A0	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
> > =C2=A0
> > @@ -89,7 +89,7 @@ static int interrupt_cnt_read(struct counter_device *=
counter,
> > =C2=A0{
> > =C2=A0	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> > =C2=A0
> > -	*val =3D atomic_read(&priv->count);
> > +	*val =3D atomic_long_read(&priv->count);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > @@ -102,7 +102,7 @@ static int interrupt_cnt_write(struct counter_devic=
e *counter,
> > =C2=A0	if (val !=3D (typeof(priv->count.counter))val)
> > =C2=A0		return -ERANGE;
> > =C2=A0
> > -	atomic_set(&priv->count, val);
> > +	atomic_long_set(&priv->count, val);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0} =20
>=20


