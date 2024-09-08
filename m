Return-Path: <linux-iio+bounces-9326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2C97076E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01391F2170C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610915853D;
	Sun,  8 Sep 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCR9KYwV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583991DA26;
	Sun,  8 Sep 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798984; cv=none; b=VO76SkALLG9Fs9RdBtEsx1SzExTr51kPsiFPdOIFz5XvvzIWm5Hb6rkhihDzreGdfoczZndZBOdDXQnjidSk7A8XPESRgdymTdgPNVKSoZRxeUl8PPCdd684XqODCp2Hn/W7VIDIxhf1SzzHIFRhvvDmjvAdbBLKEG4Mk+iiZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798984; c=relaxed/simple;
	bh=zZUkXvrJT+zjjt5o2nODDWaDFl+ttyY4UoJlywdCoS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL7rcTzlfaSHHdobmgWO5LOf8FXNP368oLDZqnm+SwNMDDqoVBzFpT0JhdgMsj1vgf6xoU+O7EVsYscCVE3A72YAjPL65zY8cOLFos9slUquZCcLcEBTBAPdabRTSrx2UrnsJTc4w+lPg+2SQAvjuo/dIMH1eUXUfK1RuofediA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCR9KYwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB3C4CEC3;
	Sun,  8 Sep 2024 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725798984;
	bh=zZUkXvrJT+zjjt5o2nODDWaDFl+ttyY4UoJlywdCoS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCR9KYwVzlLHvLsbGFEhQcAvRoK4dZvfyXlC5vaAgNApO1ZfG/wFSKUNvYQt5rlXJ
	 EhKFGHVMbZivVCWaDXD60rstVI5oiTLu9KM+KzQpo+aMTHu3nj5AjaJvOdc8G6Yg3D
	 VWftWTFJUfBZNYtwJ5BKtz6zByiwhNPNoTjlQdBsG0gSiafgJjgrMa8R/ESvdvgNTs
	 CP+RLjqzznHVWn5aTYEaWhzlslLp3OYb2WjRPJo3IuxMjJo4Gje09TnFkLl4+RPGvk
	 AvyGN7++kVoAZVFyxCR8ndYTgcq9COf0vqntWX6wMihEX9O71Uncpy5CZdEDaQQIQQ
	 EfZxOE2qkTtHA==
Date: Sun, 8 Sep 2024 13:36:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of
 child fdt node
Message-ID: <20240908133613.796d8817@jic23-huawei>
In-Reply-To: <38cc5356fc737460f6962d6aae274e72f5b5c73d.camel@gmail.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
	<7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
	<38cc5356fc737460f6962d6aae274e72f5b5c73d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 06 Sep 2024 09:08:59 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-09-05 at 14:19 -0500, David Lechner wrote:
> > On 9/5/24 10:17 AM, Angelo Dureghello wrote: =20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Change to obtain the fdt use case as reported in the
> > > adi,ad3552r.yaml file in this patchset, with the DAC device that
> > > is actually using the backend set as a child node of the backend.
> > >=20
> > > To obtain this, registering all the child fdt nodes as platform
> > > devices.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > Co-developed-by: David Lechner <dlechner@baylibre.com>
> > > Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
> > > =C2=A01 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-=
dac.c
> > > index cc31e1dcd1df..e883cd557b6a 100644
> > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *=
pdev)
> > > =C2=A0{
> > > =C2=A0	struct axi_dac_state *st;
> > > =C2=A0	const struct axi_dac_info *info;
> > > +	struct platform_device *child_pdev;
> > > =C2=A0	void __iomem *base;
> > > =C2=A0	unsigned int ver;
> > > =C2=A0	struct clk *clk;
> > > @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device =
*pdev)
> > > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n"=
);
> > > =C2=A0
> > > +	device_for_each_child_node_scoped(&pdev->dev, child) { =20
> >=20
> > This should use fwnode_for_each_available_child_node() so that it skips
> > nodes with status !=3D "okay".

Ah. That oddity strikes again...

> >=20
> > Would be nice to introduce a scoped version of this function too.
> >=20
> > Also, if we are allowing multiple devices on the bus, the DT bindings
> > need to have a reg property that is unique for each child.
> >  =20
> > > +		struct platform_device_info pi;
> > > +
> > > +		memset(&pi, 0, sizeof(pi)); =20
> >=20
> > struct platform_device_info pi =3D { };
> >=20
> > avoids the need for memset().
> >  =20
> > > +
> > > +		pi.name =3D fwnode_get_name(child);
> > > +		pi.id =3D PLATFORM_DEVID_AUTO;
> > > +		pi.fwnode =3D child; =20
> >=20
> > Need to have pi.parent =3D &pdev->dev;
> >=20
> > It could also make sense to have all of the primary bus functions
> > (reg read/write, ddr enable/disable, etc.) passed here as platform
> > data instead of having everything go through the IIO backend. =20
>=20
> Note that ddr enable/disable is something that makes sense to be in the b=
ackend
> anyways as it is something that exists in LVDS/CMOS interfaces that are o=
nly running
> the dataplane. Bus operations like read/write could make sense but that w=
ould mean an
> interface directly between the axi-dac and the child devices (bypassing t=
he backend
> or any other middle layer - maybe we could create a tiny adi-axi-bus laye=
r on the IIO
> topdir or any other place in IIO) which I'm not so sure (and is a bit odd=
). OTOH,
> this bus stuff goes a bit out of scope of the backend main idea/goal so y=
eah... Well,
> let's see what others have to say about it but I don't dislike the idea.

For the read/write using platform data does seem reasonable to me.
Agreed that DDR is dataplane (at least sometimes) so backend ops probably a=
ppropriate.

>=20
> >  =20
> > > +
> > > +		child_pdev =3D platform_device_register_full(&pi);
> > > +		if (IS_ERR(child_pdev))
> > > +			return PTR_ERR(child_pdev); =20
> >=20
> > These devices need to be unregistered on any error return and when
> > the parent device is removed.
> >  =20
>=20
> Definitely this needs to be tested by manually unbinding the axi-dac devi=
ce for
> example. I'm not really sure how this will look like and if there's any p=
roblem in
> removing twice the same device (likely there is). The thing is that when =
we connect a
> frontend with it's backend, a devlink is created (that guarantees that th=
e frontend
> is removed before the backend). So, I'm fairly confident that if we add a=
 devm action
> in here to unregister the child devices, by the time we unregister the ch=
ild, it
> should be already gone (unless driver core somehow handles this).
>=20
> All of the above needs careful testing but one way out it (and since in h=
ere we have
> the parent - child relationship), we could add a boolean flag 'skip_devli=
nk' to
> 'struct iio_backend_info' so that devlinks are skipped on these arrangeme=
nts. Or we
> could automatically detect that the frontend is a child of the backend an=
d skip the
> link (though an explicit flag might be better).

Agreed it needs testing but I'm not sure why it would already have gone.
The driver would have unbound, but the platform device /child would still b=
e there
I think at time of removal. Can probably get away with devm to tear
it down when the backend device then goes away.

Maybe I'm missing some subtlety though.

Jonathan


>=20
> - Nuno S=C3=A1
>=20
> >  =20


