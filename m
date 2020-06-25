Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0629420996C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jun 2020 07:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbgFYFYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jun 2020 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbgFYFYu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jun 2020 01:24:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3BC061573;
        Wed, 24 Jun 2020 22:24:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f9so2520187pfn.0;
        Wed, 24 Jun 2020 22:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXdubhTV2rFDKkg/iMiISj5sENkZjDy3A69VIM0beEA=;
        b=otZFkn+xlIJ6hX0J8f+jfwEquSCD1xAz5RZpMUYHAPHAnVIvN+uW98AINOqq4g+NOm
         xL4CZPN2A0vT/ab2Jd2XCzsm6Q5/w8wOML61MOiIDVoBMz0OrpivZ0swlsFXgZwZAcwW
         7DyEZ3/HcKlU1DhOwjTO29PCtzk1lP3TKVS7Lx/82NZEuHIr7JuegxtHHeg4Ha6AI9QG
         daBSc/WMaTGe71/ywHgvTXa54cykNjtby8nkPFqvB34fchJIGyb42BqUtsasKGCOi50C
         DFE+jfZGA7VjFK02RrnQRC5elhGL3QxISyOk3L9XjmBFuebg2RHUMANKgHLaVXcl4OpP
         E8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXdubhTV2rFDKkg/iMiISj5sENkZjDy3A69VIM0beEA=;
        b=KPPb3QshvGySRkFFgd59VqMy0U6S5RZaO/AhcFaBtxv6hb0ZKUq+8RkB2vINk5AnMi
         8XIP9wgvxS4ILOkdLWgnKJESAPhoQ82FjW3s+kGjmt8yfqvS8w5+eOWtpDRhCL/yeF7R
         fK0KnzHMeITGoND3DtPOoY/tc8VTZKcMbVJqmAcxHg1tMfdZrfKSwwcVjZHty/D/cLwP
         uhZXxXqzAioPORvSXPsT8fW3CrdFimYtr5q8cDeOOyu+jpugXfwPg9D+g/Q4Mg7EnBUS
         aRlc2DF+kvRXS2QZRNfYPx2qvTpfeOV6FXTR7rZ9DdkL0gumQe2TYnB/RrHIkeOXz8ge
         UmrQ==
X-Gm-Message-State: AOAM530o6lA9xqgxvw6+nvh8ElPDhpX2KqTq2RGBdSzeHu2GWqa93THp
        rHXIpcoImjlNs0g+sg3di2o=
X-Google-Smtp-Source: ABdhPJwXGyiFwlJTNgi0iC6m1Ar4lC3vQXDwOYiT2Ha8Mwjs8VUcVJ7cPdCOD7pg7k+ICwf1UB/M+Q==
X-Received: by 2002:a05:6a00:7c6:: with SMTP id n6mr30520985pfu.120.1593062689506;
        Wed, 24 Jun 2020 22:24:49 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id hv15sm6763798pjb.17.2020.06.24.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 22:24:48 -0700 (PDT)
Date:   Wed, 24 Jun 2020 22:24:46 -0700
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
Message-ID: <20200625052446.GF248110@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-5-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608112211.12125-5-andrzej.p@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 01:22:08PM +0200, Andrzej Pietrasiewicz wrote:
> A new helper is available, so use it.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/acpi/button.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index ff7ab291f678..4deb2b48d03c 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -411,7 +411,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>  		input = button->input;
>  		if (button->type == ACPI_BUTTON_TYPE_LID) {
>  			mutex_lock(&button->input->mutex);
> -			users = button->input->users;
> +			users = input_device_enabled(button->input);
>  			mutex_unlock(&button->input->mutex);
>  			if (users)

This chunk (pre-patch) is really wrong. 'users' value is obsolete and
can not be trusted the moment we unlocked the mutex. "if" needs to be
inside critical section.

>  				acpi_lid_update_state(device, true);
> @@ -460,7 +460,7 @@ static int acpi_button_resume(struct device *dev)
>  
>  	button->suspended = false;
>  	mutex_lock(&input->mutex);
> -	if (button->type == ACPI_BUTTON_TYPE_LID && input->users) {
> +	if (button->type == ACPI_BUTTON_TYPE_LID && input_device_enabled(input)) {
>  		button->last_state = !!acpi_lid_evaluate_state(device);
>  		button->last_time = ktime_get();
>  		acpi_lid_initialize_state(device);
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
