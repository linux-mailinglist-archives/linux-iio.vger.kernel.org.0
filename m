Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB116D1765
	for <lists+linux-iio@lfdr.de>; Fri, 31 Mar 2023 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCaG1n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Mar 2023 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCaG1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2023 02:27:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6C1B37B
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 23:27:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i9so21295570wrp.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680244050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5EDfFl2icVB4EnX5DtqiZZdzDKXEjBm/zE1KhkXyeHs=;
        b=ejbv5P7jL7uNDMOJCDJcQ9RSJSXno8utDr6CQ0u1ljsKG5D50B21iRdS68SxeFLxQl
         qfK40a5qLL6tV/7Q88/Ee84LmrA7dPpPjB9J2NZr0D952K8P6+bFEcUbXWfxuxwgePaK
         U/O/0Rk4dRAcJUInLKVkdeavDvMvOfb3lAo67rfyUnU1kgLntOEbuTSuFpbeLhjmkPMR
         AECWAbhno68Iaygzr5GC4g8muQij9RCbzQKkZ2WJ7zFxWZ6q5MMurx+Yw67PUVQiJvqY
         OT/bto5oFOKwzFm4Zn+DXw74qYSd32qoZ9KImOM8GJVqRTDWQgZZb7uw342+cWGTswVw
         pwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680244050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EDfFl2icVB4EnX5DtqiZZdzDKXEjBm/zE1KhkXyeHs=;
        b=KwrN3trH5wY2eUxlmdT0mLz8a2RQ6I1bDF7aT1tpZ8WEK/62iu4d/hyjTzTQ8pe33g
         PL/ygASEVmXyyF454p/PycaNReE0qQPcoY8Cty4QaZm3nz1GXkNsT/KLK6RzqWkPAK6a
         6CuA0xUq3pZuTywdiFX6/LQPrLhLN+BuqpvO28N/XhBLd/56jiaKicSHwS8PMpe9j6TK
         Ej4Sjm58pkxwasJHYkEDRfW2w2aRTA1kmFZzJbPKFvueYiDlf06IDGpzaXyp+KWewX2D
         iavDJyNa/5LBc8+yecs8p+c3hN1NWjA2jy8MnB2mZ9veGdT744FFnJ1fB2+GCQKv+Rrq
         aL9g==
X-Gm-Message-State: AAQBX9cXn89dC2v+bVVkNlSaEfRnQLd89Nq63Kefl5eBOVNOB5mFxkfX
        pz/322GHzMtOrJ+CWvdvKxmszqBVa7m2sKXI
X-Google-Smtp-Source: AKy350aRMxvhSbweqiQBmvX5tBDVsp317emP4e3br66H3oz/oWyo9bHYvIDrwinW5g5iSOidMwdzaw==
X-Received: by 2002:a05:6000:180d:b0:2c5:a38f:ca31 with SMTP id m13-20020a056000180d00b002c5a38fca31mr5593213wrh.7.1680244049476;
        Thu, 30 Mar 2023 23:27:29 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b002c71b4d476asm1222235wrv.106.2023.03.30.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 23:27:29 -0700 (PDT)
Message-ID: <a8b79265bf4ed57dc7c5cbd49da3fd8013168a15.camel@gmail.com>
Subject: Re: [PATCH 1/2] ad7192 driver: fix null pointer dereference in
 probe when populating adc input ranges
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 31 Mar 2023 08:27:28 +0200
In-Reply-To: <50b8c0527f0baf5769f20809daf96a6593998b06.camel@gmail.com>
References: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
         <50b8c0527f0baf5769f20809daf96a6593998b06.camel@gmail.com>
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

On Wed, 2023-03-29 at 17:01 +0200, Nuno S=C3=A1 wrote:
> On Mon, 2023-03-27 at 22:02 +0200, Fabrizio Lamarque wrote:
> > Fix ad7192.c NULL pointer dereference in ad7192_setup() when
> > accessing
> > indio_dev structure while populating input rages, causing a kernel
> > panic.
> > Fixed by calling spi_set_drvdata after indio_dev is allocated.
> >=20
> > Additional details
> >=20
> > Kernel panic log
> > [=C2=A0=C2=A0=C2=A0 5.763067] Unable to handle kernel NULL pointer dere=
ference at
> > virtual address 00000208
> > [...]
> > [=C2=A0=C2=A0=C2=A0 6.265076] [<c063b94c>] (driver_register) from [<c07=
0e59c>]
> > (__spi_register_driver+0xd8/0xe4)
> > [=C2=A0=C2=A0=C2=A0 6.273757]=C2=A0 r5:c0b88c7c r4:00000000
> > [=C2=A0=C2=A0=C2=A0 6.277351] [<c070e4c4>] (__spi_register_driver) from
> > [<c0e4c288>]
> > (ad7192_driver_init+0x20/0x28)
> > [=C2=A0=C2=A0=C2=A0 6.286305]=C2=A0 r9:c107fe00 r8:c107fe00 r7:00000000=
 r6:c0e56854
> > r5:c0e4c268 r4:c40fa000
> > [=C2=A0=C2=A0=C2=A0 6.294070] [<c0e4c268>] (ad7192_driver_init) from [<=
c01023d0>]
> > (do_one_initcall+0x58/0x2ac)
> > [=C2=A0=C2=A0=C2=A0 6.302569] [<c0102378>] (do_one_initcall) from [<c0e=
01594>]
> > (kernel_init_freeable+0x1c4/0x254)
> > [...]
> > [=C2=A0=C2=A0=C2=A0 6.387349] Kernel panic - not syncing: Attempted to =
kill init!
> > exitcode=3D0x0000000b
> > [=C2=A0=C2=A0=C2=A0 6.395049] ---[ end Kernel panic - not syncing: Atte=
mpted to
> > kill
> > init! exitcode=3D0x0000000b ]
> >=20
> > The patch is against the current tree, but it applies without
> > modifications to 5.x (the driver has not changed much since then).
> > Reproduced in kernel version 5.15.x. Newer driver versions are
> > affected by the same issue.
> >=20
> > Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> > the beginning of function ad7192_setup(), but the
> > spi->dev->driver_data member is not initialized here, hence a NULL
> > pointer is returned.
> >=20
> > By comparing every other iio adc driver, whenever there is a call
> > to
> > spi_get_drvdata() there is also one to spi_set_drvdata() within
> > probe
> > function.
> > It should also be noted that the indio_dev structure is accessed
> > just
> > to get the number of bits for the converter, and no other driver
> > calls
> > spi_get_drvdata within probe.
> > After the patch is applied the system boots correctly and the ADC
> > is
> > mapped within sysfs.
> >=20
> > Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> > --- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42=
.646239506
>=20
> Thanks for the fix. This is missing a fixes tag though... With that:
>=20
> Reviewed-by: nuno.sa@analog.com
>=20
>=20

BTW, proper tag being:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


