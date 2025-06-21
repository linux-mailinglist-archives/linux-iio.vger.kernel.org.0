Return-Path: <linux-iio+bounces-20822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133FBAE2A95
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E9B3BC8D8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F19223715;
	Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k86AvFf0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46562222580;
	Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526394; cv=none; b=TTYDAoGNQAnTq6+LNKwfs4OLi2xhcrwCrjxAYhgLY5HHdYMApT6ffVRXztQQY36/Ra9SfGrvUUiwlYtPPGvCQGocCtbslmxGw5HhGoD8JYsEQ8HqrT5loZq+CXxhsRC+fSeOZ5HoLZGqrjxjqRg5i/2mt8eQ9E/wDTUdULp4gj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526394; c=relaxed/simple;
	bh=we+oCKABVV6Skl7RacxNHRk3oYJEl72c2KoaHxAjFO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJxAJr93SCs0Hmgn/x+2UTCNjdeV0exAEMJWvXxsOc5PyFRpiLlI+KEuSur44eUhQDQiLvaZ/sneSQHGKIzFYL1wMWQ+cE9gzlCyRbbzwGSkMYnXOzlg1zEd6+nh+cemjFS7Um77sZlDQjCJw2IiZZM7FRQWRV2W2eOImgExejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k86AvFf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E55C4CEE7;
	Sat, 21 Jun 2025 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526393;
	bh=we+oCKABVV6Skl7RacxNHRk3oYJEl72c2KoaHxAjFO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k86AvFf0EQiihhYED/nfLFgPnowcKfQeHlNPcTB+AoxRuhHyR+9JmFgPVhfs+0PX8
	 FTIQS7t7+cVWPAJtLPfRs55oKn3wwMISi0glJHroIhtp4AOi6k+rkuWKkrxLvbTqRn
	 lonf9CvfADNS7zhTnSLsKw1vrhURIrYxNZ7do5lqxXSZldsLEBw0XCuzFZ3VA+5p80
	 NsjcND4H7hubdiaHz5Dealtl5t8aGi3uPy/cwBDUGIqx+dEBvZ/GbNR4Hfc3gGw+6E
	 UklkYzYyr0SyqXb89x0kllwsgS0kLsKtwOeVPrBhRJkAURT0IpzOin0pLN5VtOekUC
	 ubmc378rDU1zA==
Date: Sat, 21 Jun 2025 18:19:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Victor.Duicu@microchip.com, dlechner@baylibre.com, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 Marius.Cristea@microchip.com, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250621181946.28d831ac@jic23-huawei>
In-Reply-To: <CAHp75Vc2nueOycoy8+dYyQekAAMPO82wOYSVT0RZOC4yRaE5jA@mail.gmail.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
	<20250613130207.8560-3-victor.duicu@microchip.com>
	<CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
	<f980b3c1a4fbd60f70dda9670648479a38313439.camel@microchip.com>
	<CAHp75Vc2nueOycoy8+dYyQekAAMPO82wOYSVT0RZOC4yRaE5jA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025 11:29:30 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 19, 2025 at 10:22=E2=80=AFAM <Victor.Duicu@microchip.com> wro=
te:
> > On Sat, 2025-06-14 at 00:50 +0300, Andy Shevchenko wrote: =20
> > > On Fri, Jun 13, 2025 at 4:02=E2=80=AFPM <victor.duicu@microchip.com> =
wrote: =20
>=20
> ...
>=20
> > > > +MICROCHIP MCP9982 TEMPERATURE DRIVER
> > > > +M:     Victor Duicu <victor.duicu@microchip.com>
> > > > +L:     linux-iio@vger.kernel.org
> > > > +S:     Supported
> > > > +F:
> > > > Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982
> > > > .yaml
> > > > +F:     drivers/iio/temperature/mcp9982.c =20
> > >
> > > So, with the first patch only the dangling file will be present
> > > without record in MAINTAINERS. Please, make sure that your DT schema
> > > file is in MAINTAINERS. =20
> >
> > Are you referring here to the file sysfs-bus-iio-temperature-mcp9982?
> > This file was in v2 where there were a few custom attributes. In v3
> > I removed them, so the driver currently doesn't have custom attributes.
> > Should I had added it to the files in MAINTAINERS? =20
>=20
> You should have added the file to the MAINTAINERS in the same patch it
> appears. Not in some arbitrary change afterwards.
>=20

Perhaps the confusion here is that Andy is talking about 2 lines above, not
the immediate line above this feedback.  So the one with the dt-binding
file.  If Victor was reading it as being about the .c file then
this whole cross discussion makes more sense!

Jonathan




