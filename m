Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F35111E04A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfLMJId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 04:08:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42493 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMJId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 04:08:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so1229296pgb.9;
        Fri, 13 Dec 2019 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxPqLVLahzfTFPSjd2lbJPuyMQNKnrepmPG6ocYBcx4=;
        b=SUrsMEMb5l0PWA8gLMCZ1Chtvg3jnhwK2/vgh7F9R9In+qm04qH8UaVIXa50MCqpVK
         dnt7pnwdnNTCUOACxo9GxwGBfj7c6IRCGWMufFXGS1S2Ixgxe2tCl05gtQpMXclq3Q7/
         tGC7HF8nj8qtD/gejuVIjf28O6u3iYTCh2B9qZ0bLAzW82Puhx2GXsdjsGBSUeqwe1pn
         tuDg66dObvKLPKFwx1mV8T2MWzGWjSYShGj7U6cxllJlJbihWHbnfxqJAeIDpIfqOEMn
         A65cCdjjhsJOUldvAIpNcMeERAwRluWMptbaeEF3UiJq6qwZNR9kDDlfSNG8z6PdMxxi
         ATwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxPqLVLahzfTFPSjd2lbJPuyMQNKnrepmPG6ocYBcx4=;
        b=FcSZ1snUKqOp7PYRhKxygVEBRhEHM+ajYxF22L/umXSZqzGCa6QLVjc5N5hsNYfd3j
         eB2UwUiwxZfCcokhMh4Fe+FULlWy0fXjdbku8U/jqnozd/Af+yJJisKIoBweWX1ymIOF
         VwwVZ70QqPnh0JD36UCPc/OENTpWzzY3m/IP08FC37sHgFDwHGxEUw79P3IMZaPJppSK
         MHhshzlQtJSa2XUcGhB9AV7mc9xBeQu+u7cLyQefnXIf46vwPFBPALFzh9RECFOU4PIC
         FTu44sELEpvfZF46uE7OPhW7D8k5qNuVotjUdPqyt+HKRNLT2CvBZlHmjvRpDBPEEg/T
         m7yA==
X-Gm-Message-State: APjAAAWNJhmOoT0+U8zskfQoyR1CdS+lvRHjL7SyQgEqMFdlO4R8EHZk
        XUUXLORVQ+4IZsTa5SIjarLE3+yaJv+2ngyPnrs=
X-Google-Smtp-Source: APXvYqy7AOFT9gacPFy8fva2qjxrkgVB2Bc8boyHgJDbZ7PTWw6lUx6ECBqGHWTyq1Okaig8E2i7/9mXsCoNAO75THE=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr15392101pgk.74.1576228112226;
 Fri, 13 Dec 2019 01:08:32 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com> <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
 <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
In-Reply-To: <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Dec 2019 11:08:22 +0200
Message-ID: <CAHp75VdhOgUt6rCMyJdM+NpweJbS7=Lrxf+KA+goiaj+xmNu-Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
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

On Fri, Dec 13, 2019 at 6:03 AM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B412=E6=9C=8812=E6=97=A5(=E6=9C=A8) 0:29 Andy Shevchenko <andy=
.shevchenko@gmail.com>:
> > On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > >                         } else if (crt > 0) {
> > > -                               unsigned long crt_k =3D CELSIUS_TO_DE=
CI_KELVIN(crt);
> > > +                               unsigned long crt_k =3D
> > > +                                       celsius_to_deci_kelvin(crt);
> >
> > It used to be one line, why do two?
>
> Because this line over 80 characters.  This patch doesn't make this line
> longer, but checkpatch.pl complains about it.

I'm not a maintainer here, but as it was before why not to leave as is
(in terms of line length)?
Supposedly maintainers are okay with it.

> > >         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> > > -               acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->t=
emperature));
> > > +               acpi_device_bid(device),
> > > +               deci_kelvin_to_celsius(tz->temperature));
> >
> > Ditto.
>
> Same as above, checkpatch.pl complains about line over 80 characters.

Same as above.

P.S. checkpatch is recommendation, and not something one must follow.

--=20
With Best Regards,
Andy Shevchenko
