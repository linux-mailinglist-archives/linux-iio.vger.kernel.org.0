Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55E1A4569
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 12:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgDJKzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 06:55:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33568 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDJKzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 06:55:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17so864839pgo.0;
        Fri, 10 Apr 2020 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIcnFNlKwbhEUKuern25WOvqQEVVsTXqGIr0A8WwShs=;
        b=OHsTaGa0WQ0YKhuVGOQ6pPcIKYKJQmtrS2+T8Szuyi16vomvG6C+YQ0O3IlqEnYEuY
         vu9zRhcCwSVWKFUOlCa+2e9JI8Q6x940HHClWPfwkcZnMF5hnXZKbD0oS6/aaG+TnVYc
         pRBFg5mAzqvql2AcdtPhjL9lMpMJ9J2zqmyzybRd0MWTbak6q6rP9UheTARiDh2qHMmB
         OQLbxh7glsMqwXOzDPqJ8GoCU7fjGbJFO+iSiVuKbM6+M63B4ffbioe7km4BzU/PYU9j
         hGP5CFwcd6r6oL55/u1/wjFFN6GAWEnYsAY8JBGSBgVtGEPYEMk727gMMDVvVW+2vJC+
         YoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIcnFNlKwbhEUKuern25WOvqQEVVsTXqGIr0A8WwShs=;
        b=FQGoLlD1OjYCfqSugyQ6xskZ0/oMm0SQifUxR0KCy9nLSx5UnR59xAtP8+DArMKqxS
         Vo1UMwWuFZVW3nwZrfu3CB9oFdhEaNzyxGD5jUS9XZjScMpU7e+gmE97IhHQLN8QPXOs
         Eh9vkMsE/v1IcasF+GGfWlFLg6dWXlMOhKraT12WzO1rmwZQI9FNgeTaj8N1+VxZ0pbW
         R5AYpZLftXljP/nscrZYDrvWhGQmjsTFiiZ6IeXtCti94Sr3Cen9K30px+tpeHXlIGr2
         bATAOfUW5L0BdSEEpWwfaxGlUmIaR2+wPPOmYZdPg446IYwtEY6yjrBjFwurfg5LgAOH
         k1vw==
X-Gm-Message-State: AGi0Puak9eMKhODsor6zaLp9Wbw8eZ50XdlnsM4RcQurMJv+idfhK/1w
        BtrC+Ip0DepZegzPSFm1mIs4o5TmVFfqFRKG0dU=
X-Google-Smtp-Source: APiQypJjTjt8JGmxlFWTs2L3oU8ewPIPy4jYOmNiUW8hyrSurIcnqOta9nx1FhHqib1d/JIBljwPbBXFfHF5+tGhjZg=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr4357812pfj.130.1586516137980;
 Fri, 10 Apr 2020 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151125.32677-1-aishwaryarj100@gmail.com> <20200409155936.GV3628@piout.net>
In-Reply-To: <20200409155936.GV3628@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Apr 2020 13:55:26 +0300
Message-ID: <CAHp75VcLLjjc5T+Qq8du4QgnQ-rtzFLh=5Jt-DPjigb+QUWOSg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Aishwarya R <aishwaryarj100@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 9, 2020 at 7:00 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 09/04/2020 20:41:23+0530, Aishwarya R wrote:
> > Use the helper function that wraps the calls to
> > platform_get_resource() and devm_ioremap_resource()
> > together.

> Please elaborate the actual value of doing that.

Please, elaborate actual value of not doing that.

Yes, I know that you are p* off of these changes, but why you not
going further and forbid all clean ups we are doing in the code?

To the point. Above change is reducing code base and showing the new
comers modern APIs to use.

-- 
With Best Regards,
Andy Shevchenko
