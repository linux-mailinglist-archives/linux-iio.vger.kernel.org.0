Return-Path: <linux-iio+bounces-9317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E559706B0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6671F21B57
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB9152169;
	Sun,  8 Sep 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDby999W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190A4B5AE;
	Sun,  8 Sep 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792441; cv=none; b=d0106UbOh6oS2AU5kq69sGSB7nhYikZV9MjfCzz7aNQeJo6aDVYxoi+vJuPgIxwP3Y/a8gjf9yfbuEfyKHYWw0+EwpR4ZYicNtpACg+S/4u6AV9JrhhhpVcDYpLnMARRADatNkud0XaMFBVEuVSPD3mWrPHAbakZOM0PHcw81ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792441; c=relaxed/simple;
	bh=UKNmYp6GPFaN/LKpeO1ZuRalCt0DLguHHWLvmmydY5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rp2fHr68xLuTiMiFALTJqAUzoj3MRlMOV6qQJBVr90HdDl9biafh3tngPjXbyGtmE2kk9VlcUQK4K82mB6LJ5SDLQXvfLm9SnJp4u70GNWkjp7Vt5DutcwPtO26mhvg8VWQoXDfIWhgXycaw0sqsZdZOpYXFx/TZxnnCHWo6Ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDby999W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C1BC4CEC3;
	Sun,  8 Sep 2024 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725792441;
	bh=UKNmYp6GPFaN/LKpeO1ZuRalCt0DLguHHWLvmmydY5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDby999WmRjj9VgHsiLSKJvWxq/zIShiWoSxwtMglivzGTh2B04xUCsaI1VE4AVXe
	 zswq3CnWbR7FaLE8h5wc9xZIyd4EUblniJ4QQcvJXwABN/Y6+iUtNBA7HtKNU+XqIM
	 D/i7qJCD5y5IKDi1R1VpCq4h9mOHinIG/xGeEA86XkQEnt7iqiTknu3llKXGdHYGe9
	 PMUAWN1i4UpE3eHWB1pRdXiDJWDq6bN/MKojGGfeadRl2xJdhU8j2Uw1FhqHiEExzs
	 giYQxv6oCaGBQIBMfr61H4/1urc4SPpa/Bop/NYpbPuar7gmdAmkcmssbK9tkDoi2N
	 PmaV978Ofseag==
Date: Sun, 8 Sep 2024 11:47:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v5 6/9] iio: adc: ad7606: rework available attributes
 for SW channels
Message-ID: <20240908114711.0f350072@jic23-huawei>
In-Reply-To: <CA+GgBR99R=PEyTR_KZO6M_YiRepa5ZFhXcRRq=AtD65rn5MCZg@mail.gmail.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
	<20240907065043.771364-7-aardelean@baylibre.com>
	<20240907160356.3de047b0@jic23-huawei>
	<CA+GgBR99R=PEyTR_KZO6M_YiRepa5ZFhXcRRq=AtD65rn5MCZg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Sep 2024 21:10:10 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Sat, Sep 7, 2024 at 6:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sat,  7 Sep 2024 09:50:39 +0300
> > Alexandru Ardelean <aardelean@baylibre.com> wrote:
> > =20
> > > For SW mode, the oversampling and scales attributes are always presen=
t.
> > > So, they can be implemented via a 'read_avail' hook in iio_info.
> > >
> > > For HW mode, it's a bit tricky, as these attributes get assigned base=
d on
> > > GPIO definitions.
> > >
> > > So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and =
use
> > > that for the SW channels.
> > > And 'ad7606_info_os_range_and_debug' can be renamed to
> > > 'ad7606_info_sw_mode' as it is only used for SW mode.
> > >
> > > For the 'read_avail' hook, we'll need to allocate the SW scales, so t=
hat
> > > they are just returned userspace without any extra processing.
> > > The allocation will happen when then ad7606_state struct is allocated.
> > > The oversampling available parameters don't need any extra processing=
; they
> > > can just be passed back to userspace (as they are).
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com> =20
> >
> > One question inline.
> > =20
> > >
> > >  int ad7606_probe(struct device *dev, int irq, void __iomem *base_add=
ress,
> > > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > > index 635407c2acc0..fa175cff256c 100644
> > > --- a/drivers/iio/adc/ad7606.h
> > > +++ b/drivers/iio/adc/ad7606.h =20
> > =20
> > >  #define AD7616_CHANNEL(num)  AD7606_SW_CHANNEL(num, 16)
> > >
> > >  /**
> > > @@ -65,11 +84,15 @@ struct ad7606_chip_info {
> > >  /**
> > >   * struct ad7606_chan_scale - channel scale configuration
> > >   * @scale_avail              pointer to the array which stores the a=
vailable scales
> > > + * @scale_avail_show a duplicate of 'scale_avail' which is readily f=
ormatted
> > > + *                   such that it can be read via the 'read_avail' h=
ook
> > >   * @num_scales               number of elements stored in the scale_=
avail array
> > >   * @range            voltage range selection, selects which scale to=
 apply
> > >   */
> > >  struct ad7606_chan_scale {
> > > +#define AD760X_MAX_SCALE_SHOW                (AD760X_MAX_CHANNELS * =
2) =20
> >
> > Why is the number of scales dependent on the number of channels? =20
>=20
> Well, that was just a lazy implementation.
> I doubt there would be 16 scales (channel range values) for any newer par=
t.
> A value for a channel-range is 4-bits (for 0 to 15).
>=20
> In IIO the current highest scale-count is 5; I guess I can update this
> to a macro, and use that.
Indeed defining this as 16 would make more sense than basing it on random
unconnected thing!

Jonathan

>=20
>=20
> > =20
> > >       const unsigned int              *scale_avail;
> > > +     int                             scale_avail_show[AD760X_MAX_SCA=
LE_SHOW];
> > >       unsigned int                    num_scales;
> > >       unsigned int                    range;
> > >  }; =20
> > =20


