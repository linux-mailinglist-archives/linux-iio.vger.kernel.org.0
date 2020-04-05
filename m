Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34D19EB32
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDEMYa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgDEMYa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:24:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF03820672;
        Sun,  5 Apr 2020 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586089469;
        bh=WeElrOdEljZlX3sc42YJnl4iy1cnJgpEOkV3Pg6ad8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p9o1P2WohfFELD2MsyPm1YT8iR7RGlnkxdleWPfVoDcG9WnHjcRw7pG/FEpQ7AT8c
         /b8kqVTl2gGpFHEWW4xBpYaLGMCO015242O8AzOblEwJk4HUQxMfqXSFQIrwSzJ2mM
         xihFj11qC4nilsuPeNNmCIzaqmcb0M7Z2XMlbMBw=
Date:   Sun, 5 Apr 2020 13:24:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>
Cc:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] iio: st_sensors: make scale channels also shared by
 type
Message-ID: <20200405132425.2432bca9@archlinux>
In-Reply-To: <20200405115139.GA189531@ADVI0116>
References: <20200330145920.441528-1-rvlander@gaetanandre.eu>
        <20200405110217.0f6a38d0@archlinux>
        <20200405115139.GA189531@ADVI0116>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 13:51:39 +0200
Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:

> On Sun, Apr 05, 2020 at 11:02:17AM +0100, Jonathan Cameron wrote:
> > On Mon, 30 Mar 2020 16:59:20 +0200
> > Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:
> >  =20
> > > Scale channels are available by axis. For example for accelerometers,
> > > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are available.
> > >=20
> > > However, they should be shared by type as documented in
> > > Documentation/ABI/testing/sysfs-bus-iio.
> > >=20
> > > For each sensor (acceleros, gyros and magnetos) only one value is spe=
cified
> > > for all the axes.
> > >=20
> > > Existing, by axis, entries are preserved in order to to leave the old=
 ABI
> > > untouched. =20
> > Hi Ga=C3=ABtan,
> >=20
> > Thanks for this.  Whilst I agree the ideal ABI would be to have just the
> > shared version userspace should cope with the current version anyway as
> > it would be the right option if for example the scale of x and y are co=
ntrolled
> > by one register field and z by another (this used to be common for acce=
lerometers)
> >=20
> > Any userspace software using this will have to assign a precedence to t=
he
> > two files that result and the most likely option is more specific first=
 meaning
> > the shared version is unused.
> >=20
> > Hence I'd argue we aren't broke (just non ideal) and adding the additio=
nal
> > interface just confuses matters.  Hence I would rather leave things how=
 they
> > currently are.  Do we have some userspace that is broken by this being =
less
> > than ideal?
> >  =20
> Hi Jonathan,
>=20
> Thanks for taking time to answer.
>=20
> I don't have any point of view regarding what is better.
>=20
> What I know is that iio-sensor-proxy [1] only looks for a common scale.
> Hence, it won't work with ST sensors as is.

Ah.  Cc'd Bastien for that.

>=20
> I could either do this patch or patch iio-sensor-proxy. What decided me
> is that all ST sensors, if I am correct, use only one scale value for all=
 axis.
>=20
> If things are to be kept as is, then iio-sensor-proxy should be patched.
Hmm. Even if we patched iio-sensor-proxy (and we probably should to support
devices that actually have different scales), we'd still have the normal
problem of people not upgrading their stacks terribly often.

Lets see what Bastien says, but (with the addition of a comment to say why
we are doing both in the code) I'm fine taking this patch given we have
known userspace issue without it.

>=20
> Also, note that currently in_acceleration_scale_{x, y, z} don't seem to
> be documented.

Good spot.  We should tidy that up.  Seems in_magn_x_scale is there, but
not the in_accel_x_scale etc.  Likely some of the others are missing as well
but we never noticed.

Thanks

Jonathan

>=20
> Thanks,
>=20
> Ga=C3=ABtan
>=20
> [1] iio-sensor-proxy: https://gitlab.freedesktop.org/hadess/iio-sensor-pr=
oxy/
>=20
> > Thanks
> >=20
> > Jonathan
> >  =20
> > >=20
> > > Signed-off-by: Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu>
> > > ---
> > >  include/linux/iio/common/st_sensors.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/ii=
o/common/st_sensors.h
> > > index 33e939977444..f31e309f0fd1 100644
> > > --- a/include/linux/iio/common/st_sensors.h
> > > +++ b/include/linux/iio/common/st_sensors.h
> > > @@ -52,6 +52,7 @@
> > >  	.type =3D device_type, \
> > >  	.modified =3D mod, \
> > >  	.info_mask_separate =3D mask, \
> > > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> > >  	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > >  	.scan_index =3D index, \
> > >  	.channel2 =3D ch2, \
> > >=20
> > > base-commit: b723e9431b77976b83efb90178dfcada3405321c =20
> >  =20

