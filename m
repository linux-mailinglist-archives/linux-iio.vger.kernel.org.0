Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846BB1AF2FF
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRSDb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSDa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:03:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ABB20776;
        Sat, 18 Apr 2020 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587233010;
        bh=+vnN+b7oLErNPyZEiy/XOJsCfu+GJnqYQobwgFKDzCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuIcFw7xLh+30daWRlOe/jjcCMPUrqMszbDrcQoxckSvYPsG1aV8Z4Ymx4hFU/1KW
         3WzXdM4Y7UfVDBKjEvJYTxth+ZE8O3FoBlvDjEXfKrTc07Zhc4yNS0lkVQfAWsEBH6
         zCtz5fs/wo2/Iz6btLxRkh5LSknfH5n/VKHk36e4=
Date:   Sat, 18 Apr 2020 19:03:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: Introduce common properties
 for iio sensors
Message-ID: <20200418190324.2372d36b@archlinux>
In-Reply-To: <20200414214923.GA21041@bogus>
References: <cover.1586094535.git.agx@sigxcpu.org>
        <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
        <20200414214923.GA21041@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 16:49:23 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun,  5 Apr 2020 15:50:29 +0200, =3D?UTF-8?q?Guido=3D20G=3DC3=3DBCnthe=
r?=3D wrote:
> > Introduce a file for common properties of iio sensors. So far this
> > contains the new proximity-near-level property for proximity sensors
> > that indicates when an object should be considered near.
> >=20
> > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> > ---
> >  .../devicetree/bindings/iio/common.yaml       | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/common.yaml
> >  =20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks

Jonathan
