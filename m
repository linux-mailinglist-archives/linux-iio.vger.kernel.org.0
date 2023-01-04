Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6B65D4A9
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jan 2023 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjADNrO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Jan 2023 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjADNrH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2023 08:47:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F15FCC3
        for <linux-iio@vger.kernel.org>; Wed,  4 Jan 2023 05:47:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vm8so75768010ejc.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2023 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAIQZvW5RZUPmyj2ch5cIK4CvZCcLKlBNu+PBeDorUg=;
        b=feJknn9iKitrlA0+TzXEVxXfTjovGt5bFEBOu+EbuVB9dEm2b6rZxr8uOLi9BZIu7P
         VZfZxQSdamB7YVwfHGB+CHFWJHULpQgUXvW667HDb/UJoULco2O+G2N90jdLV5TeDGdn
         MRvtxvxhwOwPOJkuTO4fI9Q10IesZpYaHRKpuiq0r/W9ojFw4lfEaNTt5lW5uQrEZMKY
         ATwCUPwLyK3wk/JLVZWof0RLagMUyZAjmTWVmHpTKeNbtfcH2NXnbHEZi5ewq8UZm3Ck
         vudTxQTR8eAhPAUFiRRW7zcTQXieDmmBrcsqS3PHjkHcjt5+O+m0/1I3Oljpz/DlnEMe
         vRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAIQZvW5RZUPmyj2ch5cIK4CvZCcLKlBNu+PBeDorUg=;
        b=wJolayzXYQhZHd+kE/YPPf/LboUNvtqOJGehXXH3HlGafrQFPRrt6I9RlCS/ec5sM6
         CEuJA/ghXHmke2wEnRKRt+A9991vyHBNfT4Cste5ufwQe1RbXljXdeOSgSBYQJk92dqC
         Z+3IoUzIFzNPdEu6rPpTgj1L2cPKPrYEHmx2Ft9pWfZf0zpqw25Pfb23QmWcWb+VCJyy
         OgTwYGd4NVurJ3Tnn0OCJ6v0wG3hMLXAQJZw+oQYAr4ZnqZwA15XoEjm3yZgPFWGYX/I
         6TN3OIM/99hiBe7dsCAue4k5omfIfbJu/o6VG7BhP4fBGUzzrED90RM9suSliHLbHHmc
         ilOw==
X-Gm-Message-State: AFqh2kqgeJcRJagBNs+w747M0aUHAhPLyr+itCrPf9X2vsLHs5p+bcnt
        OZECNxnXHD863iXXHtMPurk=
X-Google-Smtp-Source: AMrXdXvK+mbKV68fVIuuT1z9xB5r0NY2Z6+aKcjSL+GBdNzt+Pf4aAqt5AIhm6zXm4dDKgnDcIi6uw==
X-Received: by 2002:a17:907:8dc6:b0:84c:f9b1:f46e with SMTP id tg6-20020a1709078dc600b0084cf9b1f46emr1239106ejc.31.1672840024473;
        Wed, 04 Jan 2023 05:47:04 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709063c0e00b00780b1979adesm15323922ejg.218.2023.01.04.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:47:03 -0800 (PST)
Message-ID: <7a76556496c0a72a54df2eea5813aeac924b1973.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ep93xx: Enable wider build testing with
 COMPILE_TEST
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Date:   Wed, 04 Jan 2023 14:47:02 +0100
In-Reply-To: <20221231144128.489810-1-jic23@kernel.org>
References: <20221231144128.489810-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2022-12-31 at 14:41 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> It is useful to be able to build this driver without needing
> to build support for ARCH_EP93XX.
>=20
> Also add an explicit dependency on HAS_IOMEM so we have
> devm_platform_ioremap_resource() etc available.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> ---
> =C2=A0drivers/iio/adc/Kconfig | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 46c4fc2fc534..7d6e74189a2d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -441,7 +441,8 @@ config ENVELOPE_DETECTOR
> =C2=A0
> =C2=A0config EP93XX_ADC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Cirrus Logic EP=
93XX ADC driver"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX || COMP=
ILE_TEST
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on HAS_IOMEM
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Driver for the ADC=
 module on the EP93XX series of SoC from Cirrus Logic.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It's recommended t=
o switch on CONFIG_HIGH_RES_TIMERS option, in this

--=20
Alexander Sverdlin.

