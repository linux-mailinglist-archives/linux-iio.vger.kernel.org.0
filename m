Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA89B19EA9A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDEKxq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDEKxq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 06:53:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55A4206B8;
        Sun,  5 Apr 2020 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586084025;
        bh=6Y5VeSBeh8aYiph9RvH1WUYUtJk/6KelitXaK2jowkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/4+IyfDnVg1ElUWBcpnB9e9AYKxd7ZxmyoxW4JMKYEOvlV1Nti+pnZLRA+MZHOd0
         snhkIQndOaPUnw+CMkgPDEKKZdlKUiygt+EGbPPQR+uFzVklC1IhXjyci4rOLCU/pQ
         50dvllCqst7Lm2uXOZWi8TMnvUYW4zx82ZrAr3lY=
Date:   Sun, 5 Apr 2020 11:53:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for
 chrdev
Message-ID: <20200405115341.631b8769@archlinux>
In-Reply-To: <db6bdd2b-cb9b-442f-46b9-557e1f31f431@metafoo.de>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
        <20200330145705.29447-4-alexandru.ardelean@analog.com>
        <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
        <20200405104939.0e220daa@archlinux>
        <bcdeeb9e-b225-6f6a-65f4-49023ebba169@metafoo.de>
        <db6bdd2b-cb9b-442f-46b9-557e1f31f431@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 11:58:38 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/5/20 11:57 AM, Lars-Peter Clausen wrote:
> > On 4/5/20 11:49 AM, Jonathan Cameron wrote: =20
> >>>> 3. A side question is about the 'iio_buffer -> pollq' field. I was
> >>>> wondering if it would make sense to move that on to 'iio_dev=C2=A0=20
> >>>> pollq' if
> >>>> adding multiple buffers are added per-device. It almost makes sense =
to
> >>>> unify the 'pollq' on indio_dev.
> >>>> But, it looks a bit difficult, and would require some more change=20
> >>>> [which is
> >>>> doable] if it makes sense for whatever reason.
> >>>> The only reason to do it, is because the iio_buffer_fileops has a=20
> >>>> .poll =3D
> >>>> iio_buffer_poll() function attached to it. Adding multiple buffers=20
> >>>> for an
> >>>> IIO device may require some consideration on the iio_buffer_poll()=20
> >>>> function
> >>>> as well. =20
> >>> I think we need one chardev per buffer. Conceptually that is the right
> >>> approach in my option since the two buffers are independent streams.=
=20
> >>> But
> >>> also from a practical point of view we want to have the ability to ha=
ve
> >>> the buffers opened by different applications. E.g. iio_readdev on the
> >>> input buffer and iio_writedev on the output buffer. And there might be
> >>> some other operations that wont multiplex as nicely as read/write. The
> >>> high speed interface for example would not work as it is right now.
> >>> =20
> >> Yup. Separate chardev is pretty much the only option given the poll=20
> >> infrastructure.
> >> In theory could do the anon file trick again but I'm not sure it's=20
> >> worth it
> >> - the vast majority of drivers are still going to be single buffer (I=
=20
> >> think!) =20
> > The main problem I see with the anon file trick is that we use the=20
> > open file also as mutual exclusion so only one application can access=20
> > a buffer at a time. This means if one application has the main chardev=
=20
> > open no other application will be able to access the buffers (or events=
). =20
>=20
> And of course also that you can use `cat`, `echo`, `dd` and so on.

True on both counts. For events I'm don't think this restriction really mat=
ters
because they are normally fairly tightly coupled to the data stream coming =
in
etc (though we should do an in kernel consumer at somepoint).  I did have a=
 plan
a long time ago to allow additional kfifos to be attached as consumer devic=
es
to allow more complex multi user cases if needed but never implemented it.

Lets not go down the anon route for input vs output buffers as seems entire=
ly
reasonable that they might be used by separate programs.

Jonathan

>=20

