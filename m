Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEC3423A5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCSRsy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSRsx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 13:48:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C66C06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:48:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so7114608pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KJyyJ9mdrUZmoi9juEn1IA8YndKGBGSVerMITk6BSQ=;
        b=dgL3f3arNmYPHGlKVr3jX3z87FhZDiorqFAZ/mXCOfvfKiBxjpMn3f9a9tCNxlrCVN
         dNilw6yBAajdNu0R/gemehag+sdA8himG3UtLIjbL643RMxQbUaGkkM7iggm/ZqzmyzH
         9dES82b++ryn2abHA5h7I/BNJZP+LMUYTNKCLnOUJxd7KfQz8K9bnlOBnH4ggZ4JN61W
         l1D1alUHDt/Ndh5y+vZ5JepBU2YU40U+vY8oU14UuHIHVpMVSXgGKPKYoKi3SR9tq8gk
         G86E9kR9GgcMnIbOfM0vxq+YoXcXNWyUjRcwc60JfiZBE0IGNIRwqZLq4mhlYBMx9vo0
         kgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KJyyJ9mdrUZmoi9juEn1IA8YndKGBGSVerMITk6BSQ=;
        b=J05LV/aAaQ4YuSZ9zfLBn8ScjQuDtHXh0U6qeK9MSCt9m7lqveCDMQrk2SLocS0N/+
         fqGzk89z1I6smmdo4k1knE71vxd3pw6BJlnW2mTJV/QbFB/Ff6mwciAB3HdeFjcERXBx
         bFrtIEldhFmuzJFjyV7oA0istIEnG6dQCxTUMKnP0wYb5yqyMvana7xvEB04FTbmOr26
         w9SBRAgHDuHRvYOoxyWJsqro9vxaY1zo/2gD5NfiHYHBaMnQlZSyJxcHry2Gdl6uSDY6
         F4t/AuTi73Y7u82rEzPOPQVboFNIao6jHubPGTHgHePMrGiiJexppucmCR0tvex8Lkmb
         7GnQ==
X-Gm-Message-State: AOAM532zk3F1mYqHmzRNhVuRAQvxMVi55tHKJTepox/yPVQNnx6Bxvbo
        ymwoBQ/T297z4N8+BEhzYN+hW/M9r6ecDJpuepg=
X-Google-Smtp-Source: ABdhPJxTmNwCWMhuzx+pGdlE3oeNxFF9dRopbhoS69iKbf7MzvEorzrZn30HiTBJZXV0CZvLidMH3vn9NBt1sVTiNlM=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr10770671plb.21.1616176132710; Fri, 19
 Mar 2021 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210319165807.3639636-1-gwendal@chromium.org> <20210319165807.3639636-3-gwendal@chromium.org>
In-Reply-To: <20210319165807.3639636-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 19:48:36 +0200
Message-ID: <CAHp75VeEV1ttWd1SKdrLYJZyN=4nDgcoKPTBCbdXOdh=J5fG8g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: sx9310: Support ACPI properties
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 6:58 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Use device_property_read_... to support both device tree and ACPI

device_property_read_uXX()

> bindings when reading the properties we need to configure the SAR
> sensor.

...

> +               count = device_property_read_u32_array(dev, "semtech,combined-sensors", NULL, 0);

device_property_count_u32()

-- 
With Best Regards,
Andy Shevchenko
