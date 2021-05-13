Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCB37F4B8
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 11:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEMJNI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEMJNI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 05:13:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7395C061574;
        Thu, 13 May 2021 02:11:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c21so20767720pgg.3;
        Thu, 13 May 2021 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwQWPa4/9pfGduMpMgr1i24CZaP8m5vmM0JnxjiekRc=;
        b=PifpFADREVMFL8Ip3slALlS6z+aI08neFpnPAxnY5z3uqsghvPzUTQ6F15LLxGdz2j
         wjsz58EYw4dVLtVAzAmTETF9XHfhEi44jppLGNePSgJNAy7HTtF8gquprxilTxljhA3T
         FwtvNp7iX9mNI8GqcW4rOJLFCNJlyEwyXYA65+n64SdnZM8BRzHS6Kv0dDi3OSdwKW60
         TtgJarYiki+HwH8n1fymnlICxExklZMe1Q4JY+rorupvwa5qZ040P9pcK/Ny53ogluUV
         dbAzL4XQqGmmqZFVCDIbY1CWNNvsqN5GZVQdswaIscvo4m2ABvjOj51mlMUrr63citm4
         jMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwQWPa4/9pfGduMpMgr1i24CZaP8m5vmM0JnxjiekRc=;
        b=mkxei5OvxqlTLoJZ+ukfSgH1MUpeBNaebCSfOLHkGCd9z7QkOLj6IESTrJmSjTArOk
         SGjboCFsljGmk3gkcQSALjXy+q0OoFbS6tLX7VvCV6EvGp8mdCsdfmvOSeeBNuHxWvSg
         PLXqtCPPUGCv7/Ds+WbQqlCNArVCA3tVV/RZRKcDwXfXAIaX58ZjI5yJdjy05fSXm9Fd
         fF4eaGIZfrf1tsDkKMXplxQMuMHEVEwFaTt+urEX4/Dmyw8NSvBj020/YOvTmHsG9bcq
         9otM9IFSNAW3Yy9zfw6mKngyD68jRZ/0pBftGzZid+jz2b/87GPOmv/pM5VTq6MZreZ5
         7MVg==
X-Gm-Message-State: AOAM530fdq/014E4D7+5Mx/rd+0Xxgj1+lByobNW4Pvtb3dGN9Pg5g/C
        i/8LKcqmYSg+TRrpIMfIw66XjPH/KbmhBtUc+4X/QUxQ
X-Google-Smtp-Source: ABdhPJweC3xM4IA2b6Hn0tNL+6x+3RnD96/sMFhnrLz27QlwBlPd1xg7zsbbejOlPX7PthP+Z7vgSfYOZ5YKir5hx8k=
X-Received: by 2002:a17:90b:f8f:: with SMTP id ft15mr7777201pjb.181.1620897117446;
 Thu, 13 May 2021 02:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210512174914.10549-1-aardelean@deviqon.com> <20210512174914.10549-5-aardelean@deviqon.com>
 <46a03414-0ead-46a1-f0fe-20f1c22a70b5@metafoo.de>
In-Reply-To: <46a03414-0ead-46a1-f0fe-20f1c22a70b5@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 13 May 2021 12:11:46 +0300
Message-ID: <CA+U=DspWZNKT8M+Qa7oR_sBBMX04MaQ1K_xKq68WKwtPeQ8D1Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] iio: adc: ad7192: handle zero Avdd regulator value
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 13, 2021 at 10:43 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 5/12/21 7:49 PM, Alexandru Ardelean wrote:
> > This change fixes a corner-case, where for a zero regulator value, the
> > driver would exit early, initializing the driver only partially.
> > The driver would be in an unknown state.
> >
> > If the regulator value is zero, then the internal reference will be zero
> > (though that value will be zero for anything less than 1 millivolt).
> >
> > Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
> > Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >   drivers/iio/adc/ad7192.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index d3be67aa0522..9da394ad3868 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -951,7 +951,7 @@ static int ad7192_probe(struct spi_device *spi)
> >
> >       voltage_uv = regulator_get_voltage(st->avdd);
> >
> > -     if (voltage_uv > 0) {
> > +     if (voltage_uv >= 0) {
> >               st->int_vref_mv = voltage_uv / 1000;
> >       } else {
> >               ret = voltage_uv;
>
> More idiomatic would be to check for voltage_uv < 0.

sure;
makes sense
will re-spin

>
>      if (voltage_uv < 0) {
>          ret = voltage_uv;
>          dev_err(&spi->dev, "Device tree error, reference voltage
> undefined\n");
>          goto error_disable_avdd;
>      }
>
>      st->int_vref_mv = voltage_uv / 1000;
>
