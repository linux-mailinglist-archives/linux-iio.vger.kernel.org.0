Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BAE214735
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGDQGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgGDQGJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:06:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F030C20739;
        Sat,  4 Jul 2020 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593878769;
        bh=0ptZ4vvcX/8OOSog7MYIb++ZaTDDUTSvFZVnkFeE8z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1mX4mYrYZq7fb4MKgQysagPZKxYNkP3aJS+UkhAO+xusshUkUr9ZBABaTpOizBK9/
         +ZvC5UOwgRzXHVDX3Kn2DCc1ckSvcRIImFJOnD33VOQzlbM+G/TvZkbNazFCUZ2mI6
         lvUc4fxccUviRcpTvd3tUSnf+vCo2GDM6+FNAOKk=
Date:   Sat, 4 Jul 2020 17:06:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 1/2] iio: adc: adi-axi-adc: Fix object reference
 counting
Message-ID: <20200704170605.20657b71@archlinux>
In-Reply-To: <8f297dda580043fc5a9c5bae53139c8aa74dd666.camel@analog.com>
References: <20200701120442.258-1-nuno.sa@analog.com>
        <8f297dda580043fc5a9c5bae53139c8aa74dd666.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Jul 2020 14:07:05 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-07-01 at 14:04 +0200, Nuno S=C3=A1 wrote:
> > [External]
> >=20
> > When looking for a registered client to attach with, the wrong reference
> > counters are being grabbed. The idea is to increment the module and
> > device
> > counters of the client device and not the counters of the axi device
> > being
> > probed.
> >  =20
>=20
> Yep.
> Good catch here.
>=20
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
> > Fixes: ef04070692a2 (iio: adc: adi-axi-adc: add support for AXI ADC IP
> > core)
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> >  drivers/iio/adc/adi-axi-adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-
> > adc.c
> > index 63d926e86798..86b6b65916ee 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -332,12 +332,12 @@ static struct adi_axi_adc_client
> > *adi_axi_adc_attach_client(struct device *dev)
> >  		if (cl->dev->of_node !=3D cln)
> >  			continue;
> > =20
> > -		if (!try_module_get(dev->driver->owner)) {
> > +		if (!try_module_get(cl->dev->driver->owner)) {
> >  			mutex_unlock(&registered_clients_lock);
> >  			return ERR_PTR(-ENODEV);
> >  		}
> > =20
> > -		get_device(dev);
> > +		get_device(cl->dev);
> >  		cl->info =3D info;
> >  		mutex_unlock(&registered_clients_lock);
> >  		return cl; =20

