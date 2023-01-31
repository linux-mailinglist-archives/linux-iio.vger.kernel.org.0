Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0C682BAA
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 12:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAaLlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 06:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjAaLlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 06:41:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34149962
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 03:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AAC2B81BCE
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BA8C433EF;
        Tue, 31 Jan 2023 11:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675165306;
        bh=uF3ZomjwtXYw3szMITxktVp5rQ6n9itzRl6CkTTiV8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtpM27S2oLiGlVpXGDaiQjzCUWbk9KRHTvTZmc8MfcF5ep3SGqIQLqtKu84HpnIqx
         IKkbpZs9iSc2/mLQqB8rj1iQWPAMBVfn1EICSnw34otUWEYU1iBBsLXZ2UGhGtkOAs
         DHbBYjc+dwvaBVXg/2QCL1+8WZdbrxrn6Qyw+427LXUJKzSxJ3+8BfTGCyFDE6//t0
         o2KWIAdz6mKguoqG1QQuqHM71wuHbofjiFlw4Bsv6ip0WdMcod0ohKo92KusGWVCsS
         KKF7poJWe5lX8Wn8pI9jFs90Cx0yDRv8xdu1scMGK/9KeC9ZG4bywFanNSNont7so8
         MaGSFwX5dWo+w==
Date:   Tue, 31 Jan 2023 06:41:43 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9j+d1NAcuEouQMa@ishi>
References: <Y9g5MOWkDGZxovjW@ishi>
 <Y9jD5h64XFknwb8/@kroah.com>
 <Y9j4PGeHWnqPGxNG@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AmhatLiCYOpM0OeG"
Content-Disposition: inline
In-Reply-To: <Y9j4PGeHWnqPGxNG@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--AmhatLiCYOpM0OeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 06:15:08AM -0500, William Breathitt Gray wrote:
> On Tue, Jan 31, 2023 at 08:31:50AM +0100, Greg KH wrote:
> > On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrote:
> > > The following changes since commit 1b929c02afd37871d5afb9d498426f8343=
2e71c2:
> > >=20
> > >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/=
counter-updates-for-6.2a
> > >=20
> > > for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff=
2c:
> > >=20
> > >   counter: fix dependency references for config MICROCHIP_TCB_CAPTURE=
 (2023-01-18 09:59:58 -0500)
> > >=20
> > > ----------------------------------------------------------------
> > > First set of Counter updates for the 6.2 cycle
> >=20
> > You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
> > can tell.
> >=20
> > > This set of updates consists only of Kconfig cleanup and changes for =
the
> > > Counter subsystem. In particular, the Kconfig entries are reorganized=
 to
> > > to alphabetical order, and dependencies added to restrict building
> > > certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
> > > systems that support them.
> > >=20
> > > Changes
> > > * counter
> > >   - Sort the Kconfig entries alphabetically
> >=20
> > This isn't needed for 6.2-final at all from waht I can tell.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Oops I mistyped the version in the description; yes these are for the
> 6.3 merge. Would you like me to retag and resend?
>=20
> William Breathitt Gray

Actually, I'll resend this afterall. I prefer the history of this pull
to be clear on the mailing list, and hopefully to avoid another
off-by-one mistake when 6.4 comes around.

William Breathitt Gray

--AmhatLiCYOpM0OeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY9j+dwAKCRC1SFbKvhIj
K25EAQDIIHykj3rtRrfNCHgET/Zw0ww6ItPkzjzoORf7GGSC6wD7B3qa/4BDyd97
FLBqiApB6/kv+xePZ4sX4eQNML1TnA0=
=F9Ab
-----END PGP SIGNATURE-----

--AmhatLiCYOpM0OeG--
