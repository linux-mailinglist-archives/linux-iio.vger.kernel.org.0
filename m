Return-Path: <linux-iio+bounces-24490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DBBA60DC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3182A4E0621
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816227604E;
	Sat, 27 Sep 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWNFFq1i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664C1A23A4;
	Sat, 27 Sep 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758985458; cv=none; b=WMj4YZpORa5Kwua5Eur8bzyIOwZ2F9rUpjPF1CjMqtrsJEG66lmPfn94gC2yRcspMCd8Nqh4etAHWWGmN7hBEusveOET+dayZTieee1KGttyleTyVA3pqGzJ9jUnAmDKxwF9HQdt8L/px2NERAbcPYay3iaIbDvCiKK53JlPTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758985458; c=relaxed/simple;
	bh=Y5xKfNvs4LF3X/2adaaYdJ1hT1TQMmh6osAz97vELoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ousJnaB40nXxPpflNgG8MVT5Be1jlPG4c8DazwC0kWjJcFqYPm+NQF7sjw7Kk5S5dN2GVGb1Jc+ZCfU2XL2NjQ3KEecOQuWPDxXgpi/QTQbEWz2WyEhEkKKCoTOmiskp0c3WhR1KZKoU6sa5pgO7ch56xg28ky75T+yKfP1KSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWNFFq1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2ECC4CEE7;
	Sat, 27 Sep 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758985457;
	bh=Y5xKfNvs4LF3X/2adaaYdJ1hT1TQMmh6osAz97vELoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aWNFFq1iZEpYgFZtjDaSIWVLe/HKjgh6arHPa9h05Rp8FV5/AUOr2DzzRXeyzuEZX
	 jm8DubUZiCQlwfB60eCgxg24HnBSE1+LWTRKlTAqV+ns6c5LSy7TJ5GjtQmuXv8Xkn
	 CAkOBaUi+L/8giobz/DCJUNLPMEXnPd2aEkReiqgGe4QYvr/o9+16j5dRcDTfNWO/Z
	 wSlwFu7mncKyuH3k4Pk8yIukq7gkGrRQl/iVAXYvHf2284cSBSGZYJN+Xnj74s0QAR
	 2cLfGzRiL5embcj8Jj0IOMeCDMi7Y1jA4+SiRb9SuuFrzxmhfZccUDao57xjf0qaCy
	 F61rxywV5HXQg==
Date: Sat, 27 Sep 2025 16:04:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marius.Cristea@microchip.com, dlechner@baylibre.com,
 linux-hwmon@vger.kernel.org, jdelvare@suse.com, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
Message-ID: <20250927160408.25a6bcd4@jic23-huawei>
In-Reply-To: <36c4794d-2116-4d3e-8ad5-ac3ec764a7a1@roeck-us.net>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
	<20250920123340.1b1d03be@jic23-huawei>
	<a97486df-9f15-4280-8cb3-d77f4cf223df@roeck-us.net>
	<e6ab5becf5908d83857fcfd57823ffd259e6db90.camel@microchip.com>
	<36c4794d-2116-4d3e-8ad5-ac3ec764a7a1@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 07:32:22 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Sep 25, 2025 at 09:09:04AM +0000, Marius.Cristea@microchip.com wr=
ote:
> > Hi Guenter,
> >=20
> > Thank you for the feedback.
> >=20
> > On Tue, 2025-09-23 at 19:11 -0700, Guenter Roeck wrote: =20
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >=20
> > > On 9/20/25 04:33, Jonathan Cameron wrote: =20
> > > > On Wed, 17 Sep 2025 15:21:56 +0300
> > > > Marius Cristea <marius.cristea@microchip.com> wrote:
> > > >  =20
> > > > > This is the iio driver for EMC1812/13/14/15/33 multichannel Low-
> > > > > Voltage
> > > > > Remote Diode Sensor Family. The chips in the family have one
> > > > > internal
> > > > > and different numbers of external channels, ranging from 1
> > > > > (EMC1812) to
> > > > > 4 channels (EMC1815).
> > > > > Reading diodes in anti-parallel connection is supported by
> > > > > EMC1814, EMC1815
> > > > > and EMC1833.
> > > > >=20
> > > > > Current version of driver does not support interrupts, events and
> > > > > data
> > > > > buffering. =20
> > > > Hi Marius,
> > > >=20
> > > > For a temperature monitoring device like this, the opening question
> > > > is
> > > > always why not HWMON?
> > > >=20
> > > > There are various reasons we have temp sensors in IIO but mostly
> > > > they are not
> > > > described as being monitors and this one is.
> > > >=20
> > > > IIO may well be the right choice for this part, but good to lay out
> > > > your
> > > > reasoning and +CC the hwmon list and maintainers.=C2=A0 There is an
> > > > emc1403
> > > > driver already in hwmon, so perhaps compare and contrast with that.
> > > >=20
> > > > I've +CC Jean, Guenter and list to save sending a v2 just to do
> > > > that.
> > > >  =20
> > >=20
> > > At first glance it looks like the series is (mostly ?) register
> > > compatible
> > > to the chips supported by the emc1403 driver, so it should be
> > > straightforward
> > > to add support for the emc180x series to that driver.
> > >=20
> > > Guenter =20
> >=20
> > Most of the register address are compatible. The EMC181X is an update=20
> > (a newer generation) then the EMC1403.
> >=20
> > The biggest improvement is that the EMC18XX has a continuous block of
> > registers in order to improve the temperature reading (that means some
> > addresses are overlapping with the older register maps) and a new set
> > of registers to  handle the "Rate Of Change" functionality.
> > Also the older EMC14XX has some hardcoded configuration/features based
> > on the part number.
> >=20
> > Considering all of the above I consider that the complexity of the
> > EMC1403 will increase quite a lot without any real benefit and it will
> > be harder to be maintained.
> >  =20
> Ok.
>=20
> > I have submitted this as the fist iteration from a longer list of
> > feature that I want to add to the driver, including events and maybe
> > interrupts.
> >=20
> > If nobody has anything against, I would like to add a separate driver
> > for EMC18XX into the IIO. =20
>=20
> IMO this should be a hwmon driver.

So far I haven't seen any reason why IIO would make more sense, so agreed.

Jonathan

>=20
> Guenter


