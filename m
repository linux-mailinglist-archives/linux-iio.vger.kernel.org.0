Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D71B8809
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDYRK6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgDYRK6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44098206B6;
        Sat, 25 Apr 2020 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587834658;
        bh=9JLPrvwtf1kR1XWHBlo5cHjeAQpwvGV5tSTP/VROjBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c+5nHlWN09zsQoQrU7U4zQaBKY44wiT3NKX9U9V8hidHXxvLJilr6BbWYqiZlzmHA
         sg0rgZ7GkamplUTWe26nR+NwNc8K6SKJ8z5yxbDlZfHkZnWkfE/rPphKgMTtenO4FC
         VmAfFdtUOGCU83p4F9vY07/ipVGV96nmBuhiKZIk=
Date:   Sat, 25 Apr 2020 18:10:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
 dependencies
Message-ID: <20200425181052.1588a862@archlinux>
In-Reply-To: <CY4PR03MB33502FFA293BB3F068A488B299D00@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200423150523.23984-1-robh@kernel.org>
        <CY4PR03MB33502FFA293BB3F068A488B299D00@CY4PR03MB3350.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 07:26:46 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Rob Herring
> > Sent: Donnerstag, 23. April 2020 17:05
> > To: devicetree@vger.kernel.org
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter
> > Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> > Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
> > dependencies
> >=20
> > With the bracketed list form, any strings with commas have to be quoted
> > or they are separated.
> >=20
> > Fixes: 3986a14870cb ("dt-bindings: iio: Add ltc2983 documentation")
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > --- =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Rob, Do you want to pick this one up via your tree?

Thanks,

Jonathan

> >  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml      | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > index 8fb46de6641d..04da5c48a5e9 100644
> > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > +++
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > @@ -260,7 +260,7 @@ patternProperties:
> >        - adi,rsense-handle
> >=20
> >      dependencies:
> > -      adi,current-rotate: [ adi,rsense-share ]
> > +      adi,current-rotate: [ "adi,rsense-share" ]
> >=20
> >    "^thermistor@":
> >      type: object
> > @@ -349,7 +349,7 @@ patternProperties:
> >        - adi,rsense-handle
> >=20
> >      dependencies:
> > -      adi,current-rotate: [ adi,rsense-share ]
> > +      adi,current-rotate: [ "adi,rsense-share" ]
> >=20
> >    "^adc@":
> >      type: object
> > --
> > 2.20.1 =20
>=20

