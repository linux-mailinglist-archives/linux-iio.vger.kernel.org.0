Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E0207638
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jun 2020 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbgFXPAX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Jun 2020 11:00:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389043AbgFXPAX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2020 11:00:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id k15so2167936otp.8;
        Wed, 24 Jun 2020 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eykhWQcNNxAwrKLr1Dkv70utXgS770FMiPrM6b8KPjc=;
        b=hkHeIouE0X74Rn2j8Igk/XY/4jOLE8DlfLi2yerUJcVKFK2NOOdBPJbwUwayFt9GQG
         WS5VZ/1HkAVQNdCD4Qw61wOfGp6p+kXSgTgiww5uGvWDHsnEHfavrw6TnCFiUMRwADaM
         Gd+nb664kj4N2CTEWKSFKzOnyCSUoM4CJG3iDxh/Lw+ARo+KhKTWSa8WSAFoE6O8KrIX
         QqKdDMntr1VZNUZn6VVodgXBpCRtWjQhYS0+9AUQSTZC3SGGEvb1PV8vyNRtbJ0zOqwk
         BQ8u0iVIWuDqnwsJPwDKJqWcWWf2h1JXRTSBmURpbESG15E4O2MZV9ck1Df4AXDW5atK
         cjyQ==
X-Gm-Message-State: AOAM5336mnoguDHEPE24ywgzFB52m96XoeX9G0UfGu4pFJP+u37TYJUY
        FSdV+YfFLbHlIQYcFgyWWiYMoRFz/kyJSlvVZAw=
X-Google-Smtp-Source: ABdhPJxTfu2nRQ0ID+eDw+0oWm7stVdBgfOBXZxtPamhCD54VzLFyKUSp9gBGIPEG0mIIAqQQkSpe0tvPBek2gXWEWg=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr22236731otn.118.1593010820398;
 Wed, 24 Jun 2020 08:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com> <20200608112211.12125-4-andrzej.p@collabora.com>
In-Reply-To: <20200608112211.12125-4-andrzej.p@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 17:00:09 +0200
Message-ID: <CAJZ5v0j7e9TzDtEiDXmj3fLAQ7CvFHoe7Q3aYKKas3PEXrsUuw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] ACPI: button: Access input device's users under
 appropriate mutex
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 8, 2020 at 1:22 PM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Inspecting input device's 'users' member should be done under device's
> mutex, so add appropriate invocations.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

This looks like a fix that might be applied independently of the other
patches in the series.

Do you want me to pick it up?

> ---
>  drivers/acpi/button.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 78cfc70cb320..ff7ab291f678 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -456,13 +456,16 @@ static int acpi_button_resume(struct device *dev)
>  {
>         struct acpi_device *device = to_acpi_device(dev);
>         struct acpi_button *button = acpi_driver_data(device);
> +       struct input_dev *input = button->input;
>
>         button->suspended = false;
> -       if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
> +       mutex_lock(&input->mutex);
> +       if (button->type == ACPI_BUTTON_TYPE_LID && input->users) {
>                 button->last_state = !!acpi_lid_evaluate_state(device);
>                 button->last_time = ktime_get();
>                 acpi_lid_initialize_state(device);
>         }
> +       mutex_unlock(&input->mutex);
>         return 0;
>  }
>  #endif
> --
> 2.17.1
>
