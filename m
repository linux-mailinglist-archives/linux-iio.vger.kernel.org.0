Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83996148D14
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbgAXRiA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 12:38:00 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:50916 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389487AbgAXRiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jan 2020 12:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kO2pTpMXTjirs1T9+Tqx7exh45U6cC4XVCnw+kz4z9E=; b=kMv1Q6A1EdayuI15tq9yAZ6k+
        qa++o6aMBXi60PmCr+b+soC0XqQAisYB5fIds9C/ILLai0zmZq8Yyg0RIeWY2I0psyaAn6s69AHH7
        xvyHg8q3olYxaA0+Mbe/yFnIlKHq0szjubS4hfJp0+XfZxVLvWVvGZ6lg8ipISRDkOYBo=;
Received: from p200300ccff0b16007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff0b:1600:7ee9:d3ff:fe1f:a246] helo=eeepc.fritz.box)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iv2tv-0007T7-E8; Fri, 24 Jan 2020 18:37:49 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iv0sq-0006jm-2T; Fri, 24 Jan 2020 16:28:32 +0100
Date:   Fri, 24 Jan 2020 16:28:18 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200124162818.0697f551@kemnade.info>
In-Reply-To: <20200120084934.GZ15507@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
        <20200117215926.15194-3-andreas@kemnade.info>
        <20200120084934.GZ15507@dell>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IMwQ3EA3mlW=xf1Y4GDLMWA"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/IMwQ3EA3mlW=xf1Y4GDLMWA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

hmm, I cannot find this in any branch/repo I know of and not in linux-next,
just wondering...
I guess the iio part is something to go towards 5.7 unless 5.5
is delayed mucch.

Regards,
Andreas

On Mon, 20 Jan 2020 08:49:34 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 17 Jan 2020, Andreas Kemnade wrote:
>=20
> > This adds a subdevice for the ADC in the RC5T619.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/rn5t618.c | 1 +
> >  1 file changed, 1 insertion(+) =20
>=20
> Applied, thanks.
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>=20

--Sig_/IMwQ3EA3mlW=xf1Y4GDLMWA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl4rDRMACgkQl4jFM1s/
ye+L9hAAs+bo7p2SXf11Rn3tlAHcI94DNVUx7FnrebA36C1LXkMWC0RrclYtKkPS
xLyxLiZLeUxUvOWjlRXcBU0FU7QVeM+FxB61ze9V50dBGFgj1PHAVPAgmyeM+Ch3
d/TGMONsI2lfR5NFU/TSWyPan2Em6s5Yet4HAnpv2WIyAGT4qHfyoHo5gmU5GqD3
wQCekCRwi5gs/yYIKG/AEpVo/MT6DOQ3bSPRmC6sxaqgfJVJXAXsStcNRNW07cq7
onj/OU+aauVT6xJ2XvB7uiKaC8kzrVXK0t02nOhqDIct3GYOpm2bO0AtFafURKhe
sGgq/SPFCBISOMqIGvU+0/Hd2abGA/r4win12xYWI9o/0LPMZs25LyFxXNBBaRtc
9QFhE7DazpoLpPCFv7Za5+KmuZxcifN8DZgFl177V0U79vXPuS52g3vEIbzwZboc
+HCB2imqCOIhAOMhwGr7ADn0u/ryo8LG4HgozzoEztm7xoSMOyDPf9ct9wZS8Np5
2ImzgpnYb70qIvSV9y6JCupLXeChZmyB6Kfc3sird2bwNIQNPHOLEQKoDlvkawNG
7ePxvN0pqZUuS2DhLbbzKFoljnhiR4DEiIHmnQDUEEvEfz6dHDGM7fEzY5679Fuu
3L0DmPqvHi28vobM2YscZ9VTHimw7N6lZozqVy2t12NNbl36D7E=
=nb2+
-----END PGP SIGNATURE-----

--Sig_/IMwQ3EA3mlW=xf1Y4GDLMWA--
