Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9173D3A0E24
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhFIH5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 03:57:04 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46600 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhFIH5D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 03:57:03 -0400
Received: by mail-lf1-f43.google.com with SMTP id m21so20845016lfg.13
        for <linux-iio@vger.kernel.org>; Wed, 09 Jun 2021 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDGkNe89BzRm9Jlr08qpVw28pGox1R+wE4oniTqXN7c=;
        b=Eq4N69cxpLxqbNT9lC9pJnBwY+wZts/pkoPQgVl4FA3wlbg9k3yqTwACXcSgQ7T2BD
         +93E5qiSL5CyfTLlJmu7w4M1crPy7IBAK5CaVlRb99JIDBcl7539GtUDeD5IMEHbu+2f
         vGe4YZhpuQWO8Fp8JEsFTm8ILj4q/JBYIGRcdIKYEvYggqymz3OI8A2EGT8CCRJDFX6z
         EBmsKyGrItnySyxQJkBEa/3XO09a8LIWMZzK70rZn4fG9KxkzZD+vpaxSwbfl8PjbLNz
         tqoxoG6cyfYotbuVriFYC9ZwlpsOqaIsfDgTw/qvomFjqopehxshElYpa3gK0USl/p8J
         qzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDGkNe89BzRm9Jlr08qpVw28pGox1R+wE4oniTqXN7c=;
        b=t14hfEqOnpmh891qaV1myln8GOn25AuHbhBqbeDJdrxLcObMOGW4iaVJRF0zp28Qft
         5g1Lv9hNdKi43zxWeZxw30xz87b6WtgEmCB4mxIB6Xa0l2RpsYleKGIDlwMQDO0BPFaQ
         nfNi9Fw6ODGKfSDfbKH50mryIkcgkQbd2bfD8cqlgqnrpUdBT2WmWzdItkjhIB9AFFhz
         lG2CkQ2VbjmiY2ZVycoTd6htui5dOLsirKNTce5XX4vxHBJfFQDAs5ZeEWM5QZ8H/8s2
         fbwv19In/cLOw3IuGrjVy2UjAXmlQWr7N/6CDJMQI7T0N602niHLiYe5EadX1m3Pu9Oo
         K/Sg==
X-Gm-Message-State: AOAM533K973aGJuwqpfL30EzVebme4nINM4uCiYcEnl9FI4wYLwc7a8M
        Ef9P3a1wc6NKjymRdz1VL6+v145O0raAZPMi19s2gQ==
X-Google-Smtp-Source: ABdhPJyC0jrzBj7RWC4W2WjGOMqKBWBFyLY971hxVbCjwefgf/QEE16C2zobK4ncg8GP81owsacPVf2xvVXLp9ZO6fA=
X-Received: by 2002:a19:c753:: with SMTP id x80mr18283112lff.586.1623225248182;
 Wed, 09 Jun 2021 00:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210608175149.4019289-1-jic23@kernel.org>
In-Reply-To: <20210608175149.4019289-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 09:53:57 +0200
Message-ID: <CACRpkdYmToL445kE5A53+sRitFxsn5e7sn+PPiQiPv1OocDopA@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: Remove some unused includes and add some
 that should be there
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 8, 2021 at 7:50 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The st-sensors drivers have changed in structure over time, and includes
> have not always kept up with this.  Let's bring them back to nearer
> the ideal.
>
> Identified with the  include-what-you-use tool and careful checking of
> its suggestions.
>
> Note I haven't been particularly aggressive here, so this is just the
> cases where the include obviously isn't needed rather than the more
> subtle corners.
>
> Note I took the opportunity to add mod_devicetable.h as I generally
> prefer to see that when acpi or of match tables are present.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
