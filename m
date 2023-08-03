Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDC76F35E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Aug 2023 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHCTWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Aug 2023 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHCTWd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Aug 2023 15:22:33 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C362BA
        for <linux-iio@vger.kernel.org>; Thu,  3 Aug 2023 12:22:32 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79a31d66002so455156241.3
        for <linux-iio@vger.kernel.org>; Thu, 03 Aug 2023 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691090551; x=1691695351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1T2gH68DArT9FmYrPj9BMhK77ECutQD6S0cdO/cxM0=;
        b=ny84zohfpmzmtt0eYE61+7x5gx6BbdREdY81Vr973udeoVVY8AKYPLmVx1AYaSMEWY
         XJ2rExN7Cuw0Ovhf0XNk0YFt/B3prBwO516BJRAtjOJQASz/AScIZGZ+eUea1mpPeYCh
         MooxQRXVSKGTtu3+8eVEjbEfzjGhCTIYBSI6vMxH8X2x+PpxrzzLwE19Q1ohmXFo11r4
         8N13qe7YqeZ3GCVgksAc+vTJBFn3K29QOMzbulRh/zmJUs8brkfDrFlX7Np6xg6RMlrZ
         STPFouGaVLYBt3A3pbrS9dWIDizU7h31fZugVNxxRpKjMPzf7FSFoDTSM+vImlRNSWXy
         UxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090551; x=1691695351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1T2gH68DArT9FmYrPj9BMhK77ECutQD6S0cdO/cxM0=;
        b=g5X80zz05UIzGyLK/M4Ab3Jnt1mlY7kEIOWPGU3an64ai6rPOXFk1gPia/WWuWwaB9
         bjQ65V7F+hu2+ssX3eyGgLY0SNB0z8wHQs8pmGO26WEl8GjAwhqKUgn6D1UheDrvujRy
         XJV/ylo6K8PEDKsOPzH/7sf/8WFJdLUcvZPiMmQuvBodUr4DhJ7rRkNnpFg64D20bmKf
         J97M/CLFr07Avcx4gHojb85wFkQ/nVyVKa9GpoJiZ7w6UqxeTX62N8t1dJ8Bg7VmRg9B
         TE0A62iZ8Xm/maS1iw9LBuU0JuE9DbrbVz6+3nLKeav2fFYNh+DbmDr/pig0oZJC5/ZR
         wK6g==
X-Gm-Message-State: ABy/qLZdklEddaEWjqPqwipQkxU3cbsKqmnTarnuO7r+eAc9YOOkPAP7
        hatxaqMQ8n40StByTzlucsOliV8IvDxvv08b/h8=
X-Google-Smtp-Source: APBJJlGyfRXQMER1Gt5fDu8Rdp2YZU7so89bf9DIrdnQtZPa3YHIvsOIjX6tpZc0ra1uNwewnbg0Eg==
X-Received: by 2002:a67:fd69:0:b0:444:c644:c231 with SMTP id h9-20020a67fd69000000b00444c644c231mr7199155vsa.12.1691090551551;
        Thu, 03 Aug 2023 12:22:31 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id i19-20020a67c213000000b0044794fe40f3sm81153vsj.21.2023.08.03.12.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:22:30 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:22:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3] counter: rz-mtu3-cnt: Reorder locking sequence for
 consistency
Message-ID: <ZMv+dICGMsWoVpfU@fedora>
References: <20230725154611.227556-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UibedGS5+vaQ13nT"
Content-Disposition: inline
In-Reply-To: <20230725154611.227556-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--UibedGS5+vaQ13nT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 04:46:11PM +0100, Biju Das wrote:
> All functions except rz_mtu3_count_enable_write(), call
> pm_runtime_{get,put} inside the lock. For consistency do the same here.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/r/ZH8Fmom8vZ4DwxqA@duo.ucw.cz
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to counter-next.

Thanks,

William Breathitt Gray

--UibedGS5+vaQ13nT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZMv+dAAKCRC1SFbKvhIj
K/RtAP9TCfM4UxCGQVG1P2aWQTVJHQ5DFEzToiJfx8uI08ecmgD8DF+rWeTgFQSr
oa5KQUHNKF5kxByXX1wGkWAu/9jkIAQ=
=d4Z9
-----END PGP SIGNATURE-----

--UibedGS5+vaQ13nT--
