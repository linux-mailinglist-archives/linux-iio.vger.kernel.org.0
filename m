Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75603DCED6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfJRS7f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 14:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRS7f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:59:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471C621897;
        Fri, 18 Oct 2019 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425175;
        bh=FaBTQYFbIe1uIiLjc2SzAlGbzB83/G87/c7btvbnge8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tHeCLCUcLjdf7SwWyk0hDAir8a0uf0tP0SWqLFO3DIdEAZ+3jR/RUq+ehELKwIAwP
         2l8lV2QdOXTldOdedfsoEX0UnYPNNKirj5m7H5U8c4U38ygIV+h+8GpnBsqhuiw77O
         KIH80pv0xz09rXOQnQ9Ey5/Stlja9UBwh4zTDh0Q=
Date:   Fri, 18 Oct 2019 19:59:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCH 1/2] iio: adc: exynos: Drop a stray semicolon
Message-ID: <20191018195931.17512ef2@archlinux>
In-Reply-To: <1019298652.01571023201320.JavaMail.epsvc@epcpadp1>
References: <CGME20191013123734epcas4p138622f17adc5c3baaeba8eb8f4cff1bb@epcas4p1.samsung.com>
        <20191013123524.1821390-1-jic23@kernel.org>
        <1019298652.01571023201320.JavaMail.epsvc@epcpadp1>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Oct 2019 11:18:43 +0900
Chanwoo Choi <cw00.choi@samsung.com> wrote:

> Hi,
>=20
> On 19. 10. 13. =EC=98=A4=ED=9B=84 9:35, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Identified by coccinelle
> > drivers/iio/adc/exynos_adc.c:654:2-3: Unneeded semicolon
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/exynos_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index 42a3ced11fbd..b5a497381452 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -651,7 +651,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev=
_id)
> >  		input_sync(info->input);
> > =20
> >  		usleep_range(1000, 1100);
> > -	};
> > +	}
> > =20
> >  	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
> > =20
> >  =20
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Applied.

Thanks,

Jonathan

>=20

