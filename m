Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F365E5443
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIUUND (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiIUUM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 16:12:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F1A4B02
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 13:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A51CFCE1BA3
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 20:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D5AC433C1;
        Wed, 21 Sep 2022 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663791170;
        bh=K/kA8UuArYRUwQ/2fiMrAty2fUX0/dIW4/X56IAg/Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ep5a9KL8dwcgAXv+Lizuc8tQcPaWOrQ2Y4tA1hyKrYhAWbw4mIICNiPrfj0FZJeIN
         F7tIyWEJ7vWcQ8CoIgBx2g262Cm4pucRA2wdK2pupEbRGK5HkPlRThSIYYCb7SxsRM
         6Fvp4v1NoycwHEcxl6NZoj2UvQH4N0T8bJfhhNjIUqUpBjsow2HMfXqPi+ksmOVda3
         v+I8FzDK6XjpkqeO06SDg0z0RjZwUeQhQZUClrZP3Nm4YyXxcJRUagoEgY074SuXym
         VP/cl8U91tTQPFEFtBvV9VVewbO5SvLAeRVHLsHlgCnMawuCIMG5uJVMUfqmiokS+g
         /xjN2WkQ/Ia6A==
Date:   Wed, 21 Sep 2022 16:12:48 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] counter: First set of Counter fixes for 6.0-rc5
Message-ID: <YytwQEV+ajrZELTm@ishi>
References: <YyNWADWgfl1sL10S@ishi>
 <YysQ+JUP0u3kge53@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OkmhcYLR+PlewFIb"
Content-Disposition: inline
In-Reply-To: <YysQ+JUP0u3kge53@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OkmhcYLR+PlewFIb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 03:26:16PM +0200, Greg KH wrote:
> On Thu, Sep 15, 2022 at 12:42:40PM -0400, William Breathitt Gray wrote:
> > The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5=
b868:
> >=20
> >   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/co=
unter-fixes-for-6.0a
> >=20
> > for you to fetch changes up to 8294b04153c33602e9c3dd21ac90c1e99bd0fdaf:
> >=20
> >   counter: Realign counter_comp comment block to 80 characters (2022-09=
-11 11:45:02 -0400)
> >=20
> > ----------------------------------------------------------------
> > counter: First set of Counter fixes for 6.0-rc5
> >=20
> > counter
> >  - Realign counter_comp comment block to 80 characters
> >=20
> > 104-quad-8
> >  - Fix skipped IRQ lines during events configuration
> >=20
> > ----------------------------------------------------------------
> > William Breathitt Gray (2):
> >       counter: 104-quad-8: Fix skipped IRQ lines during events configur=
ation
> >       counter: Realign counter_comp comment block to 80 characters
> >=20
> >  drivers/counter/104-quad-8.c |  6 +++---
> >  include/linux/counter.h      | 40 ++++++++++++++++++++----------------=
----
> >  2 files changed, 23 insertions(+), 23 deletions(-)
>=20
>=20
> You signed this pull request, yet I don't see your key in the kernel.org
> pgp repo, and so I get this error when trying to merge:
>=20
> # gpg: Signature made Thu 15 Sep 2022 06:40:07 PM CEST
> # gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE1=
2232B
> # gpg: Can't check signature: No public key
>=20
> Did you use the right key, or is it somewhere else?
>=20
> thanks,
>=20
> greg k-h

It's located under pgpkeys/keys/B54856CABE12232B.asc in the kernel.org
pgp repo: https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/=
B54856CABE12232B.asc

I added wbg@kernel.org as a new UID and uploaded it to keys.openpgp.org:
https://keys.openpgp.org/search?q=3D8D37CDDDE0D22528F8E89FB6B54856CABE12232B

Looks like the kernel.org pgp repo hasn't been synchronized yet with the
updated key from keys.openpgp.org, so I suspect that's why you're
getting the error right now.

William Breathitt Gray

--OkmhcYLR+PlewFIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYytwQAAKCRC1SFbKvhIj
K/KlAPwKfrAiRAdEDmtT7enQHgfCcxZP+eb5I4XbrmzdQeatnQEAvGsmMgLdzosr
/3R2HQ3bap7kO1Hiry4BeyWKZx4nPQ4=
=nvtb
-----END PGP SIGNATURE-----

--OkmhcYLR+PlewFIb--
