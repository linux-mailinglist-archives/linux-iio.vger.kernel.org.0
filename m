Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7222720C949
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgF1RoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 13:44:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D03C03E979
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 10:44:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so6189933plr.4
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOVfKwmmQNZr2G352QOaABowV/XDqba7e5uUpidjSTo=;
        b=jh9hcN17TwJcJSyWGQ0yN4PrII+/jU3FybguQnfb+509RC+ef7TSPZOr8OE7vkjVLX
         xA4QNoG7tfN/z3H36urNdb/JN36PrHLD44+4mK0Fjsg8mffC7uRYPKvLZmzUQqy3gMpK
         WIDmqo26+8ICQ8/e8OIbYV5DVXEiwV+wxC95Hu/e6+wztekCYOxIQMSY7ric74iQdMoL
         /NBjua+cyTfAeRe8fR4Oz4XlmbJkSDyxp7B0Xsj0Dw94SBzdfE6H4KSrOkD66zBg4cOE
         dFh3ZwcYr+kYtExMa2jyyl+V86zge/v9aFUSgufNTNA+3XUcCeKr3sAzqykj11aWU+zm
         2h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOVfKwmmQNZr2G352QOaABowV/XDqba7e5uUpidjSTo=;
        b=ZJScORz2G9EjSnJiq5xKADVwIJ+3mZOEvTkTza8cYvotR7Ft4JQFmZUHFErRlc6Fty
         QCREjtvHM2SheS1qPQLn0tUP4NNd776fOmLzxUzLxHCxzz/Rf5nk0U9wi2Yo6CaxnWhB
         +YkZhv//xrbgNVc/RaBHJatyQspAn0hkwRxhY6NldGwjw8/auOZEYIKmXtiOLtms8ruo
         kqGOsbUpsOehHtzMHIozZl7Wg3+MGa3tuXXYB+OdkfmPwV8p65TRKI+sLprJvA4mMwgi
         O3i8NJMW8V2M6iu77Td0YItdB7qPw3xffVZDZ6HPJlYHQtu/qbHHlTqDzNRqvXVeJf3/
         v2XA==
X-Gm-Message-State: AOAM53385xAAsYpwVMJcxXVoEBJpUowtD7KDsyyvaHDOaI15m5YJqpsr
        n/5dGDLMhXmsZCxD+2M/7Z0IFkhKxb3+Hxnmo4g=
X-Google-Smtp-Source: ABdhPJy2Yu9CY7fU3zcCSxUkY8LU0HgNA2herx+ESbxgzbk3PXqaQECWfAKOrllmm+0eLie2mJ7B/Rr8Q4ixSSqteMA=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr10649450pll.255.1593366246791;
 Sun, 28 Jun 2020 10:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-3-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-3-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Jun 2020 20:43:50 +0300
Message-ID: <CAHp75Vdfe=5gwM9wRpVq5+OQeSALQOhcVyENUaNDaXZpYnnRyQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] iio:adc:axp20x: Convert from OF to generic fw /
 device properties
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Whilst fairly unlikely anyone will ever use this driver with anything
> other than DT, we are trying to move IIO over to the generic interfaces
> where easy to do so.
>
> In this case this involved moving to generic check on presence
> of fw_node, generic device_get_match_data and dropping the of_match_ptr
> protection.  Also relevant header changes to have property.h and
> mod_devicetable.h only.

...

> -               info->data = (struct axp_data *)of_device_get_match_data(dev);
> +               info->data = (struct axp_data *)device_get_match_data(dev);

Casting is not needed, but if you remove it it reveals a hidden const
qualifier drop.

-- 
With Best Regards,
Andy Shevchenko
