Return-Path: <linux-iio+bounces-9813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C764988FA6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABA51F2185B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58418892D;
	Sat, 28 Sep 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQHjJYtF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF26186E59;
	Sat, 28 Sep 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533779; cv=none; b=X8Fg1NIShf79V0MxHH+LmEAzRApk8FGV7vVJwO3VQCYOmFOF7Pi+l8TqWPR7w1ZNh0LWLDAl4sHiVxY1zkPxVK0/37ArdgW+l7NPr1Jzud8DwXJLzdZ/wT4p6hbqBh8bS1vRr46zA4PgPaCEDNi04p7/obhxjTTQx/QRj98eMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533779; c=relaxed/simple;
	bh=BQe8e7lFzVfmZUr+z2sDDGSb5uLfPX8XMR5x5U2lb1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn3tglf3Uvvbpr9dSMlZ9XiWbUolU9mSAxz5kHFfAC7g4Ul+KgESMbRgW14qkq9a1AriQJcxMbAXz3hmMxMJGfTcfTa4tezE8NK3+Wi9QAdMb9ukiIfGFB5CVT6ZYC0M7V6dOUZvJjrcDmWfGh1hz+EQG2pUCjL9KrxJuGbMIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQHjJYtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F07C4CEC3;
	Sat, 28 Sep 2024 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727533779;
	bh=BQe8e7lFzVfmZUr+z2sDDGSb5uLfPX8XMR5x5U2lb1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQHjJYtFlEhZLQlmUwozo1Yr23MlhMSqY4p/UtWwNWhZaXGG77Zie9XTRVRqK15rF
	 bb069Iq4WvmGLkAtNE1/WyqOw6Lm6oJ5l+RzZ3SEcKmse8Eulns9HyiEgXnwKLW8wb
	 Yb9SOZWr4LkHumNHH6lgF5bX+yLfb2FpZGbB9jLdT9YRXmeP/ulDFTkRlzJ8mCrnYY
	 /IgsV75WCSz3PawyVgKik4PGPAmrlXlC2HRpEgvRux3rUugmw2Dlwprj+j5np3QlTc
	 CeuuMPtqqu9/mxnbtl0hktIBmtp8WeaHQDgBad6dTQszVYqFp+EQsaFSzvrc1uUXXA
	 3NMEI1O8Z2x7g==
Date: Sat, 28 Sep 2024 15:29:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Nechita, Ramona" <Ramona.Nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240928152928.38ee18b1@jic23-huawei>
In-Reply-To: <CAMknhBFyydCJeAazDYMkkH=rKU2DbJGy=Kpb0242Vn81MHn0mQ@mail.gmail.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
	<20240914180648.592cd69e@jic23-huawei>
	<SN6PR03MB4320E03B052A867DE73196CBF36C2@SN6PR03MB4320.namprd03.prod.outlook.com>
	<CAMknhBFyydCJeAazDYMkkH=rKU2DbJGy=Kpb0242Vn81MHn0mQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Sep 2024 14:51:28 +0200
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Sep 20, 2024 at 3:24=E2=80=AFPM Nechita, Ramona
> <Ramona.Nechita@analog.com> wrote:
> >
> > Hello all,
> >
> > Just a minor question
> > ... =20
> > > =20
> > >> +
> > >> +static irqreturn_t ad7779_trigger_handler(int irq, void *p) {
> > >> +    struct iio_poll_func *pf =3D p;
> > >> +    struct iio_dev *indio_dev =3D pf->indio_dev;
> > >> +    struct ad7779_state *st =3D iio_priv(indio_dev);
> > >> +    int ret;
> > >> +    int bit;
> > >> +    int k =3D 0;
> > >> +    /*
> > >> +     * Each channel shifts out HEADER + 24 bits of data therefore 8=
 * u32
> > >> +     * for the data and 64 bits for the timestamp
> > >> +     */
> > >> +    u32 tmp[10];
> > >> +
> > >> +    struct spi_transfer sd_readback_tr[] =3D {
> > >> +            {
> > >> +                    .rx_buf =3D st->spidata_rx,
> > >> +                    .tx_buf =3D st->spidata_tx,
> > >> +                    .len =3D AD7779_NUM_CHANNELS * AD7779_CHAN_DATA=
_SIZE,
> > >> +            }
> > >> +    };
> > >> +
> > >> +    if (!iio_buffer_enabled(indio_dev))
> > >> +            goto exit_handler; =20
> > >
> > >If buffers aren't enabled, the push to buffers won't do anything. So t=
his race shouldn't matter.  If it does, what happens?
> > >I'm curious because I'd expect any races that cause trouble in this ca=
se to be pretty universal across drivers. =20
> >
> > I added that condition rather because the DRDY pulse will keep on being=
 generated even when the buffers are not active,
> > and it would be better to exit the function sooner. I tested it and it =
does not break to remove the condition, I just
> > thought it made more sense like this. Should I delete it?
> > =20
> > >.... =20
> >
> > Best regards,
> > Ramona Nechita
> >
> > =20
>=20
> Perhaps a better way to handle this would be to move
>=20
>     disable_irq(st->spi->irq);
>=20
> to the buffer predisable callback instead of doing it in the buffer
> postdisable callback. Then we will be sure to not get any more DRDY
> interrupts after the buffer is disabled.
>=20
> (And to keep things balanced, moved the corresponding irq_enable() to
> the buffer postenable callback.)

That makes logical sense but in reality in the vast majority of cases
it makes no practical difference whether things are in the pre or
post callbacks as the fundamental races with tear down are there in
both cases but shouldn't matter as they correspond to slightly
earlier or later disabling of the buffer.  So this is a nice to
have for readabilty and understanding rather than a required change I think.

>=20
> Since ad7779_trigger_handler is the IIO trigger interrupt handler and
> not the DRDY interrupt handler though, it is already not possible for
> this interrupt handler to be called while the IIO buffer is enabled.
> So it should be safe to remove the if
> (!iio_buffere_enabled(indio_dev)) even without the other changes I
> suggested.
Exactly. =20

Jonathan



