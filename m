Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB318C1665
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2019 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfI2QzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Sep 2019 12:55:12 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:16987 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfI2QzL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Sep 2019 12:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569776113; x=1601312113;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=x7b6SLeaG9bmKhPMxmT8BEbRRwJk0nI3N/pQdCncVCM=;
  b=im7vmOenWC8h5UPgD4ejuhL8BtsTPWqDoJHV8F6VjTi9vuAEOVBW8XTp
   WbIw5dGZMjNEY2+NokwYuoIfD9tMOJCMfeDmROmjq8HHxLCqOcHPDBEbM
   +ZW5EkNiRjZMspCuPVC0jWHiYz0ga/9bxqvoe+bkhTCYQOcnUs7h/h5GY
   RqpdJnr8nWM5GhUv1xn7p+UvIJP35gRi55qO9deOGte+g/i1g62UKv9Ck
   GRqwzbm51mDXOeJjdbPbJVTvYu1wWGZPZxRS/EQwNzEc/CiCclkzS8fsx
   LAeMS+Fz432ypfiqSOwpv+p2x2pedJBUbOQsTJQu/YPOeBzm+/P66zEgP
   A==;
IronPort-SDR: dSKbp2pH4sBEXhZrJ7LDgLkPWc0RKQmtsVY37M89Ac+F/CnFVcF3lWdRlW/wudOVZ9p683RlBF
 9j/7WaZN7ptuKgBN5IxDb2LsiZYLER6zz8Wvwh9nOwp4onJ7K+Ks4+G02C0OPiHKmv6CROfJoH
 8zb1SCVxbObMSg8YWUFpA65QohLayFuAMBzw3gE3n09jKwdsCUN10rFpioRWI0+Nwtq6Mkfowr
 fv6lKZYvhec7wyvBW/0LlycUvIP2ThLb3rhnQcQ6DFCpsCPiu95+YcrjQRMgaP0OlBYD+b6x1w
 Bek=
IronPort-PHdr: =?us-ascii?q?9a23=3A3HqEgRUKCpXfXIlLKYhFw+uslZbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxOPt8tkgFKBZ4jH8fUM07OQ7/m7HzBYqs/Z7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMYbjZdtJqos1h?=
 =?us-ascii?q?fEoGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI63cokBAPcbPetAoIb9qVkBoxuwCwevGe3h1CNHi2Tq3aEmye?=
 =?us-ascii?q?ktDR3K0BAiEt8IrX/arM/1NKAXUe2tzqbIzDTCb/NL2Tf69YPHcRAhruuNXb?=
 =?us-ascii?q?ltdsfQyUguFwPfgVWRtYDpIz2Y2/8Qs2eH9epsT/yghHM6qwxopDWk28Qiip?=
 =?us-ascii?q?HRi44L1lzJ8T91zYU1KNGiVkJ3fd2pHIFOuy2GK4d7RN4pTXtytyYg0LIGvI?=
 =?us-ascii?q?a2fC0NyJs62RHSc+eHc42U4hL7U+aRPCt4iGpleL2hgxay9lCtyujmWcm11F?=
 =?us-ascii?q?ZGty5FktvRunwU2Rzf9NSLRudn8keu3jaP0A/T6uVaLkwuiaXbLJshzqYxlp?=
 =?us-ascii?q?oVr0vDAjf7lFvqgKKSbEkp+eil5/75brn6pZKQLZF4hh3iPqg2n8ywG+U4Mg?=
 =?us-ascii?q?wAX2iB/uS80aXu/E34QbVKlPI2k7XVvIzUKMkAu662HxVV3pw95BmiEjeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1XPIPD+EPe+jE2gkDZqx/DBJbDhHJrNIWbZkLv7fr?=
 =?us-ascii?q?Zy9VRcyAwtwtBb/Z5UDasBIP2gEnP24frZBR8+NwWvi8PsQPpg15kTETaDD7?=
 =?us-ascii?q?XfMK7Iq3eI4ew1ZeCQMtw7ojH4fskk9f7zijcLmVYcNf24z5seaSjgRdx7KF?=
 =?us-ascii?q?/fbHbx1IRSWVwWtxYzGbS5wGaJViReMjPrB/ox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUAAAc4ZBdf8jQVdFmHAEBAQQBAQw?=
 =?us-ascii?q?EAQGBUwcBAQsBhA8qhCKIHIZSgg+ZJIF7AQgBAQEOLwEBhEACgzgjNAkOAgM?=
 =?us-ascii?q?JAQEFAQEBAQEFBAEBAhABAQkLCwgnhUKCOikBgz0BAQQSEQRSEAsLDQICJgI?=
 =?us-ascii?q?CIhIBBQEcBhMigwCCC59DgQM8iyZ/M4hnAQkNgUgSeigBjA2CF4ERgxI+h0+?=
 =?us-ascii?q?CWASBLwEBAYs/gjGHK5ZJAQYCghAUjE2IPhuZNi2KKJ0EDyOBL4IRMxolfwZ?=
 =?us-ascii?q?ngU5QEBSBWhcVji0kMJEXAQE?=
X-IPAS-Result: =?us-ascii?q?A2EUAAAc4ZBdf8jQVdFmHAEBAQQBAQwEAQGBUwcBAQsBh?=
 =?us-ascii?q?A8qhCKIHIZSgg+ZJIF7AQgBAQEOLwEBhEACgzgjNAkOAgMJAQEFAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQkLCwgnhUKCOikBgz0BAQQSEQRSEAsLDQICJgICIhIBBQEcBhMig?=
 =?us-ascii?q?wCCC59DgQM8iyZ/M4hnAQkNgUgSeigBjA2CF4ERgxI+h0+CWASBLwEBAYs/g?=
 =?us-ascii?q?jGHK5ZJAQYCghAUjE2IPhuZNi2KKJ0EDyOBL4IRMxolfwZngU5QEBSBWhcVj?=
 =?us-ascii?q?i0kMJEXAQE?=
