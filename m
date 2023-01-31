Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4F682C0B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAaL5Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 06:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaL5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 06:57:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3B4C6F2
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 03:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BCF56147C
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C47C433D2;
        Tue, 31 Jan 2023 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166242;
        bh=jHW3Qiy3QgaXSMmSc/DBx0YNkkwSxxkw9snihSLZbjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6nGpZM5Ufcd8YGfKRJi28pvZEzejyBqYJOZ57i4eXP7lr+2wdooucVhpRAJdh87S
         9+7jy+mM7Q+kD4R44UblvO2QdBGx3x/OnaJ0ZXWUOBCwlS0M17WCVqlbCNDcmvrVyG
         RhxrLe2AR2GMZZ/6SozSbt1JFtXJ7NCPEPZePvAWPkyG+vc/G5zwpNiFXyLRHjza5q
         sSKYgbFw3flkQe00ZkQ+0TD0xCvn72Pf65Lnw4DgxrHEbEfIHLQ8tU1GBNXOATEYVJ
         TbX82Bj0wNbV6Ht1OjdG63QhP/TfCKn5nJcJf8VJNPFjz17xSamoXrJ/9Wg84Xd5y0
         EVEAO8Xo63NMQ==
Date:   Tue, 31 Jan 2023 06:57:20 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9kCIK2bkha/JYJS@ishi>
References: <Y9g5MOWkDGZxovjW@ishi>
 <Y9jD5h64XFknwb8/@kroah.com>
 <Y9j4PGeHWnqPGxNG@ishi>
 <Y9j/lgPB3kzPENvs@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yv/ltj/jQbIT0KYs"
Content-Disposition: inline
In-Reply-To: <Y9j/lgPB3kzPENvs@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--yv/ltj/jQbIT0KYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 12:46:30PM +0100, Greg KH wrote:
> On Tue, Jan 31, 2023 at 06:15:08AM -0500, William Breathitt Gray wrote:
> > On Tue, Jan 31, 2023 at 08:31:50AM +0100, Greg KH wrote:
> > > On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrot=
e:
> > > > The following changes since commit 1b929c02afd37871d5afb9d498426f83=
432e71c2:
> > > >=20
> > > >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> > > >=20
> > > > are available in the Git repository at:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tag=
s/counter-updates-for-6.2a
> > > >=20
> > > > for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cf=
ff2c:
> > > >=20
> > > >   counter: fix dependency references for config MICROCHIP_TCB_CAPTU=
RE (2023-01-18 09:59:58 -0500)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > First set of Counter updates for the 6.2 cycle
> > >=20
> > > You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
> > > can tell.
> > >=20
> > > > This set of updates consists only of Kconfig cleanup and changes fo=
r the
> > > > Counter subsystem. In particular, the Kconfig entries are reorganiz=
ed to
> > > > to alphabetical order, and dependencies added to restrict building
> > > > certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture)=
 to
> > > > systems that support them.
> > > >=20
> > > > Changes
> > > > * counter
> > > >   - Sort the Kconfig entries alphabetically
> > >=20
> > > This isn't needed for 6.2-final at all from waht I can tell.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > Oops I mistyped the version in the description; yes these are for the
> > 6.3 merge. Would you like me to retag and resend?
>=20
> Please do.  Also, I can't verify your signature:
> 	# gpg: Signature made Mon 30 Jan 2023 10:27:41 PM CET
> 	# gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE=
12232B
> 	# gpg: Can't check signature: No public key
>=20
> Is it in the kernel.org keyring?
>=20
> thanks,
>=20
> greg k-h

I'm not quite sure why it's returning an error for you, but here's the
key (8D37CDDDE0D22528F8E89FB6B54856CABE12232B) in kernel.org pgpkeys
tree:
https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/B54856CABE=
12232B.asc

Does that work for you?

William Breathitt Gray

--yv/ltj/jQbIT0KYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY9kCIAAKCRC1SFbKvhIj
KybPAQCkQaqNb09bPbbwGtJbfTPn1wOmnpy5Aqzq0WMUlDO+XQEA9m9ttHgpDJje
LEfYl/mrWRL2jLgjgaQP7Hs6H5arvQg=
=kccG
-----END PGP SIGNATURE-----

--yv/ltj/jQbIT0KYs--
