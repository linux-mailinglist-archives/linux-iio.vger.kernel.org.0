Return-Path: <linux-iio+bounces-8192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98694696E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CD51C20B4A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850814C5A1;
	Sat,  3 Aug 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbrbsJbx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D77EF09;
	Sat,  3 Aug 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683881; cv=none; b=Fo4yT/CqkWYVEayyhfHlftE9wgaqiJJ6Ca25LGAxEDYAySg1LBhAi4iTaczOQ3kTVohALnZPpQrmo/m6c6PgI8/gquivQp9iSMRdzeFwd/58e92akF3+/bJujOAeUdbf6oQ+7u/ZnWwisMvvcKmDtFxEmOi7M/GvK3CexdyvJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683881; c=relaxed/simple;
	bh=GXT0DgK5j3DMMtu/LmcbliLAhERbqe/7eBNWpDi1a9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edoloa1Nws8yDgvXZbhHyseEOrtFaLeCdsL998POGazpUaDnnLHrT1PbXVCm0RjCh0bQurhL1gSmvYmAGuXeUWOUzT0J7X5dB9GWHAcaeL0fj1tP0RB3xKmcD9MisztTQWsVCW9hWIXTelGYjduN6n0oMH0lT5Gj6hBhfWtJ3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbrbsJbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3383EC4AF0A;
	Sat,  3 Aug 2024 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722683881;
	bh=GXT0DgK5j3DMMtu/LmcbliLAhERbqe/7eBNWpDi1a9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UbrbsJbxioKaVmV6FKTUJCvcgHt5aeTxT9xEFF3pByxbsAA61ufqlCKxY5K6x9rpr
	 vKyBK+K5JHCpnL183MELDvStw4Cgn3wqhFhJxkjftxEFWj7AM2ypZfm7oJA1PKdjiU
	 z/G50+BaKexgg35NXLhQLqHx6PBQ8jHhCEdtg76InTK0JNNMh7FsSbkzeRUanVx952
	 RE9Cltc0NTlIRJqTZYpiArFSuYuN6KgMDOKsDaXRLIu8MI9V1D8bS73sMezdvPKVLj
	 mm7PxuXl/JwKM70GvPhMm5D3WZ9ZeSzPkTyvLIrcLAoUzppSV3HZefsNRmJd66KNM7
	 02I2mxxR9onNA==
Date: Sat, 3 Aug 2024 12:17:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
 <james.clark@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Anand
 Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek
 <michal.simek@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel
 Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad7768-1: use device_* to iterate over
 device child nodes
Message-ID: <20240803121752.4d9693bc@jic23-huawei>
In-Reply-To: <02bda6f37ac5ed171429a980b9a3ac69cd4efcf9.camel@gmail.com>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
	<20240801-device_child_node_access-v1-2-ddfa21bef6f2@gmail.com>
	<02bda6f37ac5ed171429a980b9a3ac69cd4efcf9.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Aug 2024 09:31:16 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-08-01 at 08:13 +0200, Javier Carrasco wrote:
> > Drop the manual access to the fwnode of the device to iterate over its
> > child nodes. `device_for_each_child_node` macro provides direct access
> > to the child nodes, and given that they are only required within the
> > loop, the scoped variant of the macro can be used.
> >=20
> > Use the `device_for_each_child_node_scoped` macro to iterate over the
> > direct child nodes of the device.
> >=20
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied
>=20
> > =C2=A0drivers/iio/adc/ad7768-1.c | 5 +----
> > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 70a25949142c..721672fe84ab 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -544,13 +544,10 @@ static int ad7768_set_channel_label(struct iio_dev
> > *indio_dev,
> > =C2=A0{
> > =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> > =C2=A0	struct device *device =3D indio_dev->dev.parent;
> > -	struct fwnode_handle *fwnode;
> > -	struct fwnode_handle *child;
> > =C2=A0	const char *label;
> > =C2=A0	int crt_ch =3D 0;
> > =C2=A0
> > -	fwnode =3D dev_fwnode(device);
> > -	fwnode_for_each_child_node(fwnode, child) {
> > +	device_for_each_child_node_scoped(device, child) {
> > =C2=A0		if (fwnode_property_read_u32(child, "reg", &crt_ch))
> > =C2=A0			continue;
> > =C2=A0
> >  =20
>=20


