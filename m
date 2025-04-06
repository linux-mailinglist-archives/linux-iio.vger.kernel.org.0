Return-Path: <linux-iio+bounces-17663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26BA7CDB3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB33B3B2671
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67D1A5B8C;
	Sun,  6 Apr 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNSesa27"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841BEACD;
	Sun,  6 Apr 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938456; cv=none; b=TMBAq0lV8+Fs5dJO1PpZX6RrFNBmCblayKb6t0lpWcKn+oDuPmZE63rVCHu5u71e+D+IAD5yw2MxQd4T+UUplsyg7xmiwHlizWLP2udDi5wSJNuOqutDpj+qdzCmOc1XBEzYlM31fva6mcWX45BsZgIHwHTBs5tBzC6fwBjyGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938456; c=relaxed/simple;
	bh=TA+MKpZmcTq19vFj3UjOJH4k3U+3MjBZLDNjN9Oaq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7UApZR1Iin4tdCBlGSENYIVIPQ5j4lVKe4dd0L8LJo1dqC3CDieqoYwAMojQwuzg6poGaJLSCFaa3s6DbvuF7fI+xGzR/p6BU4vLD4/hJ9WYsCou79sN75UCWsReZ5lFaO/PYPKm/bsuXgyCSVo0PQubkwznN2lmQwC0AFbvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNSesa27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8CC4CEE3;
	Sun,  6 Apr 2025 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743938456;
	bh=TA+MKpZmcTq19vFj3UjOJH4k3U+3MjBZLDNjN9Oaq0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UNSesa27LDsuxQw9XFA7o7eh8jFz/aMuA5/kPiL6xwABOLEw4pQA2fp2ZWJqE0rM/
	 VNt720cKy58XPYJJJYdOe+BPIL+wmyZilXus3ZUqBkyIsCHUr1uGhVGcmYNVLJSuk2
	 Ob6O3o9ps2vQbCfLIP0NvCYzIr2bDHJtwm1c3ju7ICTzUp/pOahSdy3BTboO+ORiNC
	 D52ZosDRKwTiwrm+9UQjV+oh/IrD9VpVX2iXUTrcQWgHM/0SMLZEB6t2wrocZXDaJv
	 5rjyD/keb776Wmq3nvc9KBSJ9OtavnCQo5lD6dQNKRAXsP/Mp1GVVqtJA5snDUqPmq
	 wD15wIH2m9AWg==
Date: Sun, 6 Apr 2025 12:20:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Message-ID: <20250406122048.3d59c2b5@jic23-huawei>
In-Reply-To: <CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-4-gye976@gmail.com>
	<20250404123308.00003d72@huawei.com>
	<CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Apr 2025 22:47:45 +0900
gyeyoung <gye976@gmail.com> wrote:

> Hello Jonathan, thank you for the review.
>=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b =
b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > new file mode 100644
> > > index 000000000000..6cdfd34be016
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > @@ -0,0 +1,7 @@
> > > +What:                /sys/bus/iio/devices/co2_range
> > > +Date:                April 2025
> > > +KernelVersion:       6.14
> > > +Contact:     Gyeyoung Baek <gye976@gmail.com>
> > > +Description:
> > > +             Writing a value adjust maximum measurable PPM.
> > > +             should be 2000 or 5000. =20
> >
> > I haven't checked but assume this also results in a scaling of the
> > measure _raw values?  If so the control should be via the standard
> > ABI scale.  If you need to be able to establish the range, provide
> > the _available for the _raw via the read_avail() callback and setting
> > appropriate bit in info_mask_separate_available
> > =20
>=20
> In this device, changing the measurement range does not affect the
> unit or scaling.
> As far as I know, increasing the range just leads to a decrease in accura=
cy.

That's unusual but fair enough.  hardwaregain is perhaps appropriate
as this doesn't really map to calibscale which is the other thing close
to this.

>=20
> > General rule is don't introduce new ABI unless it is impossible to
> > provide the same information via existing interfaces.  The decision
> > to use scale rather than range info to control channel scaling was
> > made a very long time ago and having a mixture of the two would
> > make for very complex userspace code. =20
>=20
> I=E2=80=99ve reviewed the sysfs-bus-iio documentation, I think there is
> no suitable interface for this case. So I'll drop this option.
>=20
> Thanks,
> Gyeyoung


