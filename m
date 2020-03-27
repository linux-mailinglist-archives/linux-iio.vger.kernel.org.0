Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291CA1955B2
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 11:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0Kul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 06:50:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40550 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgC0Kul (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 06:50:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so9671301ljj.7
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1118tB2cGkrLlGFZlpNCQTWgFUCtpOTTXJZvXIxdyvk=;
        b=QvC1YbCxdzLAz1xK7DULkudUBoxKZXTN+EgXfAlOAYxVOiI1x8eSpWbIpdqgWm+xb1
         WFztSeQKSyTwQg7ce2k1+ctxxwH0sOTJ/deQmrejD5nBWE0h6ndRR8wuFLLVYbLWH5a2
         H2vMG5jjWOzWdDM9qSIxHHxOIBtaB0MlXdCfyHDmQ4afaT24VUxUquCM5+511oQ6cj12
         qGv/wfNmaT5g579sM5T8OVT5dhiIvTT0aH5us8VB4Cd7Df+nrKd1szTzyI1Sv0JOoCJR
         Wm5DXzUkCV1Kn1g4pWB6hlImtuRins8HA+ANZpJ7JL/u6KcMi5kHWeiVexgRboOtkstr
         TYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1118tB2cGkrLlGFZlpNCQTWgFUCtpOTTXJZvXIxdyvk=;
        b=RdcHBIHGzsb8miF5rTROyVSh5UsLWb0mmbTQo73rWQN2Qba6H+2Gjcf84v+dpmbszF
         ef2Jm7U2JpAFjXlCWZfNACLCHeEE8lg/B699OCCbKa6pkdp4TsJ5qnjR4jBuu9lOuwCF
         cq1nNlsU3Is02wUV+YbF5YcPwmViBQi9XOHDnRC7N2GgGVc2bbKLCgFJhWNiESd8LNj0
         wngTDAwkhPwMhXpEYFZG5Tu2wPSnK4PK6R8DH6jndsT/FlKMConeJYviMMU5ya6gxe3B
         XGIXmhCRpVnfGFjik7SYrL8riYXJKdvqBuuDLhNYT/23bHlEej4Y5bUZyNd3uweab0/G
         DAUA==
X-Gm-Message-State: ANhLgQ3H4znwxC+7AtZCnDS92DrBWilihC24y0hHQ21NAlMgUOoIxZs9
        qFf6U1/P7+lLAaK+i/7DdApEptABmXB2eaNq11muhnExhKU=
X-Google-Smtp-Source: ADFU+vt4Ey9gVKN3D7RdVcahkX5EEEoFIMDf4hiYI0QksK3CpA4BLLTIxWKFi6mNynfTCWILVvWqxRRf1l+vXOHkdUU=
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr7780373ljg.125.1585306236984;
 Fri, 27 Mar 2020 03:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:50:25 +0100
Message-ID: <CACRpkdagNP6cY353oi0vCAihqvd2ZOHJ8Os7j-cq4EVBCC4+Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Tolerate IRQ before registering
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 11:41 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> With DEBUG_SHIRQ enabled we have a kernel crash
>
> [  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000
>
> ...
>
> [  116.606571] Call Trace:
> [  116.609023]  <IRQ>
> [  116.611047]  complete+0x34/0x50
> [  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]
>
> because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
> ought to be able to handle an interrupt happening before request_irq() returns.
>
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: put conditional logic back when re-initializing completion (Jonathan)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
