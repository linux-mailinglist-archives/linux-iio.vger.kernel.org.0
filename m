Return-Path: <linux-iio+bounces-9366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F997103C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9D1C22177
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470B1B143D;
	Mon,  9 Sep 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqFopMOU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D791B1429;
	Mon,  9 Sep 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868176; cv=none; b=M5TpEKcddeUWMTIa9U2NxmAMDes2oRg/XfbkrO8U3nY3wawUSezsOaGJkfmlP51HXIhvODwKxm13vCKd5fJW+42fPZpni1oQYzGTnsUDzqLmuFtcBvYLXpjRVySzxrbzdcpQaC7rhSXhpbk2yw9cknO/rHmFWqlUsZcRxeixums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868176; c=relaxed/simple;
	bh=c4kb+NQLYuRyYBta+T3iL1FIoEajZ0NeSTvuhuKN0l4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5EDZ4MuA43xSyaTlnpXd56uQzmT7zD6rRiZISzAiWVK0IBSItq5JkVbf98itjgWiJ+JJo3YIOdfz6ifkHaY9lal9YwEbOfmlc795AT3usCiU+BfBGh9FtIwMcy5KNAOSttBF4WKk57C4RvOeNCeleoA/57Kx9JG0IeRyXE565Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqFopMOU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374bd0da617so2454157f8f.3;
        Mon, 09 Sep 2024 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868171; x=1726472971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUUPsWFf3kxSxAf8i1tbi6kRTbOtSo56vFc2PzePdGk=;
        b=IqFopMOUX17jeQmbmuG7EiKgNuiUWPrUKo9tBmF5zp67nVlU7BSmDOx1JJBr65MGk8
         4OJuNYfeJAHrJ2icER5hO5BArGpYDTdRYyNUEbmw9yU6ZwN61+yffIPdBG17HJtcowQL
         6qZ1S3hQotnCZ2OUQkw2u6557bhy/YqGBjb/RR8njvlyHWiOFeA2CHN960xoXVqg26rS
         V3dTIFJAzmVMmAy5kANFx0YLvnbrF/zcpbHpYXRU6Nbsk+C3DN9XgQ6FN45PApSnraGT
         zNJ40gmSqUh3X69FyEKtQDX++/zYgwd+f5jvBOvYQIQXW7uX26BYzgt2CmUhDEWUo2oG
         l/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868171; x=1726472971;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUUPsWFf3kxSxAf8i1tbi6kRTbOtSo56vFc2PzePdGk=;
        b=buIa/J+VkeKNnvxeXk/qGWNx8WZveL2gFS4OS+3Cxu7Qc/kmver6drNxUvKZow8poD
         NsFFyB9pHCgiEbiIxoUG3rfRdAR3Hwtu8fc9GLvLD91GhBmnd1JlFly9lJENrpHF5AoG
         TJCS0EPo2X+z9ol0tGLjpb1sweKaEeYn+dvouC/PygEe7Tdzg16X/AfX5uoU8QqPywBX
         RaLE74ca+ij6EhSUKUCX3LEOvsnUcs5HbmRkNlNkkcL6ljSU/FUn9kFsIAZYb64Yd3Y3
         nn1Kidk+g+zIHnD+WLZk/c99X8/59eDpYmAqW2iQpBoio7FV+YIyWbernkQKkU2qGE02
         iSSA==
X-Forwarded-Encrypted: i=1; AJvYcCVwxabysgx3viNbaq7nEv3pve8//JNhjsEhkxJj6lZxd9POJNeain0EKXnA+w75DFfRSrIVCUY1m2ZoWAk0@vger.kernel.org, AJvYcCWSF1ldgO3KysiwNdBCme25tZC9viCKVNYVv7bBn5YOG5k5BZ/UMwPOH3XE7YZptH15oZ+K0hi9jECp@vger.kernel.org, AJvYcCWYfzyfy3u6b/PLmDQltARrAT+eT+hMwVobvxVf7ndNykatbiU7azMSZJNNUIb0LVB9uGoXBdcCSzJn@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPc25jUWtRbzPPxU2pLae1FES7aOlA42MbftQT5hYPKXDhid8
	hK6KihtlgTK62621TX/Uk/88Xhxo+m2KmN3LOLlWAfOUjPw6jGhf
X-Google-Smtp-Source: AGHT+IEUi7D4gbsnPGIII6nUkNfXzMD0/T7Et9m3L5Zn9dHOBdYzLQESmA0o27c8akcxcsY+KC9vEg==
X-Received: by 2002:adf:e747:0:b0:374:b381:e12a with SMTP id ffacd0b85a97d-378896124edmr6228062f8f.33.1725868170793;
        Mon, 09 Sep 2024 00:49:30 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0642f99sm64639175e9.40.2024.09.09.00.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:49:30 -0700 (PDT)
Message-ID: <05be6feab2fd34801ec0a521859acea4cfd1b074.camel@gmail.com>
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of
 child fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 09 Sep 2024 09:53:39 +0200
In-Reply-To: <20240908133613.796d8817@jic23-huawei>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
	 <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
	 <38cc5356fc737460f6962d6aae274e72f5b5c73d.camel@gmail.com>
	 <20240908133613.796d8817@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-08 at 13:36 +0100, Jonathan Cameron wrote:
