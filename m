Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01675E95F5
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIYUiy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIYUix (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 16:38:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCD26105
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 13:38:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hy2so10272212ejc.8
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=OaZucz9S56qvWBD+7k+kTS+HBw5bFAP+ZtEIWbVKyqM=;
        b=ANwjh5joJXyH4ejpGNMaAJ3riPfbjzUlgYK4IJjrms2EHE2EEK1RzCe6UkNueK1iS0
         FHtA8U/Ow441uBxTv1wq77l0Oig+p1EhlIOCcef+y8/SxpRi3Q7V4lPtr6p3WSJmpKSi
         AsJrje5/+zTsDX54ZD58P7PULoQNlpPUJxWvC7NjARajCYAC45NN4pcjZ6Q09aIefJE4
         aaI2vHdIdgu7sU96Ybk01e6PpHpszqIm5Qvp2JKxBz5Ft2W6pVahvYfwOCwmM3fy2RuZ
         MoRG9qztRLHkMKK2/VxO4qVndsU0Hd/pUcsBlqVh9gEI9JWVl54jxXXWIMsGMy1nRphk
         22Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OaZucz9S56qvWBD+7k+kTS+HBw5bFAP+ZtEIWbVKyqM=;
        b=Mo4CJP5hHJPfv1SPHomBcnyE0wAf34Go3Pi5lNMVjtoW9/tt/qS0UsAhHdsPKjLWCq
         hkrBwCrHAKKe+PEJXgy4v1XyBEpWQvslcbFLekz4DAZRtk1HQ7TpI3fm8ZKKkIh1cXto
         cPZTbtXjFuOSgi5RuUCpQrMlGFThRwXYV3b87Sufxla2ivkF3z9NltpwL2KSsLfv9VQy
         J8KzJBThOZJqtNr2tmmxIqW0NbplyTJgu91M124jIRp2R/dIDch8Zx5cAMgoMEqR40Vs
         p3BWdxR/DKmwYiOP/rGvK262VRCDi6sxlpaDMK9w3o6UFRzpplOc38T6H2d9S+641Imo
         Clzg==
X-Gm-Message-State: ACrzQf2zQDGsDWIAC2owSQMNc4Ya6K5qdut8zQ4vgwMp6r4y2rrHL0iy
        Exq8N/8cQm+6gULc0QRYa70tE4gHlBWdtL2S+Eo=
X-Google-Smtp-Source: AMsMyM41lgm4JdhV6j3MeNw4KpSvvdGBz3YlLhCMoPxernnddViSws8tNDR9uSEoeCJUOb1030SdtqLBkkOMZLgedyI=
X-Received: by 2002:a17:907:7fa0:b0:782:9713:1e with SMTP id
 qk32-20020a1709077fa000b007829713001emr11894538ejc.394.1664138330936; Sun, 25
 Sep 2022 13:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220920112821.975359-1-nuno.sa@analog.com> <20220920112821.975359-8-nuno.sa@analog.com>
In-Reply-To: <20220920112821.975359-8-nuno.sa@analog.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Sep 2022 22:38:39 +0200
Message-ID: <CAFBinCAtAemSFXfBNtn282yxF9YG5zdRcbXYAHS-ygBOEzShcg@mail.gmail.com>
Subject: Re: [PATCH 07/15] iio: adc: meson_saradc: do not use internal iio_dev lock
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
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

On Tue, Sep 20, 2022 at 1:28 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for this patch!
