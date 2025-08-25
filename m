Return-Path: <linux-iio+bounces-23215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77067B33DE0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D31A82D9A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E82E7BC0;
	Mon, 25 Aug 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs1rW+FW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0B27B51A;
	Mon, 25 Aug 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121008; cv=none; b=l/OuTSXarPyJVETfk275sEDtINvdYPm76nSIlKQ6Zu7RZ9zunoVdVPkGmVuLC+/nFgtWyjcx4NXTOg6We09TYvsjDZXqOUp6CcfwT9ZaoLfmKKQkDfSgEYqeLvh25h7vTBkqUeHNFXzC/5komE1CmgXBuuV2e6J6yOj3ISkIrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121008; c=relaxed/simple;
	bh=YLuNmgSadAAEa3ZPFUF8jemmpIic3MiIIXQgw34LGCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fieRFNcByDrUqzboebrVxZ4hLoNtxxm/jmjh2UDEEo/oT5gOpUQczo0bcBFW0w0GG9h7FfFGIhX3ErCFES0r+krwIcJLrui5v/Iepjo0aiTkYBbM29l+++e4/fQFRWl85tWVWgzOvlNCZGvIYTu2qGIQGJ5DUh0AwusSgGTD4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs1rW+FW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65378C4CEED;
	Mon, 25 Aug 2025 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121008;
	bh=YLuNmgSadAAEa3ZPFUF8jemmpIic3MiIIXQgw34LGCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bs1rW+FWDWAleftJfB7xKa9mjQQdPJNZ/Zzp4ntGcsViBYLF6U0gI0zKbK3YLazYz
	 7alACQs4GSarDiHQQKACslPn1mvRer+tqybHgrb+eOK0lxvvNqafRXqIqIvrVQiVXH
	 TLdY2St9l3iQZiF5yu1UcpLW91NOphcvJYwwQzdfQWiuFx7/nk8q4QlisJgssHyQTF
	 njPc3JWQu+B23QGe4xzXLfp0wgwXSTTy+hFCcq0zorsQzW4Ebdr59TuP3xe9zJoxnd
	 c/x2bdkb5sWqF5tetlYapWoUcHE4qNiNzLThxc41foH2pJ4HLMJsYBVctTonKpCOjh
	 YUUlHexCWNQsw==
Date: Mon, 25 Aug 2025 12:23:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
 <michal.simek@amd.com>, Andy Shevchenko <andy@kernel.org>, Manish Narani
 <manish.narani@xilinx.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating
 alarms
Message-ID: <20250825122319.6faf8782@jic23-huawei>
In-Reply-To: <MN2PR12MB42237EC0AA00D05DE52F8C988B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
	<MN2PR12MB42237EC0AA00D05DE52F8C988B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 11:28:27 +0000
"O'Griofa, Conall" <conall.ogriofa@amd.com> wrote:

