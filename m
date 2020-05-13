Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847CB1D0E83
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgEMKAk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgEMJvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:51:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F4C061A0C;
        Wed, 13 May 2020 02:51:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so7775815pfx.7;
        Wed, 13 May 2020 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjiKJ7FJyTyiMTQabLbMdyXHxAd5Y5rApctKC8YRsHE=;
        b=p7i6gqiUSXTtK8sEqLVDaHCAQ4YPJvlMltihgkLN7PhyQ+GkAQ13GNyAEymKYACWAF
         Z8VAhvK8B1LJYKmMS2KF1M/TV8DHztjkQco/ZFyFDXNzKiaIx4RZz7xBWFDR16ITIdCx
         jHEg/QgmnkBftkMGLGoPfM0qxMz1CpHKozcnhaKuOi2jeiARYIRZPQByw9cY8tbS/AAk
         hC1GDea4nZlaXy0tn6iJbsACuFTdha5CqiXFVYBskwh9+LslZOdOnNMFMqY7kJ7Opqbs
         yTRB1F1Q/nICpbSz/IUXIDs8pDHgXq//6RETRj7c91UGb18dnxDJt9uZo1YSTMW8mSq8
         4WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjiKJ7FJyTyiMTQabLbMdyXHxAd5Y5rApctKC8YRsHE=;
        b=LYQZCWjglxnBoqWh97RtefJXqLeJE4Nx6JnWUgs/mmwkBOSRvz7QMmo5T1mkK38pVo
         kiU0S8Pmxxi4ebGYCCUttfEhnXBKiUC3KUl6CuKCr0wB2a6lX8hbfhLnnPDSwgf6exS/
         sm5GUe9faNTQJP8gOphIg+LqpXYewSqEZAj0T0LZ6VCA6NcBfSTOSTLu8HwO5Z5MSP6K
         JiYFkBlEL0tJR6YIQGbX+wwhIq5YoNwBoZV0vLLiRavuwoc4iA7Itk7OHROULeCe3tZt
         +vXmSE/QFIymMPCYit3rrU3MZj/s0ilq9RUEUl8o8jGOUdIcqRHQPf3XceeRyWtB86Ee
         Viuw==
X-Gm-Message-State: AGi0PubInIQmkABs6348LPCQKrUzly6g1CCNxkd9iMR0Ma3wvDSuixSm
        Sj+rfdJq7Wo67LSDmWS749eX9AxF4OY7QsIq3O4=
X-Google-Smtp-Source: APiQypIgIamK3+3CJqNCYmJC4K3blTlFkyzYGSrlGUS2dxYhc98NURSl+FWvlL20we5SAXLj5NrJHWb6PfApdwXRfzI=
X-Received: by 2002:a62:7f11:: with SMTP id a17mr24262558pfd.36.1589363503255;
 Wed, 13 May 2020 02:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org> <1589361736-816-6-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1589361736-816-6-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 12:51:36 +0300
Message-ID: <CAHp75Vf-bFfrZ7uCOnXuzT+p+itkcmkE61=ezZzN8yDFQHABdw@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] iio: adc: Clean up ADC code common to PMIC5 and PMIC7
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 13, 2020 at 12:24 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> This commit includes the following changes:
> Add a common function used for read_raw callback for
> both PMIC5 and PMIC7 ADCs.
> Add exit function for ADC.
> Add info_property under adc_data to more efficiently
> distinguish PMIC5 and PMIC7 ADCs.

Something happened to the editor settings. We have lines up to 72
(recommended) characters.

...

> @@ -512,6 +518,7 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>                         &adc5_prescale_ratios[prop->prescale],
>                         adc->data,
>                         adc_code_volt, val);
> +
>                 if (ret)
>                         return ret;
>

Unrelated.

-- 
With Best Regards,
Andy Shevchenko
