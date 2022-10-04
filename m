Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329455F4539
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJDOOS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDOOR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 10:14:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB460689
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 07:14:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s18so8179152qtx.6
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=maEXSmVmGtXhghuZ9eV9Qu8wIQRINbQBXVMbVoUqxeI=;
        b=eztDnV24HCyqXE2eEiT4owbCvj5y3otJL5kilBQZ6HUxUBVvJ3a9uUUYz7Xe6sOf9Z
         alyHbm4EcyW5T9v6RXsfuUCd2UYwtfnUZshZVbEymIO8vjsriucZjMz6U/5UXwtIqcYo
         jd0eTps+8Z1iHbd2P6hk8Yu1yfUgUZtQkVA2p8zSPp0i99dRrxdPJsXhcuk1JLFGWfnT
         QClXVa66weXSvktQVxwRm0jvlz4sPUrdOkaxh0/kxByZscGYeGn1HdW9/AZJ4/aug1la
         /tSfJwCvzOmyS/+chWg+/Xt/Kixp8OK38UCDPf40STboKG13bkQebXRQ9GPDnDk/Kc1a
         lhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=maEXSmVmGtXhghuZ9eV9Qu8wIQRINbQBXVMbVoUqxeI=;
        b=Rla976fGOOK6q/Hwb36TQRI3fRguWdxx7WmaBr43Dr5tM0oEHMC4zKRc9roQfEvbpK
         jOBnzdMv93v5kvcYyXKKo/+F2mlgTMRgfe6DF3QyjW9ECfAt8nh6Y1b9WZzhbKTygxl6
         ZUBMLm2vWQy3E34mLqG9pmy9zzmBuiLIHRZDYOEg73A7jvfkQazAfCvcTOUpHmhqO4Ls
         SucArM4ZnVGWS8h6uYkgnlarD+9fnWqOa0XtOsqWKSJSv3bpycKC012crNZpq9NcYl0k
         pR/BSwS+ABL61RkrxRoui8mNH3OrxYL8YL8lV1AIAnpbyEfJPKJgwtYmTn8qDZF/wxmC
         e8Gg==
X-Gm-Message-State: ACrzQf0kqk7pDzyIKsEGlEHHdJx5EYZ3gAflfvewPD8wBsgfNKmDbOgN
        IyJ7PwkA46YBeEaADCDat1qA+Np6JwZtkrpFib8=
X-Google-Smtp-Source: AMsMyM4s6DEU5yVCc9twcWThWHGbqWxPTnr1GnFXsCftksCb6kacyWf2VpRgZjkgVAqm2Gje7DT3g5MKoRofGpnyDQQ=
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id
 o3-20020ac87c43000000b0035ccd8f3da5mr19837471qtv.61.1664892855872; Tue, 04
 Oct 2022 07:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221004134909.1692021-1-nuno.sa@analog.com> <20221004134909.1692021-15-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-15-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Oct 2022 17:13:40 +0300
Message-ID: <CAHp75Vfv4BntoDPOo_MXZ33dVEKYj1KW_Ocd5QL_Ez06HJ33iw@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] iio: health: max30100: do not use internal
 iio_dev lock
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
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

On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The pattern used in this device does not quite fit in the
> iio_device_claim_direct_mode() typical usage. In this case,
> iio_buffer_enabled() was being used not to prevent the raw access but to
> allow it. Hence, let's make use of the new
> iio_device_claim_buffer_mode() API to make sure we stay in buffered mode
> during the complete read.

...

> +               if (iio_device_claim_buffer_mode(indio_dev)) {
>                         ret =3D -EAGAIN;

Why is the error code shadowed? Isn't it better to return exactly the
one you resend to the upper caller(s)? Each unclear error code
shadowing should be at least explained.

> +               } else {

>                 }

--=20
With Best Regards,
Andy Shevchenko