> Hi,
>=20
> Looks good, thank you for taking the time to submit this patch.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> Cheers,
> Conall.
>=20
> > -----Original Message-----
> > From: Sean Anderson <sean.anderson@linux.dev>
> > Sent: 15 July 2025 01:29
> > To: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>; Jonathan Cameron
> > <jic23@kernel.org>; linux-iio@vger.kernel.org
> > Cc: David Lechner <dlechner@baylibre.com>; Nuno S=C3=A1 <nuno.sa@analog=
.com>;
> > linux-arm-kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.c=
om>;
> > Andy Shevchenko <andy@kernel.org>; Manish Narani
> > <manish.narani@xilinx.com>; linux-kernel@vger.kernel.org; Sean Anderson
> > <sean.anderson@linux.dev>
> > Subject: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alar=
ms
> >=20
> > To convert level-triggered alarms into edge-triggered IIO events, alarm=
s are masked
> > when they are triggered. To ensure we catch subsequent alarms, we then
> > periodically poll to see if the alarm is still active.
> > If it isn't, we unmask it. Active but masked alarms are stored in
> > current_masked_alarm.
> >=20
> > If an active alarm is disabled, it will remain set in current_masked_al=
arm until
> > ams_unmask_worker clears it. If the alarm is re-enabled before
> > ams_unmask_worker runs, then it will never be cleared from
> > current_masked_alarm. This will prevent the alarm event from being push=
ed even if
> > the alarm is still active.
> >=20
> > Fix this by recalculating current_masked_alarm immediately when enablin=
g or
> > disabling alarms.
> >=20
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> >=20
> >  drivers/iio/adc/xilinx-ams.c | 45 ++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.=
c index
> > 76dd0343f5f7..180d4140993d 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -389,6 +389,29 @@ static void ams_update_pl_alarm(struct ams *ams,
> > unsigned long alarm_mask)
> >  	ams_pl_update_reg(ams, AMS_REG_CONFIG3,
> > AMS_REGCFG3_ALARM_MASK, cfg);  }
> >=20
> > +static void ams_unmask(struct ams *ams) {
> > +	unsigned int status, unmask;
> > +
> > +	status =3D readl(ams->base + AMS_ISR_0);
> > +
> > +	/* Clear those bits which are not active anymore */
> > +	unmask =3D (ams->current_masked_alarm ^ status) &
> > +ams->current_masked_alarm;
> > +
> > +	/* Clear status of disabled alarm */
> > +	unmask |=3D ams->intr_mask;
> > +
> > +	ams->current_masked_alarm &=3D status;
> > +
> > +	/* Also clear those which are masked out anyway */
> > +	ams->current_masked_alarm &=3D ~ams->intr_mask;
> > +
> > +	/* Clear the interrupts before we unmask them */
> > +	writel(unmask, ams->base + AMS_ISR_0);
> > +
> > +	ams_update_intrmask(ams, ~AMS_ALARM_MASK,
> > ~AMS_ALARM_MASK); }
> > +
> >  static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask=
)  {
> >  	unsigned long flags;
> > @@ -401,6 +424,7 @@ static void ams_update_alarm(struct ams *ams, unsig=
ned
> > long alarm_mask)
> >=20
> >  	spin_lock_irqsave(&ams->intr_lock, flags);
> >  	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
> > +	ams_unmask(ams);
> >  	spin_unlock_irqrestore(&ams->intr_lock, flags);  }
> >=20
> > @@ -1035,28 +1059,9 @@ static void ams_handle_events(struct iio_dev
> > *indio_dev, unsigned long events)  static void ams_unmask_worker(struct
> > work_struct *work)  {
> >  	struct ams *ams =3D container_of(work, struct ams, ams_unmask_work.wo=
rk);
> > -	unsigned int status, unmask;
> >=20
> >  	spin_lock_irq(&ams->intr_lock);
> > -
> > -	status =3D readl(ams->base + AMS_ISR_0);
> > -
> > -	/* Clear those bits which are not active anymore */
> > -	unmask =3D (ams->current_masked_alarm ^ status) & ams- =20
> > >current_masked_alarm; =20
> > -
> > -	/* Clear status of disabled alarm */
> > -	unmask |=3D ams->intr_mask;
> > -
> > -	ams->current_masked_alarm &=3D status;
> > -
> > -	/* Also clear those which are masked out anyway */
> > -	ams->current_masked_alarm &=3D ~ams->intr_mask;
> > -
> > -	/* Clear the interrupts before we unmask them */
> > -	writel(unmask, ams->base + AMS_ISR_0);
> > -
> > -	ams_update_intrmask(ams, ~AMS_ALARM_MASK,
> > ~AMS_ALARM_MASK);
> > -
> > +	ams_unmask(ams);
> >  	spin_unlock_irq(&ams->intr_lock);
> >=20
> >  	/* If still pending some alarm re-trigger the timer */
> > --
> > 2.35.1.1320.gc452695387.dirty =20
>=20
> Reviewed-by: O'Griofa, Conall <conall.ogriofa@amd.com>


