Return-Path: <linux-iio+bounces-16570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B68A57BF1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931BA1890A95
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13461E5721;
	Sat,  8 Mar 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzp+BIy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F341B21B4;
	Sat,  8 Mar 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451383; cv=none; b=V7gBPrPlqbd9o1xODD8IBPzwIVWnvhyEt/1BSaPrgPcynFloeVrSL6IIageP+YgKKHwQbJeyNfj/h2UL6aqq6fyZiXMDKfMf2lL8w7cf2QpGDMrnVreoLvLLMkfT04bG6LyC0NxjwJeY79m1ziJsn2WV+gwmJBoFzISh2EEo00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451383; c=relaxed/simple;
	bh=SdeY4HUDR25gSwHntex8TgQMRjhWp1R3x/osJlwkf2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u57RRz4rlN//oeRQ7AQh3oZLQW7+rt92lc/5jwSlfUoX3x//v0IAry+0APgVtpKV5yPVTqBb4jvB9i4bLTWsH2XqvlWO3Kw2ozkEt4HVAju6GwU2rVrjQ3pT9TLYuFpC5l5q2g7vrdr6fuWYgR+gWcPvBwNMt672dBA+u/MGyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzp+BIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0032C4CEE0;
	Sat,  8 Mar 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741451383;
	bh=SdeY4HUDR25gSwHntex8TgQMRjhWp1R3x/osJlwkf2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NSzp+BIy+RyYAh5eXPfpEeXytNRO+Yn6QDm61AqJR8JPEZz8lPYUdH5rwAtQ05Xgi
	 nJ52JT45pfwi6qQmjNAQl3PQm42j3TaIFdCd9qBeOGwEiLP5I4ChuxG/eiUIvHz+gf
	 vFNeOPjjYakfsWHf3baQaOKsl1voaEzszbfYyZf3MV94dErx1nbWai2CFl3Azkw15j
	 rPpzaDB7MAis2oreAPGOwD994ClDh/BRvfWkNboiV69CTNipPu/XspI5zRPgzAWTgR
	 owYLqgaQkKxX174yazNjuFoEFyme0FYmA2oF6DDFWudPFsQy0VFIbtdTW9FkcU73tW
	 wdzVAijHUAy0A==
Date: Sat, 8 Mar 2025 16:29:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, Matteo
 Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250308162928.72bd1d1b@jic23-huawei>
In-Reply-To: <54a031d0-df47-4baa-a23a-1a79c0922542@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<e71c63c2f61135f9a8c7884525aab2c48f1e84c2.1740993491.git.mazziesaccount@gmail.com>
	<CAMknhBGQaqFZJsPAoauZL4S5MYtN05EOQ-BO2vw5gH+Z2RLOhw@mail.gmail.com>
	<54a031d0-df47-4baa-a23a-1a79c0922542@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 12:54:33 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks for the review David.
