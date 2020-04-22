Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3553E1B39F9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVI0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgDVI0H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 04:26:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AEC03C1A6;
        Wed, 22 Apr 2020 01:26:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g30so713251pfr.3;
        Wed, 22 Apr 2020 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV0Q009XDUBEJ6XOBiBMysKQr9TzSZ+SGvleeYy/DRE=;
        b=lbCTeiS72NHzKWWYdWdfDa60Hq6oYQzqTo5vFJSmMqyrhbKTtHlQtvOWKvhygmOAaI
         1wT+bPsMk7/1IxWz/YBxWP30rH+4lvAbCmyK6mmnfqVlYJDHWqXa7zRlvJPzY1aGXex+
         wLxdS61HfpILOtiMbgBXgY0Gad2514Xp1zoPkIS0s6SnqxqD8WgDfTxu5HB/+r4NqAn4
         2FiZ1GpdFjOlKm1lzwTdpumw3++JUq41xQeYpyi46eO5LLls6+YuJY/c7txYqQ3gl9lV
         +0SmhcG+oL2fItZwd29oJ+sGAQi/jyq0YClaG7xKRk9oN1i570pdmPU84dQyCRkz3S7X
         1TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV0Q009XDUBEJ6XOBiBMysKQr9TzSZ+SGvleeYy/DRE=;
        b=VSmGbBWYFw35bP5xGY95fiUE9eda473FNH2JjoyJ+yGaKTV93gRYkspccg0bMgjUr5
         XbDL+Wel0hgpCAngDrMSpRZEA+YZy+UHlKMLCZzLH8U9A5qupzJV9Ho7iQjpwoQgGAv2
         ZF71ENLYAFv3qDJESa0T73748dkU1tUXg2wZxAtz9mar2jfZjXgPDX3/RcR10zsrjgJl
         72o/E7zUWnH3NG2f3LFgbMxGqq87xSsEr4oDuNd7QbfXrfaMlSaufUDziuJhsiQ68+UA
         J0woGMZx9oPpNh5vXQQBap/CJmGsMz59bNGufHPlwbB5z5KkUNVBMFNUZDgIEQu1GoIs
         k0Jg==
X-Gm-Message-State: AGi0PubtwUC3GdT74KFE1xUsqDy0jAnHF6bpJin9Fs5CMi6Mt1q8U6hb
        OpWLVa7Opzjc0P97X0mJCSWMY1jOHMmHNfCvNUw=
X-Google-Smtp-Source: APiQypIWi5uaJ/1YONSBxvQIqXuWQBCMBUadEMTEMHTUEbzMbXXw4yeVu01h99Jnyczvow4z6y6v6lRLhkHARCUB9+A=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr24959141pfb.130.1587543965739;
 Wed, 22 Apr 2020 01:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200421075532.19192-1-m.othacehe@gmail.com> <20200421075532.19192-3-m.othacehe@gmail.com>
 <CAHp75Veqp=tb0Z9h2cey5DE_KpNBp3Jdmh2gLzSoo-N5CsGpvw@mail.gmail.com> <87y2qoosn0.fsf@gmail.com>
In-Reply-To: <87y2qoosn0.fsf@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 11:25:58 +0300
Message-ID: <CAHp75VfE-0Uw1ii1P1Sen8fuoiiXjqxQTBOx_11rzXfHiQchkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 11:02 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> >> +               ret = devm_request_threaded_irq(&client->dev, client->irq,
> >> +                                               NULL, vcnl4010_irq_thread,
> >> +                                               IRQF_TRIGGER_FALLING |
> >
> >> +                                               IRQF_ONESHOT,
> >
> > Isn't it by default when threaded IRQ is asked with NULL for hw handler?
>
> No, and it fails with this error message if IRQF_ONESHOT is not set:
>
> pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",

Ok, thanks.

-- 
With Best Regards,
Andy Shevchenko
