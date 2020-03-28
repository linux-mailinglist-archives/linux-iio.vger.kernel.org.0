Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB91968A7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC1So2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 14:44:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40248 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1So2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 14:44:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so6431050pgj.7;
        Sat, 28 Mar 2020 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEgBW9QQu99a2sai4d1Uz2IOeiRHB8mBntj4/oX3if8=;
        b=ouDCjhKFXNz0qHg97LSTL9LtxoMEHHt5XmMHY0O3JWTXTX6KVUoBbbKGEaRoe4suqH
         Bgodh/bhOWuh+Uw5ZYeUQDC/rlML9443WQkuM+KCmxxhjELg+7MhD0Lq4BubKI4pnMJo
         ZfzaEEDCyNKntZ4F6dUb4Vs7Vd7wELm98oGUZpswTvhm/Q/HA/SIavwXKsKEUe8xWMC5
         veV78phgOYhrh7JtLFf0oynNemIhylY0qL9bQa33NeSOWpUu5C2XlY98iV+luNSHwaoY
         omgLIxik4AauciZPkWxYN3o5K2+dsH2puaV0rjGc9TgHCkoqYwbi0M9EoN+qXpWdHwjE
         0FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEgBW9QQu99a2sai4d1Uz2IOeiRHB8mBntj4/oX3if8=;
        b=dlULcW7kqArkv4j7DbmJHfUyFt4GbrAIHzZoQXfR5O0KPH5B5AnwTAcncNaFqFEVpX
         E06XRhfASd74n30kpgSPaPpHVmBaBLt+px8+yi8pR7hgadhBmUQCTHhKh1tNu1WMoqhI
         lDCteVz/OpqrfBGWA/RbIUR3ff2nD+Sx9UV0M/JPG8cQhJ+SRpI1r4rrer1+FSjPyjmt
         VeEqSsRWljlBN2KVDVSN3aycD6igJwP4ma3Mvrl0g2YhdQdJPnONRNf7PjBI/HyGtcMX
         EQD63CYD89GYsxCokQz3zNESrVGi8rfUyaKRbrjrep+wPSwdFUH98NHgOSjYWMJnmHSV
         MNAw==
X-Gm-Message-State: ANhLgQ0zqf6VJTpoj7dsR+EApo/YZ7PAutSsnW6U+DNXAiGhilaWc+z2
        uSUMvyc/sLqWtu8CQdiYr6SPqoo11DKGOgLdJ4w=
X-Google-Smtp-Source: ADFU+vuLh8bWhofnY0uetIzib0+lVHRoBH+mcX9y4a5vGukmUlw/9WY99xY/uiIsg6cXSU/IMm9zO7gbPWfER27vvoc=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr5459087pfs.36.1585421066788;
 Sat, 28 Mar 2020 11:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-5-sravanhome@gmail.com>
 <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com> <36892440-99b2-10e8-1d7c-dd8c97e03a39@gmail.com>
In-Reply-To: <36892440-99b2-10e8-1d7c-dd8c97e03a39@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 20:44:14 +0200
Message-ID: <CAHp75VdAfiSjkHhTnghZ__WAJCJTGSWBprJBPNmpkxZTjZuVgQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] power: supply: Add support for mps mp2629 battery charger
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 1:29 PM saravanan sekar <sravanhome@gmail.com> wrote:
> On 28/03/20 12:02 pm, Andy Shevchenko wrote:
> > On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

...

> >> +       val->intval = (rval * props[fld].step) + props[fld].min;
> > Too many parentheses.
> >
> > ...
> >
> >> +       return ((psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT) ||
> >> +               (psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT) ||
> >> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) ||
> >> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE));
> > Ditto.
> I think I misunderstood you previous review comment "Redundant
> parentheses", no sure what is the expectation

(At least) surrounding pair is not needed, return (a == b) || (c == d);

> > ...
> >
> >> +       return ((psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT) ||
> >> +               (psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT));
> > Ditto.

...

> >> +       struct power_supply_config psy_cfg = {NULL};
> > { 0 }
> >
> NULL to make compiler happy.

Hmm... Can you share warning / error compiler issued in 0 case?

-- 
With Best Regards,
Andy Shevchenko
