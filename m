Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AF363009
	for <lists+linux-iio@lfdr.de>; Sat, 17 Apr 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhDQMvC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Apr 2021 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDQMvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Apr 2021 08:51:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A095FC061574;
        Sat, 17 Apr 2021 05:50:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso17851477pji.3;
        Sat, 17 Apr 2021 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC5OiihKMgrfza4TGRNLOPug/spoci6zSb6GTHJlcLU=;
        b=J1IA8epO3GJTk766eaG1mMs1CXup2YSrJChiOZe1ip6Bv+zRVTxLbsvTO9G+Kf2xx4
         FbfZTpjR2fQrf+fSpcmag6wmqMukH95GGXvqzIrek5j5H8B2L9CXEWiBiBGvy8dNxvIj
         IRvwjPcjJT14nabrdrVbkAIChWQdbsWTfUrZFsRjAKQHdEGAWT30DlbXLBtDzhVTcO0D
         9WTP81u/qY9yw33TdbzkqqKQkMAX2n5eOM3YceftIZtuB9n97Z8fYbjuDtxaS746PbLx
         pGgygVQNLycUhagH4hURFDPLXiSS+pob+79ZqVZ+pIQf2SpvLfPl45yYcEh5zdWiqWkW
         VPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC5OiihKMgrfza4TGRNLOPug/spoci6zSb6GTHJlcLU=;
        b=kguhd+a1DXTN/YesRkfWAFzuExL6+OrQMZZ0XmXpntMbsiuQKMTt7vZuO+ESJsAnGH
         PoUvRbenaN23pTbXkZkgWYYHLFkCkcfpIJbBYBup2ZFdwZy6MQkVyzKs2W66JGeec08Z
         LAvgCRE7ilRN1XVK6PKlhwVbGi5Yjze0b1yokX6po7XaYNIY8/P/7MfvGNWB9hrGlkU5
         IVNKeF9Mar/QziotQuwUTSmM6OWwzKAjNKTrpKPY9uoOkfhIg64InukwIQrPbz1v4wJ2
         CC7VJx10hWuAyeSKNkKmKERX2nmkevV+HNf6RQUfC7T9oknd4681WtaDUVQyzl0bYLnb
         Xfdg==
X-Gm-Message-State: AOAM530FUsOdV7SQ56JrvehiOnFGlBfW7PJ/NYAqZD2F+lxvRhAFIfLt
        HB3EmVmSUI/46xfVZhaASoE8XYNO0DvLfb5bfY0=
X-Google-Smtp-Source: ABdhPJzZa1GQ2+K3AtNS9szk8w6Of3Z2NehE7ghbt4IKB2Ujf5D6USW0eOylX8wDZd3igCsQ7J0ixBXCkEeHQzdfB0Y=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr13980053plq.17.1618663832771; Sat, 17
 Apr 2021 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210416174902.9036-1-joe.g.sandom@gmail.com>
In-Reply-To: <20210416174902.9036-1-joe.g.sandom@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Apr 2021 15:50:16 +0300
Message-ID: <CAHp75VeSNDdY_jUsgy06mLpLVXnuyw3NjvxJBN6D-cxV5-VvUg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] Added AMS tsl2591 driver implementation
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 16, 2021 at 8:49 PM Joe Sandom <joe.g.sandom@gmail.com> wrote:
>
> Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
>
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
>
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.

Hmm... It's v8 and the subject line is wrongly formatted.
Please add the corresponding prefix "iio: light: ..."

Otherwise it's in very good shape.

...

> +/* TSL2591 enable register definitions */
> +#define TSL2591_PWR_ON              0x01
> +#define TSL2591_PWR_OFF             0x00

> +#define TSL2591_ENABLE_ALS          0x02
> +#define TSL2591_ENABLE_ALS_INT      0x10
> +#define TSL2591_ENABLE_SLEEP_INT    0x40
> +#define TSL2591_ENABLE_NP_INT       0x80

Is it a bitfield?

...

> +       als_lower_l = als_lower_threshold;

>> 0, but it's up to you.

> +       als_lower_h = als_lower_threshold >> 8;

...

> +       als_upper_l = als_upper_threshold;
> +       als_upper_h = als_upper_threshold >> 8;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