> On Fri, 06 Sep 2024 09:08:59 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-09-05 at 14:19 -0500, David Lechner wrote:
> > > On 9/5/24 10:17 AM, Angelo Dureghello wrote:=C2=A0=20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Change to obtain the fdt use case as reported in the
> > > > adi,ad3552r.yaml file in this patchset, with the DAC device that
> > > > is actually using the backend set as a child node of the backend.
> > > >=20
> > > > To obtain this, registering all the child fdt nodes as platform
> > > > devices.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > Co-developed-by: David Lechner <dlechner@baylibre.com>
> > > > Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
> > > > =C2=A01 file changed, 15 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-ax=
i-
> > > > dac.c
> > > > index cc31e1dcd1df..e883cd557b6a 100644
> > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device
> > > > *pdev)
> > > > =C2=A0{
> > > > =C2=A0	struct axi_dac_state *st;
> > > > =C2=A0	const struct axi_dac_info *info;
> > > > +	struct platform_device *child_pdev;
> > > > =C2=A0	void __iomem *base;
> > > > =C2=A0	unsigned int ver;
> > > > =C2=A0	struct clk *clk;
> > > > @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_devic=
e
> > > > *pdev)
> > > > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio
> > > > backend\n");
> > > > =C2=A0
> > > > +	device_for_each_child_node_scoped(&pdev->dev, child) {=C2=A0=20
> > >=20
> > > This should use fwnode_for_each_available_child_node() so that it ski=
ps
> > > nodes with status !=3D "okay".
>=20
> Ah. That oddity strikes again...
>=20
> > >=20
> > > Would be nice to introduce a scoped version of this function too.
> > >=20
> > > Also, if we are allowing multiple devices on the bus, the DT bindings
> > > need to have a reg property that is unique for each child.
> > > =C2=A0=20
> > > > +		struct platform_device_info pi;
> > > > +
> > > > +		memset(&pi, 0, sizeof(pi));=C2=A0=20
> > >=20
> > > struct platform_device_info pi =3D { };
> > >=20
> > > avoids the need for memset().
> > > =C2=A0=20
> > > > +
> > > > +		pi.name =3D fwnode_get_name(child);
> > > > +		pi.id =3D PLATFORM_DEVID_AUTO;
> > > > +		pi.fwnode =3D child;=C2=A0=20
> > >=20
> > > Need to have pi.parent =3D &pdev->dev;
> > >=20
> > > It could also make sense to have all of the primary bus functions
> > > (reg read/write, ddr enable/disable, etc.) passed here as platform
> > > data instead of having everything go through the IIO backend.=C2=A0=
=20
> >=20
> > Note that ddr enable/disable is something that makes sense to be in the
> > backend
> > anyways as it is something that exists in LVDS/CMOS interfaces that are=
 only
> > running
> > the dataplane. Bus operations like read/write could make sense but that
> > would mean an
> > interface directly between the axi-dac and the child devices (bypassing=
 the
> > backend
> > or any other middle layer - maybe we could create a tiny adi-axi-bus la=
yer
> > on the IIO
> > topdir or any other place in IIO) which I'm not so sure (and is a bit o=
dd).
> > OTOH,
> > this bus stuff goes a bit out of scope of the backend main idea/goal so
> > yeah... Well,
> > let's see what others have to say about it but I don't dislike the idea=
.
>=20
> For the read/write using platform data does seem reasonable to me.
> Agreed that DDR is dataplane (at least sometimes) so backend ops probably
> appropriate.
>=20
> >=20
> > > =C2=A0=20
> > > > +
> > > > +		child_pdev =3D platform_device_register_full(&pi);
> > > > +		if (IS_ERR(child_pdev))
> > > > +			return PTR_ERR(child_pdev);=C2=A0=20
> > >=20
> > > These devices need to be unregistered on any error return and when
> > > the parent device is removed.
> > > =C2=A0=20
> >=20
> > Definitely this needs to be tested by manually unbinding the axi-dac de=
vice
> > for
> > example. I'm not really sure how this will look like and if there's any
> > problem in
> > removing twice the same device (likely there is). The thing is that whe=
n we
> > connect a
> > frontend with it's backend, a devlink is created (that guarantees that =
the
> > frontend
> > is removed before the backend). So, I'm fairly confident that if we add=
 a
> > devm action
> > in here to unregister the child devices, by the time we unregister the
> > child, it
> > should be already gone (unless driver core somehow handles this).
> >=20
> > All of the above needs careful testing but one way out it (and since in=
 here
> > we have
> > the parent - child relationship), we could add a boolean flag 'skip_dev=
link'
> > to
> > 'struct iio_backend_info' so that devlinks are skipped on these
> > arrangements. Or we
> > could automatically detect that the frontend is a child of the backend =
and
> > skip the
> > link (though an explicit flag might be better).
>=20
> Agreed it needs testing but I'm not sure why it would already have gone.
> The driver would have unbound, but the platform device /child would still=
 be
> there
> I think at time of removal. Can probably get away with devm to tear
> it down when the backend device then goes away.
>=20
> Maybe I'm missing some subtlety though.
>=20

Hmm, I guess there was some confusion of me not explaining myself. What I w=
anted
to say is that we will be unregistering the same device twice. But yeah, ma=
ybe
it ends up just being a NOP in the driver core. But yeah, we definitely nee=
d to
test this and make sure that the device is only gone by the time the parent
device calls platform_device_unregister() on it.

- Nuno S=C3=A1


