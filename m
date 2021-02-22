Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BD320F41
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhBVBtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 20:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhBVBtn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 20:49:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2107AC061574;
        Sun, 21 Feb 2021 17:49:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 201so2558931pfw.5;
        Sun, 21 Feb 2021 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hebd6uugVGveygY0H7hjLr9kdJP1KXNvKEA6aicEnDM=;
        b=sR31DYeKTcPjOerVBQbZ0rno2hEkGvFGxVuoJ8/bhPDuObgh5A3ykBcF/hY1Bv2WEK
         jyxsSK9OYQedJ4nKyGGJS6NfpxBhBvBinsLW4Ci4B5OSQeBsGwZZWyKqsZ3WZzsyBbne
         v5lmXuOX0BcxUmpa4ibo572JoK3XI1j7lMEwxi9RHKSqy4NSKmFEVftlpPG5utC1Wcov
         Td+3L9DHEYNPEBBzxOpY2ods5G3Obx+BBetoWMfIu5Oy/xKHaZ6N3nk1tyv3RyEZSyPB
         LEFeAOh9obkZwyO12P3bH+0SiI71Byxn3igHYDdcICvc8w+ws/iqe8jkQXdIHd1aMBLb
         2z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hebd6uugVGveygY0H7hjLr9kdJP1KXNvKEA6aicEnDM=;
        b=nnWaoow2J1/YkdeYL2dOtNdnb33PAadDKDVPv2x6mcjGH1Xa/bW5PviN6iRqK459gz
         OGjm7O1oXJ9DRIW20q/WT4K7QwFgQcIQm+IP+WY7qCEXXYCp6DmBJEo1RUTpI4Ew5s7I
         TjtTjAbpOct0AAWWLPPkT7CgtX2x3yt4tA/iSsbYvd3TFmX9LjMQaG7EaaHklvOdvBkL
         kPOMMg9oc5ABUYLzi3cL6ltut9hEXMcfOZMx6iL2iRgN+0TMMSjIzYojKs/ggGzc4ZRl
         81Ppnkr2+xu36e6Ros/J5dDHJTWRhIkRl7+cnpy0gTGoOdNcSZAwzFNiHgEtPPXgPmdd
         GQWA==
X-Gm-Message-State: AOAM532XJCKiP3YFhxHYChb8cuE38Wc0caoTNnYhjyxiEcdTCcYNW+ab
        DmHkPtb9VJIewSKQjX1r9No=
X-Google-Smtp-Source: ABdhPJyyxvuNEFtgbC+oGFs9yHjgmuGvCLzyl7/1VLVUySw8WP7BeltcJ0/YrMsoqDrKT42+4+FT5Q==
X-Received: by 2002:a63:cf05:: with SMTP id j5mr1823111pgg.384.1613958542443;
        Sun, 21 Feb 2021 17:49:02 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id l144sm16346802pfd.104.2021.02.21.17.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 17:49:01 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:48:56 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 0/2] add support for GPIO or IRQ based evemt counter
Message-ID: <YDMNiBjnJKanhTUH@shinobu>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BDjHk8mAMD1tdDzJ"
Content-Disposition: inline
In-Reply-To: <20210216081356.3577-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--BDjHk8mAMD1tdDzJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2021 at 09:13:54AM +0100, Oleksij Rempel wrote:
> changes v6:
> - rename it to interrupt-counter

Hi Oleksij,

Sorry to nitpick again, I think "irq-counter" as Jonathan suggested in
an earlier review would be a better name afterall. Would you be able to
rename this driver to use that name instead?

Sincerely,

William Breathitt Gray

> - driver fixes
> - device tree fixes
>=20
> changes v5:
> - rename it to event counter, since it support different event sources
> - make it work with gpio-only or irq-only configuration
> - update yaml binding
>=20
> changes v4:
> - use IRQ_NOAUTOEN to not enable IRQ by default
> - rename gpio_ from name pattern and make this driver work any IRQ
>   source.
>=20
> changes v3:
> - convert counter to atomic_t
>=20
> changes v2:
> - add commas
> - avoid possible unhandled interrupts in the enable path
> - do not use of_ specific gpio functions
>=20
> Add support for GPIO based pulse counter. For now it can only count
> pulses. With counter char device support, we will be able to attach
> timestamps and measure actual pulse frequency.
>=20
> Never the less, it is better to mainline this driver now (before chardev
> patches go mainline), to provide developers additional use case for the c=
ounter
> framework with chardev support.
>=20
> Oleksij Rempel (2):
>   dt-bindings: counter: add event-counter binding
>   counter: add IRQ or GPIO based event counter
>=20
>  .../bindings/counter/interrupt-counter.yaml   |  62 +++++
>  MAINTAINERS                                   |   7 +
>  drivers/counter/Kconfig                       |  10 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/interrupt-cnt.c               | 249 ++++++++++++++++++
>  5 files changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-c=
ounter.yaml
>  create mode 100644 drivers/counter/interrupt-cnt.c
>=20
> --=20
> 2.29.2
>=20

--BDjHk8mAMD1tdDzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAzDYgACgkQhvpINdm7
VJIgoRAApS74TXDUsKkZQX0zB2tstPlhK4yOcr5po7I8Gqgk7PPCEcVtwBKEGC5y
YfcAXhnz1apn+3DragCbxs1LWPqP8U+TyjOt80k5o8in7YWDlSVPdKTIb5PtUwNJ
EIIEFiwf8qhdW9m7tMo6iePdEx2/OlU6/NSoH6qb6RPCz+5UzetrqyyKSrDSrLGC
P4VykWpSA2IPK0wq5O8kS7pcxB1X4FVSJGNGYXouz3qonPmKw6Q+uaDHNZNhHAxa
T2SLW8lu/cKtB/P7gkHtUqQuOFbG6kkpGJ1MqI+uNN6XpLjd4jg0qO7kLMxaphZv
29T+Mw+H5mzvnMmnsk31JNNUTWj6fLjqqRcuGfXHEizCL1O5KC6mDXt0E1+BNjz+
rM03txQwaNhicXWZvix0EZzRrNT0njRGQzXJkumsDk0teCsFW/8dO50Ab/DbtoVv
V6EtYdbnN4m6BPbQ3vU2IEEEnLrMw32SjEF+2ZaVB7G21iZIFjjrpbCjKvFTT87A
Y2XX7ggGPwfAH97BIgbrGqMD2sds9qPOCcjpsbYeNWsE4fJsRFxd4n9G0tyFZ5Id
XXcyc/ReXdsjzia8nOtXg3GoXrcYkYFQzqSsBb0srpBQeHgBWy0M7ZnOxKJFUmMf
M8HEsF8Q7avqxbpkuPqHIxj5sjQzPU1FcTt3E0CTk4L0SoYXC90=
=w7XY
-----END PGP SIGNATURE-----

--BDjHk8mAMD1tdDzJ--
