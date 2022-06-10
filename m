Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6D54690D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiFJPHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiFJPHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 11:07:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5423B94C;
        Fri, 10 Jun 2022 08:07:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g7so1389468eda.3;
        Fri, 10 Jun 2022 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kUO2ibunC7H0XDsaHRR1RaXa5+TAT1P54T7nymM8aoY=;
        b=Km/6uG4N0I1v3nCHQDOVYyGXyKL6LrNTIbysl2MklDB9UNEDZqbo8NqSGO5sAbe1x3
         1cNbRBqVAX7iALT4cPuZPV2Gy0svte0/yscfFN+g1Ogb2RIQjl6DgOizWWO5fd4eNFOS
         cFHB/CShwbXerNRbAbMaZARMBkStUWNdpK4AI4NeBMKj0sDM63KFgdNX9P/+Dhd1uRNk
         FLcTygnXnEYbzwm+r9bTo4ZY2iUckj/9fDrW+Io2qRDuYMft54iHj9QNjGfcRYMVRQ12
         wfKGJOKpPYgf+b/ciNPTOWTHRSnMg76WfJK7EXdcaCmTVdopl5R4fFUp7H4JdCySKPj5
         iqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kUO2ibunC7H0XDsaHRR1RaXa5+TAT1P54T7nymM8aoY=;
        b=1E/MYMNRrSD350nP3akB/uB5EwrAG1P+InYLpmUbRA9Bx+mjGlb5/VTNSpRgouPfH2
         rGyMC4DpoKtGBxKRbjhzAFnrNjkS3mGvyyQBacNFFzE/dx6jEP4TIcGzqD1bkoYlG69P
         cCWomxgGmR3dkSQ0xMkS6nU21pmBuPO66z1Sma3HxfznyNpvNZ7uqarhXb4Uru1VInQd
         NmjJkR0zToRGI/bc9r4U4YPxHlnsSjYqJTmrwkiGNnhOCysuthaZmL1NVnU0lb/fd40d
         ZFW/VSgvtdw7hFwcqP9G1Q+kvxCyajmjRpHjJWTjxd1nm3j3CpuFkthblO1Tu4YYr/KV
         Ue8g==
X-Gm-Message-State: AOAM530+h6V+DZGwJvOiSB6ksunsZmpROGa+rd2jb2wORmJzBY8d9fga
        Ia2TXCJJfit4aWsOGwy5s8Zq3cLtt9ry57OV+QQ=
X-Google-Smtp-Source: ABdhPJxWp2gvN4Nfk2r+vYkXDxxpanl8SYkus08bByYas8UdfPjxgCPUYO0Y8DTxN4CocSeDaFKMLBbwWkQqK48L8Co=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr51786214edr.209.1654873659584; Fri, 10
 Jun 2022 08:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-24-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-24-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 17:07:03 +0200
Message-ID: <CAHp75VcxZrMM7nHyOYdNMkepbP51Wf4z5botU9ma8+gmn_Lz-w@mail.gmail.com>
Subject: Re: [PATCH 23/34] iio: inkern: split of_iio_channel_get_by_name()
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
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

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This change splits of_iio_channel_get_by_name() so that it decouples
> looking for channels in the current node from looking in it's parents
> nodes. This will be helpful when moving to fwnode properties where we
> need to release the handles when looking for channels in parent's nodes.
>
> No functional change intended...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 69 ++++++++++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 31d9c122199a..dde47324b826 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -211,44 +211,63 @@ static struct iio_channel *of_iio_channel_get(struc=
t device_node *np, int index)
>         return ERR_PTR(err);
>  }
>
> +struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
> +                                                const char *name,
> +                                                bool *parent_lookup)
> +{
> +       struct iio_channel *chan;
> +       int index =3D 0;
> +
> +       /*
> +        * For named iio channels, first look up the name in the
> +        * "io-channel-names" property.  If it cannot be found, the
> +        * index will be an error code, and of_iio_channel_get()
> +        * will fail.
> +        */
> +       if (name)
> +               index =3D of_property_match_string(np, "io-channel-names"=
, name);
> +
> +       chan =3D of_iio_channel_get(np, index);
> +       if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER) {
> +               *parent_lookup =3D false;
> +       } else if (name && index >=3D 0) {
> +               pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +                      np, name ? name : "", index);
> +               *parent_lookup =3D false;
> +       }
> +
> +       return chan;
> +}
> +
>  struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>                                                const char *name)
>  {
>         struct iio_channel *chan;
> +       bool parent_lookup =3D true;
>
>         /* Walk up the tree of devices looking for a matching iio channel=
 */
> +       chan =3D __of_iio_channel_get_by_name(np, name, &parent_lookup);
> +       if (!parent_lookup)
> +               return chan;
> +
> +       /*
> +        * No matching IIO channel found on this node.
> +        * If the parent node has a "io-channel-ranges" property,
> +        * then we can try one of its channels.
> +        */
> +       np =3D np->parent;
>         while (np) {
> -               int index =3D 0;
> -
> -               /*
> -                * For named iio channels, first look up the name in the
> -                * "io-channel-names" property.  If it cannot be found, t=
he
> -                * index will be an error code, and of_iio_channel_get()
> -                * will fail.
> -                */
> -               if (name)
> -                       index =3D of_property_match_string(np, "io-channe=
l-names",
> -                                                        name);
> -               chan =3D of_iio_channel_get(np, index);
> -               if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
> +               if (!of_get_property(np, "io-channel-ranges", NULL))
>                         return chan;
> -               if (name && index >=3D 0) {
> -                       pr_err("ERROR: could not get IIO channel %pOF:%s(=
%i)\n",
> -                               np, name ? name : "", index);
> +
> +               chan =3D __of_iio_channel_get_by_name(np, name, &parent_l=
ookup);
> +               if (!parent_lookup)
>                         return chan;
> -               }
>
> -               /*
> -                * No matching IIO channel found on this node.
> -                * If the parent node has a "io-channel-ranges" property,
> -                * then we can try one of its channels.
> -                */
>                 np =3D np->parent;
> -               if (np && !of_get_property(np, "io-channel-ranges", NULL)=
)
> -                       return chan;
>         }
>
> -       return ERR_PTR(-ENODEV);
> +       return chan;
>  }
>  EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
>
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