>=20
> On 04/03/2025 11:25, David Lechner wrote:
> > On Mon, Mar 3, 2025 at 12:32=E2=80=AFPM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote: =20
> >>
> >> There are ADC ICs which may have some of the AIN pins usable for other
> >> functions. These ICs may have some of the AIN pins wired so that they
> >> should not be used for ADC.
> >>
> >> (Preferred?) way for marking pins which can be used as ADC inputs is to
> >> add corresponding channels@N nodes in the device tree as described in
> >> the ADC binding yaml.
> >>
> >> Add couple of helper functions which can be used to retrieve the chann=
el
> >> information from the device node.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> --- =20
>=20
> >> + *
> >> + * Return:     Number of found channels on succes. Negative value to =
indicate =20
> >=20
> > s/succes/success/ =20
>=20
> Thanks!
>=20
> >> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
> >> +                                         const struct iio_chan_spec *=
template,
> >> +                                         int max_chan_id,
> >> +                                         struct iio_chan_spec **cs)
> >> +{
> >> +       struct iio_chan_spec *chan_array, *chan;
> >> +       int num_chan =3D 0, ret;
> >> +
> >> +       num_chan =3D iio_adc_device_num_channels(dev);
> >> +       if (num_chan < 1)
> >> +               return num_chan;
> >> +
> >> +       chan_array =3D devm_kcalloc(dev, num_chan, sizeof(*chan_array),
> >> +                                 GFP_KERNEL);
> >> +       if (!chan_array)
> >> +               return -ENOMEM;
> >> +
> >> +       chan =3D &chan_array[0];
> >> +
> >> +       device_for_each_child_node_scoped(dev, child) {
> >> +               u32 ch;
> >> +
> >> +               if (!fwnode_name_eq(child, "channel"))
> >> +                       continue;
> >> +
> >> +               ret =3D fwnode_property_read_u32(child, "reg", &ch);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               if (max_chan_id !=3D -1 && ch > max_chan_id)
> >> +                       return -ERANGE;
> >> + =20
> >=20
> > Should we use return dev_err_probe() on these to help with debugging a =
bad dtb?
> >  =20
>=20
> I am not fan of using dev_err_probe() in a 'library code'. This is=20
> because we never know if there'll be some odd use-case where this is not=
=20
> called from the probe.
>=20
> All in all, I'd leave adding most of the debugs to the callers -=20
> especially because we do not expect to have bad device-trees after the=20
> initial 'development stage' of a board. The board 'development stage'=20
> should really reveal bugs which prevent the channels from being=20
> registered - and after the DT is correct, these debug prints become=20
> unnecessary (albeit minor) binary bloat.
>=20
> >> +               *chan =3D *template;
> >> +               chan->channel =3D ch;
> >> +               chan++;
> >> +       }
> >> +
> >> +       *cs =3D chan_array;
> >> +
> >> +       return num_chan;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, "IIO_DRIV=
ER"); =20
> >=20
> > We can make this less verbose by setting #define
> > DEFAULT_SYMBOL_NAMESPACE at the start of the file. Then we can just do
> > EXPORT_SYMBOL_GPL() throughout the rest of the file. =20
>=20
> I am not sure what to think of this. I use the good old 'ctrl + ]' in my=
=20
> editor when I need to check how a function was supposed to be used. That=
=20
> jumps to the spot of code where the function is. I'd like to see the=20
> namespace mentioned there in order to not accidentally miss the fact the=
=20
> function belongs to one.
>=20
> OTOH, I do like simplifications. Yet, the added simplification might not=
=20
> warrant the namespace not being visible in the function definition.
>=20
> > Also, I would prefer if the namespace matched config name (IIO_ADC_HELP=
ER). =20
>=20
> I had some lengthy discussion about this with Andy and Jonathan during=20
> earlier review versions. In short, I don't like the idea of very=20
> fragmented namespaces in IIO, which will just complicate the drivers=20
> without providing any obvious benefit.
>=20
> https://lore.kernel.org/all/20250222174842.57c091c5@jic23-huawei/
>=20
> >> +
> >> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
> >> +                                         const struct iio_chan_spec *=
template,
> >> +                                         int max_chan_id,
> >> +                                         struct iio_chan_spec **cs);
> >> + =20
> >=20
> > There are some different opinions on this, but on the last patch I did
> > introducing a new namespace, the consensus seems to be that putting
> > the MODULE_IMPORT_NS() in the header file was convenient so that users
> > of the API don't have to remember to both include the header and add
> > the import macro.
> >  =20
>=20
> I do like this suggestion, and I believe this would be the balance=20
> between getting the benefit of hiding part of the symbols - while not=20
> unnecessarily complicating the callers. I know some people are opposing=20
> it though. My personal opinion is that having the MODULE_IMPORT_NS() in=20
> a header would be neatly simplifying the calling code with very little=20
> harm, especially here where including the header hardly has use-cases=20
> outside the IIO ADC.
>=20
> Unfortunately, the "safety" seems to often be a synonym for just "making=
=20
> it intentionally hard". As Finnish people say: "K=C3=A4rsi, k=C3=A4rsi,=20
> kirkkaamman kruunun saat". :)
> (Roughly translated as "Suffer, suffer, you will get a brighter crown").
>=20
> Let's hear what Jonathan thinks of your suggestion.

For this particular case my intent was that all the IIO exports that
are suitable for use in simple IIO drives will be in this namespace,
we just haven't started that conversion yet.

As such, having it defined from a header for this helper isn't a good
thing to do.  Generally I prefer to see in driver code what namespaces
are involved but do understand the other viewpoint. In this case I
definitely don't think it is appropriate unless we go for a specific namesp=
ace
for just this helper.

Jonathan

>=20
> Thanks!
> 	-- Matti
>=20


