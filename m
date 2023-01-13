Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2466A3A4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jan 2023 20:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAMTsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Jan 2023 14:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMTsQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 14:48:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BC63F51
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 11:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E656230D
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 19:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F33C433D2;
        Fri, 13 Jan 2023 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639293;
        bh=YVuKwW8RwQwik754+RDuBbB5qfXZ+bJZRx3xMneA180=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vjq7fB2wPstJwS+yJ1TINidlcUiS0Ua2/EgKFG7vQVg277iaFBUJn9AeQm8LOV8ee
         Vn+ydtLoLJ5W8d1iEzIC3XlR135ZS4MfVgYhYJqvNegOcGXg5t6arHXruvR8puurp/
         +2URY9EI2UrVr0T5AWiJjFeGjBD5MC0yBC3onZIfeC0rNQTZK2luTxBazIobfKVDAi
         OLWVIhzHAOBZCFYICPPZJ2EFo2SJe1ScqkNh7wXMwn9L/C+wOMlfv4klqqOq1DqyTu
         fsFbGCwgQKDUqJDNUHJilOK+QTM6bBwpGCO4ogNPVkuImjpuEu4CO7mhE8LZ/QQ5nf
         nbrW36g8VEbjQ==
Date:   Fri, 13 Jan 2023 14:48:10 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] counter: Sort the Kconfig entries alphabetically
Message-ID: <Y8G1etp37jYMuClg@ishi>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="80lNO+VyiwS0DL/8"
Content-Disposition: inline
In-Reply-To: <20230108074750.443705-1-pbrobinson@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--80lNO+VyiwS0DL/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2023 at 07:47:47AM +0000, Peter Robinson wrote:
> Sort the Kconfig menu alphabetically to make it easier
> to read as the list grows larger.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to counter-next, thanks.

William Breathitt Gray

--80lNO+VyiwS0DL/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8G1egAKCRC1SFbKvhIj
KybPAP9MIGXz+e8aTcLxMeK7hzdih5tamtyeBnvcp7YQ3LyQHQEA8crJE826lm5H
F7ecqiuoldFcx2mupRNRtJJUyPsaIQQ=
=F2B1
-----END PGP SIGNATURE-----

--80lNO+VyiwS0DL/8--
