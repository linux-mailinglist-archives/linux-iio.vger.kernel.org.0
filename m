Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BA68F485
	for <lists+linux-iio@lfdr.de>; Wed,  8 Feb 2023 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBHR2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Feb 2023 12:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBHR2y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2023 12:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FEC4FCE5
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 09:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFFF2B81F07
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 17:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F0BC433EF;
        Wed,  8 Feb 2023 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675877308;
        bh=8xa/4+tXYfXJuQK6Zuz8DAOp7pyCl6yru5HOBrHM5mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZKI5emGJIqdKl5YJCks+kbG7MSfe5RMPF6ZyDON4DGGhZjb50P8qT4xCMZ9brLe7
         KcvvQV+lMYH4i54hsnrw5roNK+cr3bXO3x7rS2e48Q/tqSlDunRYsoop80m9h00D8b
         4VXlDqUWZA75tpNLUQHWNtYI2i1mPQH9lyB/6BGt5HCNNZDh8vPvrUOpFtXhK5RT70
         QfvKMNtbD+VTuEOKGK54mdiwxSVTp3s78wpU8t/XbqSl/r8+7IK6SPDyBCGSCzU+pb
         QTAGIgfnyOc64sJKPuVaJNDxBdXC53Sc62PQwnspnL+eQXGtnmikCSUsUww+kOGqZv
         rYCoKEbR8OdVg==
Date:   Wed, 8 Feb 2023 18:28:24 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <Y+PbuPU7mupAjjqR@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
 <20230208162331.GA27875@frolo.macqel>
 <Y+PPD3iWlw9tdfHS@lore-desk>
 <20230208171523.GA28208@frolo.macqel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/s99QnNc6VhbVstE"
Content-Disposition: inline
In-Reply-To: <20230208171523.GA28208@frolo.macqel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/s99QnNc6VhbVstE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello again Lorenzo,
>=20
> On Wed, Feb 08, 2023 at 05:34:23PM +0100, Lorenzo Bianconi wrote:
>=20
> > Date: Wed, 8 Feb 2023 17:34:23 +0100
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > To: Philippe De Muyter <phdm@macq.eu>
> > Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
> > 	lorenzo.bianconi@redhat.com
> > Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filte=
rs
> > 	settling time
> >=20
> > > Hello Lorenzo,
> > >=20
> > > thank you for your patch.
> > >=20
> > > I had successfully applied the previous one, but not yet had time
> > > to test it, but this one I cannot apply.
> > >=20
> > > On which branch/tag does it apply ?
> >=20
> > I am using testing branch from linux-iio tree:
> >=20
> > git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> >=20
> > Regards,
> > Lorenzo
>=20
> I have fetched it with :
>=20
>   git fetch https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git=
 +testing
>=20
> git am complains with :
>  $ git am ~/st_lsm6dsx-real.patch
>  Applying: iio: imu: st_lsm6dsx: discard samples during filters settling =
time
>  error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:137
>  error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h: patch does not apply
>  error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:457
>  error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: patch does not ap=
ply
>  error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:634
>  error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c: patch does not apply
>  Patch failed at 0001 iio: imu: st_lsm6dsx: discard samples during filter=
s settling time
>  hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>  When you have resolved this problem, run "git am --continue".
>  If you prefer to skip this patch, run "git am --skip" instead.
>  To restore the original branch and stop patching, run "git am --abort".
>=20
> and patch -p1 with :
>  $ patch -p1 < ~/st_lsm6dsx-real.patch
>  patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>  Hunk #1 succeeded at 144 with fuzz 2 (offset 7 lines).
>  Hunk #2 FAILED at 298.
>  Hunk #3 FAILED at 330.
>  Hunk #4 FAILED at 360.
>  Hunk #5 FAILED at 374.
>  4 out of 5 hunks FAILED -- saving rejects to file drivers/iio/imu/st_lsm=
6dsx/st_lsm6dsx.h.rej
>  patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>  Hunk #1 FAILED at 457.
>  Hunk #2 FAILED at 541.
>  Hunk #3 succeeded at 673 with fuzz 1 (offset 19 lines).
>  Hunk #4 FAILED at 692.
>  3 out of 4 hunks FAILED -- saving rejects to file drivers/iio/imu/st_lsm=
6dsx/st_lsm6dsx_buffer.c.rej
>  patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>  Hunk #1 FAILED at 634.
>  1 out of 1 hunk FAILED -- saving rejects to file drivers/iio/imu/st_lsm6=
dsx/st_lsm6dsx_core.c.rej
>=20
>=20
> Could it be something caused by your or my mail-transfer-agent ?
>=20
> Best regards
>=20
> Philippe

Can you please try the following branch?

https://github.com/LorenzoBianconi/linux-iio/tree/st_lsm6dsx_discard_sample

Regards,
Lorenzo


--/s99QnNc6VhbVstE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+PbuAAKCRA6cBh0uS2t
rCREAQCGEAPpFpPzzfi5XvJhJUyIpjwZhczG/gH/cDW2bJgnGQEAkqnHpltbNrwN
HYyIlf4Owi2/4SVfqB8efRsLHHzjUAs=
=rpFz
-----END PGP SIGNATURE-----

--/s99QnNc6VhbVstE--
