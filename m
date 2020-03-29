Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF0196CD6
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgC2LJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 07:09:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36108 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgC2LJ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 07:09:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so7115457pfe.3;
        Sun, 29 Mar 2020 04:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjAcuLkB1VhT/hcJOjXUhu1Dh0xL60Xt/HoLoo3Crhc=;
        b=kk6EJ+x+Y7D+cWMvkNwCvzaqeGdmP7yzqzx6LVeOanulT3862EW/r+dAKr1/8yVlRb
         AXPSPKTXsX3Q0XcubqEoevP4XZGvYRyxl/qcD2+tGizsPyEbdbUDc0H6jGVQmtet+Lqo
         OxhcVSnhi9Z2p8yehnVUVjVFFj4osvIwSiAkg2nJkzAiHDNKXDp40jne65mbnDlwdtoj
         JkxI5qFWRMsMOOe73aUAcTuXWhSrJR2MvNnNuSFIeQGB21YeHyQF2R1e0LFmmN6lrCli
         PuP8TLCOk1aKPfot7uniGEIS8KkCoJ6zAYoqmk9pMxtPYQGM+a7FqGSajop/cM3Xv2NN
         GRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjAcuLkB1VhT/hcJOjXUhu1Dh0xL60Xt/HoLoo3Crhc=;
        b=Hou3UYDXCJGVuhXmNzc+uHrWVWL568+ODu6bUHF5kJ1J2KJRLj/N3Ge0iLx7Ba1Cub
         yp5EnXwCXZk7kqhizMSzn/MRmdtJGbAY/ds1YoJ0aNdW8BOFxHNKgDk0kIXQF+AW3UCa
         2KQ26CzE+qQj7PMx0h5yoGqwD0royUGFr97ifVvui6FBus5Kz8z46SmzDb7ok66o3Qbr
         VoIy4+phdCis/th1y+MQyhaFJh8HZW10upFn9Xk1j/q+PmHhI9r7ZTIvb+Do7D8NHifY
         zaFEYnICHCkFLTU/ayN+vRGTV005dfqM0AiMFsp2fU0hyNoTcaQDUfLdV9uS+riY24vu
         HrDw==
X-Gm-Message-State: ANhLgQ2PDSUDWAuoCsSgTElMXOIBMxSkm0csHHaF0ZfVZ3iN8/EK3Wul
        Wm3cMoR2iXgXGzCX1zlgECPMU/IbTrSPy+qpFd8=
X-Google-Smtp-Source: ADFU+vvDbyKI1Rt1MgZsf79bQVJw5AaK93/iB4EfrkiDaVjc/m0bHQEmnJa/gweVk48gql8H6A6NDJbSFyPHJ05IpnM=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr8319325pfs.36.1585480166434;
 Sun, 29 Mar 2020 04:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200322224626.13160-1-sravanhome@gmail.com> <20200322224626.13160-4-sravanhome@gmail.com>
 <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com>
 <20200328144234.081b964f@archlinux> <d6852a20-157b-ea51-7def-f11b5d1c81fe@gmail.com>
In-Reply-To: <d6852a20-157b-ea51-7def-f11b5d1c81fe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Mar 2020 14:09:15 +0300
Message-ID: <CAHp75VersB-PUbnp_wYd-pNYfopnNWV-eVW-_pz37KvKgUAdkg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Sun, Mar 29, 2020 at 1:37 PM saravanan sekar <sravanhome@gmail.com> wrote:
> On 28/03/20 3:42 pm, Jonathan Cameron wrote:
> > On Mon, 23 Mar 2020 01:32:34 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >> On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

...

> >>> +#include <linux/of_device.h>
> >> Don't see users of it.
> Forgot to reply, its needed since I used struct of_device
> "error: field name not in record or union initializer
>    { .compatible = "mps,mp2629_charger"},"

Yes, and my comment still stays. The error you  get due to lack of
proper header, i.e. mod_devicetable.h.

-- 
With Best Regards,
Andy Shevchenko
