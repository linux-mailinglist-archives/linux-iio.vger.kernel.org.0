Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0137B209968
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jun 2020 07:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbgFYFXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jun 2020 01:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbgFYFXW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jun 2020 01:23:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95487C061573;
        Wed, 24 Jun 2020 22:23:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so2763715pgu.13;
        Wed, 24 Jun 2020 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G7EYtpN+7APVu3hftiJBUcaii12rvBtQLcLyvFMd3fw=;
        b=jJIIJMoxL6YsQVrG7We7n48E+SeW7jk0D25Di+/5IowuwUSecYdFowrs3zU3Ar+clB
         D7O/AgEWBWfMEOmUWDep0xWKKl8zbs3ABy/eLh8Y/rqrV47ShC/omyeBMohoN+RrEVGv
         zMvNYy9Si2WXLoSyXeQBtE7pOxnk/4Z7HeqYSbK1usdxxvj/KfrRfwmgezF21rhBaQxL
         3dJ6sXHFV3I5r1Oc+FaC8rLXBwY9Jos35avaKEVvJB2z+WsyWE2Q+utTq9C5fOgPuUom
         YtjrsnSlphGxBQ7IyrYgDi/KklkyWAiY6PraldKhi3/UqKrYGyFCbNJyeSWtvQ/inbve
         nzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G7EYtpN+7APVu3hftiJBUcaii12rvBtQLcLyvFMd3fw=;
        b=K28tgkfoCC8MvqtkB+9VehH8oOJV/d4JTmfExcYPuzjIExcbmCSILzj0p8JXOqhaWV
         cVwSEOubffJF345A5/ihg4RsJK989UOrfqR7DnBFZ3wVUJvuAFRjJo5qNg/Trr5KqF76
         da2l1ywh0A8G3jrSgKL1I2KUOAkkY7gLF+4Rrxj8O9KUryB64oAxFD4ty4OGA5lTvhDt
         L+XITm9mYrvAfxtru8AYfSJ/X39KdrIo+XLIwPpjZnWNjzvcrUHd+1rZjiEAP/ay63uE
         IpTYmQlXwk+WenhJgxxb8uocXdKZjz0zkiZgFTXJ3kRBe+ETuyRjnEFrZDNRzFep8j5j
         Wu2w==
X-Gm-Message-State: AOAM531M4mn/6sThDL6JdPyB1HLr54hoXZxTES0J5rufbajX/NPLjsk1
        HEu0TvAG64wmkDhpsMhQxn4=
X-Google-Smtp-Source: ABdhPJw9IVvFgD9u6cKkJI+eEsVm8cCM5YDQSmq1Y1wrIMZkohaI0YZ2wNwSQKKZGzZRenNdJo7hRA==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr23942588pgr.89.1593062601705;
        Wed, 24 Jun 2020 22:23:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id i12sm21668804pfk.180.2020.06.24.22.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 22:23:20 -0700 (PDT)
Date:   Wed, 24 Jun 2020 22:23:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH v4 3/7] ACPI: button: Access input device's users under
 appropriate mutex
Message-ID: <20200625052318.GE248110@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-4-andrzej.p@collabora.com>
 <CAJZ5v0j7e9TzDtEiDXmj3fLAQ7CvFHoe7Q3aYKKas3PEXrsUuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7e9TzDtEiDXmj3fLAQ7CvFHoe7Q3aYKKas3PEXrsUuw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 24, 2020 at 05:00:09PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 8, 2020 at 1:22 PM Andrzej Pietrasiewicz
> <andrzej.p@collabora.com> wrote:
> >
> > Inspecting input device's 'users' member should be done under device's
> > mutex, so add appropriate invocations.
> >
> > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> 
> This looks like a fix that might be applied independently of the other
> patches in the series.
> 
> Do you want me to pick it up?

If you pick it we'll have to have a dance with this series. Can I apply
instead?

I do not think this change has any practical effect as nobody
attaches/detached input handlers or opening/closing input devices when
system goes through device resume phase.

> 
> > ---
> >  drivers/acpi/button.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 78cfc70cb320..ff7ab291f678 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -456,13 +456,16 @@ static int acpi_button_resume(struct device *dev)
> >  {
> >         struct acpi_device *device = to_acpi_device(dev);
> >         struct acpi_button *button = acpi_driver_data(device);
> > +       struct input_dev *input = button->input;
> >
> >         button->suspended = false;
> > -       if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
> > +       mutex_lock(&input->mutex);
> > +       if (button->type == ACPI_BUTTON_TYPE_LID && input->users) {
> >                 button->last_state = !!acpi_lid_evaluate_state(device);
> >                 button->last_time = ktime_get();
> >                 acpi_lid_initialize_state(device);
> >         }
> > +       mutex_unlock(&input->mutex);
> >         return 0;
> >  }
> >  #endif
> > --
> > 2.17.1
> >

Thanks.

-- 
Dmitry
