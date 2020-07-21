Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C1228883
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGUSqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGUSqR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:46:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC2C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:46:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so11155591pfc.6
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO6t4SZYo4dL6PC74AKueW0BnVnrxVAYgIb5RV/yN+s=;
        b=uDVAdPLHk4Te+QlYub7iNTPUgo9CNcpyH8VRegb7+Y2z4FfQRz5bEacA93qvnu2Mjy
         kdzQyRZnrCPKJsvaLFYP/rif+JnrHogjGaNqCAlL0UuNKX0kwzqoIarP9FsyhPDhMoVm
         xUTuY3C3ETQPytuu286pzkCkUB2ZlTx5n2RUCANER4ozO3rdbZq2To8SjvgaZVbBIJXN
         KI/gGFGdOYluV80BaHUZrWPnl6H+16Ji9XmQoHpcEYh9HSFg+7XjdwWREiQhsStNor3l
         6OSLity7gYjEJOJulRZKYz1dMwdpaRt0YEMYLHL3phdoUKHSetyg765Tkgrm9wkekaP7
         7Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO6t4SZYo4dL6PC74AKueW0BnVnrxVAYgIb5RV/yN+s=;
        b=BZnghsN88HLCg0l4NfxVxRbYygaVSmgbIsCLOiTf/9O1kzBlFjDdwO76TGBvYbp6Ht
         5QqgefjNGPDmzkuOE3cTz8mltPsA/SSoMLrzkOBC5YCLQ7Un8TnO8mNWmDmLhj58aQiJ
         sChfsu1rXC0mCY32vCLPWT//KaPln+swuVGHpHtfKmgD+3wUUJIoTSRVMUhUhVAPzjjO
         jQ/mV6sh/Tu7NsA2mcykoNIYO68Mb0wgqW0RVSl9hWR/3XXm3/kDVulBppjIyejBno8w
         8xkv7k2u1i18MIrDM4k8FCjsa3bPyOGhgZIKB8AL9HDmCdmBYoElQfnhQOZRGM13Tut8
         JVrA==
X-Gm-Message-State: AOAM532ytlnKnV5HUt2hSTF8CsvzoCXbq5ig2G7RcPVLO/YuIJfliE3s
        6YP/N0qa5Hnqw9medFbB3x051nrBXdtwMUxScUQ=
X-Google-Smtp-Source: ABdhPJx0yj3TwwxftXET7Aap/0rEaejfWwmibs6gWBS9SZT5nMUF1e8PHqpSuogoidLYSNpkQmH44tfcB/LmQjZUiWA=
X-Received: by 2002:a62:7657:: with SMTP id r84mr24540590pfc.130.1595357177376;
 Tue, 21 Jul 2020 11:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200720070330.259954-1-matt.ranostay@konsulko.com> <20200720070330.259954-4-matt.ranostay@konsulko.com>
In-Reply-To: <20200720070330.259954-4-matt.ranostay@konsulko.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:46:00 +0300
Message-ID: <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 20, 2020 at 10:05 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Add support for the Atlas EZO O2 chemical sensor which required
> some refactoring of the driver and parsing of i2c transfer.
>
> Sensor data is converted by the scaling value from percent to
> IIO_CONCENTRATION.

...

> +static void atlas_ezo_sanitize(char *buf)
> +{
> +       char *ptr = strchr(buf, '.');
> +
> +       if (!ptr)
> +               return;
> +
> +       for (; *ptr; ptr++)
> +               *ptr = *(ptr + 1);
> +}

NIH of memmove()? Why?

And actually to avoid strlen() you may do it other way around, i.e
shift integer part one character right and return new buffer pointer.


if (!ptr)
  return buf;

memmove(buf + 1, buf, ptr - buf);
return buf + 1;

-- 
With Best Regards,
Andy Shevchenko
