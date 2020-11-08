Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B912AAC5F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgKHQ7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 11:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHQ7z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 11:59:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF4120678;
        Sun,  8 Nov 2020 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854794;
        bh=hQ8jpwkqu7IZYJyC/2BQHv1Von+2yk8napFvrpZ4eiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNMp/ZGi7ymYhk2yPEwoP0TFON3Y2N6y6Occ5JF+bG83RvwOugWG5xpZcNuzqqTEe
         omFw+BGVOgC5Qmj5SegkRXeAglQJr2fWZTCJbA1jA4XWHZgU2vOVX9XPqCnE7N/Llg
         gqMUiWNSJLzed+EDa8v0U1qUih7FxVd9OqdNOR/Y=
Date:   Sun, 8 Nov 2020 16:59:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 37/46] dt-binding:iio:adc:ti,ads124s08: txt to yaml
 format conversion.
Message-ID: <20201108165950.2ea18229@archlinux>
In-Reply-To: <db16627a-d405-1b8f-bec9-da41f7faabf8@ti.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-38-jic23@kernel.org>
        <db16627a-d405-1b8f-bec9-da41f7faabf8@ti.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 06:49:54 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Jonathan
>=20
> On 10/31/20 1:48 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simple binding so straight forward format conversion.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Dan Murphy <dmurphy@ti.com>
> > ---
> >   .../bindings/iio/adc/ti,ads124s08.yaml        | 52 +++++++++++++++++++
> >   .../bindings/iio/adc/ti-ads124s08.txt         | 25 ---------
> >   2 files changed, 52 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
> > new file mode 100644
> > index 000000000000..5912a52953fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) =20
> GPL-2.0-only=C2=A0 OR BSD-2-Clause
>=20

Fair enough, GPL-2.0 is defined as meaning the same, but is deprecated
according to the SPDX list of names.
@Rob, I assume we aren't taking a strong view on which is preferred for
DT bindings?

Jonathan


> Otherwise
>=20
> Reviewed-by: Dan Murphy <dmurphy@ti.com>
>=20

