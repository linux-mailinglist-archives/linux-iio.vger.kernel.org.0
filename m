Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35C17CDD2
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCGLdz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCGLdz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:33:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26F2206D5;
        Sat,  7 Mar 2020 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583580834;
        bh=pg4MQZ0CM6vUCN/05TjyICftkFGEZ7Ij8g1yUHlVJag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B6DcZK8YZCkV6BCnBTJVL7rZy9FKp+cBK14P6J9/9FkQ5qg2nesJtLP967zN8eBZc
         I4X1u9SffSvADap4+F25ihzQeWgIlid2pPJ1z41M0QtIF387z9tLhBFHF+v/NTVHyQ
         OrK4USz8lejwqTIkTsi02y8mCFITryFLjwIgfUHg=
Date:   Sat, 7 Mar 2020 11:33:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200307113349.27e4484a@archlinux>
In-Reply-To: <a6b4c76a337f53db1ee05a03eca06751b901d04b.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-6-nuno.sa@analog.com>
        <20200303211045.31f977bb@archlinux>
        <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
        <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
        <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
        <13e355c6-af60-772a-92ec-aff17d0255ee@metafoo.de>
        <a6b4c76a337f53db1ee05a03eca06751b901d04b.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Mar 2020 13:04:27 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Thu, 2020-03-05 at 13:43 +0100, Lars-Peter Clausen wrote:
> > On 3/5/20 1:27 PM, Sa, Nuno wrote: =20
> > > > In my opinion there is should not be a difference in the
> > > > userspace
> > > > interface for chips that do support 32-bit burst and those that
> > > > don't.
> > > > For devices that don't support 32-bit burst it should be emulated
> > > > by
> > > > reading the LSB bits registers manually. =20
> > > Hmm. In terms of interface I think there is no difference. We
> > > always
> > > report 32bits channels (for accel and gyro). However, what we do
> > > right
> > > know is just to set the LSB to 0 if burst32 is not supported. So,
> > > we
> > > can be just ignoring the LSB bits if they are being used... =20
> >=20
> > What I meant was that somebody might still want to get the full 32-
> > bit=20
> > values in buffered mode, even if the device does not support burst32. =
=20
>=20
> They are. Just that the LSB part is always set to 0 :). And that, in my
> opinion, is wrong. As you say, we should do the manual readings if
> there are any bits on the LSB registers...
>=20
> - Nuno S=C3=A1
> > In=20
> > that case you can first do a 16-bit burst read to get the MSBs and
> > then=20
> > do manual reads of all the LSB registers and then put both into the
> > buffer.
> > - Lars
> >  =20
>=20
Thanks Lars and Nuno, I'd not grasped exactly what this was.

Hmm.  Not allowing for variable bit widths has bitten us a few times in the
past.  Howwever, it's a really nasty thing to try and add to the core now
unfortunately.

In some cases we've just padded the smaller bitwidth buffer but that
is costly to actually do.  You get fast reads from the hardware then loose
at least some of the benefit respacing the data.

Still it is definitely a policy decision so not DT.  It's ugly but if
we want to support it and can't do it at runtime, perhaps a module parameter
is the best option?

Thanks,

Jonathan


