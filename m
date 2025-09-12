Return-Path: <linux-iio+bounces-24011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD82B550A0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503337C8675
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23ED30F7E8;
	Fri, 12 Sep 2025 14:13:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522030FF26
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686385; cv=none; b=XPSizLe2sTIz5pk4ISbh3wBTBLhdKIUp621el2lklR//gi8yxxODmCuGnDKaVSudIvXWpxJn8OwE/3yJtMBy2cRxF/m9Qim8chRvZLkRL/zfTITesDJqgfnDBHpSqzQW3u5eFrJcxg9z8OnVsCZhg2gf8LAvPk2BGRenv+xBNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686385; c=relaxed/simple;
	bh=kkeGBW66TG4QpsVYOlL62YKKOXgAc9nhLC/HXwJtOcg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8+3TZsy0iK17FNaqRKe/Z0a1cu4Q1CKvryzawNqILrjIJjWWCwpXN8J6tylhCv2A6n6GGSQy8vMMbN6A4OpAf4E+Qpbw0voRaf/vFUfms1Y6hPoSdszr6xckBdVEE4N5+Y+K/k/IfnMNVTRj7no2iJ8gVYyZjwsr7DNIV/rz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNbrC6Q1Pz6L5QJ;
	Fri, 12 Sep 2025 22:08:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DF26E1402EA;
	Fri, 12 Sep 2025 22:13:00 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:13:00 +0200
Date: Fri, 12 Sep 2025 15:12:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andrej Valek <andrej.v@skyrain.eu>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Puranjay Mohan <puranjay@kernel.org>, Kessler
 Markus <markus.kessler@hilti.com>
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
Message-ID: <20250912151259.00006fd5@huawei.com>
In-Reply-To: <6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
	<20250910193049.145aa79e@jic23-huawei>
	<6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 11:33:49 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> Hi Jonathan,
>=20
> First, I would like to thanks for your feedback.
>=20
> On 10.09.2025 20:30, Jonathan Cameron wrote:
> > On Tue,  9 Sep 2025 10:55:28 +0200
> > Andrej Valek <andrej.v@skyrain.eu> wrote:
> > =20
> >> From: Valek Andrej <andrej.v@skyrain.eu> =20
> > Hi Valek,
> >
> > Thanks for the patch. Small thing on patch title, don't include drivers.
> > It's a pain but you need to look at other patches to a given subsystem
> > to find out the preferred style. =20
> Valek is my surname =F0=9F=99=82.

Oops. Sorry!=20

Hi Andrej,

> >> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> >> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> >> ---
> >>   drivers/iio/accel/adxl355_core.c | 48 ++++++++++++++++++++++++++++--=
--
> >>   1 file changed, 43 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl=
355_core.c
> >> index 2e00fd51b4d51..5386cd4766def 100644
> >> --- a/drivers/iio/accel/adxl355_core.c
> >> +++ b/drivers/iio/accel/adxl355_core.c
> >> @@ -56,6 +56,8 @@
> >>   #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
> >>   #define ADXL355_SELF_TEST_REG		0x2E
> >>   #define ADXL355_RESET_REG		0x2F
> >> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
> >> +#define ADXL355_SHADOW_REG_COUNT	5
> >>  =20
> >>   #define ADXL355_DEVID_AD_VAL		0xAD
> >>   #define ADXL355_DEVID_MST_VAL		0x1D
> >> @@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(struc=
t adxl355_data *data)
> >>   static int adxl355_setup(struct adxl355_data *data)
> >>   {
> >>   	unsigned int regval;
> >> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT]; =20
> > Needs to be a DMA safe buffer.  We can't assume that regmap will always
> > bounce the data through one before passing it to the SPI controllers
> > that do sometimes require DMA safe buffers.    Add a buffer to end of
> > struct adxl355_data where you can take advantage of the forcing of appr=
opriate
> > padding that is already going on there. =20

> I see, but I don't like extending the adxl355_data just for one time=20
> usage. The suggested approach is more similar to what is done with the=20
> ID checking.
> | if (regval !=3D ADXL355_DEVID_MST_VAL) {
> |=C2=A0 dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
> |=C2=A0 return -ENODEV;
> | }

That's a single read.  Regmap always bounces those so a local variable shou=
ld
be fine. Not so for a bulk read (or at least no one guarantees it)

https://events19.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wo=
lfram-Sang-ELCE18-safe_dma_buffers.pdf
Slide 11 (in general this slide deck is a good introduction to the fun of D=
MA safety).

The path for a single read goes through:
https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.=
c#L2779
_regmap_bus_read() which uses map->work_buf which is DMA safe.

Jonathan


