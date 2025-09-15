Return-Path: <linux-iio+bounces-24113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF607B58155
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E823BF72C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3D230D0F;
	Mon, 15 Sep 2025 15:53:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A92356B9
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951603; cv=none; b=QUUL0NdQDO8sjbbrbux1d0VNdza70NFWglNulkala1byjGk9UTq/ahahwcrbRpzqRg4cIavP3DxQPTZ1n4rOjZjy+shYbumKVldpRjg9/1t8XPwt4PxAnluBfgD8uMxtlqWBiTynBmpCWTCvRhpmD97Gr7HV6yq6/u/WGQiUYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951603; c=relaxed/simple;
	bh=0jua1eItjr/ZqvM4S5PNryunqLHAtL0bYDzfKx7KP8A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9PiHFpa4l00AMsSA1IJ4UZU0C1sLpPaZ1wvqN11kF1gaSNr5dZJ0iaZCHUlPU6g44FJwLiBGQv191zpugl5/YXV+maldg65LxAKWUC8TxZNAMD3PSuK6LHtai76vH3EhblYmke/csW7TGmb6ro5P0g80vFmUdSZwa5V1CnBZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQTzl6jQ8z6GD8d;
	Mon, 15 Sep 2025 23:51:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 81D811402EA;
	Mon, 15 Sep 2025 23:53:15 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 17:53:15 +0200
Date: Mon, 15 Sep 2025 16:53:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andrej Valek <andrej.v@skyrain.eu>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Puranjay Mohan <puranjay@kernel.org>, Kessler
 Markus <markus.kessler@hilti.com>
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
Message-ID: <20250915165313.000041fa@huawei.com>
In-Reply-To: <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
	<20250910193049.145aa79e@jic23-huawei>
	<6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
	<20250912151259.00006fd5@huawei.com>
	<b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 14:03:47 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> Hi Jonathan,
>=20
> I submitted the version 2 with applied your suggestions.
>=20
> On 12.09.2025 16:12, Jonathan Cameron wrote:
> > On Thu, 11 Sep 2025 11:33:49 +0200
> > Andrej Valek <andrej.v@skyrain.eu> wrote:
> > =20
> >> Hi Jonathan,
> >>
> >> First, I would like to thanks for your feedback.
> >>
> >> On 10.09.2025 20:30, Jonathan Cameron wrote: =20
> >>> On Tue,  9 Sep 2025 10:55:28 +0200
> >>> Andrej Valek <andrej.v@skyrain.eu> wrote:
> >>>    =20
> >>>> From: Valek Andrej <andrej.v@skyrain.eu> =20
> >>> Hi Valek,
> >>>
> >>> Thanks for the patch. Small thing on patch title, don't include drive=
rs.
> >>> It's a pain but you need to look at other patches to a given subsystem
> >>> to find out the preferred style. =20
> >> Valek is my surname =F0=9F=99=82. =20
> > Oops. Sorry!
> >
> > Hi Andrej,
> > =20
> >>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> >>>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> >>>> ---
> >>>>    drivers/iio/accel/adxl355_core.c | 48 +++++++++++++++++++++++++++=
+----
> >>>>    1 file changed, 43 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/ad=
xl355_core.c
> >>>> index 2e00fd51b4d51..5386cd4766def 100644
> >>>> --- a/drivers/iio/accel/adxl355_core.c
> >>>> +++ b/drivers/iio/accel/adxl355_core.c
> >>>> @@ -56,6 +56,8 @@
> >>>>    #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
> >>>>    #define ADXL355_SELF_TEST_REG		0x2E
> >>>>    #define ADXL355_RESET_REG		0x2F
> >>>> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
> >>>> +#define ADXL355_SHADOW_REG_COUNT	5
> >>>>   =20
> >>>>    #define ADXL355_DEVID_AD_VAL		0xAD
> >>>>    #define ADXL355_DEVID_MST_VAL		0x1D
> >>>> @@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(str=
uct adxl355_data *data)
> >>>>    static int adxl355_setup(struct adxl355_data *data)
> >>>>    {
> >>>>    	unsigned int regval;
> >>>> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT]; =20
> >>> Needs to be a DMA safe buffer.  We can't assume that regmap will alwa=
ys
> >>> bounce the data through one before passing it to the SPI controllers
> >>> that do sometimes require DMA safe buffers.    Add a buffer to end of
> >>> struct adxl355_data where you can take advantage of the forcing of ap=
propriate
> >>> padding that is already going on there. =20
> >> I see, but I don't like extending the adxl355_data just for one time
> >> usage. The suggested approach is more similar to what is done with the
> >> ID checking.
> >> | if (regval !=3D ADXL355_DEVID_MST_VAL) {
> >> |=C2=A0 dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
> >> |=C2=A0 return -ENODEV;
> >> | } =20
> > That's a single read.  Regmap always bounces those so a local variable =
should
> > be fine. Not so for a bulk read (or at least no one guarantees it)
> >
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/2018102=
3-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf
> > Slide 11 (in general this slide deck is a good introduction to the fun =
of DMA safety).
> >
> > The path for a single read goes through:
> > https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/reg=
map.c#L2779
> > _regmap_bus_read() which uses map->work_buf which is DMA safe. =20
> regmap_bulk_read is using the same _regmap_read=20
> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regma=
p.c#L3137=20
> so it should be safe, too I guess.

Whilst true, the repeated statement from the regmap maintainer that
is mentioned in the talk is that there is no guarantee that will continue
to be the case :(  Whereas the single reads are fine and will remain so.
I guess one reason for that is that regmap_read() take an unsigned int *val
so the type is almost always going to be wrong and a copy necessary.=20

Anyhow, the whole thing is a bit silly but upshot is dma safe buffers only =
to bulk
accessors unless the ABI is ever documented as not needing them.

Jonathan

> >
> > Jonathan
> >
> > =20
> Andy
>=20


