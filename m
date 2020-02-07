Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E91551A8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 06:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGFAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 00:00:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33268 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGFAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 00:00:00 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so849284ioh.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 20:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eUxTRTAIeBq48fPXnAZZzWFkychuLmUz1qmxBNG4Gc=;
        b=RhRspnBPAeHEMylGAgtVn5OkcZAfai+w5GuxdcS1Bd4Vw0Mzqzj0arr9nA5Mr3F9yH
         vRoVfwfne528Tr06sY47IrGanjH1KNrwFfT+ywbsJvaVJJhvQvHY60JvlHmEEs7zup+d
         D3y7Arshh+g8hpRdRzZ5cwseTgJWP9RWU9VdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eUxTRTAIeBq48fPXnAZZzWFkychuLmUz1qmxBNG4Gc=;
        b=K72pMlb7p6N1IgVEUtkYERye2jdQzjTLQVfeFvpuOFd3MaR6RalNy3kz7DJTumwsYa
         bwqZin/ZpH6mO/sMP1DPTEBTZ0RUpNjFK69C/fy4/HdcPH4G+eTG9W91bSoFSSpz6oog
         eRYN8D3CDK06enMF1tKBiWyoHvyZb4Cn/W6xgNDMTdzgCuKbW1JDnPdAqv2DWVrmCZ2I
         DLhIutvSHRv5ICQGm53do3cDZpIfgEsxSg5Mz5zd1HE3fh+LL/BgicJW9PkcwL5bag8i
         3CkMaPxnBxpAJi1XnNFoQkfRwTIohyHKqlEcw97sinIRsFRb2IsZebg5gae4s5d4ItRw
         CL+Q==
X-Gm-Message-State: APjAAAXNUBQE3JeeNpS7YJzFjr8lE4XjUQrnxZ6L/1DRa6YqgKKbX30A
        QSyi5dCSAnAtc3HO0Z981tNUtNNCviw796nnW9vGew==
X-Google-Smtp-Source: APXvYqxmtcT98sSYD0tiKV36T+PiUxGrjfjDu6aRCj2a0yebGz2Ven0gaympFVMacyihbFU4bJR6q+RZk4TLALBPlHs=
X-Received: by 2002:a5d:824c:: with SMTP id n12mr1568478ioo.234.1581051599233;
 Thu, 06 Feb 2020 20:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
 <20200206061332.20427-2-matt.ranostay@konsulko.com> <20200207005320.GA3589@r2700x.localdomain>
In-Reply-To: <20200207005320.GA3589@r2700x.localdomain>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 6 Feb 2020 20:59:48 -0800
Message-ID: <CAJCx=g=tNfTptvCunJ7fwrZyYsKVmKieWyLEeL5C1dCnGMd-AA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 6, 2020 at 4:53 PM Jeremy Fertic <jeremyfertic@gmail.com> wrote:
>
> On Wed, Feb 05, 2020 at 10:13:30PM -0800, Matt Ranostay wrote:
> > Sensors don't actually need a interrupt line to give valid readings,
> > and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> > the required check for interrupt, and continue along in the probe
> > function.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 2f0a6fed2589..2e34c82cb65d 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
> >       if (ret)
> >               return ret;
> >
> > -     if (client->irq <= 0) {
> > -             dev_err(&client->dev, "no valid irq defined\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       ret = chip->calibration(data);
> >       if (ret)
> >               return ret;
> > @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
> >
> >       init_irq_work(&data->work, atlas_work_handler);
> >
> > -     /* interrupt pin toggles on new conversion */
> > -     ret = devm_request_threaded_irq(&client->dev, client->irq,
> > -                                     NULL, atlas_interrupt_handler,
> > -                                     IRQF_TRIGGER_RISING |
> > -                                     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -                                     "atlas_irq",
> > -                                     indio_dev);
> > -     if (ret) {
> > -             dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> > -             goto unregister_buffer;
> > +     if (client->irq <= 0) {
>
> Should this be > 0 ?
>

Ah yes good catch :/

- Matt

> Jeremy
>
> > +             /* interrupt pin toggles on new conversion */
> > +             ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +                             NULL, atlas_interrupt_handler,
> > +                             IRQF_TRIGGER_RISING |
> > +                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +                             "atlas_irq",
> > +                             indio_dev);
> > +
> > +             if (ret)
> > +                     dev_warn(&client->dev,
> > +                             "request irq (%d) failed\n", client->irq);
> >       }
> >
> >       ret = atlas_set_powermode(data, 1);
> > --
> > 2.20.1
> >
