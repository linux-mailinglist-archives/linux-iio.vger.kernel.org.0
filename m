Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2B431207
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhJRIV1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhJRIV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 04:21:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B34BC06161C;
        Mon, 18 Oct 2021 01:19:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b14so899097plg.2;
        Mon, 18 Oct 2021 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ih3RBieLoZrRq41tfkN5XaoRmWbsikNEeiYV6sLxIhk=;
        b=YWGRvrHTNpLfghmrn90QI6RGaicSiviMe8Fc/GtiDH77ZY1BNLHudbWd19YUFbU91F
         QfQG03VlZArEIymukO9K8eW8I9PFkAax7Dw/297HIGWogSRd4XxTlQHJzpjmqCVHpaHO
         cS4pq82Yoo4vOZBUHy4wC5BoZS7omus7lV1Q+rE6+kLmbnP3Y6SqTM9/hE2QDm0QD4uC
         YYDslylGwoBWsyX7ckHhDGy/UohJKDbYpbs1anIdnBTgNJE0qxkrbdw7no5jEWTll6RP
         sIwSejac/Yn/C1SkaJLba+9wdhBkTbBxOKyPawSkHmbjuFbyx5cdcmZ3VKxyJ+tD9Pq7
         acxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ih3RBieLoZrRq41tfkN5XaoRmWbsikNEeiYV6sLxIhk=;
        b=Yrqn6D949wZXaQuD5/nds79hPBgayU3K1fWkRdQzQMR1VIS7o623g1JHsMEKtkxl+0
         Vg5jd/z5Xllk+OLwZLIXcNRJK6YYc5PJpykIGkTWzQ8TwpE48tbLelKB7hKoma9JwjpE
         3RnXb3+zZKdcP7C3PPS9nha8AfupJsUYeEQxieBqRcHnP6JRf5PY8VzYBuxoreUBMcvv
         NGoLenf7+PQk9nS2UAnJh9EdtEU6hgtr1IQ41w2FOYVanSYkmoxKMfOVLkQwRTzpTTrR
         Xml4xaVpgKXAx2isxQGhFxidQYLRPtq+H2yWocHbiqRY4XCeb5QR4LaJKX1UfdPxyP8T
         1TzA==
X-Gm-Message-State: AOAM533jzzfadA2iJNFpJqoik0zQ6y3f0mNhTbNRv/vszG9I3BUsTAYF
        pg9h+3OLCqnRGG5LXN8Nqws=
X-Google-Smtp-Source: ABdhPJwBf/rkqW/hbgV5+h9aJQHs6RVt7vBsmxNs4i/B18cxaef9VX7YOhaFAmDu36/GaLHVaqNtaA==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr25868938plo.2.1634545148846;
        Mon, 18 Oct 2021 01:19:08 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id u11sm12812199pfg.2.2021.10.18.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:19:08 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:19:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Lechner <david@lechnology.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter/counter-sysfs: use sysfs_emit everywhere
Message-ID: <YW0t9mVy6ACZYsXB@shinobu>
References: <20211017190106.3472645-1-david@lechnology.com>
 <YWyyzmNGxWKyKiAD@shinobu>
 <YW0PAq8nB6FcLwZd@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7x66oK6Gc4BHPev"
Content-Disposition: inline
In-Reply-To: <YW0PAq8nB6FcLwZd@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--n7x66oK6Gc4BHPev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 08:06:58AM +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 08:33:34AM +0900, William Breathitt Gray wrote:
> > On Sun, Oct 17, 2021 at 02:01:06PM -0500, David Lechner wrote:
> > > In the counter subsystem, we are already using sysfs_emit(), but there
> > > were a few places where we were still using sprintf() in *_show()
> > > functions. For consistency and added protections, use sysfs_emit()
> > > everywhere.
> > >=20
> > > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > > Signed-off-by: David Lechner <david@lechnology.com>
> >=20
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Thanks, want me to take this directly on top of the previous pull
> request?
>=20
> greg k-h

Yes, that should be a fine path forward for this patch.

Thank you,

William Breathitt Gray

--n7x66oK6Gc4BHPev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFtLd8ACgkQhvpINdm7
VJLKlw//dwTvwDqS+54+e7987THsQg60XmKD2oubwREghsOanqMzNkvxi1PaTipq
rYj5OpCLq4EDWpKVWbECkyydnzWbp1ikzwGy0D6YKxyoJhJYD5mLGCa/arDXIq07
lY8yZD0Ign7R8WpDBW/UTB3iQO+nq/4bwSp8pn2DIEP9e31QH75VijUOa+PxmQwV
jxSaYLNnKj8doEZA6yNongfU6/kTUi3RFqpEeLF9OlP9ndXrvHtdD6RzTEy0caNZ
tyNVbFla9nnm8ab2sWtQb6GAGJukmwg8pv5PlNpMoRUKOH9KFaV2nNl82nIOyfRX
Jq+ZwALy7IwTMcAtnsDn2TPR16rfH7UQF+EG0kL2IJLxWlyO5IqVndOnJkc877p7
c/XkkDv7jy17Gla0XRdvzo3Dq+zlo8/SPMjO/1D7CITBfGlQkLz45WmZdYADSFki
hcbelXngfKtBWHhNx28/mdSVLRjWQ4BSdvr2PmI6p+0Ir4hK0+QtU5TaEtwGplZN
A63d7lCNCmvIhaQ75br6A34DJOUJDvQREUSDLHXg/gSdUst3dfsdayTFzVNfjUqN
S20nlBdKncOaAaoCgEnOXiRiKeDgkbBbxVF5NBoWf1WimL6tbi4Q3i8cZugxOPxd
R3CY81Jv1v5u6qifBg4UKR2SXEsW4I4iNzG9nb2gNqfMsqghLDk=
=LalF
-----END PGP SIGNATURE-----

--n7x66oK6Gc4BHPev--
