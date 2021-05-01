Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95348370888
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEASy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEASy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 14:54:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E5C06174A;
        Sat,  1 May 2021 11:53:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so1042805pjb.4;
        Sat, 01 May 2021 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KrfpPIc2gQu4N8ddDl7cuGPwPQ35LH83OSg+Lmp1mU=;
        b=qbu5ln2nZWjYs2K52gZ5wnIz2s7zVgmchvYQLMaiY/Tp7Mwk5Am7CsY2sMicEScxmv
         TYw4sAWdS84iy3EXeLl6TIp4ytsNPm71eGb+NQ2xhMacEZsjKys78BWq5wZuyWd7GkAX
         ZI9AZ/BRUZBtPJVB4ZwX3s8lFzZoiJXDy7LJ+LBBUk7WLed2ppstEqpH0RxhkK7+p4C0
         Fst2OqM/rqKSEqwjGZIvd8rsla3ePyaIG9vJmJfrP89NyLNaRfDYrNER9w5TPZCl7k6S
         bxBAugzTZ7I1cWv9bWLg6KeNNZm3pxu5M68/GywRR5DsrVPjt+xfz3OwsEovH7g7Sxwy
         Y4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KrfpPIc2gQu4N8ddDl7cuGPwPQ35LH83OSg+Lmp1mU=;
        b=quVr03ZGepkRfZwfV6HPMBsA/NvFR2cPCdClQDfcyPLbQKAz0+OuGQzsARw2U27/G4
         q1+CMV6AdCbeVJ4ZDzya8awU4FbrqEidy86LwWvhd706vA1B+t0+D4nhMazCGvLDnl79
         t0XI0cYFL27tKvBZNIyNmv3o/N2RfpNtwulrLmKT1ILVJKfxzKf7WYfiBgzZvKLY1Y2z
         ED+5lFRBWqW9zmekG9edDe8kb4GGSQfuXaW0FpWW4JpBUZHmOBpAhasPWZaAdKIoMhLk
         TWj55tvidpqA7FzNJHDNE2KROfA4gy9lHegptewCIPS6UHVC/sca5RO8ob9cQREzdqdD
         +6WQ==
X-Gm-Message-State: AOAM532HJ+ZUllvqZ0zg71+5Z+iU2kY9MWrMde9yvru7ucWHH8Gc0Te+
        RWmbJ4gyyOItPzlgaHTJWZiDTfxYKld9KJKWF0g3NDV3JdXyPSxj
X-Google-Smtp-Source: ABdhPJxga1EDaoDopyZpwhz3KF0/vuBr8B5fuMq+iF/idpoJOu+KWUZOLNoMLMn4jmVHGzoFf9Lz2kwUnuQMboRaKRQ=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr11540016plq.17.1619895215712; Sat, 01
 May 2021 11:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210430152419.261757-1-i.mikhaylov@yadro.com> <20210430152419.261757-4-i.mikhaylov@yadro.com>
In-Reply-To: <20210430152419.261757-4-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 21:53:19 +0300
Message-ID: <CAHp75Vcu3z=9_nSCfLZoxd1xtKPaCJfz5eU_3L2S0LmKWr-Ogw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: proximity: vncl3020: remove mutex from vcnl3020_data
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 30, 2021 at 6:16 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Remove the mutex from vcnl3020_data structure and change it on
> iio_device_claim_direct_mode/iio_device_release_direct_mode.

iio_device_claim_direct_mode()/iio_device_release_direct_mode().

I'm wondering if it should be the first patch in the series.

...

> +end:

out_release_direct_mode:

> +       iio_device_release_direct_mode(indio_dev);
> +       return rc;

-- 
With Best Regards,
Andy Shevchenko
