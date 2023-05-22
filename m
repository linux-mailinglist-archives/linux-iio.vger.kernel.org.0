Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3070BB9C
	for <lists+linux-iio@lfdr.de>; Mon, 22 May 2023 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjEVLVL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 May 2023 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjEVLU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 May 2023 07:20:59 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDBF1FE0
        for <linux-iio@vger.kernel.org>; Mon, 22 May 2023 04:15:42 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-43943447fb9so313076137.2
        for <linux-iio@vger.kernel.org>; Mon, 22 May 2023 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684754137; x=1687346137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe0uEO9ZtluN485cWnZvS1/i70J+fGRHfkqfDe56RAs=;
        b=VAN8pSDcruxO3TxbsEjJxCCU9DaxhV1ODx1tbBvoCR8pWaxFjwrap1aoWS8Bb1oSng
         yAxK/nO3U73XAY8u03fb83C6e/y2+Ada5RLoaHNfj1977odITVBTAxmMkaDxMjNtz5Vj
         7g0jJ7iDUv1adCciCx8bUlEHfEKmbl4IT2nyeSavn8dasN6wUxWTC1ohrMkfIlWsbAfv
         7Gj9ods0vS0F4qD3TqVwqc79gUKrCi/Aiano9NPGqkfu1RROxmoEmuutn3PsO5RCQb5q
         +cRRSbSTHoJurdPyjk7SzDiiskfOE4GH4/9bg/f58aW1ZvMUAzGao0SaQCOepauc7ryU
         AguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754137; x=1687346137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe0uEO9ZtluN485cWnZvS1/i70J+fGRHfkqfDe56RAs=;
        b=IPJRLc3WUEc+8nGoOqC9iMgiY8bjE8ktO+AZpc30oFQyjiR3FhwtKzXUNj1nEJPrIM
         N+A0WdtQkj9F3Ts3AS2aCtZQfSukmj683B1SSa6NYOiGKbQz4gxLmz3x/OFjIu818TeY
         mptcXvprprPn2pjzVnG3UC2YAuXCCBQT4DrlrNxhtlhzfo5zKfmtIWwGs6Rp+BOt+wB0
         5kQVTiKuOCoME3XlG3z+NWf15T3I/7H3cC+QkOGVkEoN54i7YFZ8s+frvTb19T/3f4QO
         LI1dp5XsA0WnWZANBO55oNn0Q2M/O8UVOIDKPSbUp+kmqfvIBoN1yEV4zqrWtKhOTBKP
         Zo0g==
X-Gm-Message-State: AC+VfDxnbjd8bA/W7nQrp3aLUnU+guJ0MA3ScYURDpkFWLR+Xz08tNMX
        W3qidA9qwtHAE2lXJG4Xs3UJxA==
X-Google-Smtp-Source: ACHHUZ7xXsCl+lvUt4i9xuTKPrjGekCgXQFO7IApujxds8gKvzk98JPWki37KC4E4nR5EYbORQB3rA==
X-Received: by 2002:a67:fbda:0:b0:436:158:cf6c with SMTP id o26-20020a67fbda000000b004360158cf6cmr2473206vsr.6.1684754136793;
        Mon, 22 May 2023 04:15:36 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id v24-20020ab05598000000b006904fa86e7csm1178322uaa.2.2023.05.22.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:15:36 -0700 (PDT)
Date:   Mon, 22 May 2023 07:15:33 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 05/41] counter: add HAS_IOPORT dependencies
Message-ID: <ZGtO1U7Wx7MVi0DL@fedora>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-6-schnelle@linux.ibm.com>
 <ZGbQYzXK8InMqkxu@fedora>
 <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
 <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
 <abc02dc2af7563ae26bf0d0ddd927d9b4a21dda3.camel@linux.ibm.com>
 <ZGeF1K0Yxu9lTgN2@fedora>
 <cb6aa00b1901abb572e69e218a5500f2cd1561ce.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvesmdynfJhc3cAo"
