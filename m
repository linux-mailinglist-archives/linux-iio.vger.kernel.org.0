Return-Path: <linux-iio+bounces-16688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EEA5A3BC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92AA1891D25
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FC2356A2;
	Mon, 10 Mar 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI1r+x0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186829D0B;
	Mon, 10 Mar 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634720; cv=none; b=ogBcwZ+a4qxIcQCVkQUh78Ea8OWsXwMAivbOSQzIQd+VNVAmJ3EqspSDvMdRtS/kCl6a7KvxMEk88/IIC/Cq0jKbLfEAiSu2oq6H7yZem81Y0+YJ+QeP9Fdw+glm/gDynwXmutW48gF4u01tXnUWH6fU2/LyFoO4p4pWYMuZ17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634720; c=relaxed/simple;
	bh=HiJOVJUbPj9Y5EXs3EtkfouEzE6hMa/6Du8rJbM/8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfSdfkA5QsqXcPF37CzDMZqUl4iUTMX3gBAUn7RMUgogHIuwnDCaDB8cZAehXalC7lHWVV16GSNeB10oqqEAxtZtbYwZEBRZo4iuQylEw4ei6vEklSRuOmIXn6ocoAOd6JAkZzk3c1sauaxOt6Tx/MnrlwsahryDvyRNQ6NdM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI1r+x0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9842BC4CEE5;
	Mon, 10 Mar 2025 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741634718;
	bh=HiJOVJUbPj9Y5EXs3EtkfouEzE6hMa/6Du8rJbM/8EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TI1r+x0FIda8jW33SCD3Gv5Oz3Fcych+C9ZVqYndpSHwUYvX+I/aAlBs9Owiifmmx
	 /Iu63dqXpopc8YBmK80269Dcs104vl1hmZnDLqLwFPyAT+Pj8e5ehGrIowBBd1vjN/
	 SIKvbM/nqcvQSOfWE9ST4IKanpPHDFxX04whzNpCFzYwzEHSsakIbsLURs5bEeOCzC
	 hqaF0mW6r1COEkHffTA1PKjcWH5qcytkZMeXqh8M5lVAy7JZ/xMXucG87Md231yowD
	 cyJydDRql0PGCKRZ7wSsNyxGL+sJl+Hyq8apZ3+e7qNkXEZNux636deiwmQhu4caRP
	 yHp++Me/nGUWg==
Date: Mon, 10 Mar 2025 19:25:03 +0000
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
Message-ID: <20250310192503.71671275@jic23-huawei>
In-Reply-To: <4d5212b3-3801-408c-9a5d-c6111189793c@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<e71c63c2f61135f9a8c7884525aab2c48f1e84c2.1740993491.git.mazziesaccount@gmail.com>
	<CAMknhBGQaqFZJsPAoauZL4S5MYtN05EOQ-BO2vw5gH+Z2RLOhw@mail.gmail.com>
	<54a031d0-df47-4baa-a23a-1a79c0922542@gmail.com>
	<20250308162928.72bd1d1b@jic23-huawei>
	<4d5212b3-3801-408c-9a5d-c6111189793c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Mar 2025 09:41:00 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 08/03/2025 18:29, Jonathan Cameron wrote:
> > On Wed, 5 Mar 2025 12:54:33 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> Thanks for the review David.
> >>
> >> On 04/03/2025 11:25, David Lechner wrote: =20
> >>> On Mon, Mar 3, 2025 at 12:32=E2=80=AFPM Matti Vaittinen
> >>> <mazziesaccount@gmail.com> wrote: =20
> >>>>
> >>>> There are ADC ICs which may have some of the AIN pins usable for oth=
er
> >>>> functions. These ICs may have some of the AIN pins wired so that they
> >>>> should not be used for ADC.
> >>>>
> >>>> (Preferred?) way for marking pins which can be used as ADC inputs is=
 to
> >>>> add corresponding channels@N nodes in the device tree as described in
> >>>> the ADC binding yaml.
> >>>>
> >>>> Add couple of helper functions which can be used to retrieve the cha=
nnel
> >>>> information from the device node.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>
> >>>> --- =20
> >> =20
> >>>> + *
> >>>> + * Return:     Number of found channels on succes. Negative value t=
o indicate =20
> >>>
> >>> s/succes/success/ =20
> >>
> >> Thanks!
> >> =20
> >>>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
> >>>> +                                         const struct iio_chan_spec=
 *template,
