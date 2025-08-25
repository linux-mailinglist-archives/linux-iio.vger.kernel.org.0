Return-Path: <linux-iio+bounces-23193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24285B33B39
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F817AAEEA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302202C21F7;
	Mon, 25 Aug 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IriaYIoi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94C26C3BF;
	Mon, 25 Aug 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114611; cv=none; b=Tgz39XDVAOotlkBdcCk3l4QVKKvpSm+I19nAU+InbHmlbD5PG6ylwDJpdcRhI0fJsU9+viBTjOmZlmKur8+pdJMZJ1zyTbBtSZAHXJHD1n4IAztAbs531CPpnKHAjRKwXZh7RFuOz/VLkDUVdr5FTd4CmHXqydng0ymUpuGcvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114611; c=relaxed/simple;
	bh=x/CJrxvLnj/WFwj3bwcQs4OK07U8P14cEQTlusC5AD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHmdn5YEmNusGEO1lW6C1AFSJPqvkZyNr2e04zN1L/TLaoFZ4s3N/448UubT9oFRN+Yurelo5VJYVHdMERcbNiI5SZSlqt8XfbGK9d1mzMueSf873T4mwLdkR+vLfy2CWOITbvrAAampynVNJu2+P1lvha2wJ47sGkDKC3mNS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IriaYIoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BD5C4CEED;
	Mon, 25 Aug 2025 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756114610;
	bh=x/CJrxvLnj/WFwj3bwcQs4OK07U8P14cEQTlusC5AD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IriaYIoiRrQn89cVRgRq5OfkNAXlZ87gX0CYvi/Y25n6FxXyhLzxGoucEzatFJX8n
	 K9Qwa0TBOAucLWwD0a5yFKAYoEQEB79A4AhY3hd41NXRtw41yH0+4oEgpE4c/J5NFC
	 Ppc2wcOuJ0RrF69uoLOd64ZV8l0UK2EUlkzk8/1BuJb1WGyNpdLUHOCl7nz6/CgiMB
	 BCi1hLAhyWsMBeWAv8ryrQsXse/EqoG42N/nC9zyTv3pzBbSnoCY/CvA0BxJS2cKvl
	 P1hWOYX1SJs1viGOe2majnXkjKgX+DyzfexKTzIZzYjqjyS2cokVX0LO2dijE+7nDH
	 l9luc1IXVE+sQ==
Date: Mon, 25 Aug 2025 10:36:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ben Collins <bcollins@watter.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250825103640.5ed775bb@jic23-huawei>
In-Reply-To: <CAHp75VdbfCenb+N4rY59hG1E9DL9s4ibCdQX=Ar8hT0_wi5h+Q@mail.gmail.com>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
	<20250822-upstream-changes-v8-4-40bb1739e3e2@watter.com>
	<CAHp75VdMCY3=bL2t7zWw0D1WqtiLXrWi+ptjpaxK16b8J1KVSg@mail.gmail.com>
	<7C976B5E-781D-472B-B2C8-3AD22550E036@watter.com>
	<CAHp75VdbfCenb+N4rY59hG1E9DL9s4ibCdQX=Ar8hT0_wi5h+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 19:47:39 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 22, 2025 at 7:07=E2=80=AFPM Ben Collins <bcollins@watter.com>=
 wrote:
> > > On Aug 22, 2025, at 11:57=E2=80=AFAM, Andy Shevchenko <andy.shevchenk=
o@gmail.com> wrote:
> > > On Fri, Aug 22, 2025 at 4:24=E2=80=AFPM Ben Collins <bcollins@watter.=
com> wrote: =20
>=20
> ...
>=20
> > >> +struct mcp9600_data {
> > >> +       struct i2c_client *client;
> > >> +};
> > >> + =20
> > > =20
> > >> -struct mcp9600_data {
> > >> -       struct i2c_client *client;
> > >> -};
> > >> - =20
> > >
> > > Seems we discussed this. And my suggestion was to defer the change to
> > > when it will be needed. =20
> >
> > And my response was that it=E2=80=99s needed in 5/5 where I add the mcp=
9600_config()
> > function. That function will need to be before mcp9600_channels[] in the
> > IIR patch series.
> >
> > So either I move mcp9600_data now, or I leave it and put mcp9600_config=
()
> > below it, and then in the IIR series I=E2=80=99ll have to move both up.
> >
> > Didn=E2=80=99t seem to make sense to move 30 lines of code later when I=
 can move
> > 3 lines now. =20
>=20
> TBH, I have no strong preference, I leave this to Jonathan and other revi=
ewers.
>=20

Not significant enough to worry about. So I left it as is whilst applying.


