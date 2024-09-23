Return-Path: <linux-iio+bounces-9739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D997EBB7
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3366282121
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591E1991D9;
	Mon, 23 Sep 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iMJ55XGi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48A1991BB
	for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095903; cv=none; b=ApLsxTg+lvxWoEuwYx5NxZruER7gcLB+JLmN2FZtjT+NjWSmCy7pR5q6RJKtX1hU7BoMqZQKdSWH9ovS4s5bnpQMzmaALlgKjPgRLvKl1gWwcZqiQv/NNMV3xo6H9ULXn+JDyY1/J6oLFW8PPNqIqD/z7R/JDBqAXEmMDt1RZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095903; c=relaxed/simple;
	bh=NvepIcObAFOW0GAEKprtdJAyQP6u04ZarXNoUN/O9fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJzn8eTbiEMv/0ht8T7I/rdpL5IlUwNrE9dYYrlNQDPo2/Xkl690vodzLVnvhEyz2wrs0NNYVJf8Rbaun+tdJE/HvfNQ0LLnZApkun18TXcQy2/wt8I5fyfAsboFai4/8IUQ4h5WI5mtmAsXETLTlEgB0Wiam/L+/tTyA4a0ENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iMJ55XGi; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so44274711fa.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2024 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727095900; x=1727700700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWyVPet8hZnOop/AUNBEWZsHekqaT1mqAy7nCtERCWg=;
        b=iMJ55XGihjnMld86HJw+77vEGiM9sVdAXEGR3U1OQ9IfwjSGBfS10BfkHlraV3jnFO
         3kqoODcEnnS3sjesqsLVtMoDmcslZ4uJqwVDLh2w/66TQBsKJtYjBSCj092L9Z6YkRl3
         Sdc0rpdS5ungFyN4HRkx3wCsdZbhZ5KuZU3hs203gDmOI4ObQN2QyPZ/hCgeYD98UewQ
         ChJeXaeoVxZ5l+mvNu+WqpjA3vyfMEapqpFfjtCAIfA492APqB3TJPz1Sz5NSzdwqxHY
         nyVP1kP1RNA0ff+r++xL7mMTuLqY+ZFTT06EHl0xbE3LAQYCghHWg3m00js16XtbQB4I
         QwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727095900; x=1727700700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWyVPet8hZnOop/AUNBEWZsHekqaT1mqAy7nCtERCWg=;
        b=PHexw9VW6U4bJRS6HM8xfZ6DWX6yneYMuigwqRYjEIq90WC+K2dsn1r+FwoIxKUsrj
         Uf96+Ke/w8ubDla2g/POz1cKucRFukl056urLA3pbbjjDPSXtXhEt2U9WhSsElh5hgpG
         lnH3eZXe8XPG/nWohEqMO/OaWYZq5BARP/JxNrcldajxyB5zBzVwm98L8nYjyv8eslqM
         7ytec9ShCuvp0fqIaBTOdUdm/G/p8wMKD6GHCqWkCaYmTpNYYJ+O/ovgK5l2082PTi7X
         ZxgdB9dBwvh7aYKPxSTFs5e01u87Vk0Npb5uBb9pEHiTkoKlxmrxa5IcUlNdFWDKhtBE
         5vpw==
X-Forwarded-Encrypted: i=1; AJvYcCUTQciInRsk2L9MTWioXEIYIDWNyJf66G8NXQyOT/ta8NiDKj64KponHdGhI4Jo39/igAX+j9mbGg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NCl4rlXcbGl8VIIXHjzFPTJL2DgCMZTnTukeLx7CzSLpqIXR
	vapB3opMVd8ssd9sP6cfjmdagoD7AYPgF71S7Lm1bNVxwK1Rg6GRAZ/zmH4EGqj3JcurCPT5tVl
	/ZNR8ghoAJck4imZ+1tovg9vigJmJP9CoLMpk/w==
X-Google-Smtp-Source: AGHT+IGjwUls46wFV2p1ok6WP3bWq/lGTfL1sVNuhz5+4xnhesypCJlx6gg4f5K5q/lbcDosAtmu0Hr2KQy8e0jFd1U=
X-Received: by 2002:a05:651c:1994:b0:2f0:1a19:f3f1 with SMTP id
 38308e7fff4ca-2f7cc355ce4mr51007311fa.7.1727095899709; Mon, 23 Sep 2024
 05:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912121609.13438-1-ramona.nechita@analog.com>
 <20240912121609.13438-4-ramona.nechita@analog.com> <20240914180648.592cd69e@jic23-huawei>
 <SN6PR03MB4320E03B052A867DE73196CBF36C2@SN6PR03MB4320.namprd03.prod.outlook.com>
In-Reply-To: <SN6PR03MB4320E03B052A867DE73196CBF36C2@SN6PR03MB4320.namprd03.prod.outlook.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Sep 2024 14:51:28 +0200
Message-ID: <CAMknhBFyydCJeAazDYMkkH=rKU2DbJGy=Kpb0242Vn81MHn0mQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 3:24=E2=80=AFPM Nechita, Ramona
<Ramona.Nechita@analog.com> wrote:
>
> Hello all,
>
> Just a minor question
> ...
> >
> >> +
> >> +static irqreturn_t ad7779_trigger_handler(int irq, void *p) {
> >> +    struct iio_poll_func *pf =3D p;
> >> +    struct iio_dev *indio_dev =3D pf->indio_dev;
> >> +    struct ad7779_state *st =3D iio_priv(indio_dev);
> >> +    int ret;
> >> +    int bit;
> >> +    int k =3D 0;
> >> +    /*
> >> +     * Each channel shifts out HEADER + 24 bits of data therefore 8 *=
 u32
> >> +     * for the data and 64 bits for the timestamp
> >> +     */
> >> +    u32 tmp[10];
> >> +
> >> +    struct spi_transfer sd_readback_tr[] =3D {
> >> +            {
> >> +                    .rx_buf =3D st->spidata_rx,
> >> +                    .tx_buf =3D st->spidata_tx,
> >> +                    .len =3D AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_S=
IZE,
> >> +            }
> >> +    };
> >> +
> >> +    if (!iio_buffer_enabled(indio_dev))
> >> +            goto exit_handler;
> >
> >If buffers aren't enabled, the push to buffers won't do anything. So thi=
s race shouldn't matter.  If it does, what happens?
> >I'm curious because I'd expect any races that cause trouble in this case=
 to be pretty universal across drivers.
>
> I added that condition rather because the DRDY pulse will keep on being g=
enerated even when the buffers are not active,
> and it would be better to exit the function sooner. I tested it and it do=
es not break to remove the condition, I just
> thought it made more sense like this. Should I delete it?
>
> >....
>
> Best regards,
> Ramona Nechita
>
>

Perhaps a better way to handle this would be to move

    disable_irq(st->spi->irq);

to the buffer predisable callback instead of doing it in the buffer
postdisable callback. Then we will be sure to not get any more DRDY
interrupts after the buffer is disabled.

(And to keep things balanced, moved the corresponding irq_enable() to
the buffer postenable callback.)

Since ad7779_trigger_handler is the IIO trigger interrupt handler and
not the DRDY interrupt handler though, it is already not possible for
this interrupt handler to be called while the IIO buffer is enabled.
So it should be safe to remove the if
(!iio_buffere_enabled(indio_dev)) even without the other changes I
suggested.

