Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A280282FF5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 07:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEFGt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEFGs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 01:06:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40393C0613CE;
        Sun,  4 Oct 2020 22:06:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g18so3111449pgd.5;
        Sun, 04 Oct 2020 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxt0ysy04CUIuZwj7WZsE2Z9ZTrTyYeaScGu6k5Gpj0=;
        b=gfNreHzWt4TPfz/30KqlxE3MmSR0uk0mNv4BhxD1qrqJU0kKDdXnMMbeoKiZ0cDo9n
         zw3xJ9K8H22DaXnZrAlKWHNLkgYI/AEBTnGiW70jS/x9rp8plOxdERg7bBxCEXxSH5Dj
         YXHXkr4RUDj+NIT4fSnmTepF7er3jlNAirotlQ0SapEZD6bEVaPAM05Vmf91Wyzz3NyE
         juXio4hcz9qeyUkl2tVR5TsqeKh5CaQSQ7eP6wPww+qzVBDAl9juAUdkOYXFZUNkJ388
         pG/3UC6TExI4FXwx/TM1GB4E2cvgU0V7QZ3nDxfm6/syOWz1HtnL208EUdiy+R9io2kT
         OeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxt0ysy04CUIuZwj7WZsE2Z9ZTrTyYeaScGu6k5Gpj0=;
        b=CS4QUaG1nVlnmZQNiOxDZ+l7DTWmY3D6b32gigdojytAvve5vTwpagxLdfGNqhgyLX
         XXjKK+05qClJn+vOUqsIZhwI+jI4euYNnJava640jUAAScTaFUsJ72oRPlrNr3oj+rSR
         hBtagG/dH/ZmrTNv2JZkCxw04luBZugcwsOVqtlF3yVnNDpkR80qkXZEPqGpuHWWLt5f
         9Trzv8wkwanKqCPy3UiWF0N4mYtOiUAm6NoR1gdqagwsMg4iTV3GP5YwJpKZ0U9u+wqe
         pc7cIzGrSsZZ72kvCDeLFDLIHjPPtdbMCThEafFLkaJDnPI/NAb9SikBfMtlUusNo8cG
         OSEw==
X-Gm-Message-State: AOAM533vMj4hBUUio9WQnFujmhYZU72c1R4qwJ9PaIroSwy5a6xKN3XL
        naThKXN38t4SPqGs1dhifQ0=
X-Google-Smtp-Source: ABdhPJwKCvznRcFib6nkD+RO0m57F4NQznJJCICJJkM3Pz3kXgehY0ax8kdg9YjCt0l6aqeH/wrt+Q==
X-Received: by 2002:a65:4cc1:: with SMTP id n1mr4035788pgt.404.1601874406624;
        Sun, 04 Oct 2020 22:06:46 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m11sm4684586pfa.69.2020.10.04.22.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 22:06:45 -0700 (PDT)
Date:   Sun, 4 Oct 2020 22:06:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
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
        kernel@collabora.com
Subject: Re: [PATCH v4 4/7] ACPI: button: Use input_device_enabled() helper
Message-ID: <20201005050642.GH1009802@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-5-andrzej.p@collabora.com>
 <20200625052446.GF248110@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625052446.GF248110@dtor-ws>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 24, 2020 at 10:24:46PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 08, 2020 at 01:22:08PM +0200, Andrzej Pietrasiewicz wrote:
> > A new helper is available, so use it.
> > 
> > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > ---
> >  drivers/acpi/button.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index ff7ab291f678..4deb2b48d03c 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -411,7 +411,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
> >  		input = button->input;
> >  		if (button->type == ACPI_BUTTON_TYPE_LID) {
> >  			mutex_lock(&button->input->mutex);
> > -			users = button->input->users;
> > +			users = input_device_enabled(button->input);
> >  			mutex_unlock(&button->input->mutex);
> >  			if (users)
> 
> This chunk (pre-patch) is really wrong. 'users' value is obsolete and
> can not be trusted the moment we unlocked the mutex. "if" needs to be
> inside critical section.

So looking at this patch and the previous one again, I believe this
driver is wrong to key the behavior off input->users and we should not
apply either of the patches. I'll post another patch fixing this.

Thanks.

-- 
Dmitry
