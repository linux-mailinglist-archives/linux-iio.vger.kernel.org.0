Return-Path: <linux-iio+bounces-20978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BFAEA5B9
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C463A9DB7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E192EE980;
	Thu, 26 Jun 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9pFx+l1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90952EE964;
	Thu, 26 Jun 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963725; cv=none; b=gs1Dur1EMOlo2/c3sp2EZR1S+xeJsymdBePmuLEtlY+nvGnBdW0cw9vdYy6ilU8aVmGsWWOGJyZIAkARVs6CMOwNW/21hAjJ1kGRMXs9yuzbL8HEPytNsBAyDRS5ZALv5prA2rQbhVsUG7Ctld2u+tHKwLaBG/Ig0vl6WjLxHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963725; c=relaxed/simple;
	bh=tpLRBSCjneDmF1eFX7eChBL/ZaxqApabiv+eASamzO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpCq0jyILOX3on6SRHLwxACd4qgCnAGd5Cul9JRzgXO0y9F4fhDySSoJcSdrhaqedI1Iu8YMfBpGIvpHTfmTutcBOuu3VKRH5wyMvQ8yR1gUmqKjjjOk0dc6TRaVHKl9b4ZHd6kfp149P6uY6rVF1BmqR6esU95M5k4ceGOwyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9pFx+l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD27C4CEEB;
	Thu, 26 Jun 2025 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963725;
	bh=tpLRBSCjneDmF1eFX7eChBL/ZaxqApabiv+eASamzO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9pFx+l1kCNLOuTwZZ6KW5zNt9XKfcCWbcs5EguWde+bMNojwnNUmM6aFQxB5oUR8
	 NU0SPx2415wpfOsE6h8JZRlqH7/wHkyaKY5QEJfSv9sPuiqjRRhnrhh5r6/Pbrq9Eg
	 Fj8NBv4JsWOyB1TVOXUpz/QMdquE6+TJsJvQACvu0RQK230M1BmD1uvgBg0NTC0Zga
	 nfRhbaYSrFra52wUEtg32rwKz8Xl5dWqNVfFgyqBvUd10XcXmERbrNUytPwUFyWRZS
	 NA876gFdqCGySVIiYNICwJXY6HESQIdI4Ua6ip/u6RvgDGCBfzNLqnQdm1KsrFG/6W
	 bVGwxIIUpgj6A==
Date: Thu, 26 Jun 2025 19:48:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA
 buffers at the end
Message-ID: <20250626194838.55c5eca4@jic23-huawei>
In-Reply-To: <FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
	<20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
	<CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
	<FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025 08:43:37 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >________________________________________
> >From:=C2=A0David Lechner <dlechner@baylibre.com>
> >Sent:=C2=A0Tuesday, June 24, 2025 00:13
> >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> >Cc:=C2=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@m=
etafoo.de>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel=
.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@=
vger.kernel.org <linux-kernel@vger.kernel.org>
> >Subject:=C2=A0Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure =
DMA buffers at the end
> >=C2=A0
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >On Mon, Jun 23, 2025 at 6:56=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Re=
lay
> ><devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote: =20
> >>
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>
> >> Move DMA buffers at the end of the structure to avoid overflow
> >> bugs with unexpected effect. =20
> >
> >If there is an overflow bug, we should fix that rather than hiding it.
> >
> >If I misunderstood the problem and timestamp and fifo should not be in
> >the DMA aligned area and there is a problem with DMA cache writing
> >over them, then I think we should reword the commit message.
> > =20
> Hello David,
>=20
> this change was asked by Jonathan so that potential DMA overflow would be=
 more
> easily caught by writing outside of the structure rather than writing ins=
ide
> and do unexpected behavior.
>=20
> >>
> >> struct inv_icm42600_fifo has a DMA buffer at the end.
> >>
> >> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >> ---
> >>  drivers/iio/imu/inv_icm42600/inv_icm42600.h | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio=
/imu/inv_icm42600/inv_icm42600.h
> >> index 55ed1ddaa8cb5dd410d17db3866fa0f22f18e9d2..9b2cce172670c5513f18d5=
979a5ff563e9af4cb3 100644
> >> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >> @@ -148,9 +148,9 @@ struct inv_icm42600_suspended {
> >>   *  @suspended:                suspended sensors configuration.
> >>   *  @indio_gyro:       gyroscope IIO device.
> >>   *  @indio_accel:      accelerometer IIO device.
> >> - *  @buffer:           data transfer buffer aligned for DMA.
> >> - *  @fifo:             FIFO management structure.
> >>   *  @timestamp:                interrupt timestamps.
> >> + *  @fifo:             FIFO management structure.
> >> + *  @buffer:           data transfer buffer aligned for DMA.
> >>   */
> >>  struct inv_icm42600_state {
> >>         struct mutex lock;
> >> @@ -164,12 +164,12 @@ struct inv_icm42600_state {
> >>         struct inv_icm42600_suspended suspended;
> >>         struct iio_dev *indio_gyro;
> >>         struct iio_dev *indio_accel;
> >> -       u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> >> -       struct inv_icm42600_fifo fifo;
> >>         struct {
> >>                 s64 gyro;
> >>                 s64 accel;
> >>         } timestamp;
> >> +       struct inv_icm42600_fifo fifo; =20
> >
> >I didn't look at how the drivers use timestamp and fifo, but if they
> >are passed as a buffer to SPI, then they need to stay in the DMA
> >aligned area of the struct. =20
>=20
> struct inv_icm42600_fifo has a buffer at its end that is passed to SPI.
> Same things for buffer below. That's why both buffers are DMA
> aligned.

It's a tiny bit esoteric that this is relying on structure alignment rules
that says (iirc) the structure element will be aligned to maximum of it's
elements and there is tail padding to that size as well.  Thus the whole
struct inv_icm42600 is __aligned(IIO_DMA_MINALIGN) and the buffer in there
is itself after padding to ensure that it is __aligned(IIO_DMA_MINALIGN)


Anyhow, all I think this actually does is avoid one lot of padding
(as well as making it slightly easier to reason about!)

outer struct {
stuff
padding to align #1
fifo {
	stuff
	padding to align
	buffer
	padding to fill up align
}
struct timestamp;
///this bit will go away as it can fit in the padding #1 (probably)
Padding to align
////
u8 buffer[2] __ailgned(IIO_DMA_MINALIGN)


=09
>=20
> > =20
> >> +       u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> >>  };
> >>
> >>
> >>
> >> --
> >> 2.49.0
> >>
> >> =20
> > =20
>=20
> Thanks,
> JB

