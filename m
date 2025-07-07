Return-Path: <linux-iio+bounces-21436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35771AFBA15
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 19:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D63B2D72
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DF1B4F09;
	Mon,  7 Jul 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7BfBLRh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1C18BBAE;
	Mon,  7 Jul 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910450; cv=none; b=axMt7nFpSWEofoPTxYB1ftCboJBWTuutdKo3uA7OmZQK85CyyMqHvGpkjtbi7Wl5vN1JTpwJniQt3Bi0TkMI8/PQ64GEzfwPMcmEG3754pbFKhvvpCJNbpue9DWTspAXMorDEY1uvmMn7gmHjmBvsXeK2hDq9VgjkyQ/fvMTBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910450; c=relaxed/simple;
	bh=WEbn4fdeKYnXwstffB/UnbRRLMg5J1b7MykCMDCQ+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUvNkhUTawZTe4Jwb8Ix/Ynn1npu7rt6mA1Ckuxnq+rd21U1z2McBlLDs/hcMwCI5arQ8xMQKBDO4ljvPK4XzBYdftP7khEQIxXRl86omYIPB2rBFXFpl29kldRIdzTwUPGg3hbK2vXc4Fee0cbFcyZLL4CfzCOw1ozB7+8GieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7BfBLRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0A4C4CEE3;
	Mon,  7 Jul 2025 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910450;
	bh=WEbn4fdeKYnXwstffB/UnbRRLMg5J1b7MykCMDCQ+Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7BfBLRhOw3m1S86T8jinmmTSwb5dXtSFNlMDU67529GItm7rXD7o7pLdSAF4do2W
	 gVRC9jONTWBWyRJvXYFM9sXn5coJ8raK0zlJng8ZYvMX9p6rj0M+Pp9yvJeXGDE/Yb
	 EtBERaDjqzvHEu3LE4LZl/22bvKNuHMnFANFmNRqFwxa0cEOVbZlIPCmKzoSFNgUBM
	 n9IDkgMHEhwjCxPpOTVkgfg3B2haMupWUoGAJXodak2cqBWQsEmR4Kv9LBXTQAEc/k
	 H3yl4O9P5SHRRF2c1eDdTerdPh1ZuIiRnhvXRbI1JbEjCM0JgiyQiKg4Z0836z5jCU
	 AGr/n9iTte00g==
Date: Mon, 7 Jul 2025 18:47:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7173: fix num_slots
Message-ID: <20250707184718.115bdb3a@jic23-huawei>
In-Reply-To: <fca5a3d0a89b82b2e1a6d9e440cc2fe8896b73af.camel@gmail.com>
References: <20250706-iio-adc-ad7173-fix-num_slots-on-most-chips-v3-1-d1f5453198a7@baylibre.com>
	<fca5a3d0a89b82b2e1a6d9e440cc2fe8896b73af.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jul 2025 09:06:16 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-07-06 at 13:53 -0500, David Lechner wrote:
> > Fix the num_slots value for most chips in the ad7173 driver. The correct
> > value is the number of CHANNELx registers on the chip.
> >=20
> > In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
> > ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
> > to be static const data instead of being dynamically populated during
> > driver probe. However, there was an existing bug in commit 76a1e6a42802
> > ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
> > set to the number of CONFIGx registers instead of the number of
> > CHANNELx registers. This bug was partially propagated to the refactored
> > code in that the 16-channel chips were only given 8 slots instead of
> > 16 although we did managed to fix the 8-channel chips and one of the
> > 4-channel chips in that commit. However, we botched two of the 4-channel
> > chips and ended up incorrectly giving them 8 slots during the
> > refactoring.
> >=20
> > This patch fixes that mistake on the 4-channel chips and also
> > corrects the 16-channel chips to have 16 slots.
> >=20
> > Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_del=
ta_info
> > struct")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
As discussed. Dropped patch 12 of the other series.  Applied this one to th=
e fixes-togreg
branch of iio.git.  I'll let it soak a couple of days before I do a pull re=
quest.

