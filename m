Return-Path: <linux-iio+bounces-18908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD64AA515D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A3F188330A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2825A658;
	Wed, 30 Apr 2025 16:17:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47D1ADC93;
	Wed, 30 Apr 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029834; cv=none; b=FuHb2GqHHfKJmMZOvZae3Xu3ISgvEXvKfwVqW/GejmVdabtjG0B0mk/xnyuC38rqfv3twVz0ADsEkATbbnQkCQCTyhp68PXpPlqZI8DDK/40R2u/y4gWm+9r6rTbBdTIwStRcEVcXmU4Vb6R578EsQK//XOsnTFDaIoHOeeZdpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029834; c=relaxed/simple;
	bh=u8pyoCgN3tvzdZvpvYgv063h+QLbtvDhM5b29UpKbk0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dixbpRgA+M54PKiAnV2m4Iwx2a36SiKgOIMUVjGw1CmtSoKsNbOKYh2pTTZJzoQuzhUy1pwHg+nVnr/mbX3KBc9oug7QI5hrobOmQrCPydUzRCoIIYt6XXj/VIug7eOeTEKVQVFGwflwMJJhz8/5DmoLrpW71V8JMwRTrKQfPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Znj2F6c1Xz6L4t7;
	Thu,  1 May 2025 00:15:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A47F814022E;
	Thu,  1 May 2025 00:17:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Apr
 2025 18:17:07 +0200
Date: Wed, 30 Apr 2025 17:17:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <Victor.Duicu@microchip.com>
CC: <jic23@kernel.org>, <Marius.Cristea@microchip.com>, <andy@kernel.org>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250430171705.00006e29@huawei.com>
In-Reply-To: <303fbf2f6c64241966009be59f68c1d2f8cdc786.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
	<20250415132623.14913-3-victor.duicu@microchip.com>
	<20250418190757.2b007737@jic23-huawei>
	<303fbf2f6c64241966009be59f68c1d2f8cdc786.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Apr 2025 12:57:05 +0000
<Victor.Duicu@microchip.com> wrote:

> On Fri, 2025-04-18 at 19:07 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Tue, 15 Apr 2025 16:26:23 +0300
> > <victor.duicu@microchip.com> wrote:
> >  =20
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > >=20
> > > This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> > > Multichannel Automotive Monitor Family.
> > >=20
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com> =20
> >  =20
>=20
> Hi Jonathan,
>=20
> > Hi Victor,
> >=20
> > Various comments inline,
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > > =A0.../testing/sysfs-bus-iio-temperature-mcp9982 |=A0 17 +
> > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +
> > > =A0drivers/iio/temperature/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 10 +
> > > =A0drivers/iio/temperature/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 1 +
> > > =A0drivers/iio/temperature/mcp9982.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 794
> > > ++++++++++++++++++
> > > =A05 files changed, 829 insertions(+)
> > > =A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-
> > > temperature-mcp9982
> > > =A0create mode 100644 drivers/iio/temperature/mcp9982.c
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-
> > > mcp9982 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-
> > > mcp9982
> > > new file mode 100644
> > > index 000000000000..de3360fb05be
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
> > > @@ -0,0 +1,17 @@
> > > +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > /sys/bus/iio/devices/iio:deviceX/running_average_window =20
> >=20
> > As later in review, I think we can control this via the low pass
> > filter 3dB point
> > and use standard ABI.
> >=20
> >  =20
> > >  =20
> ...
>=20
> > Hmm.=A0 A running average is a low pass filter.=A0 Can we control this
> > instead via
> > standard ABI and the 3dB point?=A0 Take a look at the filter ABI in
> > Documentation/ABI/testing/sysfs-bus-iio
> >=20
> > Custom ABI is rarely used in real cases because the tools tend not to
> > know about it
> > so we avoid it if we possibly can.
> >  =20
> > > +
> > >  =20
>=20
>=20
> The moving average filter is used to smooth the temperature spikes.
> The user should be able to set the size of the window to
> a few values: 1(disable the filter), 4 and 8.
> The user does not have access to the frequency properties.

Assuming the device is self clocking, then we know the frequency and
hence can consider an averaging filter as a type of low pass filter (which =
is
what it effectively is) and control via the 3dB point.

Whether it is documented that way is just a question of how they
decided to describe it in the datasheet.

A moving average is also known as a box car filter.=20
https://www.wavewalkerdsp.com/2022/08/03/bandwidth-of-a-moving-average-filt=
er/

Approximately (pi / N)*sampling frequency (I think anyway, I only took a qu=
ick
look).

Doing that allows you to map it to standard ABI.

>=20
> Best Regards,
> Victor
> >  =20
>=20


