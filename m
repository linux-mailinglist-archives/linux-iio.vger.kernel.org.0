Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C75E9E9B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiIZKG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiIZKGa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 06:06:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39E3BC77
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 03:06:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so9373348wrx.9
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=rIn62u31fBZFSqc2ohPoc3QY3U/0LUa67uN6kvBQuh8=;
        b=OHnOUzF/gnX1lZsRY/QdvwvIeFhmuUsI9eGWIC46ABAikwEq8dchPla6i42E3kmvuO
         /3j3cs5W0eUaLnGdgq6GxwQScGVonrgPGM3H631lb73WI4q3GEx8L+C1M+16nYsuTGrF
         WYdAgAQRQxS2mjVnpwyo8ZgRR6E434F5cXl5PLUAb3TNmdHfkuO7xtRiBmqjDTbBrmKE
         qDmSJA6XjXdgHEZuSfO0WWZu3fkE39M9MPwaEk/6frcRcU+X31vaVcB1O11Grq0nyOe1
         yvaaPGPimytMYU8WpHHSwRbFqltpv/m9BpK0EJ5H27vb6P9AaKA0U8Tfc4EvVxtrRWS6
         zkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rIn62u31fBZFSqc2ohPoc3QY3U/0LUa67uN6kvBQuh8=;
        b=n09CANsImTAw/Ogg2ioW5P074nggaH4rkYCP3WRH9FWKuuXe+n8J4vSfjCrVTZZcIu
         ZNov/htqCWjqd/ZA8Wcmky40E04uwJ8EmjrrJGspct/3vHlh1nuQO4EXoqG/2d2+0Y5/
         eo9qVrlv1WiVqYon2xFGP06Gy2z6Ef9weoCVEg8O68FMR/OY7v99U2Dxm80wW6wHdoGg
         OTvS4Sq8GeT98j/iPHZExBp5bKmHDkHXI4fnrnlYaLUQHZSJaaBgouMx2laMrkqvcBjG
         LvyDNWTYFQLt3i7lgnl2Doc8A52w3yLzT85dqeDpawdAAydJpFtvgEcwN0fCJI1/M+VV
         Av9g==
X-Gm-Message-State: ACrzQf3zUeLj/Zi5BpenMGHjBSIqmZJg/BjywzxAiHjRUjJYHja6qUgt
        +mgMLWpp3u9Xw7s+lRGxDLA=
X-Google-Smtp-Source: AMsMyM4p7G0+WM1bWEDReP2y7op1e07dPVoBgVCyv4X18p+WvrrW2gMclGuaTN9b+BI4tHsXNRNpfA==
X-Received: by 2002:a5d:508c:0:b0:228:de49:b808 with SMTP id a12-20020a5d508c000000b00228de49b808mr12529483wrt.23.1664186776357;
        Mon, 26 Sep 2022 03:06:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2f:601:e80a:12c:dd2e:47c1? ([2001:a61:2b2f:601:e80a:12c:dd2e:47c1])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b00228d67db06esm14124906wrk.21.2022.09.26.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:06:15 -0700 (PDT)
Message-ID: <92a9947072e57194fea22ba3551f7ab097b961da.camel@gmail.com>
Subject: Re: [PATCH 13/15] iio: health: max30100: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
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
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Date:   Mon, 26 Sep 2022 12:06:13 +0200
In-Reply-To: <20220924165318.0cf4403e@jic23-huawei>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-14-nuno.sa@analog.com>
         <20220920142319.61557023@xps-13>
         <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <20220920145534.0bdd4e69@xps-13>
         <SJ0PR03MB6778761640C55A5022F40822994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <20220920155305.395dad08@xps-13>
         <1684ca38960d035a0fedd077ed149f524c58f7ff.camel@gmail.com>
         <20220920171033.2f9d6d1f@xps-13> <20220924165318.0cf4403e@jic23-huawei>
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

