Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E611E036
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMJGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 04:06:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40571 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLMJGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 04:06:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id s35so927208pjb.7;
        Fri, 13 Dec 2019 01:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ybc7GcFQZhxBSK57X32yESZQ6FjJoJQQPD9To3J0myM=;
        b=CQzvdSwKXT6OZG3K59nTAtaRHtSC3h0QcLA2xgc6gg5Gblm/BbbxRNfewJg890m8pE
         iR5ZC11NhfttOSQxOX3JmDVncxwL7YPN/AgWkc0u1w1oPc4V1Xm/cA+wzLePF3TQiCWq
         pLu8liKGIJzgJB36Mh2fm0yOHPPsL/J0KxNHg+R4JKmtpypICr72yJG8qfWhRWuu1aWB
         838tVgHCzSa5LQEe9jyZ3BkRrblfNFrRAjBlQub+TyL+nbLyAh/mEtum0Ly7TobthhU5
         VOnooUi7JejHvzYnh3ZT9QsyqeQJTiMPGEdB4I5+GjPKwK6/R5h8KOxasJTMuJmlbD9k
         id1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ybc7GcFQZhxBSK57X32yESZQ6FjJoJQQPD9To3J0myM=;
        b=eS0mQJNnG/FvaKv825uAUT93viex6oOOwlPd3PGhrvGcanMTri0+mMTs7Z1vD2BHry
         xSCKPkXdAVfnZPKSQtPGonTnI67Ftcx0o1xP39kHJoJsuNolSsJeZjSx//Dis142SZCj
         KAfmenEQ9rsXHXaKnhwfyZafsl8m0SJy3pn6KrbsTjVqwZsrJLz0KBAoWBqIHho5ICHq
         BynAG5cJh+rtdOEpmWY4diTxudlfui3WaGrPmUy5/D1OPXcJHGtIUgI6NhNgQaaHft4c
         YoQOvk6J6xaVQAjMjRiWfXYUU3KfjqnWikxm8iTKfX1ZOWgJ1hp2kxrq3cebPlCYNV1z
         7OuQ==
X-Gm-Message-State: APjAAAVx3xIMX5DwNvWqbkJ5zjJX6Qi5Sw9dpWJB+dc3JRWpw30aV8ko
        Qgiz9yvL/t6r0NYrD17QVOkRoJ3zDz8tHsR7Bqo=
X-Google-Smtp-Source: APXvYqzCHj1+Sq6cO+qQd7QUtpkAonXpYK4lPwrvxQH1PraWW7di5xCFjd9b+JkQT+3TEHdPKq6H3su9VgqGnoSHcL8=
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr14525504plb.255.1576227968997;
 Fri, 13 Dec 2019 01:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com> <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
 <CAC5umygGZqWh2rRGMLvPhWFvD9Mv-5u6stY3c+5Z9_QC6OrNvA@mail.gmail.com>
In-Reply-To: <CAC5umygGZqWh2rRGMLvPhWFvD9Mv-5u6stY3c+5Z9_QC6OrNvA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Dec 2019 11:05:59 +0200
Message-ID: <CAHp75VdDLUR0N2VxRW97t4BSUgFcPCajGGdhRBdFjOw0W+SPKA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 13, 2019 at 6:06 AM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B412=E6=9C=8812=E6=97=A5(=E6=9C=A8) 0:32 Andy Shevchenko <andy=
.shevchenko@gmail.com>:
> > On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > > +       return sprintf(buf, "%ld\n",
> >
> > %d -> %ld must be explained in the commit message (e.g. "due to
> > function returned type).
>
> OK.
>
> > > +                      deci_kelvin_to_millicelsius(value & 0xFFFF));
> >
> > I prefer to have this in one line.
>
> It causes line over 80 characters.
> We had the same conversation in v1 :)

And I really don't care about this.

--=20
With Best Regards,
Andy Shevchenko
