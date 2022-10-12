Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E715FCA0B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJLRq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLRq6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 13:46:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3093FC1D0
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:46:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r19so2446128qtx.6
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyz/lIUSG70FWic8i45ydzTxNMdUqxKfc9SELXNeLo8=;
        b=okyR7A3m1nTyA6CSsQ4lc8rj24bE8WIzKqRZtHPn4l6nhJwOW5R3AYOgli/stk8Qzi
         806ndj6B/P32W6+qT0bXGHV/eDSr2JiDMMvQ1L/aj1cmm21YUjBdI3P9WmRzaCZC5CKS
         VbxguSdNXoi41m7p//Qhjc1n2XDCTwmqnZ5z8i4RH2am/aus4ZfnRA/gOqoEkpn1uUNl
         29tEi20rg249R9AprQUH7l+DtkSKjfn+tnfmEoAwUp9vYiM2fCMrbe/qksgR8Q61CCh6
         nv1c9UG4tt63FdGt/iW4S4bg0q6X8G2uXLUmXdcTNaL39OmyWe+Mo5Ir8mWIheJquBk1
         TvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyz/lIUSG70FWic8i45ydzTxNMdUqxKfc9SELXNeLo8=;
        b=VMdKcHVEyiCg0WiaJPXw0hdJN5JWbtQAkd2oArBOSxP2rwua0Jk7bTiQm+gK0GCarN
         CMjbM7Fx59ohUOlTYFdK34sfT/2I2DXRLL6bnD5o1QHx/IeXqZhpGiy5xaKaOAu4FCdj
         vM3OqJXe4hBOxS4T7Y4GTLhg2QRgFW4VJJ68lV0O2v0uLuYvECxdfLeJzW436hJZjobz
         3+boXB+5VJuxqunrixzLhJ7qsc4seu2Ho703YPX+Z0VO7fNcamUwI5uTwoo/6tf3vBA5
         bwZ5/3gIxP9HyFPgaEi/zeBT+gh77MUsI8lxg80QWGS1o8cefDkwwO6dXc7xuOuX/AX3
         B4/Q==
X-Gm-Message-State: ACrzQf0nLR8UiMJwo/NMSwkjRP69g2JpI2AVxtw5ucW4kINXVN57ZFVl
        7R5fge/hebDL25PDeH6nXDuQgr+4ExbhRms7iqc=
X-Google-Smtp-Source: AMsMyM4wC6G8QVC5EYiV+vg/uFFB8OcNl8jga6fXEr0n5Fw/3K59SrYxwXpmfqdkrFciV1jsYE9tYSxdm5hOx4EfY9g=
X-Received: by 2002:a05:622a:4204:b0:394:111d:d86f with SMTP id
 cp4-20020a05622a420400b00394111dd86fmr24950258qtb.384.1665596816780; Wed, 12
 Oct 2022 10:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221012151620.1725215-1-nuno.sa@analog.com> <20221012151620.1725215-3-nuno.sa@analog.com>
In-Reply-To: <20221012151620.1725215-3-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Oct 2022 20:46:20 +0300
Message-ID: <CAHp75Vc=TMsFBR8PUb7tifgM_b8foRhiAwy3VEDsX4hTOjKP=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: health: max30100: do not use internal iio_dev lock
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
> The pattern used in this device does not quite fit in the
> iio_device_claim_direct_mode() typical usage. In this case,
> iio_buffer_enabled() was being used not to prevent the raw access but to
> allow it. Hence, let's make use of the new
> iio_device_claim_buffer_mode() API to make sure we stay in buffered mode
> during the complete read.
>
> Note that we are shadowing the error code returned by
> iio_device_claim_buffer_mode() so that we keep the original one
> (-EAGAIN). The reason is that some userspace stack might already be
> relying on this particular code so that we are not taking chances and
> leave it alone.

The above line widths seem a bit arbitrary to me. But I think it's due
to function names in them.
Perhaps you can make them less deviated by shuffling a bit, like
moving "but to" to the next line.

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/health/max30100.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.=
c
> index 2cca5e0519f8..6ac49901c9da 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -387,18 +387,15 @@ static int max30100_read_raw(struct iio_dev *indio_=
dev,
>                  * Temperature reading can only be acquired while engine
>                  * is running
>                  */
> -               mutex_lock(&indio_dev->mlock);
> -
> -               if (!iio_buffer_enabled(indio_dev))

> +               if (iio_device_claim_buffer_mode(indio_dev)) {

I think a summary of replacing error code is good to have here, like

/*
 * Replacing -EBUSY or other error code
 * returned by iio_device_claim_buffer_mode()
 * because user space may rely on the current
 * one.
 */

>                         ret =3D -EAGAIN;
> -               else {
> +               } else {
>                         ret =3D max30100_get_temp(data, val);
>                         if (!ret)
>                                 ret =3D IIO_VAL_INT;
>
> +                       iio_device_release_buffer_mode(indio_dev);
>                 }
> -
> -               mutex_unlock(&indio_dev->mlock);
>                 break;
>         case IIO_CHAN_INFO_SCALE:
>                 *val =3D 1;  /* 0.0625 */

--=20
With Best Regards,
Andy Shevchenko
