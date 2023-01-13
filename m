Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705B66A3B2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jan 2023 20:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAMTwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Jan 2023 14:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjAMTwU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 14:52:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA87C3B1
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 11:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD0B5B821E4
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 19:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800ACC433EF;
        Fri, 13 Jan 2023 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639537;
        bh=3OwrAUqKdf8hcD/Nq5Xzbzj0F/V5j82bZlWpkaJXl+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWxDe8xBpfOdJf5S4PpoQyZuqIplXQ866tOsWKjekydl8jumJJ4TOHbRdHYPYDe/s
         GILvirI/It3tAHLJ9hoqYBa1fL+VAt33+4eSnmWmDpEwCO0B2lEhQKVnargz/4Okkx
         5TUYcJ6ijKzvIqa/rk831eJgiMwatw/F3j5EoXgzYvnm11ahxzdIhsfIPj0y60nb5t
         ya6LL29iDu92Kve+fqELtsr5QphAl/Ahlb/FBHXiwRU6vm6YpNGxhbakg84Bir6ILb
         g5r78Jc8Zbp1h3YWqgx1uNf1Fuugk6lhr2TmWEY+aP9mR3fqDkhClSEvx+lm+gFVDZ
         gu8d9DgDFRxAg==
Date:   Fri, 13 Jan 2023 14:52:14 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] counter: intel: Depend on X86
Message-ID: <Y8G2bjAR6JVq/BZi@ishi>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
 <20230108074750.443705-2-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AVx6TAKQ/INecQaA"
Content-Disposition: inline
In-Reply-To: <20230108074750.443705-2-pbrobinson@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--AVx6TAKQ/INecQaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2023 at 07:47:48AM +0000, Peter Robinson wrote:
> Limite the Intel counter driver to X86, it doesn't
> make sense to build it for all arches if the couner

I'll fix the "Limite" and "couner" typos as I pick up this patch.

> subsystem is enabled.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to counter-next, thanks.

William Breathitt Gray

--AVx6TAKQ/INecQaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8G2bgAKCRC1SFbKvhIj
K7LoAP9ft9fu+w3QShjwG17Z3Lnzn0dtOf5Q/FpqGEG8Mv9kawD9GspbNcyP8mmf
RVjg8R4M65i5cPzjdYJi6ZasAW9xqwg=
=WWxl
-----END PGP SIGNATURE-----

--AVx6TAKQ/INecQaA--
