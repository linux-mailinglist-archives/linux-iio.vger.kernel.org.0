Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7503D4FE7
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGYTxT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhGYTxT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jul 2021 15:53:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25640C061757
        for <linux-iio@vger.kernel.org>; Sun, 25 Jul 2021 13:33:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so9222389plh.8
        for <linux-iio@vger.kernel.org>; Sun, 25 Jul 2021 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okugLEzlTny+fzrF2Q1ytbwzo6iSoRoq0kbMzA1eNts=;
        b=An4ymJBEXfKS/Pft32azhmP7KpqnLdx4GWQmew2ex1OMsa61A31/R98Kgi+Ak3HTDQ
         TWqc3ounA4whs7NKJePj64C1Y396A94qOLIUfuicdsJ/7J9ZgQcGpChF1uueiL2mDBFR
         u3DWRcwpeWQ/Y86eSMPxDv8GBE4KcsBC8BywfPHYGULYAxdYwP3nMGbtQSvslCyj784x
         KdFkqAgS26tnCqjU9bsCT3Rn63yNgJGsSOk5CCE/OlS+p/obNMwafGvFSxBo1RCgXt01
         BQnK2WyfRNxwr79D4tx/a5YRh/r0BWXdnx8nRBpQ5wURAynvzLJ682AVRHo8UpRYa67/
         +L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okugLEzlTny+fzrF2Q1ytbwzo6iSoRoq0kbMzA1eNts=;
        b=DF9VpzAgVRk3c+Aa3OWwLv0pdi/4TW+c2tn8+C0BxXdKbI9UjW313eo8IcaGQDDcMo
         f6g/BZAHgPt0ugBPiF7Z0i3F13J0VrdeEVZ0p1HVYY0s5O1UT1mi3ZnJ+ObsBqA8nfwq
         8cKQOak2fkIt4sRTAGrzzW6RaeGjpZMixho+nxtaq1OAGcrneUITvzNWok7Pf26hwh3V
         z5nlAHkoqJqv54aC8LpLgDNpcgiSSICvSmYEgPlJlqyhJo9cd4T4eht4b+go3VSSOQIR
         p84EhHgt9CMHZEHTv2FOQopQFlUjQ0djR/Y8dIZj352s5jO1hrl/NXxl8rDH3VhxKFt8
         Bmhg==
X-Gm-Message-State: AOAM530pg/ie4CiAoZW85R1SA1CKTyDgB1fSIeIsTa339VVt26w1zQZv
        b5NsfCqlwZXmkaDa/Ub1inUMiE7SwcUjvsOM1T0=
X-Google-Smtp-Source: ABdhPJzYHTQttZutVxtX3A2Bgu4c32yVDm3ICGY99R5yGpkpRdxHucBc1VxNkjtBlMQbcSWuA+Q5BSIXam07Tk3gygI=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr15242577pgg.4.1627245228719;
 Sun, 25 Jul 2021 13:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210725172458.487343-1-jic23@kernel.org> <20210725172458.487343-3-jic23@kernel.org>
In-Reply-To: <20210725172458.487343-3-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Jul 2021 23:33:12 +0300
Message-ID: <CAHp75VcgMkPw8BudKkF9MN2ijjDuT=VRo3FivVcjEYsEY4L-0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio:adc:ad7124: Convert to fwnode handling of child
 node parsing.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 25, 2021 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Also use device_get_match_data() rather than of specific variant.
> These changes enable use of this binding on ACPI platforms via PRP0001.
> Whilst it's possible no one will ever do so, this is part of a general
> effort to clear out examples from IIO that might be copied into new
> drivers.
>
> It may appear that this change drops the check for status = disabled,
> but in reality it does not because the of property code uses
> of_get_next_available_child().  This driver may well fail to probe
> if disabled is ever actually set though due to the need for
> complete concurrent child nodes.  A future series might resolve
> that restriction.

Perhaps we need to have

...

> +       device_for_each_child_node(dev, child)
> +               st->num_channels++;
> +

device_get_child_node_count() ?

...

> -       for_each_available_child_of_node(np, child) {
> +       device_for_each_child_node(dev, child) {

Isn't this
  fwnode_for_each_available_child_node()
better to use?

...

So the gaps I see are
  device_get_available_child_node_count()
and
  device_for_each_available_child_node()

Both of them I think are easy to add and avoid possible breakage.

-- 
With Best Regards,
Andy Shevchenko
