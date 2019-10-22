Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842FEE01F8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfJVKXx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 06:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVKXw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 06:23:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF57A21783;
        Tue, 22 Oct 2019 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571739831;
        bh=lj1xDu2d7HyT+htIIh0laut/HwTqamtxfwIV/3EMPOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fp4nf5R0ZkD1m+Wps2id7kxQEty1smFenzQKHUjZmM2exR3Ldi7roNbt+jTHwsaua
         51PPWj09dR+fin0Wpbvv5y06P0KDudIL7Ruri9kKt/nbOWxH3L6bFiGOQlRFQPORPS
         nPan3/4fUXojhW+WYXvN7LnR0KEjt8A7kRxthU9s=
Date:   Tue, 22 Oct 2019 11:23:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191022112346.5b9180f0@archlinux>
In-Reply-To: <CAL_Jsq+5SYOPDOJJJ8+OuGpQ=PKB2JmbQ=yGN1fyuZnuQnAJ2Q@mail.gmail.com>
References: <20191011084038.45829-1-nuno.sa@analog.com>
        <20191011084038.45829-2-nuno.sa@analog.com>
        <20191012115745.069119b0@archlinux>
        <20191014143950.GA6163@bogus>
        <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
        <20191015214435.5d51835a@archlinux>
        <20191021162736.7409baa7@archlinux>
        <CAL_Jsq+5SYOPDOJJJ8+OuGpQ=PKB2JmbQ=yGN1fyuZnuQnAJ2Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Oct 2019 12:21:41 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Oct 21, 2019 at 10:27 AM Jonathan Cameron <jic23@kernel.org> wrot=
e:
> >
> > On Tue, 15 Oct 2019 21:44:35 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Tue, 15 Oct 2019 09:19:10 -0500
> > > Rob Herring <robh@kernel.org> wrote:
> > > =20
> > > > On Mon, Oct 14, 2019 at 9:39 AM Rob Herring <robh@kernel.org> wrote=
: =20
> > > > >
> > > > > On Sat, Oct 12, 2019 at 11:57:45AM +0100, Jonathan Cameron wrote:=
 =20
> > > > > > On Fri, 11 Oct 2019 10:40:38 +0200
> > > > > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > > > > =20
> > > > > > > Document the LTC2983 temperature sensor devicetree bindings.
> > > > > > >
> > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > > > > >
> > > > > > I'm happy with this, but will be waiting for Rob to have a chan=
ce
> > > > > > for a final look before applying. =20
> > > > >
> > > > > LGTM, but I need to add the int64-matrix type to the core schema =
first
> > > > > or this will give you errors. I should get to that in the next da=
y or
> > > > > so. =20
> > > >
> > > > Now added, so please update dtschema and check.
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org> =20
> > >
> > > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temp=
erature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-=
thermocouple:0:0: 18446744073659331616 is greater than the maximum of 92233=
72036854775807
> > > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temp=
erature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-=
thermocouple:0:2: 18446744073679351616 is greater than the maximum of 92233=
72036854775807
> > > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temp=
erature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-=
thermocouple:0:4: 18446744073704251616 is greater than the maximum of 92233=
72036854775807
> > >
> > > Which is odd.  I haven't looked into it beyond testing and reverting =
the
> > > patch as out of time for today. =20
> >
> > I'm still getting this and not sure why.  Rob? =20
>=20
> Just realized I failed to send my draft...
>=20
> This is dtc yaml output not maintaining the sign, so everything is
> unsigned. (I had mentioned this and then promptly forgot.) I'll need
> to figure out how to plumb this thru dtc. For now, its probably
> easiest to just change to uint64-matrix with a comment that it should
> be signed.
>=20
> Rob
Thanks.  Made the change and added the note to the docs.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


