Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1C5F453E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDOQV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDOQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 10:16:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C36D40E15
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 07:16:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g23so8188275qtu.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=0rcb/XYS0+1jVNuI0ke6JUw1K8jrLDic/BJeGiPZcZU=;
        b=Nb7AI8mIaXlDNuelDXhYbWsYeJW32CZ+i/wiXTNn2c5oOjNpGs9iCsAaV2oeWHwLIT
         SDI6UXxNq5F9hvPVXZIqCPA9azMPNmoer5JQ5BhBw4lENgT56h+sZEIZNqjh6V1h4G9P
         Ft+ermQqHufrq0bVKGiDCOYL2ihepTdkQS6JX3I65oJce1DBr8c8tEMELpx20tRGxDBJ
         ldHNm+6KFzizt7EXMaYITIzrfazRilx9TqCnd0eY4Oh+JcbS6OWWef15tjWub3CYFipn
         gHq+13ZNjH9JZWLaR18FnOdwPz3LzXnxEM/ljM4t7s7CEoVf1H5zT3bHpcrTtJZHCd+Z
         b4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0rcb/XYS0+1jVNuI0ke6JUw1K8jrLDic/BJeGiPZcZU=;
        b=4ylV5ABmcx63pknGXUN3iUpRNTzmhmZEx+Ukw8yAmDdssFRtr7f/PP6nXH6iSgRuF3
         3ZYlpyUrEOoaWRQpX97EbABnFMZpfsDZto3N5mANlurOuEZvRlN2XRU1nXl6NdPkiatb
         4DvMIlxUg9xOfSf4GOVKGr4x+qP2EVf3solD9jnZyEdP971IK0RCOGB68VysGJ6lFjar
         scJQvKlmjYSd6wJCPYvwUVfit0kE7CCqhncvOEE2yzGt0NCxymwesuFio3ywADEYfsYn
         c0JvyfdFZPNR8+HnkmuUCtL7rGesZ5yof8Wx184XZVE8DfIIMN0T+Wygzi81dzaIWRSw
         x+2g==
X-Gm-Message-State: ACrzQf2htDdRc1Rzr025cuUnxr+oocTx81e0gE7WaJBxc6M9BgSioWLo
        OlAnJWUwgSHIxN0OpIxd8jUWIvyRm7eo2P0Vsng=
X-Google-Smtp-Source: AMsMyM7UckMfyKNGnzy+FEk+jo3I5YUg5GAscnC6pYd5O5nRkl4Y+yNDu4Z3ZKmu9xtWbxFSZ31qA6hiyWKGgNZp+s8=
X-Received: by 2002:ac8:5e07:0:b0:35c:e7fd:1e94 with SMTP id
 h7-20020ac85e07000000b0035ce7fd1e94mr20055258qtx.384.1664892979300; Tue, 04
 Oct 2022 07:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221004134909.1692021-1-nuno.sa@analog.com> <20221004134909.1692021-16-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-16-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Oct 2022 17:15:43 +0300
Message-ID: <CAHp75VdiAzOUNMB3wD5og-uZi1W_7UWkqV6+s7jCxpaBs1VWRQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] iio: health: max30102: do not use internal
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
> iio_device_claim_direct_mode() typical usage. In this case, we want to
> know if we are in buffered mode or not to know if the device is powered
> (buffer mode) or not. And depending on that max30102_get_temp() will
> power on the device if needed. Hence, in order to keep the same
> functionality, we try to:
>
> 1. Claim Buffered mode;
> 2: If 1) succeeds call max30102_get_temp() without powering on the
>    device;
> 3: Release Buffered mode;
> 4: If 1) fails, Claim Direct mode;
> 5: If 4) succeeds call max30102_get_temp() with powering on the device;
> 6: Release Direct mode;
> 7: If 4) fails, goto to 1) and try again.
>
> This dance between buffered and direct mode is not particularly pretty
> (as well as the loop introduced by the goto statement) but it does allow
> us to get rid of the mlock usage while keeping the same behavior.

...

> +               if (iio_device_claim_buffer_mode(indio_dev)) {

Why is ret not used here?

> +                       /*
> +                        * This one is a *bit* hacky. If we cannot claim =
buffer
> +                        * mode, then try direct mode so that we make sur=
e
> +                        * things cannot concurrently change. And we just=
 keep
> +                        * trying until we get one of the modes...
> +                        */
> +                       if (iio_device_claim_direct_mode(indio_dev))

...and here?

> +                               goto any_mode_retry;

> +               } else {

> +               }

I.o.w. what error code will be visible to the caller and why.

--=20
With Best Regards,
Andy Shevchenko
