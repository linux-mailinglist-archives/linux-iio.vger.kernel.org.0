Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E61DCEE0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443204AbfJRTAm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443193AbfJRTAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:00:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D7120700;
        Fri, 18 Oct 2019 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425241;
        bh=HeMo/K+tgAMqlrONgDeEOGi3s38b+Q2+mR/Asm2Lx2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjYng2LoxHGcJBnLeNBfcu9WIFsWGgOKiKmsXRhDCAjxC0b2KEae8WKpM4fLWMq53
         Fa7nGcp30XdUdxJyGCl+KbT3ryneHbAkSAVKTy2q4FxieYcSZRRdE5b7q41a57UdMn
         xQXeYzo3OXIumC43E4/cKkWHF+1301syxTop1HVQ=
Date:   Fri, 18 Oct 2019 20:00:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCH 2/2] iio: adc: exynos: use
 devm_platform_ioremap_resource
Message-ID: <20191018200035.5fb4caf5@archlinux>
In-Reply-To: <857068247.21571023201523.JavaMail.epsvc@epcpadp1>
References: <20191013123524.1821390-1-jic23@kernel.org>
        <CGME20191013123734epcas2p28874e87fe8c104bc550f642200ce382b@epcas2p2.samsung.com>
        <20191013123524.1821390-2-jic23@kernel.org>
        <857068247.21571023201523.JavaMail.epsvc@epcpadp1>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Oct 2019 11:18:58 +0900
Chanwoo Choi <cw00.choi@samsung.com> wrote:

> Hi,
>=20
> On 19. 10. 13. =EC=98=A4=ED=9B=84 9:35, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Reduce local boilerplate.
> > Identified by coccinelle
> > drivers/iio/adc/exynos_adc.c:792:1-11: WARNING: Use devm_platform_iorem=
ap_resource for info -> regs
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/exynos_adc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index b5a497381452..2df7d057b249 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -769,7 +769,6 @@ static int exynos_adc_probe(struct platform_device =
*pdev)
> >  	struct device_node *np =3D pdev->dev.of_node;
> >  	struct s3c2410_ts_mach_info *pdata =3D dev_get_platdata(&pdev->dev);
> >  	struct iio_dev *indio_dev =3D NULL;
> > -	struct resource	*mem;
> >  	bool has_ts =3D false;
> >  	int ret =3D -ENODEV;
> >  	int irq;
> > @@ -788,8 +787,7 @@ static int exynos_adc_probe(struct platform_device =
*pdev)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	info->regs =3D devm_ioremap_resource(&pdev->dev, mem);
> > +	info->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(info->regs))
> >  		return PTR_ERR(info->regs);
> > =20
> >  =20
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>=20
Applied.  Thanks,

Jonathan