Content-Disposition: inline
In-Reply-To: <cb6aa00b1901abb572e69e218a5500f2cd1561ce.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lvesmdynfJhc3cAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 12:42:15PM +0200, Niklas Schnelle wrote:
> On Fri, 2023-05-19 at 10:21 -0400, William Breathitt Gray wrote:
> > On Fri, May 19, 2023 at 03:39:57PM +0200, Niklas Schnelle wrote:
> > > On Fri, 2023-05-19 at 15:38 +0200, Niklas Schnelle wrote:
> > > > On Fri, 2023-05-19 at 15:17 +0200, Niklas Schnelle wrote:
> > > > > On Thu, 2023-05-18 at 21:26 -0400, William Breathitt Gray wrote:
> > > > > > On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> > > > > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() =
and friends
> > > > > > > not being declared. We thus need to add HAS_IOPORT as depende=
ncy for
> > > > > > > those drivers using them.
> > > > > > >=20
> > > > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > > >=20
> > > > > > Hi Niklas,
> > > > > >=20
> > > > > > The change itself is fine, but please update the description to=
 reflect
> > > > > > that this is adding a depends on HAS_IOPORT_MAP rather than HAS=
_IOPORT,
> > > > > > along with the reason why it's needed (i.e. devm_ioport_map() i=
s used).
> > > > > >=20
> > > > > > Thanks,
> > > > > >=20
> > > > > > William Breathitt Gray
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Right, this clearly needs adjustment. I went with the following c=
ommit
> > > > > message for v5:
> > > > >=20
> > > > > "counter: add HAS_IOPORT_MAP dependency
> > > > >=20
> > > > > The 104_QUAD_8 counter driver uses devm_ioport_map() without depe=
nding
> > > > > on HAS_IOPORT_MAP. This causes compilation to fail on platforms s=
uch as
> > > > > s390 which do not support I/O port mapping. Add the missing
> > > > > HAS_IOPORT_MAP dependency to fix this."
> > > > >=20
> > > >=20
> > > > Just noticed this isn't entirely correct. As devm_ioport_map() has =
an
> > > > empty stub for HAS_IOPORT_MAP=3Dn this doesn't lead to a compile er=
ror it
> > > > just doesn't work. Will reword to "This causes the driver to not be
> > > > useable on platforms ..."
> > >=20
> > > s/useable/usable/
> >=20
> > 104_QUAD_8 has an explicit dependency on PC104 and X86, so I don't think
> > it would ever be used outside of x86 platforms. Does it still make sense
> > to have the HAS_IOPORT_MAP dependency in this case?
> >=20
> > William Breathitt Gray
>=20
> Well, yes and no, you're right that it doesn't really cause compile
> issues despite the "|| COMPILE_TEST" albeit the code could never work.
> Still, I'd add the dependency. At the very least it serves as
> documentation and maybe in the future someone will want to remove those
> empty stubs for HAS_IOPORT_MAP=3Dn.
>=20
> Thanks
> Niklas

Sure, that reasoning makes sense to me too, so let's go with the
explicit depends afterall.

By the way, I noticed two other modules that call devm_ioport_map() but
seem to be missing the HAS_IOPORT_MAP depends lines: the
drivers/iio/addac/stx104.c and drivers/iio/dac/cio-dac.c drivers. Do
these need respective patches as well?

As an aside, I haven't been following the previous patchsets closely so
forgive me if this has already been discussed in another thread: why
doesn't X86 automatically select HAS_IOPORT? Are there x86 platforms
that do not support ioport?

William Breathitt Gray

--lvesmdynfJhc3cAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGtO1QAKCRC1SFbKvhIj
K51mAPwIdOqB4viwJHoa872UFoQps4r86WdliN/6XVH9/iKGMQD+K/cgzOH47iLy
u51o+Y6RoIoavHfWY39mUSbtEm9KngQ=
=L71k
-----END PGP SIGNATURE-----

--lvesmdynfJhc3cAo--
