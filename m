Return-Path: <linux-iio+bounces-22844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F4B28EC5
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4D3BC691
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05222E7627;
	Sat, 16 Aug 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptTsKWMx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03A2309B2;
	Sat, 16 Aug 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356974; cv=none; b=NfZP9DFLqpgyynvw/weT1QSK+g61TEQfD8j/tWG4PuS1F5YrhCkB3Bk+uqx1ZwyWPcBoABRi1+fWkbbggeig7P3Mkd0l3Naux5yZFWa0FzgeJYDa1hmmXpcGAaL3ODuosC8kpT2fAxxeV8gn/LqZO+MYh/JjFAr5kj3b86eeuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356974; c=relaxed/simple;
	bh=HIJFNWddVcK1gv1KFX73iQAqCHp8ZKO/WLLRZWuce+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alKgCSvGXS/sLZ3Wrye8Otlaq6BhZdaQFzoeK2m85l53IeqfL0Q80X5aekkg+P0zN2CtoDlOLZOXXP3jqmBFv1K2jbS9G/oiOjj92fmddQ7h/Cy6PvlGd0w/G71rprPtM+RgVE6fi/4nHvFP1Oqo41F9qifIHq/QNNdhSq143kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptTsKWMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93CAC4CEEF;
	Sat, 16 Aug 2025 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356974;
	bh=HIJFNWddVcK1gv1KFX73iQAqCHp8ZKO/WLLRZWuce+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ptTsKWMxfXMR2DhFcv2lj7qg71jvfX33jOi1U6d8gM52EihjnOpaCuao3Sa1q02zl
	 dV/8MbgIbyEm9he4jweQmCe4C7dysHMs4zo04zQrAEtgX7YkNZgfN2mMXHUYBaFkbK
	 uH/xZnZ44J9ufp8HZBOm0FhAXlkafUAWqZ+ypvU8a5qxfr7tGWsY2nXRDokGc0WWWw
	 izBfxH2dLIu67C/1G6VHnI9uCVyvqiYoJTClTMaj83aXaqdp3u5ORyClj6/UfBCxPf
	 gxeomEvwPibjSVYbUz4DxDV8mf3Sr914Hx/7vXHTt69fAm/OsteSsRyeEvDJyRX4Wf
	 V0jsBgcZ00+BA==
Date: Sat, 16 Aug 2025 16:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
Message-ID: <20250816160927.534dfa12@jic23-huawei>
In-Reply-To: <1CAB4E66-23B6-41F6-9782-3F3D66AB9908@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-5-bcollins@watter.com>
	<20250816111125.65fcbb09@jic23-huawei>
	<1CAB4E66-23B6-41F6-9782-3F3D66AB9908@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 09:18:09 -0400
Ben Collins <bcollins@watter.com> wrote:

> > On Aug 16, 2025, at 6:11=E2=80=AFAM, Jonathan Cameron <jic23@kernel.org=
> wrote:
> >=20
> > On Fri, 15 Aug 2025 16:46:06 +0000
> > Ben Collins <bcollins@watter.com> wrote:
> >  =20
> >> dt-bindings documentation for this driver claims to support
> >> thermocouple-type, but the driver does not actually make use of
> >> the property.
> >>=20
> >> Implement usage of the property to configure the chip for the
> >> selected thermocouple-type.
> >>=20
> >> Signed-off-by: Ben Collins <bcollins@watter.com> =20
> > Hi Ben,
> >=20
> > Just one trivial thing inline. =20
> ...
> >>=20
> >> +static int mcp9600_config(struct mcp9600_data *data)
> >> +{
> >> + struct i2c_client *client =3D data->client;
> >> + int ret;
> >> + u8 cfg;
> >> +
> >> + cfg  =3D FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
> >> +  mcp9600_type_map[data->thermocouple_type]);
> >> +
> >> + ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> >> + if (ret < 0) {
> >> + dev_err(&client->dev, "Failed to set sensor configuration\n"); =20
> >=20
> > Only called from probe so use return dev_err_probe() here =20
>=20
> Hi Johnathan. That=E2=80=99s correct in this patch. However, in the IIR p=
atch
> I call this when the filter is set, so it didn=E2=80=99t seem to make sen=
se to
> do it that way, just to change it in the next patch.
>=20
> I appreciate all the feedback. I=E2=80=99ll get things cleaned in for v4.
Ah. Fair enough then. Leave it as it is and thanks for pointing this out.

Jonathan


