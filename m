Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98EA1983EA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3TH5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 15:07:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46344 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC3TH5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 15:07:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so9032573pff.13;
        Mon, 30 Mar 2020 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmnH3rera8wNeq52dRP7sYLJorb76j9t1Bss52B1zk0=;
        b=CsiQlVU+bjcbRdarIqig2kKkx7cqpd37z4dUL2RENjJy7mMb3bG89IV5kXriYeu2Z6
         z2NpmIQryXLDaswoiLnK9DOtnsVkk2pVOpAeeXJ78PegWPaFZdXjIhS6wYb+HC6kyW5g
         pOvu/zqM6i/kPuDhjTMn5ucxPkbMhlpQx+yIyODYB7CCBSAfsPEWpqnWvb03BYmqbqJU
         KWYUl3wo31GoIlI4N7X+AXH21bqePVzDmU7tKoOUBAlhtUL1KHibGRuJq91byiKz4X5v
         Y/yYx9kw8BXWMJiW2obPjc6nAy9XsMA18xI6rTyf22ctRYLYwD/DcbrH+bJbavKcmi4H
         TuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmnH3rera8wNeq52dRP7sYLJorb76j9t1Bss52B1zk0=;
        b=c2TbBXGCh54C5t+ixFQmatZvF3BHuOXJkZ4Vv3Kpb82WWELZ2029D5EdCNPQMP/1EP
         0JOddwWrqGDsNtOHHkQH3NZBli8f78nc9Ml5xofsBhE79PtBj8/fq3oobk0XvE8As1Js
         gW+4M+ixU5t5a+1jnzxXVv840MR2y/tpIQVEmcrvJ4lV0iL9VYLMLCzXwGidvYNqDbRt
         cdiTte1vJKYGTXxAATQGEThtyrNm+DwnZJW0x7dNR1yHN+gQMn5fpQv66A3fi7fZ3ZzN
         IZwZ+dyWBBQybtrqXQVAkFtPo/osz5KK2om3ENaeYShOtNk6s1xbjAm0StVYnCoY74wY
         bkew==
X-Gm-Message-State: ANhLgQ3A98B/cPoAuUKlYnVnLNEPwgp5gpeYToXvRlvbont+cphooBgH
        RQud6y+dgZgLJZlOP1sVmhK2aW6BW1OKBjlqn33LYKelA3k=
X-Google-Smtp-Source: ADFU+vv2/Ok8QRFv88ZZ2f0YVmbslivXbBYtvIVBvtbsp2Z8sMjUFrqmY+CiQtz4GCTtDv7Ki2aFG00s/SveGo9LLpA=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr13828976pfj.130.1585595275509;
 Mon, 30 Mar 2020 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200330152711.8769-1-i.mikhaylov@yadro.com> <20200330152711.8769-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200330152711.8769-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 22:07:43 +0300
Message-ID: <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 30, 2020 at 6:27 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

Still my tag applies, but
I have few more comments below.

...

> +#define VCNL_DRV_NAME          "vcnl3020"
> +#define VCNL_REGMAP_NAME       "vcnl3020_regmap"

I'm wondering why you need the second one.

...

> +       rc = device_property_read_u32(data->dev, "vishay,led-current-milliamp",
> +                                     &led_current);

> +       if (rc == 0) {
> +               rc = regmap_write(data->regmap, VCNL_LED_CURRENT, led_current);
> +               if (rc)
> +                       dev_err(data->dev,
> +                               "Error (%d) setting LED current", rc);
> +       }
> +
> +       return rc;

Why not to use standard pattern, i.e.

  if (rc)
    return rc;
  ...
  rc = regmap_write(...);

?

...

> +       if (rc) {
> +               dev_err(data->dev,

> +                       "vcnl3020_measure() failed with error (%d)", rc);

Perhaps you keep same pattern for error messages as in previous function(s).

> +               goto err_unlock;
> +       }

> +       rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res, 2);

sizeof(res)

> +       if (rc)
> +               goto err_unlock;

-- 
With Best Regards,
Andy Shevchenko
