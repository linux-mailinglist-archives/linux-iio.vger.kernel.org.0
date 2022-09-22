Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AF5E603F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiIVK4Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIVK4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 06:56:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D94CD1E7
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 03:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDF062C17
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F6C433C1;
        Thu, 22 Sep 2022 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663844173;
        bh=5+IboIz5/pcHaAER3NQKgFCPD2ECq4ClHKQqARVK6go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELrTq5z4mi5enkNqX09u54d6cYRK1WVQzvKfMNnLxUcOB2sG6pDjHbOnCUbUXOsxw
         LAuEqhecpHLOaZxV4G/ULcfgJ/MFe1Z2wgVpxJXW3rQGETv45wnsblLgKJTv7hgzYP
         1JX2X8pmGZvopLJ+lpOKrYL1h/BhftKLS2mxXrzfksGSAWcDiqCJksaQcnfh6ykxw2
         7m5VASG2vzGHkPXQSWta6ZwzwerFbe2s3rt3i3rIj9jf91JwAqrVADFJ1bDLle1OM7
         M1A5w1IvkuK1iWTOiIrHHahYGh5fkjQg2tcOATlX4zEy6+0qga4fCBJTfjdFtVivXe
         KyBGFkwWcmvTg==
Date:   Thu, 22 Sep 2022 06:56:10 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] counter: First set of Counter fixes for 6.0-rc5
Message-ID: <Yyw/SoO31Hy+dFQZ@ishi>
References: <YyNWADWgfl1sL10S@ishi>
 <YysQ+JUP0u3kge53@kroah.com>
 <YytwQEV+ajrZELTm@ishi>
 <YywPgWIgkE76z48/@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJvGg/DYgjAcQNRn"
Content-Disposition: inline
In-Reply-To: <YywPgWIgkE76z48/@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rJvGg/DYgjAcQNRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 09:32:17AM +0200, Greg KH wrote:
> On Wed, Sep 21, 2022 at 04:12:48PM -0400, William Breathitt Gray wrote:
> > On Wed, Sep 21, 2022 at 03:26:16PM +0200, Greg KH wrote:
> > > On Thu, Sep 15, 2022 at 12:42:40PM -0400, William Breathitt Gray wrot=
e:
> > > > The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea2=
2cf5b868:
> > > >=20
> > > >   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> > > >=20
> > > > are available in the Git repository at:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tag=
s/counter-fixes-for-6.0a
> > > >=20
> > > > for you to fetch changes up to 8294b04153c33602e9c3dd21ac90c1e99bd0=
fdaf:
> > > >=20
> > > >   counter: Realign counter_comp comment block to 80 characters (202=
2-09-11 11:45:02 -0400)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > counter: First set of Counter fixes for 6.0-rc5
> > > >=20
> > > > counter
> > > >  - Realign counter_comp comment block to 80 characters
> > > >=20
> > > > 104-quad-8
> > > >  - Fix skipped IRQ lines during events configuration
> > > >=20
> > > > ----------------------------------------------------------------
> > > > William Breathitt Gray (2):
> > > >       counter: 104-quad-8: Fix skipped IRQ lines during events conf=
iguration
> > > >       counter: Realign counter_comp comment block to 80 characters
> > > >=20
> > > >  drivers/counter/104-quad-8.c |  6 +++---
> > > >  include/linux/counter.h      | 40 ++++++++++++++++++++------------=
--------
> > > >  2 files changed, 23 insertions(+), 23 deletions(-)
> > >=20
> > >=20
> > > You signed this pull request, yet I don't see your key in the kernel.=
org
> > > pgp repo, and so I get this error when trying to merge:
> > >=20
> > > # gpg: Signature made Thu 15 Sep 2022 06:40:07 PM CEST
> > > # gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856C=
ABE12232B
> > > # gpg: Can't check signature: No public key
> > >=20
> > > Did you use the right key, or is it somewhere else?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > It's located under pgpkeys/keys/B54856CABE12232B.asc in the kernel.org
> > pgp repo: https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/k=
eys/B54856CABE12232B.asc
> >=20
> > I added wbg@kernel.org as a new UID and uploaded it to keys.openpgp.org:
> > https://keys.openpgp.org/search?q=3D8D37CDDDE0D22528F8E89FB6B54856CABE1=
2232B
> >=20
> > Looks like the kernel.org pgp repo hasn't been synchronized yet with the
> > updated key from keys.openpgp.org, so I suspect that's why you're
> > getting the error right now.
>=20
> Ok, can you just send me the patch through email for now until things
> get propagated properly?
>=20
> thanks,
>=20
> greg k-h

Sure, I'll resend these soon as a patch series on the list.

William Breathitt Gray

--rJvGg/DYgjAcQNRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyw/SgAKCRC1SFbKvhIj
K3DhAP95OoHzWQK+vtIGgAvg1wFKMTqQPSAyQ9WKLGx2YVSw8wEAgRrfyN3vZV3E
oqM+pqUVm1D2gVVGJZbmlxiG5pzumQw=
=T7/y
-----END PGP SIGNATURE-----

--rJvGg/DYgjAcQNRn--
