Return-Path: <linux-iio+bounces-20314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433DAAD1301
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCD9188B34A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69536335C7;
	Sun,  8 Jun 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7fZoFLr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA410F1;
	Sun,  8 Jun 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749396614; cv=none; b=bJfQYgTnY8uLrO4R/9C9djQqJHYsIDWqmiDm53ULTQi0DFB4BM9KAgVWsqUGkB9o4E6EANbMuJSLWixo76TGBvOylsoePY2Iwrk4UckgLZ670sh6ZmhEjW0XYkOnb8JjqZQsC/cMUZoejHJE99yiHileerQTOGs+pA2h9d3u54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749396614; c=relaxed/simple;
	bh=1cxSAzy5uPjr/FzLfWoGcgqFHyU0Hho28i2TI8uFB2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHahfiGRZZ6HOOjjYWE6fTNn5RwvhEeZ+GVkuf2K+xVuJBHz94WZtTzjC/GB6Q/lBZmchABTHu3aYuik1CIvWr41aQDxrHJkY3zSB/PnnVe9PESXmbN/v99FOL39FfFlJfEG0aBPDJ2GX3x8ykdy6Znv3pzyto/pqux09ss7qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7fZoFLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E33C4CEEE;
	Sun,  8 Jun 2025 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749396613;
	bh=1cxSAzy5uPjr/FzLfWoGcgqFHyU0Hho28i2TI8uFB2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e7fZoFLr0wL6SLouyvi/pKQZ4Iz2Ro0FQPfPLmq5/P+vtn4W9/OFkCNdvnsIncB5o
	 ns37jUR3GTiuhnTEwTjg76OpXRGznDAdBStPIUJPT9gsYQPSeEt2REVFxBngTp5CiR
	 09xg5UJBTsNOZsRWtncfdglkjrrcQa+2tbrOCDRzL0OekBtWqozeswEo8uUqdnhSg/
	 GR9J8xcXqwC3y7RAabA2Mwb+6dDOPq39bcYtPfSnDSXWqWZnmrKU6vvLDm13MO9DJ+
	 T/1891IpK9aCg+HKXbnHgJ6INcvmkCKE7f306GIr3COuDjaOlepUTOsqVqu8uLR4uH
	 UKwI+VIugm0Cw==
Date: Sun, 8 Jun 2025 16:30:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] iio: accel: adxl313: add basic interrupt
 handling for FIFO watermark
Message-ID: <20250608163005.71b06e27@jic23-huawei>
In-Reply-To: <CAHp75Ve6nifph44F-_sOwqSBBy_Ay5BeH9QxWMmMUNR1N7wUzQ@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-7-l.rubusch@gmail.com>
	<CAHp75Ve6nifph44F-_sOwqSBBy_Ay5BeH9QxWMmMUNR1N7wUzQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Jun 2025 22:26:42 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Prepare the interrupt handler. Add register entries to evaluate the
> > incoming interrupt. Add functions to clear status registers and reset t=
he
> > FIFO.
> >
> > Add FIFO watermark configuration and evaluation. Let a watermark to be
> > configured. Evaluate the interrupt accordingly. Read out the FIFO conte=
nt
> > and push the values to the IIO channel. =20
>=20
> ...
>=20
> > +static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> > +{
> > +       struct adxl313_data *data =3D iio_priv(indio_dev);
> > +       const unsigned int fifo_mask =3D 0x1f, interrupt_mask =3D 0x02;=
 =20
>=20
> GENMASK()
> BIT()
>=20
> > +       int ret;
> > +
> > +       value =3D min(value, ADXL313_FIFO_SIZE - 1);
> > +
> > +       ret =3D regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
> > +                                fifo_mask, value);
> > +       if (ret)
> > +               return ret;
> > +
> > +       data->watermark =3D value;
> > +
> > +       return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> > +                                 interrupt_mask, ADXL313_INT_WATERMARK=
);
> > +} =20
>=20
> ...
>=20
> > +static int adxl313_get_samples(struct adxl313_data *data)
> > +{
> > +       unsigned int regval =3D 0; =20
>=20
> Useless assignment.
>=20
> > +       int ret;
> > +
> > +       ret =3D regmap_read(data->regmap, ADXL313_REG_FIFO_STATUS, &reg=
val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> > +} =20
>=20
> ...
>=20
> > +               ret =3D devm_request_threaded_irq(dev, irq, NULL,
> > +                                               &adxl313_irq_handler,
> > +                                               IRQF_SHARED | IRQF_ONES=
HOT,
> > +                                               indio_dev->name, indio_=
dev);
> > +               if (ret)
> > +                       return ret; =20
>=20
> Now I see the first user of 'irq'. Logically these two patches may not
> be split. Or split should be made differently, let's say IRQ type
> holding variable + switch case can go in the first preparatory patch
> (however it will make a little sense without real users, as it is/will
> be a dead code).
>=20

I'd just combine these two patches and patch 2 (which is also dead code
until this one is in place).

Jonathan



