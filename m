Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291D75A140B
	for <lists+linux-iio@lfdr.de>; Thu, 25 Aug 2022 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiHYOji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Aug 2022 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiHYOjK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2022 10:39:10 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F1B81D1
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2022 07:38:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id q6-20020a4aa886000000b0044b06d0c453so2850845oom.11
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2022 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dD45AotZgawn6j7yXm8vQJ+UE0Dbo/KkcTzZcEiShZk=;
        b=K+RHoh+HUw7Lslc17S1hk0nZmNLDzJbF6N73rs6R1mYJ3SRr9ELrDwFpg8vwZDVZZk
         kWho5V+GGmA/3LXG0xZg/pXSPJIsSxNTZm3LoYXiEWZUz3DwzwEDHf86rQPNrypZ8hNe
         JFIsycyNk6fxTk+XVGjPCwqV5/oFim0dzEXAnh5TQJJ6w7AugQtrZxfVxzxbw8FR07AL
         t/GgwYpeJJPm7NGYhygh5BCUkXY5dG2rGrr2b/kwecVXAfTN/nrvEhWhUhUXtZoEbJl2
         8nf109NW7dKi+crgRh0sRpGxoBzEb/HvWY+Fdrcy3D1FDyxKcIuoDJK70zQ/5RiqyXt4
         H2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dD45AotZgawn6j7yXm8vQJ+UE0Dbo/KkcTzZcEiShZk=;
        b=b7wC0rCSEUlhBXGP7t/PJ+CsX1iD9gzyxeu/x53fV0aC1Jqg7omn+AkimzYd4SD/Hz
         LLM1lAdi0YRgvtdBrSuOomq8/YCyAPtT8oO00k7kls+QamBDJ4fMbJo3xXZqpsO4l50j
         RHI1kKAMW8em7GYyVFoCgEDtJiyr2yuov5pX/q80H2uRJBVBdjpvV9BbxHKqf8oI6bE3
         2zWUECygQOP3xf8xvr61NZ7rMHBAqQ5Kbzm9LOaESsvdEFTSAAnlaCo5s+X1zoNJw10C
         6fTUa/dy5dbMb+49BFHKlNku1k5VnHNtkdg3c+s9MMm79gk/0cdCZu3GXZcio9Bo11Ku
         uhRA==
X-Gm-Message-State: ACgBeo36C3E7kkhhyRqLHptGvHNZIrcpljjTknxJECzWB14cbwudbbcE
        DvWWZGd2n5QvQDfl7RKx1BpKXEZevJ8Cpewf
X-Google-Smtp-Source: AA6agR5b55IUOFFbPyjXVGsBwjiEhvECpdWI/tNtXaH7xbcjDHW403RlhV5oD7vQe80xy+iy4VwRYg==
X-Received: by 2002:a4a:c113:0:b0:435:4ce0:9794 with SMTP id s19-20020a4ac113000000b004354ce09794mr1364871oop.87.1661438293205;
        Thu, 25 Aug 2022 07:38:13 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k19-20020a9d7013000000b0063696cbb6bdsm5196989otj.62.2022.08.25.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:38:12 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:03:43 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] counter: Move symbols into COUNTER namespace
Message-ID: <YweBP30SLb5JMDq0@fedora>
References: <20220815220321.74161-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Awi6TV3gD/mTDbk7"
Content-Disposition: inline
In-Reply-To: <20220815220321.74161-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Awi6TV3gD/mTDbk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 06:03:21PM -0400, William Breathitt Gray wrote:
> Counter subsystem symbols are only relevant to counter drivers. A
> COUNTER namespace is created to control the availability of these
> symbols to modules that import this namespace explicitly.
>=20
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-next branch.

William Breathitt Gray

--Awi6TV3gD/mTDbk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYweBPwAKCRC1SFbKvhIj
Kz8xAQDVpcs6TSh1nCA9NTh9HkIp7VdzcBsSUUucshnYANY8FAEAhqF9QuAzFdoP
jT18GCZH6jgDLd+3tR1jau8IU8doFwI=
=6kcl
-----END PGP SIGNATURE-----

--Awi6TV3gD/mTDbk7--
