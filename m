Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07341D813A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfJOUol (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 16:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfJOUol (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Oct 2019 16:44:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B7220854;
        Tue, 15 Oct 2019 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571172280;
        bh=96tbnK3YSsVZWln/vAFBqJf1uNUVlq2DthHzGkzBeqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfA8DuiPz6JCtEQdAkJch9QJsgoefCt8NLYdcPKYzrHkv/Zo2llpYAGwxmu/H614R
         S7yYjYZOewW+F7BhbagPtge0UhNNYymyptZBs8M/8BAznmTUrrn5LZTqBzuyz1kOIg
         dXrj8EJXvN2BXWcaHRr0GTOXjuFeiVmBh09C6NMw=
Date:   Tue, 15 Oct 2019 21:44:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191015214435.5d51835a@archlinux>
In-Reply-To: <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
References: <20191011084038.45829-1-nuno.sa@analog.com>
        <20191011084038.45829-2-nuno.sa@analog.com>
        <20191012115745.069119b0@archlinux>
        <20191014143950.GA6163@bogus>
        <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Oct 2019 09:19:10 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Oct 14, 2019 at 9:39 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, Oct 12, 2019 at 11:57:45AM +0100, Jonathan Cameron wrote: =20
> > > On Fri, 11 Oct 2019 10:40:38 +0200
> > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > =20
> > > > Document the LTC2983 temperature sensor devicetree bindings.
> > > >
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > >
> > > I'm happy with this, but will be waiting for Rob to have a chance
> > > for a final look before applying. =20
> >
> > LGTM, but I need to add the int64-matrix type to the core schema first
> > or this will give you errors. I should get to that in the next day or
> > so. =20
>=20
> Now added, so please update dtschema and check.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

/home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temperatur=
e/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-thermo=
couple:0:0: 18446744073659331616 is greater than the maximum of 92233720368=
54775807
/home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temperatur=
e/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-thermo=
couple:0:2: 18446744073679351616 is greater than the maximum of 92233720368=
54775807
/home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temperatur=
e/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-thermo=
couple:0:4: 18446744073704251616 is greater than the maximum of 92233720368=
54775807

Which is odd.  I haven't looked into it beyond testing and reverting the
patch as out of time for today.

Thanks,

Jonathan


