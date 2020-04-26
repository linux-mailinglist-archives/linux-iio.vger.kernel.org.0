Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B101B8E11
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZIzV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 04:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgDZIzU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 04:55:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4461220700;
        Sun, 26 Apr 2020 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587891319;
        bh=I+BF0dVWvC9Dx4ICRolhqOlkdDoEIrBgqe/2wouDFAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5qpJhBHlm582Hqxj6EuPSw56og/ROWMhQxe/xlRDf9ryQ/m+ZMWgxttZB8w1nW14
         8qItfG4TTG0aDhg/43aiqRjpnwvHG0xQ816k/Dc++o+hxNTh28HZ56bU7Ou1YVPiE7
         9Cc7f+lmXUiKUlXvhnv/N8+G+i/T/1jbDa+5PhrQ=
Date:   Sun, 26 Apr 2020 09:55:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Leslie =?UTF-8?B?SHNpYQ==?=(=?UTF-8?B?5aSP6YKm6YCyX1BlZ2F0cm9u?=)" 
        <Leslie_Hsia@pegatroncorp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hermes =?UTF-8?B?SHNpZWg=?=( =?UTF-8?B?6Kyd5pe75YqtX1BlZ2F0cm9u?=)" 
        <Hermes_Hsieh@pegatroncorp.com>,
        "jesse.sung@canonical.com" <jesse.sung@canonical.com>
Subject: Re: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Message-ID: <20200426095514.28aaecad@archlinux>
In-Reply-To: <754706C925201D4896E92CCAD6B38E4401F0F6B825@PTW-EX-38.PEGA.CORP.PEGATRON>
References: <754706C925201D4896E92CCAD6B38E4401F0F6B825@PTW-EX-38.PEGA.CORP.PEGATRON>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 06:58:17 +0000
Leslie Hsia(=E5=A4=8F=E9=82=A6=E9=80=B2_Pegatron) <Leslie_Hsia@pegatroncorp=
.com> wrote:

>   *   Author: Leslie Hsia
>   *   Amplifier driver for TAS5805M, initial the amplifier and set the so=
und's parameter.
>   *   Signed-off-by: Leslie Hsia <Leslie_Hsia@pegatroncorp.com<mailto:Les=
lie_Hsia@pegatroncorp.com>>
>=20
>       -------------------------------------------------------------------=
------------------------------
>=20
>   *   Hi Jonathan,
> tas5805m only needs to be initialized via i2c port, this driver doesn't u=
se any ALSA API,
> so we put this driver into this path

I'm still unconvinced. This is very much an audio part so people
aren't going to expect to find it in IIO.  Mark?=20

Also please ensure next version of code is sent inline.  See
Documentation/process/submitting-patches

Jonathan

>=20
>=20
>=20
> This e-mail and its attachment may contain information that is confidenti=
al or privileged, and are solely for the use of the individual to whom this=
 e-mail is addressed. If you are not the intended recipient or have receive=
d it accidentally, please immediately notify the sender by reply e-mail and=
 destroy all copies of this email and its attachment. Please be advised tha=
t any unauthorized use, disclosure, distribution or copying of this email o=
r its attachment is strictly prohibited.
>=20
> =E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=
=E4=BB=B6=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=A9=9F=E5=AF=86=E6=88=96=E4=
=BE=9D=E6=B3=95=E5=8F=97=E7=89=B9=E6=AE=8A=E7=AE=A1=E5=88=B6=E4=B9=8B=E8=B3=
=87=E8=A8=8A=EF=BC=8C=E5=83=85=E4=BE=9B=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=
=E4=BB=B6=E4=B9=8B=E5=8F=97=E6=96=87=E8=80=85=E4=BD=BF=E7=94=A8=E3=80=82=E5=
=8F=B0=E7=AB=AF=E5=A6=82=E9=9D=9E=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=
=B6=E4=B9=8B=E5=8F=97=E6=96=87=E8=80=85=E6=88=96=E8=AA=A4=E6=94=B6=E6=9C=AC=
=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=EF=BC=8C=E8=AB=8B=E7=AB=8B=E5=8D=B3=E5=
=9B=9E=E8=A6=86=E9=83=B5=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=AF=84=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E4=B8=A6=E9=8A=B7=E6=AF=80=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=
=E4=BB=B6=E4=B9=8B=E6=89=80=E6=9C=89=E8=A4=87=E6=9C=AC=E5=8F=8A=E9=99=84=E4=
=BB=B6=E3=80=82=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=B6=93=E6=8E=88=E6=AC=8A=E8=80=
=8C=E4=BD=BF=E7=94=A8=E3=80=81=E6=8F=AD=E9=9C=B2=E3=80=81=E6=95=A3=E4=BD=88=
=E6=88=96=E8=A4=87=E8=A3=BD=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E6=
=88=96=E5=85=B6=E9=99=84=E4=BB=B6=E4=B9=8B=E8=A1=8C=E7=82=BA=EF=BC=8C=E7=9A=
=86=E5=9A=B4=E6=A0=BC=E7=A6=81=E6=AD=A2 =E3=80=82
>=20

