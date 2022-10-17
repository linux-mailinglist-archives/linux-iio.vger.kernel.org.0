Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66B601D47
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJQXG1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiJQXGF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 19:06:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A082D15
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 16:05:59 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g130so13792658oia.13
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRhFUpYDdCFXzNwAeX9AE7YYnZJr4Skf+DX1YAOCRLg=;
        b=xMvsAi0Eo3zOIT8ell55VEjTlo+HS97JnBKRZNLn82hZTB6oniQgcrhZLwdzPjqG2Q
         w+u/RjCnh89e57Wqt8eJjrkD2A0qPYv0hZIM3EGfyV8s960v9cNYafgvv6qh9neNtKTc
         EMPHg9A0MAvUNljU8JqeEP9ZsNxdeAGoSFxosR7LhWuEXHnbi3km4I311VYlP8v2917w
         7iyDO05m7U136+uTIFTMvYEreZ2s7go6FOaJnr3WTSL19jfh641sx7YKKWgZtkOUBrfV
         kI1dzzV7V27yPR4rL5IkA75p/IcAutVHH7+MyzfbmV9099dZaxHhopfyZchoGKLbsLqh
         FpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRhFUpYDdCFXzNwAeX9AE7YYnZJr4Skf+DX1YAOCRLg=;
        b=vbFfnW19+YREdjX2ivYjH2X124W6YwO7xR69I+X9ZQ/GQbzs+Ah7CCwJsX9J4jowra
         N7gN7Bzl8ixk0HDk1/WFAzhgC/Z1Zt0PG1D6F66OkuEEB6wVvv24mA2mWytj2ZOwSI+3
         R3EdIZfRNDZhpA3B6gCe2A59bSZ085WCUUuvcQBCbRMVWS2ZaR9vIsAvdVWbHvhwp5v4
         9RxH8xySw5uvIN2OigryzsL2AoTtNKyA2kNDXg5EMLMoxGJ9qtUa0J6Nv1gt9aA3xjnr
         425o6TlC2sigKyCWycO3yJOrlcYBzx5xrXun9JaM4MC19GQWuSuIN0LGWVuhclJBhG7D
         GKDA==
X-Gm-Message-State: ACrzQf1CWKcfC2FF+yYfaHcZZcC9acDoBa1auzV/nR4+jNMbLn4AYPAN
        3CeyNLphhSGaGSyU4pBG3719xlHYKMFTlw==
X-Google-Smtp-Source: AMsMyM6cqHriRGkDbm992oZ034RWQDGZH5WSC4pPMkbP+JDpZrYLU1+CZ2v3uqnhKeozDCGO7pWvkQ==
X-Received: by 2002:aca:5d09:0:b0:354:cca5:920b with SMTP id r9-20020aca5d09000000b00354cca5920bmr14603211oib.197.1666047759744;
        Mon, 17 Oct 2022 16:02:39 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id n132-20020aca408a000000b00342eade43d4sm4843120oia.13.2022.10.17.16.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:02:38 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:02:36 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Message-ID: <Y03fDFm/utBG7r2Q@fedora>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
 <Y02FksmG22a03bcS@fedora>
 <OS0PR01MB5922E7C67CB923D67BBEFCFB86299@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N98NDNZBzOgh8Wpa"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922E7C67CB923D67BBEFCFB86299@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--N98NDNZBzOgh8Wpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 07:58:54PM +0000, Biju Das wrote:
> > Is my understanding correct here? Is the selection between
> > MTCLKA/MTCLKB and MTCLKC/MTCLKD done in software, and should we expose
> > it in sysfs?
>=20
> Yes, we need to expose this to sysfs. Is it same as phase mode?
> Can you please provide an example, if possible how to handle this?
>=20
> Cheers,
> Biju

Tentatively, I think you can handle it the same way as the phase
counting mode by creating a new Counter device extension; the code
should be pretty similar except the name you give it will be different.

William Breathitt Gray

--N98NDNZBzOgh8Wpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY03fDAAKCRC1SFbKvhIj
KxIWAP96AVG3wSZ9A5wZU6E0JP/Z7nTuDVkKXIMgkVsiveHm5gEA861hPJZKaNQ2
N5DLWQ4PWN4UzeHP72jkxpEOxwc8AAA=
=KcpX
-----END PGP SIGNATURE-----

--N98NDNZBzOgh8Wpa--
