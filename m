Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9950EE024D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 12:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfJVKuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 06:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388372AbfJVKuQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 06:50:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256A62075A;
        Tue, 22 Oct 2019 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571741415;
        bh=HLnoPG4NqtCzOt9lT9Vz7q0mws9WR3wYSYgX18WYPYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2fDfhbmc4ltqu66OYTH+21FIkF0OiS1Uc1nII2OALDCnQM41KhOnTf6sZ4kASDAH
         +mec1MmJc4nLevTccIjILEk/vIB/QAm1qQS6tW+R0RMmgXZwZjyB11fEd0Paeftkif
         CBUxsm0dy/fSz+m6/OCKASeDY9JbtqK4D5ObQJg4=
Date:   Tue, 22 Oct 2019 11:50:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-iio@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mma8452: Re-word 'interrupt-names'
 description
Message-ID: <20191022115010.7957744e@archlinux>
In-Reply-To: <1a1bdf10-2505-6baf-8030-ce5e0e2b55a9@posteo.de>
References: <20191022035626.13002-1-andrew.smirnov@gmail.com>
        <1a1bdf10-2505-6baf-8030-ce5e0e2b55a9@posteo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Oct 2019 10:43:09 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> On 22.10.19 05:56, Andrey Smirnov wrote:
> > Current wording in the binding documentation doesn't make it 100%
> > clear that only one of "INT1" and "INT2" will ever be used by the
> > driver and that specifying both has no advantages. Re-word it to make
> > this aspect a bit more explicit.

=46rom a quick glance at the datasheet, it appears that the hardware
is capable of routing different interrupts to different pins, even
if the driver does not do so.

CTRL_REG5 has 6 different bits to set whether particular blocks have
their interrupt routed to INT1 or INT2, so it appears to be possible
to send some each way.
=20
A binding is for the hardware not the driver, so if I'm right about this
the current text is correct and should be left alone.

Thanks,

Jonathan

> >=20
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/=
Documentation/devicetree/bindings/iio/accel/mma8452.txt
> > index e132394375a1..b27b6bee9eb6 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> > +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> > @@ -17,7 +17,7 @@ Optional properties:
> > =20
> >    - interrupts: interrupt mapping for GPIO IRQ
> > =20
> > -  - interrupt-names: should contain "INT1" and/or "INT2", the accelero=
meter's
> > +  - interrupt-names: should contain "INT1" or "INT2", the acceleromete=
r's
> >  		     interrupt line in use.
> > =20
> >    - vdd-supply: phandle to the regulator that provides vdd power to th=
e accelerometer.
> >  =20
>=20
> Acked-by: Martin Kepplinger <martink@posteo.de>
>=20
> thanks,
>=20
>                            martin
>=20

