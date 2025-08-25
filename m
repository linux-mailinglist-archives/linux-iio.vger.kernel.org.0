Return-Path: <linux-iio+bounces-23216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA487B33DE6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1286B7AD910
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838B2E7BC9;
	Mon, 25 Aug 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojMEJtVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460A2E7BB3;
	Mon, 25 Aug 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121075; cv=none; b=MpHpDJq89sTXAxkjhqljF/pRXcwfIgFVsjY1thyHRVQlo0IuYahPcECkLK/GSFVo+HNSE/ZTd37gaMPbaWCzUuyiEG21TuEN9Wg/7uTMW2WbkuUBh6hZJhDiuPCIUHonIXhjvjufWun01KbJz5QGN14vN5sXBvldGcuE63N53RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121075; c=relaxed/simple;
	bh=XFCAtpJ/d92BaV2RcCmleQHUp/r6mqPPDKzSnsbrl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IygvoD9Q3JIkDzUIL6w+FqxeiyJMYxU2xJcj4rfVQ5saeytiBayr3/s/TI7tzE4Vnlv+bryuQ3+J5gg40Or1OtGoJFC6lRkLyIoXKvoSJAH+F0d967aRUubPflPBVXeEckA02Gz5HYglATfUuJ+iG7U/yxdcY+9utgjgLhuOVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojMEJtVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13ADC4CEED;
	Mon, 25 Aug 2025 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121074;
	bh=XFCAtpJ/d92BaV2RcCmleQHUp/r6mqPPDKzSnsbrl8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ojMEJtVlaHdhwhg3QiH8bqRwbUWNBQRFRH5BtImPXDFnLkv5odG0KffEEct+EESFE
	 Q0SYEmrpBSdkhcIbbvZOY303oFUEcqz6i+Xq1zGnt4YYqEhsq5LqlOzpo6XydJUmsr
	 lZUraNH/7jNFVIQTohJu/0Xc9OHWuKoTUmhbT+sMEeRvZwUP/6LjiCxvnakdNQb2ET
	 UXVB9Vp5YvzhlEYT0lOWjZ0N+19LJJSSLYekOcmq4fowV3dh5GyH05fyoVNxOAjogP
	 PWzT3rdK/0hFbWUoQk1tcOf9nyuO2jsBLewpg7T697upcvAoMmOZk4GV9opPMqxCwq
	 JdbjyVmlkAljQ==
Date: Mon, 25 Aug 2025 12:24:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, David Lechner
 <dlechner@baylibre.com>, Manish Narani <manish.narani@xilinx.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Message-ID: <20250825122425.4c656d31@jic23-huawei>
In-Reply-To: <MN2PR12MB4223B775F240DFD91C6131138B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
References: <20250715003058.2035656-1-sean.anderson@linux.dev>
	<MN2PR12MB4223B775F240DFD91C6131138B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 12:31:12 +0000
"O'Griofa, Conall" <conall.ogriofa@amd.com> wrote:

> Hi,
>=20
> Good spot, thanks again!
Applied to the fixes-togreg branch of iio.git and marked for stable.
Thanks,

Jonathan

>=20
> Cheers,
> Conall.
>=20
> > -----Original Message-----
> > From: Sean Anderson <sean.anderson@linux.dev>
> > Sent: 15 July 2025 01:31
> > To: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>; Jonathan Cameron
> > <jic23@kernel.org>; linux-iio@vger.kernel.org
> > Cc: Andy Shevchenko <andy@kernel.org>; linux-kernel@vger.kernel.org; Si=
mek,
> > Michal <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; Da=
vid
> > Lechner <dlechner@baylibre.com>; Manish Narani <manish.narani@xilinx.co=
m>;
> > Nuno S=C3=A1 <nuno.sa@analog.com>; Sean Anderson <sean.anderson@linux.d=
ev>
> > Subject: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
> >=20
> > AMS_ALARM_THR_DIRECT_MASK should be bit 0, not bit 1. This would cause
> > hysteresis to be enabled with a lower threshold of -28C. The temperatur=
e alarm
> > would never deassert even if the temperature dropped below the upper th=
reshold.
> >=20
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> >=20
> >  drivers/iio/adc/xilinx-ams.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.=
c index
> > 76dd0343f5f7..552190dd0e6e 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -118,7 +118,7 @@
> >  #define AMS_ALARM_THRESHOLD_OFF_10	0x10
> >  #define AMS_ALARM_THRESHOLD_OFF_20	0x20
> >=20
> > -#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
> > +#define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
> >  #define AMS_ALARM_THR_MIN		0x0000
> >  #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
> >=20
> > --
> > 2.35.1.1320.gc452695387.dirty =20
>=20
> Reviewed-by: O'Griofa, Conall <conall.ogriofa@amd.com>


