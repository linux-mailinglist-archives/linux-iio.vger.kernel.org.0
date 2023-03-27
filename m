Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436B6CAF54
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0UDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjC0UDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 16:03:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7A100
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 13:03:05 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s19so5911111pgi.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679947385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5Vyacj7zk8g56K1xGjD+ilMAoimLmLqD6/UKNxPpRs=;
        b=Ckr2jyVhRU5qOVNQ9f2GUi/vOrjCS0gOmT3pzDFLuGIt/4ECdvsiISuSu4eo6zy908
         DHfEVVxGU7XhCbVKvtlP7z4P2MQnnkhK8HkxVmvP402xxA7gnXqeLBXtjtB+BwhzX4qS
         JYCGGqncKzlC7MBUwDU86IRQALpkJQRC8+haI9MXurV1DU8pnXAOKUJi7ECI4qpHAhXH
         DuzqiszFvgQMBNSxbT8emF3IF+XW1S90xUrQHJTeBbIbQGjwqlbbMjDeJjiXze5KknfO
         j3HXcvRcaIyBkFHkZp+GrZgGMcELhMudUb5yEHMv+0wHefnS/7kklsbifvkjPd7HKJLa
         1HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5Vyacj7zk8g56K1xGjD+ilMAoimLmLqD6/UKNxPpRs=;
        b=hZOMuRyY9ZN43pTQAAe2RTbKmcgivvFWyW7tINLjsu9Zc8d3AjhOi1OdRchxg5a1JN
         kjMSpouWYanCXVwWCTke2WLXWmXKKJT1Ax+/qvhPHl17bcgSW0MbwohgnDXk9zvQ0kWS
         7uHRgK+rhKHqhtZenBhzKWor6QhpJpAwb0jtZ3iwW2zSJDMlYzszfLIENZqudFiSgsV8
         nn/fenEzBTK89zEu4fJTsZ6GyOpNQdmbp2XzpfXtK/ymAmDcwVa1TKXtCtAz0STQedR/
         LLGboweHIxWHPeuITnNU3tWq1DcIjkFGDrFdpELZN81WfWQWqqgxd0Q8ZVGUFvkMYKyZ
         XblA==
X-Gm-Message-State: AAQBX9dIlJB5TYk06VKNm9Jd5yDbK0CXVn/9A/okNA8P77+BYk/YRUHh
        XaNlPyNEi/bfF8spxj1Pjt+6KfSUDzJlG2p/mLjT0cRcjxBddL0iElk=
X-Google-Smtp-Source: AKy350adQHLabWoW9SLfgZ5gLrjv7shoq9GZVPFZwFxBKCGbf6r/Rbxk9rs7qAkyeHr+Bo/iXTAMoSIv2/K2msqmq7U=
X-Received: by 2002:a05:6a00:99d:b0:5e6:f9a1:e224 with SMTP id
 u29-20020a056a00099d00b005e6f9a1e224mr6907317pfg.6.1679947384840; Mon, 27 Mar
 2023 13:03:04 -0700 (PDT)
MIME-Version: 1.0
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Mon, 27 Mar 2023 22:02:48 +0200
Message-ID: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
Subject: [PATCH 1/2] ad7192 driver: fix null pointer dereference in probe when
 populating adc input ranges
To:     alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix ad7192.c NULL pointer dereference in ad7192_setup() when accessing
indio_dev structure while populating input rages, causing a kernel
panic.
Fixed by calling spi_set_drvdata after indio_dev is allocated.

Additional details

Kernel panic log
[    5.763067] Unable to handle kernel NULL pointer dereference at
virtual address 00000208
[...]
[    6.265076] [<c063b94c>] (driver_register) from [<c070e59c>]
(__spi_register_driver+0xd8/0xe4)
[    6.273757]  r5:c0b88c7c r4:00000000
[    6.277351] [<c070e4c4>] (__spi_register_driver) from [<c0e4c288>]
(ad7192_driver_init+0x20/0x28)
[    6.286305]  r9:c107fe00 r8:c107fe00 r7:00000000 r6:c0e56854
r5:c0e4c268 r4:c40fa000
[    6.294070] [<c0e4c268>] (ad7192_driver_init) from [<c01023d0>]
(do_one_initcall+0x58/0x2ac)
[    6.302569] [<c0102378>] (do_one_initcall) from [<c0e01594>]
(kernel_init_freeable+0x1c4/0x254)
[...]
[    6.387349] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b
[    6.395049] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=3D0x0000000b ]

The patch is against the current tree, but it applies without
modifications to 5.x (the driver has not changed much since then).
Reproduced in kernel version 5.15.x. Newer driver versions are
affected by the same issue.

Pointer to indio_dev structure is obtained via spi_get_drvdata() at
the beginning of function ad7192_setup(), but the
spi->dev->driver_data member is not initialized here, hence a NULL
pointer is returned.

By comparing every other iio adc driver, whenever there is a call to
spi_get_drvdata() there is also one to spi_set_drvdata() within probe
function.
It should also be noted that the indio_dev structure is accessed just
to get the number of bits for the converter, and no other driver calls
spi_get_drvdata within probe.
After the patch is applied the system boots correctly and the ADC is
mapped within sysfs.

Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
--- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42.646=
239506 +0100
+++ linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:33:41.654=
803797 +0100
@@ -997,7 +997,7 @@ static int ad7192_probe(struct spi_devic
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82return -ENOMEM;

 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82st =3D iio_priv(indio_dev);
-
+=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82spi_set_drvdata(spi, indio_de=
v);
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82mutex_init(&st->lock);

 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82st->avdd =3D devm_regulator_g=
et(&spi->dev, "avdd");
