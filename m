Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03468F338
	for <lists+linux-iio@lfdr.de>; Wed,  8 Feb 2023 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBHQea (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Feb 2023 11:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjBHQe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2023 11:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29E4DE1A
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 08:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD6B061730
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3213C4339C;
        Wed,  8 Feb 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874067;
        bh=E96M5++BhETYBCWBE+9a5HWqYMCyv/BzjH1waIGF8SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADPBV72EuQiGS+txsBTwH5BLSJ3R3xgh9QCSMs8OFo8ZZRdOZ2vD1i42npaOoggQ3
         frD2KQVfdOBDn4mZDUiwF6SUJ6qAT0PIt2MP3MfqcItnlU1Vj2eKwsc/KHuVjeavpG
         UCkt2zlmbWhaT+u0G7YHrkEuo9OOxCFvLGlojQDW19lEKU5Szd17KUgc9PpwyKSbaX
         wiX2MHkInuNo6/mv5JYbHInhMMLyxvUG8ZqyKD9n+J2l2RBNmsCW1wBbnKnBW0fwki
         CpjcBNl2NSRNnqU/dkhuIf/EFuwwrf/fUkKbymTOGNR6RJOMNiOqBGXCyzlynHlFRA
         I3Jc3zDOiuc/w==
Date:   Wed, 8 Feb 2023 17:34:23 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <Y+PPD3iWlw9tdfHS@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
 <20230208162331.GA27875@frolo.macqel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ES69quUh7b1yDuj"
Content-Disposition: inline
In-Reply-To: <20230208162331.GA27875@frolo.macqel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7ES69quUh7b1yDuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo,
>=20
> thank you for your patch.
>=20
> On Wed, Feb 08, 2023 at 03:42:31PM +0100, Lorenzo Bianconi wrote:
> >=20
> > During digital filters settling time the driver is expected to drop
> > samples since they can be corrupted. Introduce the capability to drop
> > a given number of samples according to the configured ODR.
> > Add the sample_to_discard data for LSM6DSM sensor.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
> >  3 files changed, 77 insertions(+), 10 deletions(-)
> >=20
>=20
> I had successfully applied the previous one, but not yet had time
> to test it, but this one I cannot apply.
>=20
> On which branch/tag does it apply ?

I am using testing branch from linux-iio tree:

git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Regards,
Lorenzo

>=20
> Best regards
>=20
> Philippe

--7ES69quUh7b1yDuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+PPDgAKCRA6cBh0uS2t
rOL+AQDUwq3Caamt4H78IudiWWGodn+q/cBU3r9kFEN+fXoWpQEAzZpoGeCDEj5U
fxSqBm2LPcZ3tn2J9VkTHD89IuSU+w0=
=nIr6
-----END PGP SIGNATURE-----

--7ES69quUh7b1yDuj--
