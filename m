Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4A2444FE
	for <lists+linux-iio@lfdr.de>; Fri, 14 Aug 2020 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgHNGZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Aug 2020 02:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgHNGZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2020 02:25:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138DC061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 23:25:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so6971003wme.4
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p4OU/y2rgb7VC/+GthGLthh/f8w52N6FXbx25EfxTI=;
        b=RgZAohyK2FO1w2oYW1hfvGT2NF1zMVLDDvQq79O8dZlKlvSXbGn0LYPbM9YDbU+Zs7
         I3IyQ06vRc9PH8lW2r5ZH1B9a40wsTOHr+HuxvTnQ04nKTsnFdUO86FfUZbAm2VySQWe
         6OpQR3L2s58P04IsW9RNI+FCPAQaTkEPkNajFw55G7NxABbj09GEd7bqy8lsnTc4yBsm
         Pp9+Pn+JJXg+W0MXJV5kcuGgSI1wbHNnVXUV3FZOt1wr0m2xPH71e7ceLSTWtlvgNtg6
         OrNcajt7ub4QCeUAFzA4UVzH02pcNT/zSWHdMdBjT/CS3Sa6guh4hQ0XwS+b8SjmfgYE
         CQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p4OU/y2rgb7VC/+GthGLthh/f8w52N6FXbx25EfxTI=;
        b=EguCn3hl196Ya4qbqm+4K0tIJLM/ZBpJD4nZK158pxDS7DPbC/aReGIMPStfX49/uN
         O3yv/lHTHltYY05m4VzHAEz4LotUnTZ0C+82/btL7AFQTtrS5qntaqlpySVvaZe+uXqc
         z4a384aE5cFmLgvoqexmm5ZjMo+0F/dyxLnNUdcozmIcvWAI5qDYGzHdPMgyvn+uG1VS
         Y+L1p/WlDcDxC0bE4Kc3V7TDX/BuOAJwmJAeL1oTdINMgPbq1CLUORFdoUCIj0UXzqvq
         8ywS9cxIZ3HVgfvraOi2GSTlKbNOf/PwoQT2zjORyqgD81Z57lP0hMe/rTCURtjS96e1
         NI0w==
X-Gm-Message-State: AOAM530MoF0R+Ehqfmv5I0xXhtWrqVWGxeRtuu7s23KbNnCZ8O500SUo
        mz9X2dWl3VthbrR26ZVYR1ad7lSrewxYpCxI1u/1bncp
X-Google-Smtp-Source: ABdhPJxiGOl5C4FKCB90B+TAngXrBqFthmbICevLoS8FnVUwv6JycT/HWytMAMBkq+fK6x/vLrO1IRoGzCWZ09/zMLo=
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr1065000wmg.69.1597386322394;
 Thu, 13 Aug 2020 23:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200801135511.342869-1-angelo@amarulasolutions.com> <20200801174633.08cee9d1@archlinux>
In-Reply-To: <20200801174633.08cee9d1@archlinux>
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date:   Fri, 14 Aug 2020 08:24:46 +0200
Message-ID: <CA+TH9VkXpHwuMv4EA+SF8GkR-8sZQ8DrCqqovURwcU48NP0+bA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: mcp3422: fix locking scope
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno sab 1 ago 2020 alle ore 18:46 Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> ha scritto:
>
> On Sat,  1 Aug 2020 15:55:11 +0200
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>
> > Locking should be held for the entire reading sequence involving setting
> > the channel, waiting for the channel switch and reading from the
> > channel.
> > If not, reading from a channel can result mixing with the reading from
> > another channel.
> >
> > Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>
> Looks like we should be backporting this.  Fixes tag please.

I don't know what it fixes, there is no signalled bug for this, I
simply discovered it doing some testing.

>
> Jonathan
>
> > ---
> >  drivers/iio/adc/mcp3422.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> > index d86c0b5d80a3..02a60fb164cd 100644
> > --- a/drivers/iio/adc/mcp3422.c
> > +++ b/drivers/iio/adc/mcp3422.c
> > @@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
> >  {
> >       int ret;
> >
> > -     mutex_lock(&adc->lock);
> > -
> >       ret = i2c_master_send(adc->i2c, &newconfig, 1);
> >       if (ret > 0) {
> >               adc->config = newconfig;
> >               ret = 0;
> >       }
> >
> > -     mutex_unlock(&adc->lock);
> > -
> >       return ret;
> >  }
> >
> > @@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> >       u8 config;
> >       u8 req_channel = channel->channel;
> >
> > +     mutex_lock(&adc->lock);
> > +
> >       if (req_channel != MCP3422_CHANNEL(adc->config)) {
> >               config = adc->config;
> >               config &= ~MCP3422_CHANNEL_MASK;
> > @@ -150,7 +148,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> >               msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
> >       }
> >
> > -     return mcp3422_read(adc, value, &config);
> > +     ret = mcp3422_read(adc, value, &config);
> > +
> > +     mutex_unlock(&adc->lock);
> > +
> > +     return ret;
> >  }
> >
> >  static int mcp3422_read_raw(struct iio_dev *iio,
>


-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
