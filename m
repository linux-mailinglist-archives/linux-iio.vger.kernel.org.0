Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7E6614D9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAHLu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHLuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 06:50:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CCDFCC
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 03:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3E160C35
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 11:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17733C433EF;
        Sun,  8 Jan 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673178653;
        bh=QwBoOc7YuuBFw3+HHlEQfOUTuyesHYcwRmg9cdZZ3oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpd5NxFfQXHCeZYqrf3VAQlKTsWiKYTqOsQBFR3K9iqhkcIkll/pJubvriAms5gl5
         0ZzulAFZ+qxdvAVIC9MKocN+RfGFYzXsvNCye1AKCWO5vFkYjGffDsYymOAVBmmp4Z
         gW+nw9qhRqHN/Yax5zlGmgcvxV4DeLqCnuyKKKHayWrisRS9OaLZs9oxPnrHPs46ak
         rVZk41sDLHbLq+F5dzRBkfkk0rtq3BbsxeFIIkaTfE7Uz9t8q6HAbsGGdaR3vxZKnd
         bw6iYNX+hUTFJagUKFumNqENnkOdfEnyIvAT9S7HqHaLcfoWwsPGUIuMZDA42PUk3W
         n+IsVQtS3n6Ig==
Date:   Sun, 8 Jan 2023 12:04:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: [PATCH] iio: adc: ep93xx: Enable wider build testing with
 COMPILE_TEST
Message-ID: <20230108120421.53373301@jic23-huawei>
In-Reply-To: <7a76556496c0a72a54df2eea5813aeac924b1973.camel@gmail.com>
References: <20221231144128.489810-1-jic23@kernel.org>
        <7a76556496c0a72a54df2eea5813aeac924b1973.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 04 Jan 2023 14:47:02 +0100
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> On Sat, 2022-12-31 at 14:41 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > It is useful to be able to build this driver without needing
> > to build support for ARCH_EP93XX.
> >=20
> > Also add an explicit dependency on HAS_IOMEM so we have
> > devm_platform_ioremap_resource() etc available.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Applied.

Thanks,

J

>=20
> > Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> > ---
> > =C2=A0drivers/iio/adc/Kconfig | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 46c4fc2fc534..7d6e74189a2d 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -441,7 +441,8 @@ config ENVELOPE_DETECTOR
> > =C2=A0
> > =C2=A0config EP93XX_ADC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Cirrus Logic =
EP93XX ADC driver"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX || CO=
MPILE_TEST
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on HAS_IOMEM
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Driver for the A=
DC module on the EP93XX series of SoC from Cirrus Logic.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It's recommended=
 to switch on CONFIG_HIGH_RES_TIMERS option, in this =20
>=20

