Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA572D4488
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLIOlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 09:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgLIOlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 09:41:01 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05CC0613D6
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 06:40:21 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e2so1314394pgi.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 06:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k7spO7KLS0qnJlXk0XaPm/RJ7BPIr/fPgilR5M+bKY=;
        b=UnzP4NO7cI4M3oe+SSIlQtzSt3pBufk8DptILzX6Bvi9wvH7/Fn2ByRw9wtZVi06Ku
         yD12FvEn4JjguHQGS+AYPZUAUApgiqvJmhjleAxZNHxrAvHg6D/5yyC8vba35dXvpf33
         jhBj9xffuCMuHXrUX1tSuqovL42PkspxGN4FH9LPB0mhOL9VNLgfrnqBV9knOf+2n03w
         nn8jUfkR/AxW8mRJCp1LB8iKcD1Gj6VywKQSHKiVvqxPZcDX9T5Ra35GYNpiluHN+qYE
         GGA8PiX2LKVYyLmIkrzqphp4SIBTuy2OSgiMu6Z/afPFS0OIfFokZvfDx6u3+5pZDFC7
         QALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k7spO7KLS0qnJlXk0XaPm/RJ7BPIr/fPgilR5M+bKY=;
        b=fT7IJ+yyHV9k6hYJri4HK0h3RpStex85WGfzBzo/4RVs+X4T7JVjV6BLXUJ0CTYcnT
         mgdXeMgQCxBiG0BG9ljV96kbd+iX/dsH8nOpo9arquXhjkHIfCSshkTP0Yj+JHNVzMf0
         fjBA8y8c/k21Lj2wBWWF9uWxadnKP1WDkR3YykwjgusOUANCJEPnE5KduRGNaLYlbslU
         CNjbrQK0fda0vbzmoeFCzL3bID1rigpxKPAVGaT0g9Eg5ejyWHxmt2T70+vgLJgSRHcu
         FQqK3oy6fnvsviHT4zdx94TvsBAKytLwydo/nO7X2MIV4JwY2WdkTl1lbcYHdZV4kQ8O
         I6VQ==
X-Gm-Message-State: AOAM530hETUziV7nX8EJ7EeCzsnNfwQZXIyef7SWw0Pddr8gIHeHOG3T
        bff07PkgIVIjPygedQfAW6cdq0NgbvILtqg0CoM=
X-Google-Smtp-Source: ABdhPJzBsdEZQMIm+aKUQS3zjoAQmCPPIZkAsCjJ2/n9Hcry2AzSXp0Di4BiRylvIcleXkR1ZzeJuko2yEqcA3DJv3E=
X-Received: by 2002:a63:4002:: with SMTP id n2mr2284269pga.4.1607524821114;
 Wed, 09 Dec 2020 06:40:21 -0800 (PST)
MIME-Version: 1.0
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
In-Reply-To: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 16:41:09 +0200
Message-ID: <CAHp75VdqYxfdS5+zPsj071HSJ_CG3M8n=zfoTwg=jf-f6_naUw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 8, 2020 at 4:38 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Return a boolean value in st_sensors_new_samples_available routine in
> order to avoid an infinite loop in st_sensors_irq_thread if
> stat_drdy.addr is not defined or stat_drdy read fails

...

> +               if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> +                       dev_err(&indio_dev->dev,
> +                               "edge IRQ not supported w/o stat register.\n");


> +                       err = -EOPNOTSUPP;

Wrong error code. You must not return it to user space (or you should
fix all call sites to be sure this won't be returned).

> +                       goto iio_trigger_free;
> +               }

-- 
With Best Regards,
Andy Shevchenko
