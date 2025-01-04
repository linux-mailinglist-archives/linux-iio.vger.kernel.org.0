Return-Path: <linux-iio+bounces-13887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F47A01460
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F4B1884559
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE542C0B;
	Sat,  4 Jan 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECxdl/Ms"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816325949A;
	Sat,  4 Jan 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735994996; cv=none; b=CgbFSDgWvnsUlohRQKvjZbMAXBuByqrSXGfCf4KsiPVifkaGFYKTA2kmeGaql9xOsybBQPUUiPOXVNwpyO6qUIK3s25aSpquqjRsQLLxc+GOARJvj4GWRAdAgiuBbIkdtUOIkMPJCS/Tg5KwKllIz8CEXC+mMP2qusSTjaiDn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735994996; c=relaxed/simple;
	bh=S+SWXI7nBS1zgnIdoCWeW0WY/z8IGFIzRmI4FseOTCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqrq/o6SYWLTR6XbHeTZprPB3xofDtGJVWZ6aBiXane8oPeLAUvADP/ZBiPcEax2IUWA6rPaWYO0iq/hnNES+NkeQuAiUqZckTcItOZZsKi/tR2bPK0esElkItkT6NP0TWiWZnhvIXtif+CconK/ppbfCQnv4ylyQ5MN+eAElik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECxdl/Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC0C4CED1;
	Sat,  4 Jan 2025 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735994995;
	bh=S+SWXI7nBS1zgnIdoCWeW0WY/z8IGFIzRmI4FseOTCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECxdl/MsrvRPd081UT+aNe9mhwoIGvtHPDVLZYDZFPgRRXlBmlnVwgJ4y0649whvr
	 C7L2YuhBXJsQYntksmJ6ThHunZbb2el3L9eDvLaif6gPXJ7Oa2/QdW0iM6BT8U6sv3
	 u/Q55B/gvJH789FJHp4oLgm4QTGAGDsyNPHqcPctxT5zCA+CvpJq8bAyMGIbtWw8sp
	 Txy1cEbYzqPJBl0hwmQfrQfFJrpg1xZdpifpb0toNH5OeP9W3Q0jDECDrqCejkW9nS
	 QXG3+TIru+MO+BEQu6Hl4kBqccDOKljSIE6IV9cKP6MrWXTaizZu2X7l9iRfKYuXLZ
	 mubRbxQooO6Qw==
Date: Sat, 4 Jan 2025 12:49:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 6/7] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20250104124944.14deae84@jic23-huawei>
In-Reply-To: <CAFXKEHbVFsv2pQvPc-0aHCPmCJ0=RX2ezYrXf1PeMq1QUwf7ZA@mail.gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-7-l.rubusch@gmail.com>
	<20241228144536.12e2e8a5@jic23-huawei>
	<CAFXKEHbVFsv2pQvPc-0aHCPmCJ0=RX2ezYrXf1PeMq1QUwf7ZA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Dec 2024 17:11:58 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Dec 28, 2024 at 3:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Wed, 25 Dec 2024 18:13:37 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add a basic setup for FIFO with configurable watermark. Add a handler
> > > for watermark interrupt events and extend the channel for the
> > > scan_index needed for the iio channel. The sensor is configurable to =
use
> > > a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode =
now
> > > a watermark can be configured, or disabled by setting 0. Further feat=
ures
> > > require a working FIFO setup.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h      |  27 ++-
> > >  drivers/iio/accel/adxl345_core.c | 305 +++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 321 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index 6f39f16d3..bf9e86cff 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -15,18 +15,32 @@
> > >  #define ADXL345_REG_OFS_AXIS(index)  (ADXL345_REG_OFSX + (index))
> > >  #define ADXL345_REG_BW_RATE          0x2C
> > >  #define ADXL345_REG_POWER_CTL                0x2D
> > > +#define ADXL345_REG_INT_ENABLE               0x2E
> > > +#define ADXL345_REG_INT_MAP          0x2F
> > > +#define ADXL345_REG_INT_SOURCE               0x30
> > > +#define ADXL345_REG_INT_SOURCE_MSK   0xFF
> > >  #define ADXL345_REG_DATA_FORMAT              0x31
> > > -#define ADXL345_REG_DATAX0           0x32
> > > -#define ADXL345_REG_DATAY0           0x34
> > > -#define ADXL345_REG_DATAZ0           0x36
> > > -#define ADXL345_REG_DATA_AXIS(index) \
> > > -     (ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> > > +#define ADXL345_REG_XYZ_BASE         0x32
> > > +#define ADXL345_REG_DATA_AXIS(index)                         \
> > > +     (ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
> > >
> > > +#define ADXL345_REG_FIFO_CTL         0x38
> > > +#define ADXL345_REG_FIFO_STATUS      0x39
> > > +#define ADXL345_REG_FIFO_STATUS_MSK  0x3F
> > > +
> > > +#define ADXL345_FIFO_CTL_SAMPLES(x)  FIELD_PREP(GENMASK(4, 0), x) =20
> > These need linux/bitfield.h to be included.
> > =20
>=20
> Sure, I can do this.
>=20
> > However, that got me looking closer at this and it should be done
> > differently.
> >
> > Just define the masks in here and put the FIELD_PREP() inline in the
> > c file.  Same for the various other FIELD_PREP macros in here.
> >
> > It may seem convenient to wrap all this up here, but in general
> > I'd rather see that these are simple FIELD_PREP() calls where they
> > are used inline.
> > =20
>=20
> Ok, I understand, the masks stay in the adxl345.h and the FIELD_RPEP()
> macros better go to where they are used, i.e. the adxl345_core.c.
>=20
> Thank you for reviewing this. I was a bit unsure about using the
> FIELD_PREP() / GENMASK() combinations correctly. The code seems to
> work for me, though. For future usage of those macros: Generally my
> usage of those macros is correct?

Yes, the usage is fine otherwise.

>=20
> Do I understand correctly, on the long run it would generally be
> cleaner, also to migrate the defines to the adxl345_core.c? IMHO,
> probably most of the constants in the adxl345.h can be private to
> adxl345_core.c, and probably better should.

Exactly.

Thanks,

Jonathan

>=20
> Best regards,
> L

