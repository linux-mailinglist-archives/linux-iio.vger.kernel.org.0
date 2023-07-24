Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687475FA72
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGXPK4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXPKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:10:55 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8710D1
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 08:10:53 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so1311677241.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690211453; x=1690816253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1i/tbBQFEoJKnp1LBuoZpNEITwelzpxl1MwROs1heWM=;
        b=ysaJQZhrqwf+AJYp/DatIqi9VO/5opPODx9X5x+WP0SF0M75Z7hNj343fILNJGNB9p
         Kn8QN/zcrqy7tfoXTcSe0QHbQq/F8+rZiY3Uzae/amsJhxH8QTKpx6hkG5RFszYw8Z48
         dHNh5ujWkoVIL5bLU+Knuu1FSWUbz8LR5bWOhAYLUIDV/0KHUrL7EUsnn8Wkn3q073KB
         TTpjxl6r8dRY0RprgxRuFHpHsfw4XZoPAgFeblCSsvulIK1qJdInbgnBwmr/bEchC4nZ
         06YtpkdRDTVq3T4DBjmlDJkAOvQU4aDi1VwMRMx18c/sz/eDuYxunoZe0Piwclvm/Vej
         rvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211453; x=1690816253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i/tbBQFEoJKnp1LBuoZpNEITwelzpxl1MwROs1heWM=;
        b=P+Zi7y9J+YUSscpAiuiX+I6HMd8TYNizbzGVlTzCNgG4pyAimrDgS1ilZKhUy4tFM4
         E8oubk7i4PJ1MYmM2unFhRXDN5TZs9VbG3tA2yFiYSIZ8lrt6zJ76DAXOXjWJYzf7Vsu
         me1GEVGemAPbWitpDq+PByw0f36xKsWhyMdXP38PAZLLZNrg02E/2bYjMzJGDpIVz446
         XQ5YRc3JL9w537EfWwDUQj2AfctJsCf7xfRCEQGCem2tPSBzpBfkpM4IPwtwl2K5mG8e
         vnYzeEDjBJZH0hH8LY47FyOjLKYYlcQVzif/d84Nazp5FLwjPHSW+iUbONvnikS9dZM1
         AsPg==
X-Gm-Message-State: ABy/qLYXA4rKWlxZk3XusUZKjfvsysoP84lUteCfnj1TJbc5lOYOjcVt
        ZHXaB5kJcYCnRtKOvFCUijTVXA==
X-Google-Smtp-Source: APBJJlFn5Q73tj7dnOqCXc/DUujEra76hh3ewQoqQ3+ogBbma1D5zKSEp3mh5Wt7Pk94+7AMMJ4UEA==
X-Received: by 2002:a67:e3cd:0:b0:440:d2f5:e36d with SMTP id k13-20020a67e3cd000000b00440d2f5e36dmr2497092vsm.14.1690211452885;
        Mon, 24 Jul 2023 08:10:52 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id x24-20020a67c098000000b0044360ff4275sm1330384vsi.28.2023.07.24.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:10:52 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:10:49 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: Explicitly include correct DT includes
Message-ID: <ZL6UeZGGqL3oAEL0@fedora>
References: <20230714174357.4053541-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2EoHozUDW1dKat/8"
Content-Disposition: inline
In-Reply-To: <20230714174357.4053541-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2EoHozUDW1dKat/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:43:57AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Queued for counter-next.

Thanks,

William Breathitt Gray

--2EoHozUDW1dKat/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZL6UeQAKCRC1SFbKvhIj
K8FfAQDJjANsGx0TzqvuImQxzjoUMB+DS/fxIBoJaj05DGsrwwEAvExcZz/qzrmT
T+WkSHY0orCAEN5P6kDtENAyLU+Rwg0=
=THNE
-----END PGP SIGNATURE-----

--2EoHozUDW1dKat/8--
