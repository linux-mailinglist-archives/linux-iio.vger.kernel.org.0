Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4375C7BF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGUNZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGUNZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 09:25:26 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF335BE
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 06:25:03 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48147a5f0c0so677657e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689945806; x=1690550606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJKLSQgbfGDYVZ3pM+uTrqvf5A5wz9iUq88ly22Owuk=;
        b=dISXzCgLSPOMphbo/QBJ4Qqi3KMitDsNPhtf19sNt8OTOm1JEFq0sUq/TrmbpFcAP6
         nUj0C/zCMLLY7bqGTsbJDhks0/yslpp26rI6q0gWr4ODORdZJrv28Unzpl9eDKO7bnkN
         ZMupVqbT6z5+C1AAMHNd2Y1ZIPy+wUCueqx5Sb3mAL3lpD4Hr5PgEJv/BSa+PSjZ4rsI
         VlY8AS2iB+ob7qCINlttLj7kk/iy0El1ma8Wx5gBduh5wGZ4gFWu24lH7r4ttjNQygXU
         fXR10uIIVKgguYMBAI9xQwTRrjSu3FUU62l4L1ZDmpb9ea4jlHKD0aXuGlerNCwl05Ca
         E3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689945806; x=1690550606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJKLSQgbfGDYVZ3pM+uTrqvf5A5wz9iUq88ly22Owuk=;
        b=HNxB1Ze7SobgtsxSd0SZdZNzNCl/tFqusjlbuL+57BnWpJ6RMuQ1py+W+Wlx/ljSn4
         PB94QqNnZJB5612FGyei4t3lDvu7y8g2mbmpyDpKEDMkX5gsvdFJoKLpovXR9uOfhIFS
         tIEaHYZQcP4TRN+PAxvPueWKneQgG7Sp6CsrMWbvPVMzD6Xx1AOtSokcVrj8O1XsgoOK
         La1MTRmIMPnM2FQ/Zk5iyuFQonAgL+4m1Zh9UZ4fURY7PR93zURwL6zVm5iTggh/q/al
         5h1yNPZ0Cb9/iePzAeAh2EQc3u30Et5Z6jr2G3A2+YMhr4uxiGX9yhIyNwKy2aOkPZCZ
         Ct5g==
X-Gm-Message-State: ABy/qLY3DfSqZx1aQleQ7dEQPLXPbQtC3fVB943iVMxRqsEPQMefCKtK
        NigK6UtDy6F3g9iBzWiIUnXT1RyhFJfQogBN+QM=
X-Google-Smtp-Source: APBJJlF1w/n2yYmlxuG+SeNwUPflfYnyUFVZaWI44ZfFOuIKEAuwUNjbb6XgfMTnkvAtxiWNIhkesg==
X-Received: by 2002:a1f:eac1:0:b0:483:3303:f8ce with SMTP id i184-20020a1feac1000000b004833303f8cemr608198vkh.9.1689945806349;
        Fri, 21 Jul 2023 06:23:26 -0700 (PDT)
Received: from ishi (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id i12-20020ac5c2cc000000b00483e11d96f3sm432159vkk.23.2023.07.21.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:23:25 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:23:23 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: sysfs-bus-counter: Fix indentation
Message-ID: <ZLqGy3bEW/+xiq4Y@ishi>
References: <20230717120039.164804-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsqNDAR71dHagx8+"
Content-Disposition: inline
In-Reply-To: <20230717120039.164804-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XsqNDAR71dHagx8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 01:00:39PM +0100, Biju Das wrote:
> Fix indentation of the KernelVersion in external_input_phase_clock_
> select_available block.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235=
=2E183132-5-biju.das.jz@bp.renesas.com/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index dc3b3a5c876b..7981dcbda624 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -22,7 +22,7 @@ Description:
>  			phase clock.
> =20
>  What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_sele=
ct_available
> -KernelVersion:  6.4
> +KernelVersion:	6.4
>  Contact:        linux-iio@vger.kernel.org
>  Description:
>                  Discrete set of available values for the respective devi=
ce

The Contact and Description lines also need to be fixed, don't they? It
looks like they are indented using spaces while the other blocks use
tabs.

William Breathitt Gray

--XsqNDAR71dHagx8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZLqGywAKCRC1SFbKvhIj
Kw1TAP93nn7LkOW/EfP1aAzv1AAK2izdqFEEZWJcpAUcMfNTFAD/QiUJJLk7LYez
+EAFtfl9Ac68/Tli5xaxwoAA9Mv3uQE=
=43XA
-----END PGP SIGNATURE-----

--XsqNDAR71dHagx8+--
