Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B286CEC4E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjC2PBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjC2PBh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 11:01:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594840DA
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 08:01:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d17so16040744wrb.11
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680102087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FOGdkafo3VSJat34l8jC1ZvhP+306ROd8jjrDWyazic=;
        b=d7At5rha2aoVyKuhcDe+Lqff0Q9T3TQdUAm7TQowTbOvtIYOqn8pBMrp4aClsMO49j
         yP/tC1GBQAEp4DmUzGMS2vJbsAtZrlHm7ooFvyE68WqgHG9Kd+0TdOV9EVI/zIOQiCn+
         zNnIFx/yIRDIpETzbWONSqXTYmpZ9AcWpmmDvsc6Sy1Iq0pelpTZnvXzckSFJqfsaQe6
         JcgdMXNWQeJSATGIHMJ1QcPN70xJlMYUBkgBDTMe5ZD16oMTS1usOumimEA1J5/O9Zvk
         63tVbV6y/pM+9tU7t4JGv11SXHKV4OXaM4EPjZyNn1HNOo7t1rjOGXYR5jJAC5NPSW14
         BY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOGdkafo3VSJat34l8jC1ZvhP+306ROd8jjrDWyazic=;
        b=5iMa3TggnRIYrX54tgMM4l3nGeeoDMWLMQGZt8hITBWpgGo0aYGYmGT6JLIA8rZ9OM
         P0st0mtLOz7sWT3tSzfmFnDDQjew3l+F3eO/j4SN6/3kmsWGMTa3aHSv2XCqo4iHJoSO
         QkB6Q7yOT6CMAHsvAOgu1lrpAezsO8817opFX7mjWgKY2kGuBeOHsjfXNxgfaryY4C8G
         E+nzYQViniMmyexY6DyI3UA1aVIDn0qnIWdSJoCRKDKOkwdcggd5Th847pfIDe+R1zAY
         FTiJPihokTKC7N3rz4j6rod5N5I491K+o/GW4qx1AYItUyv2mTOdR5qe5UDndaE1FtuW
         VyIQ==
X-Gm-Message-State: AAQBX9eekhlEF025dadKGMbAJY55k/D4ct7/pMi3demdfpb9VmBpTAGI
        7fCTVuvq0JrlVQsXGhSvOOs=
X-Google-Smtp-Source: AKy350ZiCllX9RBJ1dj4l0cqG5pLUjoV6WLefROY8yUyR15MaiExVKxT2XDEg+8wrkkoDc0fB+llOA==
X-Received: by 2002:adf:fc8e:0:b0:2d5:39d:514f with SMTP id g14-20020adffc8e000000b002d5039d514fmr16124704wrr.65.1680102087194;
        Wed, 29 Mar 2023 08:01:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002db1b66ea8fsm16985564wrz.57.2023.03.29.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:01:26 -0700 (PDT)
Message-ID: <50b8c0527f0baf5769f20809daf96a6593998b06.camel@gmail.com>
Subject: Re: [PATCH 1/2] ad7192 driver: fix null pointer dereference in
 probe when populating adc input ranges
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org
Date:   Wed, 29 Mar 2023 17:01:26 +0200
In-Reply-To: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
References: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2023-03-27 at 22:02 +0200, Fabrizio Lamarque wrote:
> Fix ad7192.c NULL pointer dereference in ad7192_setup() when
> accessing
> indio_dev structure while populating input rages, causing a kernel
> panic.
> Fixed by calling spi_set_drvdata after indio_dev is allocated.
>=20
> Additional details
>=20
> Kernel panic log
> [=C2=A0=C2=A0=C2=A0 5.763067] Unable to handle kernel NULL pointer derefe=
rence at
> virtual address 00000208
> [...]
> [=C2=A0=C2=A0=C2=A0 6.265076] [<c063b94c>] (driver_register) from [<c070e=
59c>]
> (__spi_register_driver+0xd8/0xe4)
> [=C2=A0=C2=A0=C2=A0 6.273757]=C2=A0 r5:c0b88c7c r4:00000000
> [=C2=A0=C2=A0=C2=A0 6.277351] [<c070e4c4>] (__spi_register_driver) from [=
<c0e4c288>]
> (ad7192_driver_init+0x20/0x28)
> [=C2=A0=C2=A0=C2=A0 6.286305]=C2=A0 r9:c107fe00 r8:c107fe00 r7:00000000 r=
6:c0e56854
> r5:c0e4c268 r4:c40fa000
> [=C2=A0=C2=A0=C2=A0 6.294070] [<c0e4c268>] (ad7192_driver_init) from [<c0=
1023d0>]
> (do_one_initcall+0x58/0x2ac)
> [=C2=A0=C2=A0=C2=A0 6.302569] [<c0102378>] (do_one_initcall) from [<c0e01=
594>]
> (kernel_init_freeable+0x1c4/0x254)
> [...]
> [=C2=A0=C2=A0=C2=A0 6.387349] Kernel panic - not syncing: Attempted to ki=
ll init!
> exitcode=3D0x0000000b
> [=C2=A0=C2=A0=C2=A0 6.395049] ---[ end Kernel panic - not syncing: Attemp=
ted to kill
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
> to get the number of bits for the converter, and no other driver
> calls
> spi_get_drvdata within probe.
> After the patch is applied the system boots correctly and the ADC is
> mapped within sysfs.
>=20
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> --- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42.6=
46239506

Thanks for the fix. This is missing a fixes tag though... With that:

Reviewed-by: nuno.sa@analog.com


