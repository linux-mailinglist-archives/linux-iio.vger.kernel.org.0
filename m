Return-Path: <linux-iio+bounces-24727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510BBB8F68
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597A93C3622
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0642276024;
	Sat,  4 Oct 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs+rMBQM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA820FA9C;
	Sat,  4 Oct 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759592493; cv=none; b=fBC6vw1URC4K0cQcZwx0lcF5QxKc2/pqX7ucR4kpyxwOSGzbqstQKDxUXGc65A/QSoLG7ZrQw3AGGTJv+pgWWJLcw/qbKrduAB3vKp2sDVLb/iK1hfvmy0Qk0ZwxeU/XEtWQgAbHoLRtctaWv5kGrp7643hSwVq73vdUZcrHzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759592493; c=relaxed/simple;
	bh=x+YOd4BcHuS7KhQVY1W2QLQJS254EMNFrn1vz42vG1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHPjsIqo0zQ0SWI8UhMZUG6GaAcmxLWS4J2q3t4KEsYrCpLmgB5broklGQR9cK4r8Vv7iidgMxf98sLWlStiTVtyIoW6c0Z/r0Og4nUNkT0Ko7n8r9JXoFsfc/wThUDNdCNQfjJ+C9pJ9nvtT1MfiSdoJhaJ5K0dKQQcscyAGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs+rMBQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B587C4CEF1;
	Sat,  4 Oct 2025 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759592493;
	bh=x+YOd4BcHuS7KhQVY1W2QLQJS254EMNFrn1vz42vG1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bs+rMBQMJDPjEq8v12qP9APcA7AYYeHy1mUYsE2PPWZQxiFIb+3HGPp81fotWtL2b
	 zaTKmXjhrYKQSWd4kPwtKPNbrXqijCyZxPwK6u910HQ2wfIYGT9cj4ixVHUkXxSCp9
	 jaWvnjaEfunEbAjlftaXUiIBV5MqmPFFiqskWk5funVLUWwG6zA5wSKi9RlcBXeNUs
	 VREgYj7++WdsSGblM5BRgQkmFMs7vRn3MaemsRQIWKH+F37maHDAZDk7rfnupZnl7r
	 dJG/5nk1qm66+9Cp1zRHbRtSL8YmG2JJ70yrGCO1f06AMQ1QYYOGPSgeQiydxflXId
	 u6fyDR68X7+2g==
Date: Sat, 4 Oct 2025 16:41:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/9] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20251004164123.4faf4b45@jic23-huawei>
In-Reply-To: <FR2PPF4571F02BC2026559022A8291EC5DD8CE6A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-3-76687b9d8a6e@tdk.com>
	<20250928094524.52d492a9@jic23-huawei>
	<FR2PPF4571F02BC2026559022A8291EC5DD8CE6A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Oct 2025 12:07:40 +0000
Remi Buisson <Remi.Buisson@tdk.com> wrote:

> >
> >
> >From: Jonathan Cameron <jic23@kernel.org>=20
> >Sent: Sunday, September 28, 2025 10:45 AM
> >To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
> >Cc: Remi Buisson <Remi.Buisson@tdk.com>; David Lechner <dlechner@baylibr=
e.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org=
>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;=
 Conor Dooley <conor+dt@kernel.org>; linux-kernel@vger.kernel.org; linux-ii=
o@vger.kernel.org; devicetree@vger.kernel.org
> >Subject: Re: [PATCH v6 3/9] iio: imu: inv_icm45600: add buffer support i=
n iio devices
> >
> >On Wed, 24 Sep 2025 09:23:56 +0000
> >Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrot=
e:
> > =20
> >> From: Remi Buisson <remi.buisson@tdk.com>
> >>=20
> >> Add FIFO control functions.
> >> Support hwfifo watermark by multiplexing gyro and accel settings.
> >> Support hwfifo flush.
> >>=20
> >> Signed-off-by: Remi Buisson <remi.buisson@tdk.com> =20
> >Hi Remi,
> >
> >A few trivial things in here as well.
> >
> >Jonathan =20
> Thanks again for the review !
> Remi
> > =20
> >> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio=
/imu/inv_icm45600/inv_icm45600.h
> >> index 5f637e2f2ec8f1537459459dbb7e8a796d0ef7a6..aac8cd852c12cfba5331f2=
b7c1ffbbb2ed23d1c7 100644
> >> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> >> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> >> @@ -5,6 +5,7 @@
> >>  #define INV_ICM45600_H_
> >> =20
> >>  #include <linux/bits.h>
> >> +#include <linux/limits.h> =20
> >
> >Why this in the header?  Should be only needed in some of the c files I =
think
> >so push the include down there. =20
> This is because the below line uses U8_MAX:
> #define INV_ICM45600_SENSOR_CONF_KEEP_VALUES { U8_MAX, U8_MAX, U8_MAX, U8=
_MAX }
> So I guess the header from where it comes from should be included.
> Please correct if I miss something.

Nope. Should indeed be there. I just missed that.

> > =20
> ...
> > =20
> >> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/driv=
ers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..0c8caa8287dd4373cf11bb=
6c7b913a6c49e9eee5
> >> --- /dev/null
> >> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h =20
> > =20
> >> +
> >> +/**
> >> + * struct inv_icm45600_fifo - FIFO state variables
> >> + * @on:		reference counter for FIFO on.
> >> + * @en:		bits field of INV_ICM45600_SENSOR_* for FIFO EN bits.
> >> + * @period:	FIFO internal period.
> >> + * @watermark:	watermark configuration values for accel and gyro. =20
> >Given the contents of this to me look like things to also document.e
> > * @watermark.gyro:	....
> >etc as well would be good to add
> > =20
> >> + * @count:	number of bytes in the FIFO data buffer.
> >> + * @nb:		gyro, accel and total samples in the FIFO data buffer. =20
> >
> >This is more obvious.  Check if the kernel-doc script minds these subfie=
lds not
> >being defined.  If it does, add a the trivial documentation just to squa=
sh warnings
> >and make it easier to spot real issues. =20
>=20
> With my setup "./scripts/kernel-doc.py -v -none drivers/iio/imu/inv_icm45=
600/*" does not catch anything, even with -Wall.
> I'll detail the gyro/accel watermark comment anyway.

I guess it doesn't mind not documenting nested structure elements

Jonathan

>=20