> >>>> +                                         int max_chan_id,
> >>>> +                                         struct iio_chan_spec **cs)
> >>>> +{
> >>>> +       struct iio_chan_spec *chan_array, *chan;
> >>>> +       int num_chan =3D 0, ret;
> >>>> +
> >>>> +       num_chan =3D iio_adc_device_num_channels(dev);
> >>>> +       if (num_chan < 1)
> >>>> +               return num_chan;
> >>>> +
> >>>> +       chan_array =3D devm_kcalloc(dev, num_chan, sizeof(*chan_arra=
y),
> >>>> +                                 GFP_KERNEL);
> >>>> +       if (!chan_array)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       chan =3D &chan_array[0];
> >>>> +
> >>>> +       device_for_each_child_node_scoped(dev, child) {
> >>>> +               u32 ch;
> >>>> +
> >>>> +               if (!fwnode_name_eq(child, "channel"))
> >>>> +                       continue;
> >>>> +
> >>>> +               ret =3D fwnode_property_read_u32(child, "reg", &ch);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>> +
> >>>> +               if (max_chan_id !=3D -1 && ch > max_chan_id)
> >>>> +                       return -ERANGE;
> >>>> + =20
> >>>
> >>> Should we use return dev_err_probe() on these to help with debugging =
a bad dtb?
> >>>     =20
> >>
> >> I am not fan of using dev_err_probe() in a 'library code'. This is
> >> because we never know if there'll be some odd use-case where this is n=
ot
> >> called from the probe.
> >>
> >> All in all, I'd leave adding most of the debugs to the callers -
> >> especially because we do not expect to have bad device-trees after the
> >> initial 'development stage' of a board. The board 'development stage'
> >> should really reveal bugs which prevent the channels from being
> >> registered - and after the DT is correct, these debug prints become
> >> unnecessary (albeit minor) binary bloat.
> >> =20
> >>>> +               *chan =3D *template;
> >>>> +               chan->channel =3D ch;
> >>>> +               chan++;
> >>>> +       }
> >>>> +
> >>>> +       *cs =3D chan_array;
> >>>> +
> >>>> +       return num_chan;
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, "IIO_DR=
IVER"); =20
> >>>
> >>> We can make this less verbose by setting #define
> >>> DEFAULT_SYMBOL_NAMESPACE at the start of the file. Then we can just do
> >>> EXPORT_SYMBOL_GPL() throughout the rest of the file. =20
> >>
> >> I am not sure what to think of this. I use the good old 'ctrl + ]' in =
my
> >> editor when I need to check how a function was supposed to be used. Th=
at
> >> jumps to the spot of code where the function is. I'd like to see the
> >> namespace mentioned there in order to not accidentally miss the fact t=
he
> >> function belongs to one.
> >>
> >> OTOH, I do like simplifications. Yet, the added simplification might n=
ot
> >> warrant the namespace not being visible in the function definition.
> >> =20
> >>> Also, I would prefer if the namespace matched config name (IIO_ADC_HE=
LPER). =20
> >>
> >> I had some lengthy discussion about this with Andy and Jonathan during
> >> earlier review versions. In short, I don't like the idea of very
> >> fragmented namespaces in IIO, which will just complicate the drivers
> >> without providing any obvious benefit.
> >>
> >> https://lore.kernel.org/all/20250222174842.57c091c5@jic23-huawei/
> >> =20
> >>>> +
> >>>> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
> >>>> +                                         const struct iio_chan_spec=
 *template,
> >>>> +                                         int max_chan_id,
> >>>> +                                         struct iio_chan_spec **cs);
> >>>> + =20
> >>>
> >>> There are some different opinions on this, but on the last patch I did
> >>> introducing a new namespace, the consensus seems to be that putting
> >>> the MODULE_IMPORT_NS() in the header file was convenient so that users
> >>> of the API don't have to remember to both include the header and add
> >>> the import macro.
> >>>     =20
> >>
> >> I do like this suggestion, and I believe this would be the balance
> >> between getting the benefit of hiding part of the symbols - while not
> >> unnecessarily complicating the callers. I know some people are opposing
> >> it though. My personal opinion is that having the MODULE_IMPORT_NS() in
> >> a header would be neatly simplifying the calling code with very little
> >> harm, especially here where including the header hardly has use-cases
> >> outside the IIO ADC.
> >>
> >> Unfortunately, the "safety" seems to often be a synonym for just "maki=
ng
> >> it intentionally hard". As Finnish people say: "K=C3=A4rsi, k=C3=A4rsi,
> >> kirkkaamman kruunun saat". :)
> >> (Roughly translated as "Suffer, suffer, you will get a brighter crown"=
).
> >>
> >> Let's hear what Jonathan thinks of your suggestion. =20
> >=20
> > For this particular case my intent was that all the IIO exports that
> > are suitable for use in simple IIO drives will be in this namespace,
> > we just haven't started that conversion yet.
> >=20
> > As such, having it defined from a header for this helper isn't a good
> > thing to do. =20
>=20
> Hmm. I agree.
>=20
> >  Generally I prefer to see in driver code what namespaces
> > are involved but do understand the other viewpoint. In this case I
> > definitely don't think it is appropriate unless we go for a specific na=
mespace
> > for just this helper. =20
>=20
> I suppose having the MODULE_IMPORT_NS() in the header would actually=20
> make the more fine-grained namespaces (like IIO_ADC_HELPERS, IIO_GTS,=20
> ...) much more usable. That'd relieved the drivers from explicitly=20
> listing multiple namespaces while nicely limiting the visibility.
>=20
> If IIO was my territory, I might want to ask people to go with that=20
> approach - but I am quite happy being a freeloade.. errm, I mean,=20
> bystander ;)
>=20
It relieves the burden but I'd still prefer explicit opt in to namespaces
unless there is general agreement on the approach of doing it in headers
which there has not been so far.

Jonathan

> Thanks!
>=20
> Yours,
> 	-- Matti


