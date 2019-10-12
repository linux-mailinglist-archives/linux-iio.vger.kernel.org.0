Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE501D5035
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfJLN41 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfJLN41 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:56:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC672089C;
        Sat, 12 Oct 2019 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570888586;
        bh=0HvqvFwfwCQoraeKnSparcBfChLwzNFxZYU8txEdt2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UecdelPXpFk8H7muOCmZSBT6DH0LU3oM4xjYOlFu4DAWS3r6hwJLfbVdpj76vjyK4
         MWglcnHyUzd7ZEp+XgK8uztgJ0ngoou0jxKVXyDGLW8gfAD9LGjKp/jcZLeoEDyTEG
         5WcFUPXIwBPlzlYCTuYFOzbxHxFniLmcq4ghE/R4=
Date:   Sat, 12 Oct 2019 14:56:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] iio: adc: max1027: Add debugfs register read
 support
Message-ID: <20191012145621.228d4efc@archlinux>
In-Reply-To: <20191007120001.61c8ef71@xps13>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-2-miquel.raynal@bootlin.com>
        <20191006110424.7781d99d@archlinux>
        <20191007120001.61c8ef71@xps13>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 12:00:01 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> Jonathan Cameron <jic23@kernel.org> wrote on Sun, 6 Oct 2019 11:04:24
> +0100:
>=20
> > On Thu,  3 Oct 2019 19:33:55 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  =20
> > > Until now, only write operations were supported. Force two bytes read
> > > operation when reading from this register (might be wrong when reading
> > > the temperature, but will work with any other value).   =20
> >=20
> > That's worrying as comments go.  Just return an error on the temperature
> > register if it's going to do the wrong thing. =20
>=20
> Actually the debugfs_reg_access hook is supposedly stateless. When
> reading registers I don't know what I am reading because the "source" is
> selected during the write operation, so I have no reliable way to know
> what I am reading.
>=20
> I set the read length to 2 bytes because most of the "atomic"reads are
> two bytes and it allows us to test various commands directly from
> userspace and read meaningful values. This is a limitation as:
> * Voltage 'atomic' reads are 2 bytes
> * Temperature 'atomic' reads are 2 bytes but never come alone (usually
>   one voltage input of 2B will follow).
> * Any other 'condensed' input will be more than 2 bytes, ie. several
>   voltage values in one go.
>=20
> In any case, doing a software reset of the chip will turn it back
> into a working state no matter what was requested/read.
>=20
> For me, 2-byte reads is a "good enough" solution that will work with
> almost all the simplest ('atomic') SPI operations, but if you think
> limiting to 2-bytes access is a problem (right now there is only write
> access, which is kind of useless on its own) then let's drop the patch.
> But I wanted to contribute it because it really helped me during the
> development.=20

This is fine as is.  Comment was worrying so could perhaps have given
more detail.  Still it's a debug interface, people get to look at the
datasheet if they are using this :)

Jonathan


>=20
>=20
> Thanks,
> Miqu=C3=A8l

