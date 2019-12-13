Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C177911DCC2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfLMEGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 23:06:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34997 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMEGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 23:06:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so1098893lja.2;
        Thu, 12 Dec 2019 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=URwD2kqbKtqHBmAr97llX1pKhl7DZxsGfB/7E5QLYGE=;
        b=ni2xtTjM+9tiMdl0vEVZN6oCJYd5JkmqYneP9rmdFfxSNkEaRNTnpDtUAPxhg/WkG2
         bkcQ+xCwU3likRm558tmzXfAvt+hvoTytoPU3MIOrbdLtLvmidkGbTvIm04/n6ZeT85X
         3xEf/wk45HDrPEj5DMysxfiNMrEZYPAFSya2j9VTgoc0bJQdq+P2lCsPoSKFd01V881b
         ooCAS1DF8X1cCO4GwWMohtH8hHF+7K4mJYFktzDdsPSii+EjZNaSc37bMgU6z0B9h8/g
         opfpUHJgMg/y+kTWNMp4tMhMGLKNOljlpF9vXqLJUYmQZWhYxz+dEuOyH2zld1Xq3CeY
         fzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=URwD2kqbKtqHBmAr97llX1pKhl7DZxsGfB/7E5QLYGE=;
        b=RI+RkoFoVwbWcolwHDsExSSkZkgyLgz3HSu8I6McYQQlhsFEMlGLQOEPBS86bVrcZE
         nSPOc/iUPi9ZuM0gi23BwuGkJ2I3Y6oTnV+7R1OhCkG0ebVFesih3koyX4/Qo3CELqkD
         PnHgbPteFwTC4SlgF1iN9OdSAFckEiX5+lJWkqxAzjFWP8UuK+QKAI7m7C2MlrqgQobi
         AhDFv3MbUwfL+qJi98foh/jjxHPRE8WPU6eu203RKv7S5V0hXYtyXsumRwB7Yf4LLoVg
         t/s7W4D0diu4/s3dvB415mMaDA1Ic6P/WGdKIv24/QzV1iICuuZ/LnUV1DK/1WWqoVUN
         KtYA==
X-Gm-Message-State: APjAAAXUQQTcD32/H+ewfWQ2jFvRs5msok1PZIN+7RGPPoCb0MqOH4Jk
        G6IzZuskwsLQCLj2UPNd8rltaoLi07CkxCtOOiM=
X-Google-Smtp-Source: APXvYqzu65JNr8Zns5VVeks/iQ8D6CeQ4H0T8PGRqqD+u82N39Gk52MLphGw89g9L21cri/7kJtnKuJByOQxugJm9Ls=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr7997476ljc.84.1576209973389;
 Thu, 12 Dec 2019 20:06:13 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com> <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
In-Reply-To: <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 13 Dec 2019 13:06:02 +0900
Message-ID: <CAC5umygGZqWh2rRGMLvPhWFvD9Mv-5u6stY3c+5Z9_QC6OrNvA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

2019=E5=B9=B412=E6=9C=8812=E6=97=A5(=E6=9C=A8) 0:32 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:

>
> On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > The asus-wmi driver doesn't implement the thermal device functionality
> > directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIU=
S()
> > is a bit odd.
> >
> > This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() =
in
> > <linux/units.h>.
>
> > @@ -33,7 +33,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/platform_data/x86/asus-wmi.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/thermal.h>
> > +#include <linux/units.h>
> >  #include <linux/acpi.h>
> >  #include <linux/dmi.h>
>
> Similar comment about ordering. Can we move it to the end after dmi.h?

OK.

> > -       return sprintf(buf, "%d\n", value);
>
> > +       return sprintf(buf, "%ld\n",
>
> %d -> %ld must be explained in the commit message (e.g. "due to
> function returned type).

OK.

> > +                      deci_kelvin_to_millicelsius(value & 0xFFFF));
>
> I prefer to have this in one line.

It causes line over 80 characters.
We had the same conversation in v1 :)