On Sat, 2022-09-24 at 16:53 +0100, Jonathan Cameron wrote:
> On Tue, 20 Sep 2022 17:10:33 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Nuno,
> > 
> > noname.nuno@gmail.com wrote on Tue, 20 Sep 2022 16:56:01 +0200:
> > 
> > > On Tue, 2022-09-20 at 15:53 +0200, Miquel Raynal wrote:  
> > > > Hi Nuno,
> > > > 
> > > > Nuno.Sa@analog.com wrote on Tue, 20 Sep 2022 13:15:32 +0000:
> > > >     
> > > > > > -----Original Message-----
> > > > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > Sent: Tuesday, September 20, 2022 2:56 PM
> > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > Cc: linux-arm-kernel@lists.infradead.org;
> > > > > > linux-rockchip@lists.infradead.org;
> > > > > > linux-amlogic@lists.infradead.org; linux-imx@nxp.com;
> > > > > > linux-
> > > > > > iio@vger.kernel.org; Chunyan Zhang <zhang.lyra@gmail.com>;
> > > > > > Hennerich,
> > > > > > Michael <Michael.Hennerich@analog.com>; Martin Blumenstingl
> > > > > > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > > > > > <s.hauer@pengutronix.de>; Cixi Geng
> > > > > > <cixi.geng1@unisoc.com>;
> > > > > > Kevin
> > > > > > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy
> > > > > > <vz@mleia.com>;
> > > > > > Pengutronix Kernel Team <kernel@pengutronix.de>; Alexandru
> > > > > > Ardelean
> > > > > > <aardelean@deviqon.com>; Fabio Estevam
> > > > > > <festevam@gmail.com>;
> > > > > > Andriy
> > > > > > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>; Haibo
> > > > > > Chen
> > > > > > <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Hans
> > > > > > de
> > > > > > Goede <hdegoede@redhat.com>; Jerome Brunet
> > > > > > <jbrunet@baylibre.com>;
> > > > > > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > > > > > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > > > > > <Ciprian.Regus@analog.com>; Lars-Peter Clausen
> > > > > > <lars@metafoo.de>;
> > > > > > Andy
> > > > > > Shevchenko <andy.shevchenko@gmail.com>; Jonathan Cameron
> > > > > > <jic23@kernel.org>; Neil Armstrong
> > > > > > <narmstrong@baylibre.com>;
> > > > > > Baolin
> > > > > > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > > > > > <jbhayana@google.com>; Chen-Yu Tsai <wens@csie.org>; Orson
> > > > > > Zhai
> > > > > > <orsonzhai@gmail.com>
> > > > > > Subject: Re: [PATCH 13/15] iio: health: max30100: do not
> > > > > > use
> > > > > > internal iio_dev
> > > > > > lock
> > > > > > 
> > > > > > [External]
> > > > > > 
> > > > > > Hi Nuno,
> > > > > > 
> > > > > > Nuno.Sa@analog.com wrote on Tue, 20 Sep 2022 12:44:08
> > > > > > +0000:
> > > > > >       
> > > > > > > > -----Original Message-----
> > > > > > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > > > Sent: Tuesday, September 20, 2022 2:23 PM
> > > > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > > > Cc: linux-arm-kernel@lists.infradead.org; linux-      
> > > > > > rockchip@lists.infradead.org;      
> > > > > > > > linux-amlogic@lists.infradead.org; linux-imx@nxp.com;
> > > > > > > > linux-
> > > > > > > > iio@vger.kernel.org; Chunyan Zhang
> > > > > > > > <zhang.lyra@gmail.com>;      
> > > > > > Hennerich,      
> > > > > > > > Michael <Michael.Hennerich@analog.com>; Martin
> > > > > > > > Blumenstingl
> > > > > > > > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > > > > > > > <s.hauer@pengutronix.de>; Cixi Geng
> > > > > > > > <cixi.geng1@unisoc.com>;
> > > > > > > > Kevin
> > > > > > > > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy
> > > > > > > > <vz@mleia.com>;
> > > > > > > > Pengutronix Kernel Team <kernel@pengutronix.de>;
> > > > > > > > Alexandru      
> > > > > > Ardelean      
> > > > > > > > <aardelean@deviqon.com>; Fabio Estevam
> > > > > > > > <festevam@gmail.com>;     
> > > > > > Andriy      
> > > > > > > > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>;
> > > > > > > > Haibo
> > > > > > > > Chen
> > > > > > > > <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > > > > > > > Hans
> > > > > > > > de
> > > > > > > > Goede <hdegoede@redhat.com>; Jerome Brunet      
> > > > > > <jbrunet@baylibre.com>;      
> > > > > > > > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > > > > > > > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > > > > > > > <Ciprian.Regus@analog.com>; Lars-Peter Clausen
> > > > > > > > <lars@metafoo.de>;      
> > > > > > Andy      
> > > > > > > > Shevchenko <andy.shevchenko@gmail.com>; Jonathan
> > > > > > > > Cameron
> > > > > > > > <jic23@kernel.org>; Neil Armstrong
> > > > > > > > <narmstrong@baylibre.com>;
> > > > > > > > Baolin
> > > > > > > > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > > > > > > > <jbhayana@google.com>; Chen-Yu Tsai <wens@csie.org>;
> > > > > > > > Orson
> > > > > > > > Zhai
> > > > > > > > <orsonzhai@gmail.com>
> > > > > > > > Subject: Re: [PATCH 13/15] iio: health: max30100: do
> > > > > > > > not use
> > > > > > > > internal      
> > > > > > iio_dev      
> > > > > > > > lock
> > > > > > > > 
> > > > > > > > [External]
> > > > > > > > 
> > > > > > > > Hi Nuno,
> > > > > > > >      
> > > > > > > 
> > > > > > > Hi Miquel,
> > > > > > > 
> > > > > > > Thanks for reviewing...
> > > > > > >      
> > > > > > > > nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:19
> > > > > > > > +0200:
> > > > > > > >      
> > > > > > > > > The pattern used in this device does not quite fit in
> > > > > > > > > the
> > > > > > > > > iio_device_claim_direct_mode() typical usage. In this
> > > > > > > > > case,
> > > > > > > > > iio_buffer_enabled() was being used not to prevent
> > > > > > > > > the raw
> > > > > > > > > access but      
> > > > > > to      
> > > > > > > > > allow it. Hence to get rid of the 'mlock' we need to:
> > > > > > > > > 
> > > > > > > > > 1. Use iio_device_claim_direct_mode() to check if
> > > > > > > > > direct
> > > > > > > > > mode can be
> > > > > > > > > claimed and if we can return -EINVAL (as the original
> > > > > > > > > code);
> > > > > > > > > 
> > > > > > > > > 2. Make sure that buffering is not disabled while
> > > > > > > > > doing a
> > > > > > > > > raw read. For
> > > > > > > > > that, we can make use of the local lock that already
> > > > > > > > > exists.
> > > > > > > > > 
> > > > > > > > > While at it, fixed a minor coding style complain...
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/iio/health/max30100.c | 24
> > > > > > > > > +++++++++++++++++------
> > > > > > > > > -
> > > > > > > > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/iio/health/max30100.c      
> > > > > > b/drivers/iio/health/max30100.c      
> > > > > > > > > index ad5717965223..aa494cad5df0 100644
> > > > > > > > > --- a/drivers/iio/health/max30100.c
> > > > > > > > > +++ b/drivers/iio/health/max30100.c
> > > > > > > > > @@ -185,8 +185,19 @@ static int
> > > > > > > > > max30100_buffer_postenable(struct      
> > > > > > > > iio_dev *indio_dev)      
> > > > > > > > >  static int max30100_buffer_predisable(struct iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >  {
> > > > > > > > >         struct max30100_data *data =
> > > > > > > > > iio_priv(indio_dev);
> > > > > > > > > +       int ret;
> > > > > > > > > +
> > > > > > > > > +       /*
> > > > > > > > > +        * As stated in the comment in the read_raw()
> > > > > > > > > function, temperature
> > > > > > > > > +        * can only be acquired if the engine is
> > > > > > > > > running.
> > > > > > > > > As such the mutex
> > > > > > > > > +        * is used to make sure we do not power down
> > > > > > > > > while
> > > > > > > > > doing a      
> > > > > > > > temperature      
> > > > > > > > > +        * reading.
> > > > > > > > > +        */
> > > > > > > > > +       mutex_lock(&data->lock);
> > > > > > > > > +       ret = max30100_set_powermode(data, false);
> > > > > > > > > +       mutex_unlock(&data->lock);
> > > > > > > > > 
> > > > > > > > > -       return max30100_set_powermode(data, false);
> > > > > > > > > +       return ret;
> > > > > > > > >  }
> > > > > > > > > 
> > > > > > > > >  static const struct iio_buffer_setup_ops
> > > > > > > > > max30100_buffer_setup_ops      
> > > > > > = {      
> > > > > > > > > @@ -387,18 +398,17 @@ static int
> > > > > > > > > max30100_read_raw(struct
> > > > > > > > > iio_dev      
> > > > > > > > *indio_dev,      
> > > > > > > > >                  * Temperature reading can only be
> > > > > > > > > acquired
> > > > > > > > > while engine
> > > > > > > > >                  * is running
> > > > > > > > >                  */
> > > > > > > > > -               mutex_lock(&indio_dev->mlock);
> > > > > > > > > -
> > > > > > > > > -               if (!iio_buffer_enabled(indio_dev))
> > > > > > > > > +               if
> > > > > > > > > (!iio_device_claim_direct_mode(indio_dev)) {      
> > > > > > > > 
> > > > > > > > I wonder if this line change here is really needed. I
> > > > > > > > agree
> > > > > > > > the whole
> > > > > > > > construction looks like what
> > > > > > > > iio_device_claim_direct_mode()
> > > > > > > > does but in
> > > > > > > > practice I don't see the point of acquiring any lock
> > > > > > > > here if
> > > > > > > > we just
> > > > > > > > release it no matter what happens right after.
> > > > > > > >      
> > > > > > > 
> > > > > > > I can see that this is odd (at the very least) but AFAIK,
> > > > > > > this
> > > > > > > is the only way
> > > > > > > to safely infer if buffering is enabled or not.
> > > > > > > iio_buffer_enabled() has no
> > > > > > > protection against someone concurrently
> > > > > > > enabling/disabling the
> > > > > > > buffer.      
> > > > > > 
> > > > > > Yes, but this is only relevant if you want to infer that
> > > > > > the
> > > > > > "buffers
> > > > > > are enabled" and be sure that it cannot be otherwise during
> > > > > > the
> > > > > > next
> > > > > > lines until you release the lock. Acquiring a lock, doing
> > > > > > the if
> > > > > > and
> > > > > > then unconditionally releasing the lock, IMHO, does not
> > > > > > make any
> > > > > > sense
> > > > > > (but I'm not a locking guru) because when you enter the
> > > > > > else
> > > > > > clause,
> > > > > > you are not protected anyway, so in both cases all this is
> > > > > > completely
> > > > > > racy.
> > > > > >       
> > > > > 
> > > > > Ahh crap, yes you are right... It is still racy since we can
> > > > > still
> > > > > try to read
> > > > > the temperature with the device powered off. I'm not really
> > > > > sure
> > > > > how to
> > > > > address this. One way could be to just use an internal
> > > > > control
> > > > > variable
> > > > > to reflect the device power state (set/clear on the buffer
> > > > > callbacks) and
> > > > > only use the local lock (completely ditching the call to
> > > > > iio_device_claim_direct_mode())...    
> > > > 
> > > > I tend to prefer this option than the one below.
> > > > 
> > > > I guess your implementation already prevents
> > > > buffer_predisable() to
> > > > run
> > > > thanks to the local lock being held during the operation. Maybe
> > > > we
> > > > should just verify that buffers are enabled from within the
> > > > local
> > > > lock
> > > > being held instead of just acquiring it for the get_temp()
> > > > measure.
> > > > It
> > > > would probably solve the situation here.    
> > > > >     
> > > Not sure if I understood... You mean something like:
> > > 
> > > mutex_lock(&data->lock);
> > > if (!iio_buffer_enabled(indio_dev)) {
> > >         ret = -EINVAL;
> > > } else {
> > >         ret = max30100_get_temp(data, val);
> > >         if (!ret)
> > >                 ret = IIO_VAL_INT;
> > > 
> > > }
> > > mutex_unlock(&data->lock);
> > > 
> > > If so, I think this is still racy since we release the lock after
> > > the
> > > predisable which means we could still detect the buffers as
> > > enabled (in
> > > the above block) and try to get_temp on a powered down device.  
> > 
> > True.
> > 
> > > 
> > > Since we pretty much only care about the power state of the
> > > device (and
> > > we are using the buffering state to infer that AFAIU), I was
> > > thinking
> > > in something like:
> > > 
> > > 
> > > mutex_lock(&data->lock);
> > > if (!data->powered) {
> > >         ret = -EINVAL;
> > > } else {
> > >         ret = max30100_get_temp(data, val);
> > >         if (!ret)
> > >                 ret = IIO_VAL_INT;
> > > 
> > > }
> > > mutex_unlock(&data->lock);  
> > 
> > LGTM.
> 
> A reference counted power up flag would probably work as we'd want to
> disable
> power only when the reference count goes to 0.  Note all checks of
> that flag
> would need to be done under the lock as well.
> 

Is there any way to enable a buffer more than once? Otherwise I'm not
sure we really need a refcount... Any ways, your below approach looks
good to me and surely easier.

> As an alternative...
>  
> Whilst it is a serious oddity, how about flipping the logic and
> having
> an iio_device_claim_buffered_mode() that takes mlock and holds it
> only
> if we are in buffered mode - then holds it until matching release?
> 

This goes along with one of my suggestions:

"A version  iio_device_claim_direct_mode() that does not release the 
lock in case buffering is enabled."

You just gave it a name (and one that I would not ever remember)...

> Now, I've only done a superficial audit of the buffer removal paths
> to check they hold the lock before we call predisable() but it looks

Otherwise I guess we would have to fix it :)


- Nuno Sá
