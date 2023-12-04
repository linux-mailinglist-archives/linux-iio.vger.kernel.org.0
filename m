Return-Path: <linux-iio+bounces-557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9B802EA2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD5FB2098D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9951A5B8;
	Mon,  4 Dec 2023 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt/KrIt8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911C18AE4
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 09:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31ABC433C7;
	Mon,  4 Dec 2023 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701682390;
	bh=vB8lCoBUTdZMjJNGpuqpA44Y595SsonNAART47Zyvi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tt/KrIt8+kPOXxH+cpLndZy/lmbUVptSb6qGW7voPOcd28sxyY/dgZXdpMgeOki/0
	 ToNRUr3HOpB9m6hrfG72U8xhngOX3W0Gl7UlGwvGytegiO5d2uL4srb/DHXV3WuU3D
	 yljUBN9UlLAl05Xj7TpcB9/9jNkFazbOv/RMEkM4ZK6A06Oy8BRqvOyfDb58YH77rM
	 6OLp3IMu3oezGZw25OsYegeF8mIeg1T7Zyca8tZjO7R66oqpLrj+6d0M7ZkuUTNvbL
	 SLZL4V+8bFzmy4KKPnFldQAMNPWIDpj7+xtADNqwFGWrBKQCSiDOJOluaKmLghrU6Q
	 GrmqK+ksKYgCQ==
Date: Mon, 4 Dec 2023 09:33:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhavya Kapoor <b-kapoor@ti.com>
Cc: Wadim Egorov <w.egorov@phytec.de>, <lars@metafoo.de>, <robh@kernel.org>,
 <heiko@sntech.de>, <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nm@ti.com>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()
Message-ID: <20231204093301.05c19b96@jic23-huawei>
In-Reply-To: <0c26613b-4aba-4e1e-bf0e-57feff23e303@ti.com>
References: <20230925134427.214556-1-w.egorov@phytec.de>
	<20231005150917.2d0c833e@jic23-huawei>
	<a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
	<0c26613b-4aba-4e1e-bf0e-57feff23e303@ti.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Nov 2023 15:14:29 +0530
Bhavya Kapoor <b-kapoor@ti.com> wrote:

> LGTM !!=F0=9F=99=82
>=20
> On 24/11/23 5:41 pm, Wadim Egorov wrote:
> >
> > Am 05.10.23 um 16:09 schrieb Jonathan Cameron: =20
> >> On Mon, 25 Sep 2023 15:44:27 +0200
> >> Wadim Egorov <w.egorov@phytec.de> wrote:
> >> =20
> >>> Fix wrong handling of a DMA request where the probing only failed
> >>> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
> >>> value is returned. This makes DMAs explicitly optional. Even if the
> >>> DMA request is unsuccessfully, the ADC can still work properly.
> >>> We do also handle the defer probe case by making use of=20
> >>> dev_err_probe().
> >>>
> >>> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
> >>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de> =20
> Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

> >> +CC Bhavya,
> >>
> >> Could you take a look at this given you had comments on v1. =20
> >
> > Bhavya, any comments on this?
> > If not, is there anything else that is blocking this patch?
> >
> > Regards,
> > Wadim
> > =20
> >>
> >> Thanks,
> >>
> >> Jonathan
> >> =20
> >>> ---
> >>> v2:
> >>> =C2=A0=C2=A0 - Update description
> >>> =C2=A0=C2=A0 - Drop line break after Fixes tag
> >>> =C2=A0=C2=A0 - Move decision about optional DMA into probe/caller
> >>> ---
> >>> =C2=A0 drivers/iio/adc/ti_am335x_adc.c | 4 +++-
> >>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iio/adc/ti_am335x_adc.c=20
> >>> b/drivers/iio/adc/ti_am335x_adc.c
> >>> index 8db7a01cb5fb..5f8795986995 100644
> >>> --- a/drivers/iio/adc/ti_am335x_adc.c
> >>> +++ b/drivers/iio/adc/ti_am335x_adc.c
> >>> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device=20
> >>> *pdev)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, indio_dev);
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D tiadc_request_dma(pdev,=
 adc_dev);
> >>> -=C2=A0=C2=A0=C2=A0 if (err && err =3D=3D -EPROBE_DEFER)
> >>> +=C2=A0=C2=A0=C2=A0 if (err && err !=3D -ENODEV) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err_probe(&pdev->dev,=
 err, "DMA request failed\n");
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_dma;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20


