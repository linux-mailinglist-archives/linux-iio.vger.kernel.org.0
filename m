Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2869C9E4
	for <lists+linux-iio@lfdr.de>; Mon, 20 Feb 2023 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBTLbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Feb 2023 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTLbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 06:31:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37814EAD
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 03:31:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68EA160DEB
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 11:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC92C433D2;
        Mon, 20 Feb 2023 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676892693;
        bh=xYiGEHRtgaKWcfS3kkWMt7I879tbd9eUnWGBuSpo79o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9PHM8y+OlP39mjsPjJnzlFIhk6N9b6nK23PvgiD6SWUC1JTMl6Ef+XTCeL6kL2PE
         Yv/moi6mrEC1eifan6RrAdPeYQibKuCrXze1D4B8ossbyn/vrHOoTX58RpfSE7pIpu
         CJWSbsD7xkXP6GhdL+phZq6H2AyEWoi6/T3DZvMcPZx2N2ruYAmot2gQhLkN7BK72K
         KzOVKPdV0Ql9ATCnlN9490tuwYaHmpdLwrJPLBDkSC8O/ND6bYFrWC3H/AkiheX5gA
         99dXgFzXiycIscn9dvCRk0MdDX+aWjIAiB7VMuOEJi1fH4M9FyY7Bn5SWzOmfNadIE
         a4FniZdG/UCeA==
Date:   Mon, 20 Feb 2023 12:31:30 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <Y/NaEvSkSVkTJDUu@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
 <20230218135622.6c5d4569@jic23-huawei>
 <Y/M5feqZB+4JP99M@lore-desk>
 <20230220112811.GA25621@frolo.macqel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZEDKOlY0IJgMTejn"
Content-Disposition: inline
In-Reply-To: <20230220112811.GA25621@frolo.macqel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ZEDKOlY0IJgMTejn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo and Jonathan,
>=20
> On Mon, Feb 20, 2023 at 10:12:29AM +0100, Lorenzo Bianconi wrote:
> > On Sat, Feb 18, 2023 at 01:56:22PM +0000, Jonathan Cameron wrote:
> >=20
> > > On Wed,  8 Feb 2023 15:42:31 +0100
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >=20
> > > > During digital filters settling time the driver is expected to drop
> > > > samples since they can be corrupted. Introduce the capability to dr=
op
> > > > a given number of samples according to the configured ODR.
> > > > Add the sample_to_discard data for LSM6DSM sensor.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > Is this only necessary for the particular sensor you have provided
> > > values for?  Or is it more general?
> > >=20
> > > I think the code will currently just set the number of samples to dis=
card
> > > to 0 for other cases (as no value set for those sensor types).
> > > That's fine if 0 is definitely the right value for those other sensor=
s.
> >=20
> >  I think all the sensors have this information in the datasheet/applica=
tion
> >  note. However, even if we add sample_to_discard just for LSM6DSM for t=
he moment,
> >  we do not introduce any regression for the other sensors with respect =
to the
> >  previous codebase since sample_to_discard will be just set to 0 (so we=
 do not
> >  discard any sample). I can add sample_to_discard for LSM6DSO but at the
> >  moment I do not have other devices for testing.
> >  For LSM6DSO, do you prefer to add it in v2 or is it fine a follow-up p=
atch?
>=20
> How comes your patch really drops samples on my st,ism330dlc IMU ?

LSM6DSM and ISM330DLC share the register map.

Regards,
Lorenzo

>=20
> Best regards
>=20
> Philippe

--ZEDKOlY0IJgMTejn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/NaEQAKCRA6cBh0uS2t
rMxmAP0TaHyutSkcd83ZBWSHxQXfLMizdZZ8ark1ebC2NR4CfQEA3W1y25rYopcD
Ml8K2uP0xpz570yJBR6SWZBXIpgOXA8=
=vcHl
-----END PGP SIGNATURE-----

--ZEDKOlY0IJgMTejn--
