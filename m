Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC65EA67D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiIZMsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbiIZMr7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 08:47:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BF132FD9
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 04:23:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t7so9662527wrm.10
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=r9jbf2t4S9tfURAjz1LmPK9yTlvdF5XEAfpfFLoq91g=;
        b=YfWWB6jwsa146FgEmiw1LAreVICf7pG/LuZYNZyO8Yeqx9TvglWFBtstO4fVCzIm+S
         gT+nqamb/MOOovo+1Vrhg+FJOjO1N+TiyYMhvQ0D6ssy9DiQ6oCGwUurquJbn548m5bT
         ZmRHU0m2znfxn2L1F+cSb/Ry5KCuZOLQZt0JUwAwN5PaISAN5DHFEZFv77LaLlgzlKMh
         jY/LQregakItbUefyKj3joTpnep7r8XKRIErxVu5JHHT/iprq/rc5g/VrlSsdxwASg21
         3uRWxmuoxUOlEWcabQss1ltdyT6BNqhUcBSFKdolG+ItRRaO1oT+TZj50xtJHMBps7en
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=r9jbf2t4S9tfURAjz1LmPK9yTlvdF5XEAfpfFLoq91g=;
        b=GFu6XKan7E3G4j6/4rjkCUFhWv6nx+LxBEBJnJG0HAOymTohCOeaxIBed5QnNngZyj
         xI5VkSjGcjONTJzVjrm6hp3kmKnNbKAXa3gc6JwMcvLZJdMi/XOXLz0Nq09oWxbwuyop
         EcDiHPghWpFXgptRcG0EP7LEK9i8r5LJZR5gHcW1T5eUMeBrmUqCeJ0/WSwyq8o8jClP
         Z3pbXWzfit6rrfc5bDhCQ9OrySJAPY9nFeSWLE/56HWQIF9KOABB0iAebcm5U8DpKPf7
         JQ71a6tRpZ65sq9Kqe/pUGlff7UcEHbqeEjHlYoWR9XUqokkQAjkz5umdoZYvrb52TcD
         aB4A==
X-Gm-Message-State: ACrzQf2G6RSEnmbmKgQJkZvfePAZjepBrJHSB0PXCv1WCn+Ldc4vXWvk
        JwVqpJnxMmQ4qxanQJfOc9Y=
X-Google-Smtp-Source: AMsMyM40HEGZmtkeEurcW22ynbOfybXevUnsfX8YnESjzb7cH3kjC5R5+hHsmLEsw2JrV8GryQWJhQ==
X-Received: by 2002:a5d:59a7:0:b0:22a:47e3:a1b with SMTP id p7-20020a5d59a7000000b0022a47e30a1bmr12882406wrr.319.1664191355750;
        Mon, 26 Sep 2022 04:22:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2f:601:e80a:12c:dd2e:47c1? ([2001:a61:2b2f:601:e80a:12c:dd2e:47c1])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003b33de17577sm12471327wmq.13.2022.09.26.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:22:35 -0700 (PDT)
Message-ID: <571f1608ebbe23d7223ce168872d1df4a3b79ad3.camel@gmail.com>
Subject: Re: [PATCH 02/15] iio: adc: ad799x: do not use internal iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Date:   Mon, 26 Sep 2022 13:22:33 +0200
In-Reply-To: <20220924154517.6672e964@jic23-huawei>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-3-nuno.sa@analog.com>
         <20220924154517.6672e964@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2022-09-24 at 15:45 +0100, Jonathan Cameron wrote:
> On Tue, 20 Sep 2022 13:28:08 +0200
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > 'mlock' was being grabbed when setting the device frequency. In
> > order to
> > not introduce any functional change a new lock is added. With that
> > in
> > mind, the lock also needs to be grabbed in the places where 'mlock'
> > is.
> 
> The usage in here is an example of why we originally decided to take
> mlock
> private...  Annoying hard to reason about.  One key thing this
> description
> doesn't mention is protection of st->config vs device state and I
> think
> the original usage of mlock is partly intended to protect that.
> 
> Upshot is I'm not confident enough on this one to be happy taking it
> without
> more head scratching or some review from others!
> 

Yeah, this one is odd enough...

> > 
> > On the other places the lock was being used, we can just drop
> > it since we are only doing one i2c bus read/write which is already
> > safe.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> > ---
> >  drivers/iio/adc/ad799x.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index 262bd7665b33..838ba8e77de1 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/types.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/bitops.h>
> >  
> >  #include <linux/iio/iio.h>
> > @@ -125,6 +126,8 @@ struct ad799x_state {
> >         const struct ad799x_chip_config *chip_config;
> >         struct regulator                *reg;
> >         struct regulator                *vref;
> > +       /* lock to protect against multiple access to the device */
> > +       struct mutex                    lock;
> >         unsigned                        id;
> >         u16                             config;
> >  
> > @@ -290,7 +293,9 @@ static int ad799x_read_raw(struct iio_dev
> > *indio_dev,
> >                 ret = iio_device_claim_direct_mode(indio_dev);
> >                 if (ret)
> >                         return ret;
> > +               mutex_lock(&st->lock);
> 
> If we claim direct mode for the frequency writing we'll avoid racing
> with
> buffers being enabled or other sysfs accesses that are claiming
> direct mode.
> 

As you stated in some other patch, changing the frequency while
buffering is probably not a good idea (possible in some devices though)
but the main reason I haven't used the claim direct approach was
because it would change behavior and could, in theory, break some
userspace apps...

> That made me think we could drop the lock, but the argument gets
> tricker
> around st->config which is used in ad799x_scan_direct() and modified
> in write_event_config() in a fashion that means it could be out of
> sync.
> I'm not sure that matters but it is getting hard to reason about.
> 

The write_event_config() also could use some improvement... Note that
st->config is always written even if ad799x_write_config() fails (which
for some devices is possible). I know that for an i2c write to fail
that probably means we have bigger issues but that does not make it
correct :). We should only update the variable after doing the actual
configuration...

- Nuno Sá
> 