>=20
> > Here is the patch that actually compiles on the fixes-togreg branch.
> > ---
> > Changes in v3:
> > - Drop supports_spi_offload field.
> > - Link to v2:
> > https://lore.kernel.org/r/20250704-iio-adc-ad7173-fix-num_slots-on-most=
-chips-v2-1-a74941609143@baylibre.com
> >=20
> > Changes in v2:
> > - Improve commit message.
> > - Link to v1:
> > https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most=
-chips-v1-1-326c5d113e15@baylibre.com
> > ---
> > =C2=A0drivers/iio/adc/ad7173.c | 36 ++++++++++++++++++++++++++----------
> > =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index
> > 1966a9bc331401af118334a7be4c1a5b8d381473..c41bc5b9ac597f57eea6a097cc3a1=
18de7b4
> > 2210 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -772,10 +772,26 @@ static const struct ad_sigma_delta_info
> > ad7173_sigma_delta_info_8_slots =3D {
> > =C2=A0	.num_slots =3D 8,
> > =C2=A0};
> > =C2=A0
> > +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slo=
ts =3D {
> > +	.set_channel =3D ad7173_set_channel,
> > +	.append_status =3D ad7173_append_status,
> > +	.disable_all =3D ad7173_disable_all,
> > +	.disable_one =3D ad7173_disable_one,
> > +	.set_mode =3D ad7173_set_mode,
> > +	.has_registers =3D true,
> > +	.has_named_irqs =3D true,
> > +	.addr_shift =3D 0,
> > +	.read_mask =3D BIT(6),
> > +	.status_ch_mask =3D GENMASK(3, 0),
> > +	.data_reg =3D AD7173_REG_DATA,
> > +	.num_resetclks =3D 64,
> > +	.num_slots =3D 16,
> > +};
> > +
> > =C2=A0static const struct ad7173_device_info ad4111_device_info =3D {
> > =C2=A0	.name =3D "ad4111",
> > =C2=A0	.id =3D AD4111_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 8,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -797,7 +813,7 @@ static const struct ad7173_device_info ad4111_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad4112_device_info =3D {
> > =C2=A0	.name =3D "ad4112",
> > =C2=A0	.id =3D AD4112_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 8,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -818,7 +834,7 @@ static const struct ad7173_device_info ad4112_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad4113_device_info =3D {
> > =C2=A0	.name =3D "ad4113",
> > =C2=A0	.id =3D AD4113_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 8,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -837,7 +853,7 @@ static const struct ad7173_device_info ad4113_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad4114_device_info =3D {
> > =C2=A0	.name =3D "ad4114",
> > =C2=A0	.id =3D AD4114_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 16,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -856,7 +872,7 @@ static const struct ad7173_device_info ad4114_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad4115_device_info =3D {
> > =C2=A0	.name =3D "ad4115",
> > =C2=A0	.id =3D AD4115_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 16,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -875,7 +891,7 @@ static const struct ad7173_device_info ad4115_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad4116_device_info =3D {
> > =C2=A0	.name =3D "ad4116",
> > =C2=A0	.id =3D AD4116_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in_div =3D 11,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -894,7 +910,7 @@ static const struct ad7173_device_info ad4116_devic=
e_info
> > =3D {
> > =C2=A0static const struct ad7173_device_info ad7172_2_device_info =3D {
> > =C2=A0	.name =3D "ad7172-2",
> > =C2=A0	.id =3D AD7172_2_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> > =C2=A0	.num_voltage_in =3D 5,
> > =C2=A0	.num_channels =3D 4,
> > =C2=A0	.num_configs =3D 4,
> > @@ -927,7 +943,7 @@ static const struct ad7173_device_info
> > ad7172_4_device_info =3D {
> > =C2=A0static const struct ad7173_device_info ad7173_8_device_info =3D {
> > =C2=A0	.name =3D "ad7173-8",
> > =C2=A0	.id =3D AD7173_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in =3D 17,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> > @@ -944,7 +960,7 @@ static const struct ad7173_device_info
> > ad7173_8_device_info =3D {
> > =C2=A0static const struct ad7173_device_info ad7175_2_device_info =3D {
> > =C2=A0	.name =3D "ad7175-2",
> > =C2=A0	.id =3D AD7175_2_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> > =C2=A0	.num_voltage_in =3D 5,
> > =C2=A0	.num_channels =3D 4,
> > =C2=A0	.num_configs =3D 4,
> > @@ -961,7 +977,7 @@ static const struct ad7173_device_info
> > ad7175_2_device_info =3D {
> > =C2=A0static const struct ad7173_device_info ad7175_8_device_info =3D {
> > =C2=A0	.name =3D "ad7175-8",
> > =C2=A0	.id =3D AD7175_8_ID,
> > -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> > +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> > =C2=A0	.num_voltage_in =3D 17,
> > =C2=A0	.num_channels =3D 16,
> > =C2=A0	.num_configs =3D 8,
> >=20
> > ---
> > base-commit: 731bfc181896a4dfd20a8c219bef1c205dd1d708
> > change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a=
20b1
> >=20
> > Best regards, =20
>=20


