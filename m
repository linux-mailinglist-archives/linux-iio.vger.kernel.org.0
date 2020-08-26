Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6D252B0B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHZKBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgHZKBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 06:01:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E0C061574;
        Wed, 26 Aug 2020 03:01:45 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n128so1034038oif.0;
        Wed, 26 Aug 2020 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU6SzC4HPKAdpsfd1/EKwFJCt0CfheymGe5/PRIykis=;
        b=kLkk6P2rg8BhuVDfo6yGiUK2wsxe4gSq3InBYsZSplXAV7lOxYYp1J3Q5DPL1Atuio
         wzsMCRLELwnf36uijOPxK5cp7rbI3xFBGVt/1xNk5NI1EEpw2+MFPYKkn0DV+bQnL8jS
         gByBV5G13T1sJJOtdkimgb3sWtgAKnqVtVqsjuz/8P0ot8gu3lO55v3Zz1BAI0voo4sC
         BgZLRZ6Zevw4I5LCGST2ULe4UDW0ldYsDc/Vfwdr18TYV92+8x24tYclqB9sPTYDWngS
         viVa9iCihofF9hXA0iHyWvHUPhFmgqY2F+y3lBMzCc0HVroFxSCvo5yUYKJIvlimNnYU
         9Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU6SzC4HPKAdpsfd1/EKwFJCt0CfheymGe5/PRIykis=;
        b=JvyZanwJiIap6wmAlKUF0jWRXR6RVuoNz7p2pmi4lgOJaYHakw0Vea/c5F/60R0190
         i1sZPDLL0Cv2SQiaBNyLB5edqJj2zVdhDe+Zqb9Fi1wNEQclbjkFoxnyVTWW28csMuDJ
         VJyBRAT5I3oSQLUgQ3WQhnRwm9iDmKADhPY08fycPwRx37/QlFWAcL4En30mP5mAvakf
         8UGGINV2iz/vgptcTF0dhwgrM6YptlKJgH0MCkh/SfT8NhUJNSh+l2oJnUGra12lEFsy
         5sWYUhoQAhSz5gYbq2DwPavInGfEEldKw3o0pfGtwal07jrA+UqRQs730MkebJ6yX9K/
         rSwA==
X-Gm-Message-State: AOAM533JVxuUePS3lWiXIPcIhNfDiePUxtCgusH9EsQ5Ra2G57UTnFoG
        wJzJaP6D7EmYnGOjyrVjEzGrnQJUKAEQ0bQxtCY=
X-Google-Smtp-Source: ABdhPJxgjAA4fAItoCC7+tMC6PKsZHjoR2FEmj+no0NTVKhbsiNR3TWflTznFRRmW3BfFUjZy+oAel/kSKbg107bAHA=
X-Received: by 2002:aca:304b:: with SMTP id w72mr3257414oiw.117.1598436105035;
 Wed, 26 Aug 2020 03:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063850.47625-1-alexandru.ardelean@analog.com> <1c32f6b5-deb6-e310-4bc4-a871719cc8f3@st.com>
In-Reply-To: <1c32f6b5-deb6-e310-4bc4-a871719cc8f3@st.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 26 Aug 2020 13:01:33 +0300
Message-ID: <CA+U=Dspxp4u5BoxwHCKMJBC5HWywX7ULSS=YBfOGzP1zLP=yVA@mail.gmail.com>
Subject: Re: [PATCH] iio: stm32-dac: Replace indio_dev->mlock with own device lock
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>, alexandre.torgue@st.com,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 12:01 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 8/26/20 8:38 AM, Alexandru Ardelean wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >
> > As part of the general cleanup of indio_dev->mlock, this change replaces
> > it with a local lock on the device's state structure.
> >
> > The patch also does a minor whitespace change to align the 'lock' with the
> > 'common' field via tabs.
> >
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/dac/stm32-dac.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > index 092c796fa3d9..fc636812c17e 100644
> > --- a/drivers/iio/dac/stm32-dac.c
> > +++ b/drivers/iio/dac/stm32-dac.c
> > @@ -26,9 +26,11 @@
> >  /**
> >   * struct stm32_dac - private data of DAC driver
> >   * @common:          reference to DAC common data
> > + * @lock:            lock to protect the data buffer during regmap ops
>
> Hi Alexandru,
>
> I think the same patch has been sent by Sergiu already [1].
> Jonathan and I had a minor comment at that time: E.g. could you please
> update the comment ?

Oh.
My bad. I didn't follow the discussion closely.
Will send a V2.

>
> [1] https://lkml.org/lkml/2020/5/18/254
>
> >   */
> >  struct stm32_dac {
> > -     struct stm32_dac_common *common;
> > +     struct stm32_dac_common *common;
>
> Is above change needed?

No.
I can remove it.

Thanks
Alex

>
> Best Regards,
> Fabrice
>
> > +     struct mutex            lock;
> >  };
> >
> >  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> > @@ -58,10 +60,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> >       int ret;
> >
> >       /* already enabled / disabled ? */
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&dac->lock);
> >       ret = stm32_dac_is_enabled(indio_dev, ch);
> >       if (ret < 0 || enable == !!ret) {
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&dac->lock);
> >               return ret < 0 ? ret : 0;
> >       }
> >
> > @@ -69,13 +71,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> >               ret = pm_runtime_get_sync(dev);
> >               if (ret < 0) {
> >                       pm_runtime_put_noidle(dev);
> > -                     mutex_unlock(&indio_dev->mlock);
> > +                     mutex_unlock(&dac->lock);
> >                       return ret;
> >               }
> >       }
> >
> >       ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&dac->lock);
> >       if (ret < 0) {
> >               dev_err(&indio_dev->dev, "%s failed\n", en ?
> >                       "Enable" : "Disable");
> > @@ -327,6 +329,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
> >       indio_dev->info = &stm32_dac_iio_info;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> > +     mutex_init(&dac->lock);
> > +
> >       ret = stm32_dac_chan_of_init(indio_dev);
> >       if (ret < 0)
> >               return ret;
> >
