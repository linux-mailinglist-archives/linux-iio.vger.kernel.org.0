Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1C196C11
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgC2JZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgC2JZd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 05:25:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B55206CC;
        Sun, 29 Mar 2020 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585473933;
        bh=iqrnWuC36D/i2iLtbv9vfgG36HlMWDUVrX4Tgvr3qqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uilwj6KqNo5KyE1DfzPkp+cUDnicTZ4kC9NxfAbZ0+G9WBSrTSSjiehVXxnJ1lztc
         Oj5Z7pMxfBsw7S5pL11HkiNn4UwP4lusxI8127WWcxaCTKxkmcqn9rj6kdl3CzK4L9
         kl0tYl8/Yh5Y93Gdd5IVqvOkgdYbJSPK+sreens0=
Date:   Sun, 29 Mar 2020 10:25:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: light: vcnl4000: Add
 near-level
Message-ID: <20200329102526.1ee85e96@archlinux>
In-Reply-To: <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
        <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 12:09:06 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> This value indicates when userspace should consider an object
> near to the sensor/device.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

I'm fine with this.  Note for Rob or other DT people.

This is a new generic binding hence no vendor prefix.

I will ideally want review of both the dt patches though
before applying.  As we've missed the merge window anyway
there is no particular rush.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.=
yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 21ef2eb7a205..ac9e3bb6a505 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -25,6 +25,13 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  near-level:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Raw proximity values equal or above this level should be
> +      considered 'near' to the device (an object is near to the
> +      sensor).
> +
>  required:
>    - compatible
>    - reg
> @@ -40,6 +47,7 @@ examples:
>        light-sensor@51 {
>                compatible =3D "vishay,vcnl4200";
>                reg =3D <0x51>;
> +              near-level =3D <220>;
>        };
>    };
>  ...

