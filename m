Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCE570452
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiGKNac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKNab (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:30:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28998B28;
        Mon, 11 Jul 2022 06:30:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p129so8712508yba.7;
        Mon, 11 Jul 2022 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0sVZ6FpyWjxLC64wH2E5WS0xJ0aGx348bLslF3+uvpU=;
        b=lyIFG7SAYwoAADAKuKgohJz2I6b0mA/frIp+sDDz6ivWrNAYvb+FUa5ZRI1zjeYKdo
         xy3rV9d5WpB5os2h20t/w4PiaiJB95rDV2q6GNE5ndNmC7NGq9vAumN8bXjhDBFcSSzX
         sZB1kDCxrlAEwXEcMs7MR3J6GLYQA5QTkFZ/b04mwTcgONL/Dd4hy/fPzM9xRG6Jikia
         5sQjI/xkT9zU0V+UIcNlq6AhmWSphzScqk1q63hIQVO49NH3X6p8Xc9mP/S7m8zePPg4
         XMkRwn/613GZNIAEVumtkkIcnWaDXJ3j8FWhGek/KP1aHtJx9is8FKamNPiKaTHJbgs3
         x6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0sVZ6FpyWjxLC64wH2E5WS0xJ0aGx348bLslF3+uvpU=;
        b=WF2STIEEECA4AtekbM7glDJK6wOZTkAyJYTG5CfDbP+Kj5rlu1v+Js9Tyhqb9wEUvW
         YTvli9QkZHs0BhpVvpjywvzqgq5dPW0IF+E0LA9DktpUU0/TcDORFQXnv+EfEHflny6l
         yreyOcf/L8rVulUJavPb0KKJbzoJReb7ALHbb3dRYhPagHFkTGlgYt807hkeUbU8CCdU
         knymoPiggyTnHpkrAajHu6CMKnQ+DJ9/wIz5c9nyEtrsyYzyWA74idfda0N+Wkzo5aqx
         4HrfWEIdsiPKSqUtCaSrxoW4tjTRQW7faScwviRAdRQeNUKZuLdOcMVr5qTgKVhbaSCV
         NjWA==
X-Gm-Message-State: AJIora/qiOdeiBZ7Kth05PMYmLVvW4bkvOgw7MoJbx2NfL0+sGkwYN0w
        PMaiYoQtqSumRIe1MtMGVjAPMRwDkV8zcqdv1FY=
X-Google-Smtp-Source: AGRyM1tHqLoiz6O/1yVxliXt/Bd51WV6GRUI+Zf2RQmo5ceKZWPxF/RnaqR/V3ox2fqxK2HQ01cV3LlGJ3vA4QUno88=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr17587268ybg.79.1657546229291; Mon, 11
 Jul 2022 06:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123835.811358-1-nuno.sa@analog.com> <20220711123835.811358-4-nuno.sa@analog.com>
In-Reply-To: <20220711123835.811358-4-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:29:53 +0200
Message-ID: <CAHp75VcxcmH5QoheyERAXrUeqMtJidKLBYH1T6dr6vb7yGKqWg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 11, 2022 at 2:38 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all() were
> returning a mix of NULL and pointers with NULL being the way to
> "notify" that we should do a "system" lookup for channels. This make
> it very confusing and prone to errors as commit 9f63cc0921ec
> ("iio: inkern: fix return value in devm_of_iio_channel_get_by_name()")
> proves. On top of this, patterns like 'if (channel !=3D NULL) return
> channel' were being used where channel could actually be an error code
> which makes the code hard to read.
>
> This change also makes some functional changes on how errors were being
> handled. In the original behavior, even if we get an error like '-ENOMEM'=
,
> we still continue with the search. We should only continue to lookup for
> the channel when it makes sense to do so. Hence, the main error handling
> in 'of_iio_channel_get_by_name()' is changed to the following logic:
>
>  * If a channel 'name' is provided and we do find it via
> 'io-channel-names', we should be able to get it. If we get any error,
> we should not proceed with the lookup. Moreover, we should return an erro=
r
> so that callers won't proceed with a system lookup.
>  * If a channel 'name' is provided and we cannot find it ('index < 0'),
> 'of_parse_phandle_with_args()' is expected to fail with '-EINVAL'. Hence,
> we should only continue if we get that error.
>  * If a channel 'name' is not provided we should only carry on with the
> search if 'of_parse_phandle_with_args()' returns '-ENOENT'.
>
> Also note that a system channel lookup is only done if the returned
> error code (from 'of_iio_channel_get_by_name()' or
> 'of_iio_channel_get_all()' is -ENODEV.

LGTM (but I might miss something, it's a bit too many conditionals),
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 54 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 87fd2a0d44f2..c6f1cfe09bd3 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -214,7 +214,7 @@ static struct iio_channel *of_iio_channel_get(struct =
device_node *np, int index)
>  struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>                                                const char *name)
>  {
> -       struct iio_channel *chan =3D NULL;
> +       struct iio_channel *chan;
>
>         /* Walk up the tree of devices looking for a matching iio channel=
 */
>         while (np) {
> @@ -231,13 +231,33 @@ struct iio_channel *of_iio_channel_get_by_name(stru=
ct device_node *np,
>                                                          name);
>                 chan =3D of_iio_channel_get(np, index);
>                 if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
> -                       break;
> -               else if (name && index >=3D 0) {
> -                       pr_err("ERROR: could not get IIO channel %pOF:%s(=
%i)\n",
> -                               np, name ? name : "", index);
> -                       return NULL;
> +                       return chan;
> +               if (name) {
> +                       if (index >=3D 0) {
> +                               pr_err("ERROR: could not get IIO channel =
%pOF:%s(%i)\n",
> +                                      np, name, index);
> +                               /*
> +                                * In this case, we found 'name' in 'io-c=
hannel-names'
> +                                * but somehow we still fail so that we s=
hould not proceed
> +                                * with any other lookup. Hence, explicit=
ly return -EINVAL
> +                                * (maybe not the better error code) so t=
hat the caller
> +                                * won't do a system lookup.
> +                                */
> +                               return ERR_PTR(-EINVAL);
> +                       }
> +                       /* If index < 0, then of_parse_phandle_with_args(=
) fails
> +                        * with -EINVAL which is expected. We should not =
proceed
> +                        * if we get any other error.
> +                        */
> +                       if (PTR_ERR(chan) !=3D -EINVAL)
> +                               return chan;
> +               } else if (PTR_ERR(chan) !=3D -ENOENT) {
> +                       /*
> +                        * if !name, then we should only proceed the look=
up if
> +                        * of_parse_phandle_with_args() returns -ENOENT.
> +                        */
> +                       return chan;
>                 }
> -
>                 /*
>                  * No matching IIO channel found on this node.
>                  * If the parent node has a "io-channel-ranges" property,
> @@ -245,10 +265,10 @@ struct iio_channel *of_iio_channel_get_by_name(stru=
ct device_node *np,
>                  */
>                 np =3D np->parent;
>                 if (np && !of_get_property(np, "io-channel-ranges", NULL)=
)
> -                       return NULL;
> +                       return ERR_PTR(-ENODEV);
>         }
>
> -       return chan;
> +       return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
>
> @@ -267,8 +287,8 @@ static struct iio_channel *of_iio_channel_get_all(str=
uct device *dev)
>                         break;
>         } while (++nummaps);
>
> -       if (nummaps =3D=3D 0)       /* no error, return NULL to search ma=
p table */
> -               return NULL;
> +       if (nummaps =3D=3D 0)
> +               return ERR_PTR(-ENODEV);
>
>         /* NULL terminated array to save passing size */
>         chans =3D kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> @@ -295,7 +315,7 @@ static struct iio_channel *of_iio_channel_get_all(str=
uct device *dev)
>
>  static inline struct iio_channel *of_iio_channel_get_all(struct device *=
dev)
>  {
> -       return NULL;
> +       return ERR_PTR(-ENODEV);
>  }
>
>  #endif /* CONFIG_OF */
> @@ -362,7 +382,7 @@ struct iio_channel *iio_channel_get(struct device *de=
v,
>         if (dev) {
>                 channel =3D of_iio_channel_get_by_name(dev->of_node,
>                                                      channel_name);
> -               if (channel !=3D NULL)
> +               if (!IS_ERR(channel) || PTR_ERR(channel) !=3D -ENODEV)
>                         return channel;
>         }
>
> @@ -412,8 +432,6 @@ struct iio_channel *devm_of_iio_channel_get_by_name(s=
truct device *dev,
>         channel =3D of_iio_channel_get_by_name(np, channel_name);
>         if (IS_ERR(channel))
>                 return channel;
> -       if (!channel)
> -               return ERR_PTR(-ENODEV);
>
>         ret =3D devm_add_action_or_reset(dev, devm_iio_channel_free, chan=
nel);
>         if (ret)
> @@ -436,7 +454,11 @@ struct iio_channel *iio_channel_get_all(struct devic=
e *dev)
>                 return ERR_PTR(-EINVAL);
>
>         chans =3D of_iio_channel_get_all(dev);
> -       if (chans)
> +       /*
> +        * We only want to carry on if the error is -ENODEV.  Anything el=
se
> +        * should be reported up the stack.
> +        */
> +       if (!IS_ERR(chans) || PTR_ERR(chans) !=3D -ENODEV)
>                 return chans;
>
>         name =3D dev_name(dev);
> --
> 2.37.0
>


--=20
With Best Regards,
Andy Shevchenko
