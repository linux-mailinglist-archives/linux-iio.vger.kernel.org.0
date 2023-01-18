Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A68672079
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjARPEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 10:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjARPDp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 10:03:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76436F74B
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 07:02:14 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r71so7566290iod.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFSlJrlky2vAw3bGZpl7Yc3Zqu8itKzSOTxJU1sUyDs=;
        b=xB/YG6ErAkorBupCK2neBx+A7oNrKfOb67Qfoo8QOIaJONJlGcRe+a4FztJpagZ6ir
         jtPxeHNzloH2msRBrnZUx3p5mtdKdEvz4KgvKDBs39jcePEy4g9ggITXXKeR5jUq0sk8
         4H7iNfPJY3rh+P7MgPA9HFg6DbK8HCtQ/4yrSCn7pWOp49MerkwYx6wTfuCsIAgVMCzK
         91iuK6yL/JN5bIdz6gbSN4J+H7UHVhZCSPxm0GrfgJ+ZzkNjWM95XqY77J3Cq1xhTeoq
         iUM681Sum9kLgJx4I4BGiivOc01VohLqLycF8G+Zhp3whK3NXPWdkjWqgaRSS1HQKk/3
         Z3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFSlJrlky2vAw3bGZpl7Yc3Zqu8itKzSOTxJU1sUyDs=;
        b=hxo4sU1zX2QrG6hKOQl//ZDEsCbfFZW0iXbYxCECBAhplmlBvOPlkteBeWaIwGCjF3
         sD3vAsB6hrq22sq6/9iHtNy5gXcnBD58zz3AgqrNKBnClbczFadPuUtk5ReNhaO/owjZ
         ccEeMpc5aCz1q8rNDJMAqzZ5oDkgqfNeEuFdACWAj0O9InJmeApbOd7wINxDvNpFrJx4
         BiW6ghC/Upi6Nlkn41luAnIvDxRGoOarHih9hlknT0zw2Yfsad9vBF5UpSwOX7btlXn9
         QNJrxf1cFvtTPVJC4LUHy105oiFd6tMKwiezzU+Nfkych1pJYDl00i5TZ3qB75HE0kZi
         Cpow==
X-Gm-Message-State: AFqh2kol+iuG+pVVgpnanqhIf68W7wTKcK3HBzWt9XEpHZwS67k8puQC
        0ItujQyCYcewmkoY6u2Tt8zfgQ==
X-Google-Smtp-Source: AMrXdXvI+yd4CdLll7l4TRRe/pWKR0LO9NZcgtbN4mW0LOSAqxaTytI794LRD5/Hl0ZK/vH94Yq0RQ==
X-Received: by 2002:a5d:8502:0:b0:6bc:d71a:570e with SMTP id q2-20020a5d8502000000b006bcd71a570emr5242217ion.16.1674054133648;
        Wed, 18 Jan 2023 07:02:13 -0800 (PST)
Received: from fedora ([185.203.218.253])
        by smtp.gmail.com with ESMTPSA id c9-20020a02a609000000b003a53692d6dbsm2701272jam.124.2023.01.18.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:02:12 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:02:10 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: fix dependency references for config
 MICROCHIP_TCB_CAPTURE
Message-ID: <Y8gJ8lPAg3l3bugb@fedora>
References: <20230118074659.5909-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSsqTeVGGrf4e10X"
Content-Disposition: inline
In-Reply-To: <20230118074659.5909-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--VSsqTeVGGrf4e10X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 08:46:59AM +0100, Lukas Bulwahn wrote:
> Commit dfeef15e73ca ("counter: microchip-tcp-capture: Add appropriate arch
> deps for TCP driver") intends to add appropriate dependencies for the
> config MICROCHIP_TCB_CAPTURE. It however prefixes the intended configs wi=
th
> CONFIG, but in Kconfig files in contrast to source files, the configs are
> referenced to without prefixing them with CONFIG.
>=20
> Fix the dependency references due to this minor misconception.
>=20
> Fixes: dfeef15e73ca ("counter: microchip-tcp-capture: Add appropriate arc=
h deps for TCP driver")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/counter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 90602536fb13..b5ba8fb02cf7 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -63,7 +63,7 @@ config INTERRUPT_CNT
> =20
>  config MICROCHIP_TCB_CAPTURE
>  	tristate "Microchip Timer Counter Capture driver"
> -	depends on CONFIG_SOC_AT91SAM9 || CONFIG_SOC_SAM_V7 || COMPILE_TEST
> +	depends on SOC_AT91SAM9 || SOC_SAM_V7 || COMPILE_TEST
>  	depends on HAS_IOMEM && OF
>  	select REGMAP_MMIO
>  	help
> --=20
> 2.17.1

Applied to counter-next.

William Breathitt Gray

--VSsqTeVGGrf4e10X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8gJ8gAKCRC1SFbKvhIj
K8uNAP9qN+iORDxdNOV4OEqfNM749PKlUtm0pDXR9Sg1YmydHQEAiaD1RnPdcmAD
SAL1qkwRLcVlg8tDcLtndKHqaju05w0=
=I0Ud
-----END PGP SIGNATURE-----

--VSsqTeVGGrf4e10X--
