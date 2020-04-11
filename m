Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7081A52B2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDKQBf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 12:01:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39710 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDKQBe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 12:01:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id o10so3796043qtr.6;
        Sat, 11 Apr 2020 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhRskEKtP61k0yqbLaLsqJL1DLZl52yNBvZ6bXRfLCM=;
        b=fNxHgv832WDYysIX0jD9QPCDscvmTf43PY81UgQokDRgCjw1x1ogToIhqT4QwC1E/D
         jQV+i9/yOZevJrfP6URcG91dfGR9MznldAw4c9lwIRLy4K+ZkuSns4XOT1z3VBwCqQmU
         XzTzVOGpvddRB382w7EZKk580NNwa5C89GZQQwQRRhXGgvtshGQX/A6MFnVfeYIDEOkX
         dynKyb2bw0spA8bBE2buTF1e2TQArisyj26LhuTWPO95DRiiSIuwlSkiheCCjTpnk4Pp
         lfMpv2u4xMOoIH+aZxcBEnjjJB/c0PWEva93mmt67JDYMVjP1vdZqgNOTnWVAdisd9Bd
         qadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhRskEKtP61k0yqbLaLsqJL1DLZl52yNBvZ6bXRfLCM=;
        b=H2JIFgbt1KbidWeWTLWFrC6FXgPAVzIQx/Lns/9wZUzDiYPEwmYbO7EC3Gyy8uFzGS
         uETzeEX0YJMtyhCD+VpkwXv0R0BdESaNpCEOof1BIiCogrVVbXTW6Dop7SdbeqosFXwt
         aWhdBU8ndi690Gq4jmd/3sqNcGWqS2injdZtcURJpvL2MKxgZvtYQXdY/JmPKWrpSC67
         /RnVxFU8eEcHsj4CIOuTO7Utn3DiHYm5eIb2NMd4x/LGZiVk0aqtfpRaeskCIXxdwAUh
         i/ffZXzI0+g12WWVaLYnbmc/emCaoQTMuBgZ8I40QnBOYM22amSG1cWERMufhw2CW3eo
         Dc1g==
X-Gm-Message-State: AGi0PuZR4EeFl9NBI8T+9MlQ9ZIUuco9AOfKWfelW34n3Hjkf18FfQNO
        9SpHuIxiW9OP1xb84ObI+3s=
X-Google-Smtp-Source: APiQypLVRG/zAWgaDeXS+aPd3v3rXiHthdj4V64zP9c4KydlcwVH+GkllKXLr6/Q5Q4sF7pMJNhTqA==
X-Received: by 2002:aed:3b75:: with SMTP id q50mr4232741qte.23.1586620893939;
        Sat, 11 Apr 2020 09:01:33 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o13sm3853059qkg.111.2020.04.11.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 09:01:32 -0700 (PDT)
Date:   Sat, 11 Apr 2020 12:01:16 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Atmel TCB capture driver
Message-ID: <20200411160116.GA95806@icarus>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2020 at 04:13:58PM +0200, Kamel Bouhara wrote:
> Hello,
>=20
> Here is a new counter driver to support Atmel TCB capture devices.
>=20
> Each SoC has two TCB blocks, each one including three independent
> channels.The following series adds support for two counter modes:
> increase and quadrature decoder.
>=20
> As for the atmel clocksource and pwm, the counter driver needs to fill
> some tcb capabilities in order to operate with the right configuration.
> This is achieved in first patch of this series.
>=20
> Please feel free to comment.
>=20
> Cheers,
>=20
> Changes from v2:
>  - Fixed first patch not applying on mainline
>  - Updated return code to -EINVAL when user is requesting qdec mode on
>    a counter device not supporting it.
>  - Added an error case returning -EINVAL when action edge is performed in
>    qdec mode.
>  - Removed no need to explicity setting ops to NULL from static struct as
>    it is the default value.
>  - Changed confusing code by using snprintf for the sake of clarity.
>  - Changed code to use ARRAY_SIZE so that future reviewers will know
>    that num_counts matches what's in the atmel_tc_count array without
>    having to check so themselves.
>=20
> Kamel Bouhara (3):
>   ARM: at91: add atmel tcb capabilities
>   dt-bindings: counter: atmel-tcb-capture counter
>   counter: Add atmel TCB capture counter
>=20
>  .../bindings/counter/atmel-tcb-capture.yaml   |  35 ++
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/atmel-tcb-capture.c           | 394 ++++++++++++++++++
>  include/soc/at91/atmel_tcb.h                  |   2 +
>  5 files changed, 443 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/atmel-tcb-c=
apture.yaml
>  create mode 100644 drivers/counter/atmel-tcb-capture.c
>=20
> --
> 2.25.0

Thanks Kamel, this version applies nicely now. Fix the error messages
Rob Herring pointed out in the dt-bindings patch and I should be able to
sign off on these.

William Breathitt Gray

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6R6b8ACgkQhvpINdm7
VJJT3hAAtJGYMWuStziOpn3oiehL6iBN7av6JLXQ1xaNk4DP0R6MyU0qGUQJCH27
Cbckx4xNpwUmPK+7tV1NISlzXjBj9hEt3cRoPjf3Sd6Gw2x/F4GDSzbbcPot9KOD
jqQL6HqJ/n9YPv/UYr5NtJ5Joh312TCf0mPdJ//GXWRCG7AzHa6b5CrBfz6bWb4x
ylK0myhYbPEs5ViHlWSC69TUs+rrRqRgmIyJSBuaSukB0JYXFsj7BOMmgV7ymr9t
91Qvf43jmzsXy0F4/lpp5u5d0DliHPhMk7J9LTILIECs7AvOxKB3D0mJSEoq++ws
hugZXe1vbo39+gzf7QD1hEkVHOTwnWSG5wXUXxmjDpPqt7Ic9h1fu+mP3Nd8OLFx
PmCeKyqBgkdQxUAb75Y+YObrgTDnBiWtnn391K0kpwy22aPQ10RzZYSCHY8pBvrB
rkYsQs+KzHgH+/YtGkkohmPAialRUXEdMaGfIC/ZAggQdExxhdgtIEO49gV/yDL/
+Cp4MDfoBlomK4oLX3m1sagP9/Fzh+6yREa2EBajPMn9ZQ692Sy4hQCXfE1pFCs6
1IXRuFXRZFETnyvT+SWcDxbizKYCVm7yCrA0M55tczJvoaDQOC93/i4hNf2aVMaT
glv8dfI+2oNtO+AUclf7F1EX3izFvCqvUD89nuxhKZxfHbKkmJA=
=rbCt
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
