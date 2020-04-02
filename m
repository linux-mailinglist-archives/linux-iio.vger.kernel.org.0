Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C595B19C8FF
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbgDBSpp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 14:45:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42790 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbgDBSpp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 14:45:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so2161962pfa.9;
        Thu, 02 Apr 2020 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWr69Y/Pu+l3rKDfB+kaa0Y/R2YkkQ/XWcl9cAQ2XGE=;
        b=gJTpKAdkvdg6y/jhsrxUL+gJw2S/100D0rlWTfzoycDhCIJPeLFjN2QfhfnliVgt3T
         q+u6LtlWB1S9CkhU7CebkOMVhvNdWUhveRE+Fwf47aBxyXOWzHwAJyy3l8KeVqu0/oDX
         ArqyLnxpz8OFhfVK/NnYu6J2YXzabkRsNS7NHDaC4+k7dddSrBGPn6UUhipUJrkUbTWO
         RWBhtdXZvZrPySnysWSrbymBiuBsJ/N0AybDt5koPczRxjQMP6ZnDGRBB7rupK036Irl
         xHeL6xDIKRKGD4BavjBTSbW7LR674w3hAR3GRSKUUEfBW/CAxVx0aS8/rANOPLwbkTS1
         4JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWr69Y/Pu+l3rKDfB+kaa0Y/R2YkkQ/XWcl9cAQ2XGE=;
        b=Mg2GrnOQ1x0CnJmxpKqYyMhdMGTk1idNpaBx4oLU4nI27CX1e4XGDB0qsNsiRi5EMw
         NKkTvgpAgSJbVipq72tHUl5mbv4X5yhGS1pBpNYHDPOwzbvuPW6CAqCNUs/56I28u2+h
         7GPnHhI9+xCjf+6NXsTRyZkWNKwbBpSLEofc2ZVw+53sUIX11CsS35+xvE+zZCxjfCmH
         TwWgOKgaHbZ2c9fz4xhMsQkOcwUe62+GNhXwOhvqnXlmSBtB6tdEnUvSeQsSTzclPX4A
         iMH4H/48/MM97elJT19BNcVce7UO/rB9ncbu6cIpIWd0mNoQ4u9hE2AMeiFbSZblXu+R
         0qyg==
X-Gm-Message-State: AGi0PuYPzXkGwQtN4/9XWAfzORLXVWBmBFaDC5laR0ehG7k/0XWx+9io
        85rLHAZnZpTxCSLGQnVZZ0E7uP0/LU1RHPvCEU0=
X-Google-Smtp-Source: APiQypI5LwmZIG1K/ektUM79THvuM7P1xsTKZ/wmHbYlvtEyby8PesDjPi9wJgJrB46N+1tEX9yeNKQuphv+vMynlxA=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr4374221pfj.130.1585853144097;
 Thu, 02 Apr 2020 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200401185138.10673-1-alazar@startmail.com> <20200401185138.10673-3-alazar@startmail.com>
In-Reply-To: <20200401185138.10673-3-alazar@startmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Apr 2020 21:45:32 +0300
Message-ID: <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 1, 2020 at 9:47 PM Alexandru Lazar <alazar@startmail.com> wrote:
>
> Add driver for the Maxim MAX1241 12-bit, single-channel ADC.
>

Perhaps put data sheet link as Datasheet: tag here?

> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>

...

> +       indio_dev->name = spi_get_device_id(spi)->name;

Shouldn't be rather part number?
Jonathan?

-- 
With Best Regards,
Andy Shevchenko
