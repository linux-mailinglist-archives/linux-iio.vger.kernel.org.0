Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22A12781B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLTJ1V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 04:27:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44449 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJ1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 04:27:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so4005454pfw.11;
        Fri, 20 Dec 2019 01:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNKiOniHzSKU3M0oT+PWGTepgoOHttWen9RJRN7cbpk=;
        b=uH0KpIPuYsKhauy6uDQhR85oanHO0ONzdFK7YxazqR6sWO9AwuAefTRRLoK/BWBk6Q
         CTt4LtkBoZ87Na9BXfi97V5YLBsPuD0UV9e5IcniNMOlKjjgRAJ+d2Lasbchk9lQSpSt
         AAs2v73a9RCHWpbm9qz5q+3kgLG8l6T7DoF4juV+sEM2pwMN1MbyrcmK8cLDy7ApOcxg
         MerYx4DlqEJ/0awwoKr2crZ/Y9G5pbv01mKyWL93w+w7UB3vKy7uu3CtBMQniuMNb5Qs
         81tlO/0iXZy228ouq1IMN4VomlwZBhrAu4N546u3gCQjLb9g36UlQD7q5zBlUcd8URuY
         fZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNKiOniHzSKU3M0oT+PWGTepgoOHttWen9RJRN7cbpk=;
        b=dFylgAAtfum9DdSMcEdO+1kB383jHG+bgnWGhhNo75iKCNIAjQKrkg8nVr2B6hSlXG
         mH/szNVRzSzJOcJETrCq4aZZVaRaPjWDy2sDwrn8FKA579IxQzSKiU/R5oCWW5s0Cq3G
         hYNFWhuBasXp4CxcZ8SV9P4hus8p8eATpvkhgMIqeDBqawjEiNFKsUVmtkyrotVSc9Tg
         viLSvDBwbluKvRo3RAGD2l/mwVwFyoj6LsqfMOYJP0ioAg1yusmjUqTwY6cNlO0j37i2
         7NzufRx6gzmDUPKOFT7vFmZ1lCPzJi7k9t9HL9beu8yQPkZZku9U12z6qinG1cx4W1Hy
         DTvg==
X-Gm-Message-State: APjAAAWn4nUxoNA4JOM/9x/ElUigqHaX03vLl/27EV5dddLk1+TVdzo6
        4Hafqp+yU+UKOr58+365azh5gMcp3PtXmckjqfc=
X-Google-Smtp-Source: APXvYqyh1hbkXRo8C51/PO5I/y84aZ4jUWZTawBw/0oDDbc5KxDjYVnkag2sPe7rExGKev7pFacrKd2Ne5qbnrqiDpA=
X-Received: by 2002:a63:941:: with SMTP id 62mr14407335pgj.203.1576834040029;
 Fri, 20 Dec 2019 01:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-3-dan@dlrobertson.com>
 <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com> <20191220043220.GA16415@nessie>
In-Reply-To: <20191220043220.GA16415@nessie>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Dec 2019 11:27:10 +0200
Message-ID: <CAHp75Vec5ADoFH9KoTnU5+uEZvGqS2+NUN+MLTiwzofDtGG0+A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 20, 2019 at 6:48 AM Dan Robertson <dan@dlrobertson.com> wrote:
> On Thu, Dec 19, 2019 at 01:02:28PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 19, 2019 at 6:27 AM Dan Robertson <dan@dlrobertson.com> wrote:

> > > +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> > > +                                            int hz, int uhz)
> > > +{
> > > +       unsigned int idx;
> > > +       unsigned int odr;
> > > +       unsigned int val;
> > > +       int ret;
> > > +
> > > +       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> > > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > > +                       return -EINVAL;
> > > +
> > > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> >
> > Again, AFAICS division may be avoided in both cases (% and / above)
> > because of is_power_of_2() check below.
> > Can you revisit this?
>
> Yeah I can update this in the next patchset, but I don't know if it is much more
> readable this way.

You may describe the algo in the comment.

Let's see how it might look like

  if (uhz)
    return -EINVAL;
  idx = __ffs(val);
  /* We're expecting value to be 2^n * ODR_MIN_WHOLE_HZ */
  if ((val >> idx) != BMA400_ACC_ODR_MIN_WHOLE_HZ)
    retutn -EINVAL;
  idx += BMA400_ACC_ODR_MIN_RAW + 1;

Would it work?

> > > +               if (!is_power_of_2(val))
> > > +                       return -EINVAL;
> > > +
> > > +               idx = __ffs(val) + BMA400_ACC_ODR_MIN_RAW + 1;


-- 
With Best Regards,
Andy Shevchenko
