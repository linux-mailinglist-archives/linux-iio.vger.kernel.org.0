Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30C29B952
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1800525AbgJ0Prg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 11:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1798573AbgJ0P24 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Oct 2020 11:28:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC4822264;
        Tue, 27 Oct 2020 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603812534;
        bh=Y2O4SK3XfMBPVGIwhVh3t5te9UIcIjEHNC/iwcjZ24M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oV0O1mZpc7Hg0Q8KbOTCnJ6IHGdkdz9iuksfGJBk662nEP3ckxAQcko1J5yvaDMDG
         IVz3F1YWP497hIBRg2t9xgGBRdoAxpS+4dth0zUUGFZewAqY5gVzZRh65pdV3814Gh
         oDYRb0AMmpP+MAVAhdbM3k75g3hdAQP/liFC0VMI=
Date:   Tue, 27 Oct 2020 15:28:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] dt-bindings: iio: adc: ti,adc084s021 yaml
 conversion
Message-ID: <20201027152849.7db26688@archlinux>
In-Reply-To: <20200829185331.4cb804dc@archlinux>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-8-jic23@kernel.org>
        <20200818023000.GA2171469@bogus>
        <20200829185331.4cb804dc@archlinux>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 18:53:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Aug 2020 20:30:00 -0600
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Sun, 09 Aug 2020 12:17:47 +0100, Jonathan Cameron wrote: =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Simple conversion.
> > >=20
> > > Added the #io-channel-cells optional property to allow for consumer
> > > bindings if appropriate on a given board.
> > >=20
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: M=C3=A5rten Lindahl <martenli@axis.com>
> > > ---
> > >  .../bindings/iio/adc/ti,adc084s021.yaml       | 58 +++++++++++++++++=
++
> > >  .../bindings/iio/adc/ti-adc084s021.txt        | 19 ------
> > >  2 files changed, 58 insertions(+), 19 deletions(-)
> > >    =20
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org> =20
> Applied
Or apparently I didn't.  Not sure what happened here, but now
actually applied to the togreg branch of iio.git.

Thanks,

Jonathan

>=20
>=20
>=20