X-IronPort-AV: E=Sophos;i="5.64,563,1559545200"; 
   d="scan'208";a="10867038"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 09:55:12 -0700
Received: by mail-lj1-f200.google.com with SMTP id m8so2296787ljb.3
        for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2019 09:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjNdX3e/FDjYlFzLDAbb3JmD3MBe1ko+MmFn61I90Os=;
        b=oq/wWBXvKOyYZvjQfuxcIelfc7mN4nMqhX6p7cUEnkF3HoEVA9aK0sZuhzcDImDxM8
         G5p1d8gKdAwc+6MJM2QBCtsSZDWKK6TCNU7EC3GzoL2Hsi9XRmgW8WrLATI6yyImnpCY
         tBNiIcZ/UKXuJK3/FDJJA1U5khJwiqAJ5eyqfrfkOx00UYTB84OfHHmruTbP5ZeuIFqa
         SVXkGmwBql02K7DOQPJe5sFtf/ZqieZWpTC8xUkPwcsp8p7stfa8ArDKQnOEXYyzXV53
         2iuPk/1e6gtIi3UPBW9KtOeVTj9DYZIhjKiN9sGjB2gbTJLLG7izjNTzkWo0R0o2SKm8
         eHhQ==
X-Gm-Message-State: APjAAAV9G91cD7pMjaaL4m1BbnpkqnhY75VDX3JNiNr6ndqg6aPub9mC
        XdmoUjseWaQZ/qTS8N2Zwb2iTNROG3DOqqY0q1wyb2hhxIp/nj7lEU5wdq3PMCbmOfkHkqyqlGn
        THQTYPkt2n/yj7VA5bicXwLrLyjXu0kdYyTbm0Q==
X-Received: by 2002:a19:f512:: with SMTP id j18mr9044158lfb.169.1569776108452;
        Sun, 29 Sep 2019 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVzY32Bt/A8gXhlgqzeWJpqc+TMw73XWbverehqqSktg26b6k0t4TG24jtNlhtaPJc/gwb9AQK9KEvS4UtPUg=
X-Received: by 2002:a19:f512:: with SMTP id j18mr9044142lfb.169.1569776108214;
 Sun, 29 Sep 2019 09:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190928004642.28932-1-yzhai003@ucr.edu> <20190928064720.GA24515@osadl.at>
In-Reply-To: <20190928064720.GA24515@osadl.at>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 29 Sep 2019 09:54:54 -0700
Message-ID: <CABvMjLR1sP+-z6-vy3kKmyv-srVHdvT9=Z7g=RSWo3oDuGt8+A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized
 if regmap_read() fails
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nicholas:

Thanks for your feedback, I made changes and submitted new patches
already. Check patch script generated a warning if I strictly align
the parameter with (. I checked other code inside this file and
modified the continuation accordingly.

On Fri, Sep 27, 2019 at 11:47 PM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Fri, Sep 27, 2019 at 05:46:41PM -0700, Yizhuo wrote:
> > Several functions in this file are trying to use regmap_read() to
> > initialize the specific variable, however, if regmap_read() fails,
> > the variable could be uninitialized but used directly, which is
> > potentially unsafe. The return value of regmap_read() should be
> > checked and handled.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> Just a few minor style issues - contentwise it look correct to me.
> Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>
>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 7b28d045d271..c032a64108b4 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> >  {
> >       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> >       int regval, timeout = 10000;
> > +     int ret;
> >
> >       /*
> >        * NOTE: we need a small delay before reading the status, otherwise
> > @@ -331,7 +332,9 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> >        */
> >       do {
> >               udelay(1);
> > -             regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +             ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +             if (ret)
> > +                     return ret;
> >       } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
> >
> >       if (timeout < 0)
> > @@ -358,7 +361,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>
> any reason not to declear ret in the declaration block ?
> so just for consistency with coding style within meson_saradc.c
> this might be:
>
>         int regval, fifo_chan, fifo_val, count;
> +       int ret;
>
> >               return -EINVAL;
> >       }
> >
> > -     regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
> > +     int ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>
> +       ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>
> > +
> > +     if (ret)
> > +             return ret;
> > +
> >       fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
> >       if (fifo_chan != chan->address) {
> >               dev_err(&indio_dev->dev,
> > @@ -491,6 +498,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
> >  {
> >       struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> >       int val, timeout = 10000;
> > +     int ret;
> >
> >       mutex_lock(&indio_dev->mlock);
> >
> > @@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
> >                */
> >               do {
> >                       udelay(1);
> > -                     regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> > +                     ret = regmap_read(priv->regmap,
> > +                                     MESON_SAR_ADC_DELAY, &val);
>
> checkpatch does not fuss here but the continuation should be alligned
> witht the ( here
>
> > +                     if (ret)
> > +                             return ret;
> >               } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
> >
> >               if (timeout < 0) {
> > @@ -784,7 +795,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
> >                * BL30 to make sure BL30 gets the values it expects when
> >                * reading the temperature sensor.
> >                */
> > -             regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> > +             ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> > +             if (ret)
> > +                     return ret;
> > +
> >               if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
> >                       return 0;
> >       }
> > @@ -1014,7 +1028,11 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
> >       unsigned int cnt, threshold;
> >       u32 regval;
>
> same as above
>
> +       int ret;
>
> >
> > -     regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> > +     int ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>
> +       ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>
> > +
> > +     if (ret)
> > +             return ret;
> > +
> >       cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
> >       threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> >
> > --
> > 2.17.1
> >



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
