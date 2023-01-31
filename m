Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535C682B41
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 12:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjAaLP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjAaLP0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 06:15:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142114B880
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 03:15:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38A29B81BCF
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47955C433D2;
        Tue, 31 Jan 2023 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675163710;
        bh=PqLJf1wyIsTkZ6HGmxm0UauSX4VKp6iN27nYLyCtzJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjXBUUc3ewAFzNAvDxHPCzJPWmMMNZAg7m0+lxDgskRPh9C8T+voMgUqFJnusnN7b
         aGXxmWaolQ6ddXZxg+aluw1N42ac660aDiy39npXspktY4LQR7yNZSaYhNnL291dl9
         dlt719ke4qn/WVTyaBsFKfkuuQtn1Ib3fdRO/HXTTZvXCBaiVlaz3qg3vecfVud6a1
         ZMMhBrwRQwsj1BrsDewALkkR+qKPWcXUHXvdY0vijCqnuM2SH62cto64TFCVLYIWJY
         mhVU9JtRJidceefVfV8IcL6hNAM2q9pe/psWZpN/sPc7oUAmh7npwsCcaqgSf3DVfr
         sb7XYGj3hWISw==
Date:   Tue, 31 Jan 2023 06:15:08 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9j4PGeHWnqPGxNG@ishi>
References: <Y9g5MOWkDGZxovjW@ishi>
 <Y9jD5h64XFknwb8/@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j9vGoWFcP/e/4+XA"
Content-Disposition: inline
In-Reply-To: <Y9jD5h64XFknwb8/@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--j9vGoWFcP/e/4+XA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 08:31:50AM +0100, Greg KH wrote:
> On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrote:
> > The following changes since commit 1b929c02afd37871d5afb9d498426f83432e=
71c2:
> >=20
> >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/co=
unter-updates-for-6.2a
> >=20
> > for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:
> >=20
> >   counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (=
2023-01-18 09:59:58 -0500)
> >=20
> > ----------------------------------------------------------------
> > First set of Counter updates for the 6.2 cycle
>=20
> You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
> can tell.
>=20
> > This set of updates consists only of Kconfig cleanup and changes for the
> > Counter subsystem. In particular, the Kconfig entries are reorganized to
> > to alphabetical order, and dependencies added to restrict building
> > certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
> > systems that support them.
> >=20
> > Changes
> > * counter
> >   - Sort the Kconfig entries alphabetically
>=20
> This isn't needed for 6.2-final at all from waht I can tell.
>=20
> thanks,
>=20
> greg k-h

Oops I mistyped the version in the description; yes these are for the
6.3 merge. Would you like me to retag and resend?

William Breathitt Gray

--j9vGoWFcP/e/4+XA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY9j4PAAKCRC1SFbKvhIj
K8Z0AQDJfE6YtfPSL1R3sYri0Ao/gA13KYmeDWiXi7kO0z6VwQEA+SvN8JYbtVbB
3hXUisYCXbFnhlTaMJ8t5TlNhHm8cA0=
=wH4L
-----END PGP SIGNATURE-----

--j9vGoWFcP/e/4+XA--
