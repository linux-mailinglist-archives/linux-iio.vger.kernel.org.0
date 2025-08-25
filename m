Return-Path: <linux-iio+bounces-23200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F11B33C0E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7005F3A6B7C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190C2D739A;
	Mon, 25 Aug 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhABYxHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173B20DD51;
	Mon, 25 Aug 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115973; cv=none; b=Juqvz6NbOAiVYjSaNiUQ95HGxUq0hI7Wyr2KUqLdpFdz9/ROHoNJIhRQGUGo87ceZTmjvySFxusixCWVcadK8LPnVd/YTutqIRgaXT6yJ82dl699vIQoQ/O2l5YVvfnQ7Bc0rzii3VaaHBBfQBFUe3OayPQqf2tzuyXJF9SQ8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115973; c=relaxed/simple;
	bh=qeHMY0RvO4nwo+ot5ZVywkr3aB/H7Z3rA09Y64RaNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHFH6aL1lwWwbqftrGZXZKFSjdOhMmPHjlLc6oQVCAEEzpve8qotHL2Vn6wM7uZSDNLKXbI+brrrM8Ez/ZWjSO6PvOsuSlZ/ESS8hnd1Bz3Y0Sj182KONwNFvF82ZZoU1dmZst2e9wDU9cvqKkc0LMjgqBo+aTxn5rYpNeTvhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhABYxHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C2C4CEED;
	Mon, 25 Aug 2025 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756115973;
	bh=qeHMY0RvO4nwo+ot5ZVywkr3aB/H7Z3rA09Y64RaNnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhABYxHB5Qtt9aB+zd8NSvAJ4zhztHc7oPIaP2Pbe9UehUavkerDxmY6hMq5KF45S
	 AsApD4j/+c8hTHx4DZF3CJbLdSQ5arM6QFwvuWAP9zXX9lmekmEOYhTuW5Zcallezl
	 M5h/fIpGdpqrt0Tq1A9rAz+TAOBNNd60A3x2OzFzmp7886Mqpe4dSiacj0lfYckOP7
	 gLIPIvlAekeVyuZqr99rJQObLE5lDDVk9GDZTOtAyMKhJ7O/JuclSAxs3d7Hd7z0/H
	 Pnu5xWDRJ2dXH1e5vxK0lphH0NnSGp/c40X/fHMQwoADKA8JYsrgO4wRaYLlyxFL9W
	 oV3YlgvHD2r3w==
Date: Mon, 25 Aug 2025 10:59:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: cryolitia@uniontech.com, Alex Lanzano <lanzano.alex@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>, WangYuli
 <wangyuli@deepin.org>, Jun Zhan <zhanjun@uniontech.com>,
 niecheng1@uniontech.com2
Subject: Re: [PATCH v4] iio: imu: bmi270: Match PNP ID found on newer GPD
 firmware
Message-ID: <20250825105923.07e11c79@jic23-huawei>
In-Reply-To: <CAHp75Ve7OC80r1ZcAHPeOxeUemEUbV9GfOtr44ZJ9Vswteb78Q@mail.gmail.com>
References: <20250821-bmi270-gpd-acpi-v4-1-5279b471d749@uniontech.com>
	<CAHp75Ve7OC80r1ZcAHPeOxeUemEUbV9GfOtr44ZJ9Vswteb78Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 11:10:15 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 10:52=E2=80=AFAM Cryolitia PukNgae via B4 Relay
> <devnull+cryolitia.uniontech.com@kernel.org> wrote:
> >
> > From: Cryolitia PukNgae <cryolitia@uniontech.com>
> >
> > GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
> > When they switched to BMI260 sensors in newer hardware, they reused
> > the existing Windows driver which accepts both "BMI0160" and "BMI0260"
> > IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
> > devices, causing driver mismatches in Linux.
> >
> > 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
> > BMI260 sensors to avoid loading the bmi160 driver on Linux. While this
> > isn't Bosch's VID;
> > 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
> > 3. We're seeing real devices shipping with "BMI0260" in DSDT
> >
> > The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
> >
> > Scope (_SB.I2CC)
> > {
> >     Device (BMA2)
> >     {
> >         Name (_ADR, Zero)  // _ADR: Address
> >         Name (_HID, "BMI0260")  // _HID: Hardware ID
> >         Name (_CID, "BMI0260")  // _CID: Compatible ID
> >         Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> >         Name (_UID, One)  // _UID: Unique ID
> >         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Sett=
ings
> >         {
> >             Name (RBUF, ResourceTemplate ()
> >             {
> >                 I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
> >                     AddressingMode7Bit, "\\_SB.I2CC",
> >                     0x00, ResourceConsumer, , Exclusive,
> >                     )
> >             })
> >             Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
> >         }
> >         # omit some noise
> >     }
> > } =20
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Applied.

Thanks,

