Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E745FC9FB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJLRmH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLRmG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 13:42:06 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CAF87DC
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:42:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o2so3731963qkk.10
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGr4YOrtKswOjzzP3xN+2PhnwfyEQn8bkB6qIni8vh8=;
        b=WeL0cgYMLpxhzch3oF052ucy8+I3ta4eedAGSXAMFvGX1e1us6QlVlxUJHYshI6y1N
         fkGTWG+mK8ZKfF2WftgyQIjbpouK/JFskUgWt1kgOZMTCVi0mw2NxKYrIUYCMP8fhbw3
         F4/H5pm8YCtb5OsSI258LyF+OR31KOXlAz7FqeLtXSrZLF8+FH08H4VbgSuA5uu9eDF5
         DKk8KBUNe6c9YMB0vkgd/e41yJr8tQiHeivii4irw2fsdqd8QKvnD9CXUEwl/ScJxFR5
         Up8JgrLpD8aj2wlcoi3bCuaYREwAK5r0nJgQan6GdUi/2LHowjk3boQduD5qiTppvoNq
         7H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGr4YOrtKswOjzzP3xN+2PhnwfyEQn8bkB6qIni8vh8=;
        b=TBNYn2RD0CTjagFi9JpUfSdp8z/GwDMWtHrwE80T10aMEef/D5K+0JbrPZPQeqh7w3
         aqM4OsIzDckLmXG2UCbvKpj2VWQbrWFVeX0W+WbiKSTj0BE8PVYgqzZ4Niqq1kcPf0aO
         0SRnhGFYIwc9kYwsXSy64gReG8rBqEn792l3tcbtQSNbIQgQLTsOpQx7SleCz183tjhj
         XAEYgBK0NzoOUm1zsdTGSEgu7Z1nF640I+1IyWitwGsxJ653iKrHcxaJmoeT6OU4yS/U
         DpXY88JM1miD4eR6zQjNjGsq903YOl8r+xefisgPMKaazGQuK9AbZqnRI45Zvnb8AFIP
         3dvA==
X-Gm-Message-State: ACrzQf0WwiSxFi/JSerK7ZbPNhR+eFEoazX/rH8fhaefcg9LxFF1FxoM
        IgjIwU2dhmEmSz1Tr7TCMRs0hnDOVG6mlz3Hgmo=
X-Google-Smtp-Source: AMsMyM4Qx0QscVzFMWDT7b+vIsDRKAbiDa7oEGHZc95k537KgzhJXH0oJ//h9mJ0miOA/eNEHszDNx3V+6gTz5bOCpQ=
X-Received: by 2002:ae9:e315:0:b0:6ee:761d:4b8b with SMTP id
 v21-20020ae9e315000000b006ee761d4b8bmr8314124qkf.748.1665596524259; Wed, 12
 Oct 2022 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221012151620.1725215-1-nuno.sa@analog.com> <20221012151620.1725215-2-nuno.sa@analog.com>
In-Reply-To: <20221012151620.1725215-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Oct 2022 20:41:28 +0300
Message-ID: <CAHp75Vc2zz94axxrOb13A71MLTRRt8eLATqJy3CAG-nF253f7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: core: introduce iio_device_{claim|release}_buffer_mode()
 APIs
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 12, 2022 at 6:15 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> These APIs are analogous to iio_device_claim_direct_mode() and
> iio_device_release_direct_mode() but, as the name suggests, with the
> logic flipped. While this looks odd enough, it will have at least two
> users (in following changes) and it will be important to move the iio
> mlock to the private struct.

IIO

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 38 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  2 ++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 151ff3993354..cf80f81e4665 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2083,6 +2083,44 @@ void iio_device_release_direct_mode(struct iio_dev=
 *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
>
> +/**
> + * iio_device_claim_buffer_mode - Keep device in buffer mode
> + * @indio_dev: the iio_dev associated with the device
> + *
> + * If the device is in buffer mode it is guaranteed to stay
> + * that way until iio_device_release_buffer_mode() is called.
> + *
> + * Use with iio_device_release_buffer_mode()

Missed trailing period.

> + *
> + * Returns: 0 on success, -EBUSY on failure

Ditto.

> + */
> +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> +{
> +       mutex_lock(&indio_dev->mlock);
> +
> +       if (iio_buffer_enabled(indio_dev))
> +               return 0;
> +
> +       mutex_unlock(&indio_dev->mlock);
> +       return -EBUSY;
> +}
> +EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
> +
> +/**
> + * iio_device_release_buffer_mode - releases claim on buffer mode
> + * @indio_dev: the iio_dev associated with the device
> + *
> + * Release the claim. Device is no longer guaranteed to stay
> + * in buffer mode.
> + *
> + * Use with iio_device_claim_buffer_mode()

Ditto.

> + */
> +void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
> +{
> +       mutex_unlock(&indio_dev->mlock);
> +}
> +EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
> +
>  /**
>   * iio_device_get_current_mode() - helper function providing read-only a=
ccess to
>   *                                the opaque @currentmode variable
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f0ec8a5e5a7a..9d3bd6379eb8 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -629,6 +629,8 @@ int __devm_iio_device_register(struct device *dev, st=
ruct iio_dev *indio_dev,
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp=
);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> +void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
>
>  extern struct bus_type iio_bus_type;
>
> --
> 2.38.0
>


--=20
With Best Regards,
Andy Shevchenko
