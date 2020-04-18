Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342E11AF302
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDRSEa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:04:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C7A221F7;
        Sat, 18 Apr 2020 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587233069;
        bh=8Oiza300Qj9upHF1HuOMzNXo+u5/FnKXIINlx2GfZ1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNrF3LZrVVpUWjRH/4C7Fnpqze8mlL/yUbU7gVq3oo9izx0OTDhMOVK+4L6KpHWKd
         8rkBNRYjy9jpukSyzh12WD5yQee+Ybbvv+eQPHZKz88uvBfnTx9lhomzP5lI6AaRUv
         wvvZ1aGLRLCIKuFOb+4ZReHhGdixoCj7b7FLt/00=
Date:   Sat, 18 Apr 2020 19:04:24 +0100
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
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: light: vcnl4000: Add
 proximity-near-level
Message-ID: <20200418190424.078ddd48@archlinux>
In-Reply-To: <20200414215016.GA22563@bogus>
References: <cover.1586094535.git.agx@sigxcpu.org>
        <9bbbc30e5e8e67e50ddacb4cadc180fa5c7f7bd0.1586094535.git.agx@sigxcpu.org>
        <20200414215016.GA22563@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 16:50:16 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun,  5 Apr 2020 15:50:30 +0200, =3D?UTF-8?q?Guido=3D20G=3DC3=3DBCnthe=
r?=3D wrote:
> > This value indicates when userspace should consider an object
> > near to the sensor/device.
> >=20
> > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> > ---
> >  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml     | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >  =20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.  Thanks,
