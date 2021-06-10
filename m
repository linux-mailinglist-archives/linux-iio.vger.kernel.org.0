Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB953A2D25
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFJNg5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFJNgz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:36:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BBC061574
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:34:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b12so1020505plg.11
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkzNwSvW298FDvRA+HuN1S+l05umNOxVIId7UsBp+a0=;
        b=ZERQ0T1dkq1aQKjTNpJSQdEDmiMQ0ySqrWF01738ji7skDGCvB7QOykvICu6tUclt1
         9S1w2+Y9GKyiLzLxGHhJG4cwpy1GAoLaAFaEp6lG7ORlxpZDc8bItH73a1wS8OkrUEC1
         cTutrMAld42gW202umbdvktCvO+WhFu9jBDWVwzoqosWSsZae3R258IEcs151zQrR6Tc
         v95LbCsaa4f32kqkzRinNoJ/DpFymw14vjvrp5NBs+InDOCCo2Hhq5MCQ40hFPt7J09q
         jksWCCJDECteFiTvi2hqvyB6qlyel6Wq+GeyQ9iGd12bhtSQO+DftibQsBNJ7jPZeO8D
         Ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkzNwSvW298FDvRA+HuN1S+l05umNOxVIId7UsBp+a0=;
        b=rgLQ1gEqcLQVXEgr2Gqvi2pDwup98O1JaBSR1wekUOWLJxoGj3mjaXnCbY38rGkwz+
         CN9o6X+FFFuZ6/S1JulW7N3gXAt8nGDy4LGrzPxIvHFON2lY8b9cyLEI7An/5o/QfUSu
         r/Z+jfwXU5BAIkef0OKqlQ9EmUUYaAemv9GrHbH+XRBp4UEogYluOsxuSPGcNc3nnSXZ
         y5VQJ5VAy2/09ZwpTt6loUNdqAtlFdAwNMbMybo0Bt24ZbrqR6uZOcfcUwtE7Hf0yQ4F
         FyaQYhuP3myyB+cD6Evva21nuWKNjld+eVZz294b4XUom8a4WrCp1pTe46O5FztE93m3
         tFzQ==
X-Gm-Message-State: AOAM532pnjDypRsQhbZJHTr00EFrl9WZ58jpbEIHFGJfgVkcMilRBXbO
        zbJJjo7MLor8pPiy879Y0zUzWd2xOBM8hoQOVSXWvnev4so=
X-Google-Smtp-Source: ABdhPJybosTuvK/5wdLUgnP7fZU+H2denBDLSmEsa/ETs7fbD+DgMGB8NWu/jqyO1oP4XEq8nqWmJWUsDkY3GoJmSKY=
X-Received: by 2002:a17:90b:818:: with SMTP id bk24mr3465466pjb.228.1623332098779;
 Thu, 10 Jun 2021 06:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125358.2096497-1-mkl@pengutronix.de> <20210610125358.2096497-4-mkl@pengutronix.de>
 <CAHp75Ve=bp=iHKeHmSb8MzfMt=tP+gsgG0GTwxhQV_ej_+BqPA@mail.gmail.com> <20210610133135.tsu4lnyhab7ysmcn@pengutronix.de>
In-Reply-To: <20210610133135.tsu4lnyhab7ysmcn@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:34:42 +0300
Message-ID: <CAHp75VeoLo5JQgZRiEwA=qyaHo-rfisvJ935-V9DP5C1kO9fBw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: ltr501: ltr501_read_ps(): add missing endianness conversion
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 4:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10.06.2021 16:21:30, Andy Shevchenko wrote:
> > On Thu, Jun 10, 2021 at 3:55 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:

...

> > > +       int ret;
> > >
> > >         ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > -       ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> > > -                              &status, 2);
> > > -       if (ret < 0)
> > > -               return ret;
> > > -
> > > -       return status;
> > > +       return regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> > > +                               buf, sizeof(__le16));
> >
> > This is slightly weird since we pass a pointer to a buffer of one
> > element (buffer can be longer, but here it's always one element is in
> > use). The original code is better (initially). Also making caller to
> > do endiannes conversion each time is not good.
>
> We decided to implement the same semantics as ltr501_read_als(), where
> the caller does the endianness conversion.

I'm fully in favour of consistency, but in this case I think it would
gain from converting the old code to the above mentioned schema.

> I'll change the code and send
> a v2 (with a proper cover letter subject :))

Thank you!

-- 
With Best Regards,
Andy Shevchenko
