Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB56D313D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDAONU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAONU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF1B754
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 07:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9096F60B14
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 14:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B23DC433D2;
        Sat,  1 Apr 2023 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680358397;
        bh=iAo1QNdCNmbyE8M0OQ5yY02e+/SCBi1p7Oi4pIiMRdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VvhmQbKnTjgJKCN75SuZcvfxzPYgRkrR5AmAA0T620rGwH4UeTzRcxSkDzzUfRg2p
         t6Z7F1u8dUw3RQ+R+CqI+MA/izpYWL+l4UO6B4S1QDE0mS3IuSplrHVE9JkWOYp22C
         /X35iUJW+d2+UiyqfpMYF6M45MW3D4nwCHkE5YvHkaGmFWlSLvSBqX0QJCFa6go7VZ
         iDZSbWTL49ziKi3Vb1jNzjh2z28mS+Rafxd2U7EO2zw4VmY17r6TmKUMUdjbWCZZQA
         /6WymrWRvEmQXFMsF7Jcv+FP3Y9ng0zeJgoZ/N/CC6aYldRunYMijF7E7ep9RxCeK/
         ORzIlJTJVc/Iw==
Date:   Sat, 1 Apr 2023 15:28:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] ad7192 driver: fix null pointer dereference in
 probe when populating adc input ranges
Message-ID: <20230401152827.179d1a01@jic23-huawei>
In-Reply-To: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
References: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Mar 2023 22:02:48 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> Fix ad7192.c NULL pointer dereference in ad7192_setup() when accessing
> indio_dev structure while populating input rages, causing a kernel
> panic.
> Fixed by calling spi_set_drvdata after indio_dev is allocated.
>=20
> Additional details
>=20
> Kernel panic log
> [    5.763067] Unable to handle kernel NULL pointer dereference at
> virtual address 00000208
> [...]
> [    6.265076] [<c063b94c>] (driver_register) from [<c070e59c>]
> (__spi_register_driver+0xd8/0xe4)
> [    6.273757]  r5:c0b88c7c r4:00000000
> [    6.277351] [<c070e4c4>] (__spi_register_driver) from [<c0e4c288>]
> (ad7192_driver_init+0x20/0x28)
> [    6.286305]  r9:c107fe00 r8:c107fe00 r7:00000000 r6:c0e56854
> r5:c0e4c268 r4:c40fa000
> [    6.294070] [<c0e4c268>] (ad7192_driver_init) from [<c01023d0>]
> (do_one_initcall+0x58/0x2ac)
> [    6.302569] [<c0102378>] (do_one_initcall) from [<c0e01594>]
> (kernel_init_freeable+0x1c4/0x254)
> [...]
> [    6.387349] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b
> [    6.395049] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=3D0x0000000b ]
>=20
> The patch is against the current tree, but it applies without
> modifications to 5.x (the driver has not changed much since then).
> Reproduced in kernel version 5.15.x. Newer driver versions are
> affected by the same issue.
>=20
> Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> the beginning of function ad7192_setup(), but the
> spi->dev->driver_data member is not initialized here, hence a NULL
> pointer is returned.
>=20
> By comparing every other iio adc driver, whenever there is a call to
> spi_get_drvdata() there is also one to spi_set_drvdata() within probe
> function.
> It should also be noted that the indio_dev structure is accessed just
> to get the number of bits for the converter, and no other driver calls
> spi_get_drvdata within probe.
> After the patch is applied the system boots correctly and the ADC is
> mapped within sysfs.

I'd prefer to fix this by changing the ad7192_setup() to take the
struct iio_dev (available at it's call site) and avoid the dance
that is currently going on entirely.
Drop the struct ad7192_state *st parameter and get that via
st =3D iio_priv(indio_dev);

Thanks,

Jonathan


>=20
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> --- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42.6=
46239506 +0100
> +++ linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:33:41.6=
54803797 +0100
> @@ -997,7 +997,7 @@ static int ad7192_probe(struct spi_devic
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82return -ENOMEM;
>=20
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82st =3D iio_priv(indio_dev);
> -
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82spi_set_drvdata(spi, indio_=
dev);
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82mutex_init(&st->lock);
>=20
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82st->avdd =3D devm_regulator=
_get(&spi->dev, "avdd");

