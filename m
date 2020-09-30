Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FE27E40C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgI3IqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3IqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:46:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C2C061755;
        Wed, 30 Sep 2020 01:46:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g96so1034160otb.12;
        Wed, 30 Sep 2020 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqXchtfWNkiYpJs8vUF2dtBGW/lOhwrejOiydaNrVFE=;
        b=FKiCRVdIcpXL9azY9wEZAWOW0toKeazPmrrTymCng34T6SAKyjgQqAHQOJdi6IgGVL
         MZsjca+pN5PzvRcLmifU/FNOkqdwOI97cqcm13ec2kP9KvqIbMePE3illhofntmnCYqs
         3HMm+iwo8zIuRy1a6dk707a4V3TLTRNlu5FeodhKS2M+hIGbr6Ks2Xc2+zK1M/KsE+CX
         WpAv0C4dwrQLQ/S2+t14rZI993dPzfTfJ2U1YTW0NJjIaeRtVkA31Djt1vOts2Q43R5b
         fu51k+LP1MRmK1YcUmX/IuhpPQtUmpg9Ik6QAbe2KhAQD6Z1bjU/9yagk1xLGMUDzzD3
         4YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqXchtfWNkiYpJs8vUF2dtBGW/lOhwrejOiydaNrVFE=;
        b=HruKfGe6wHNMUB0XPiY0dBKvkNzj0WGkTZ6p3t5endpTkMLtIlBfiKOvbHMHKUe47Y
         D0aFm5gdsYwAPWWBCRJwO6b71ysEr7livV3dLQKUE/bxPRBm5x8k+u8us9TrBmheIvXa
         6tr4oC3+VvSbmFIeyS+m6eyHT280oX36ZSHQYchwYWdp6dUD+uoX3HUCivgwW8k3ZeYL
         cf76HRKKJO9Fjr2GeK8CofR4g5qfZULcywFiP+wEz5Y7iZhu0qiy0BP+6vBEqhT5bfqL
         5leQRmi6qPwhv69PVFcYbOk5OjQMAhKz+9zZsDjSU2TVH368tSZUVf/o+eYZvLRcmia7
         lsRg==
X-Gm-Message-State: AOAM5337RMsJc7vQ7zMxp95UE9EpL2GXS56fSDpkuL7gg4WHZUyxs7lD
        IqMBxOiQ0ePGCWUYQIMDOx2yAz/opnVDo/81e90=
X-Google-Smtp-Source: ABdhPJxqFNXzGcoM0pdE8WNU4dhLQrgBJOKfV/J27tuS364G5dgjNpWhwjsL4jwg6+Vli87ol4dUqB815ThyB7BqiAE=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr924001otj.224.1601455577149;
 Wed, 30 Sep 2020 01:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-5-alexandru.ardelean@analog.com> <20200930074728.GD2804081@piout.net>
In-Reply-To: <20200930074728.GD2804081@piout.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 11:46:06 +0300
Message-ID: <CA+U=DsofSvQKwSQEye9ONYMJkKiL9er6sH2FTLH-5SgmmnPqOA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: at91_adc: remove of_match_ptr() usage
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 30, 2020 at 10:48 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 30/09/2020 09:00:08+0300, Alexandru Ardelean wrote:
> > Since the driver should be allowed to build without OF support, the
> > of_match_ptr() is redundant.
> >
>
> This can probably be squashed with the previous commit.
>
> Also, I think that you should really make the driver DT only else, the
> driver will carry dead code and there will be no reminder that a cleanup
> is needed.
>
> I can take care of that if you feel that this is more work than what you
> wanted to spend on this driver.

Ah, you're saying remove the old pdata?
I can do that while waiting for other of my patches to go in.

>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/at91_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 7d846a2852a5..473bffe84fbd 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -1466,7 +1466,7 @@ static struct platform_driver at91_adc_driver = {
> >       .id_table = at91_adc_ids,
> >       .driver = {
> >                  .name = DRIVER_NAME,
> > -                .of_match_table = of_match_ptr(at91_adc_dt_ids),
> > +                .of_match_table = at91_adc_dt_ids,
> >                  .pm = &at91_adc_pm_ops,
> >       },
> >  };
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
