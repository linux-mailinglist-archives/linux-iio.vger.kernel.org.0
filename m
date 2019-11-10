Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA406F69AA
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKJPad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfKJPad (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:30:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0CC20818;
        Sun, 10 Nov 2019 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573399832;
        bh=EbDDty/PRRrKzUouBpk/BmdXSWYVbU7Vs7tIavpArIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fb0bAFD8AXj1puFSjbev0zZsRVdqvpycJy0u0hk6x2qaYTu21YDf8zYvAvYvoBcxT
         TSMZDHD+t9W+RU7S8j9exm5jfxpFRme4BJmxlIxAUbCL0W9azHNxvYpARqeuaZHk8m
         wFlwKkjTFV8H/Sy/SyGHXSmIgdDh4SSw8/De/WzU=
Date:   Sun, 10 Nov 2019 15:30:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
Message-ID: <20191110153026.6e5087b3@archlinux>
In-Reply-To: <MN2PR12MB33733917812945D0293D9D27C47B0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191107184342.20361-1-stephan@gerhold.net>
        <MN2PR12MB33733917812945D0293D9D27C47B0@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Nov 2019 12:11:46 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hi Jean-Baptiste,

I'm assuming that applies for both patches given you gave comments on
v1 that applied to patch 2!

Thanks,

Jonathan

>=20
> Best regards,
> JB
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Stephan Gerhold <stephan@gerhold.net>
>=20
> Sent: Thursday, November 7, 2019 19:43
>=20
> To: Jonathan Cameron <jic23@kernel.org>
>=20
> Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de=
>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring <robh+dt@kernel.=
org>; Mark Rutland <mark.rutland@arm.com>; Linus Walleij <linus.walleij@lin=
aro.org>; Brian Masney <masneyb@onstation.org>;
>  Jonathan Marek <jonathan@marek.ca>; Jean-Baptiste Maneyrol <JManeyrol@in=
vensense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devic=
etree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kerne=
l.org <linux-kernel@vger.kernel.org>;
>  Stephan Gerhold <stephan@gerhold.net>
>=20
> Subject: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
>=20
> =C2=A0
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
> inv_mpu6050 now supports an additional vdd-supply; document it.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
>=20
>=20
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>=20
>=20
>=20
> ---
>=20
>=20
>=20
> Changes in v2:
>=20
>=20
>=20
> =C2=A0 - Add Reviewed-by from Linus Walleij
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> v1:=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Diio_20191106183536.123070-2D1-2Dstephan-40gerhold.net_&d=3DDwIDAg&c=
=3DWoJWtq5JV8YrKnzRxvD8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4=
h9MF8q7Xk5aBwG28mVk&m=3DO82MQPnLTvlD0nxDzFW1KS3aZpWiI3qYUZwJUy_qqxc&s=3Dddv=
zqy0PywWDCnge7xbJIhpqN9NltbLrzi4EBVdeA_o&e=3D
>=20
>=20
>=20
>=20
> ---
>=20
>=20
>=20
> =C2=A0Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
>=20
>=20
>=20
> =C2=A01 file changed, 1 insertion(+)
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/=
Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>=20
>=20
>=20
> index 268bf7568e19..c5ee8a20af9f 100644
>=20
>=20
>=20
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>=20
>=20
>=20
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>=20
>=20
>=20
> @@ -21,6 +21,7 @@ Required properties:
>=20
>=20
>=20
> =C2=A0=C2=A0 bindings.
>=20
>=20
>=20
> =C2=A0
>=20
>=20
>=20
> =C2=A0Optional properties:
>=20
>=20
>=20
> + - vdd-supply: regulator phandle for VDD supply
>=20
>=20
>=20
> =C2=A0 - vddio-supply: regulator phandle for VDDIO supply
>=20
>=20
>=20
> =C2=A0 - mount-matrix: an optional 3x3 mounting rotation matrix
>=20
>=20
>=20
> =C2=A0 - i2c-gate node.=C2=A0 These devices also support an auxiliary i2c=
 bus.=C2=A0 This is
>=20
>=20
>=20

