Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A804196CE8
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgC2LRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 07:17:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42588 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2LRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 07:17:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id e1so5510417plt.9;
        Sun, 29 Mar 2020 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKtR+5w7WQys8ZLticdbGtlBPUvMy1PtG4ZxAo5yrO8=;
        b=J323auRWlF9o7SQj0lMxjvfYi4xcJSj9vs7cZj0Y+aBaps3F3n3P6WGEV1AJrZNfna
         YRbaHlXQ720eOA9HVcX6lzpObjt3MSbCIwCdzDcaUxTTa6bI0s8SgCtQNHev93p52s4H
         nzufCQOFgMC5EzfpG4j2HXAnXzy+VgJsh9gNcUxKtk/vvYeWb73k4xhLVFSV7bsy6iy2
         Htznd+1/zmoLQ2MENk2mXE9VzqwMY6p2R3tWeIUnnTfs6qfhPAK33jMGj+Akc/QRISPW
         bonKvyKYGN6p8IkaXgL9phmZxBvry+urn++5xZ+y6L6BdC720mv818dx1ox/HV+k5eHM
         zT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKtR+5w7WQys8ZLticdbGtlBPUvMy1PtG4ZxAo5yrO8=;
        b=aRxQkyBmZWcbCksS5c/INZmLXq9+QYL9NfRdZcvQTiRjfXdRui/CRf+UA3/H2wiTV1
         9Cs2AQQFKdgUrdr2nnDNLYzZW6xUli2SjO1h3G6NGd+dRHVKkmnxuKWTzMmFz+Kqh6oi
         lEhiC7G+658CJ0VZmk7ft+JLi5TJSAMftG/AUldxAO7hRhAlU/0ga/vUsUz80mspkzLq
         FZBUqJCJunrf6pNEbhAY6cRV0aEWWB5LwxvivUu+4PRYDbE/Lx8sS27wUjRF4lu9y39E
         iUcDwy/hjDn42UTkeU1dnNF6vYTVQ1aq2hGcVekvuNZI4TvKXHueTr9KA6HlLh0Wtguo
         Btdw==
X-Gm-Message-State: ANhLgQ3B8NNjUTbaqYI9QVu9u7CvHFc4gdLKtj4AR+DF8NxyE7YYej7p
        S+QUsNqSi6X0hLlGk8SjyHv2IORB8uy0nc7YMyQ=
X-Google-Smtp-Source: ADFU+vvQE6KqrhJdYUsrklNm0AJtJVflTVU+/YJx9BrHWpwMyDeakevgTa1EnSsrYSC3YCH5EEn8L3lKoRvUSaolbs4=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr8051127plm.18.1585480639948;
 Sun, 29 Mar 2020 04:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-5-sravanhome@gmail.com>
 <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
 <36892440-99b2-10e8-1d7c-dd8c97e03a39@gmail.com> <CAHp75VdAfiSjkHhTnghZ__WAJCJTGSWBprJBPNmpkxZTjZuVgQ@mail.gmail.com>
 <3d811222-68fa-0992-eeeb-97d1c6d09608@gmail.com>
In-Reply-To: <3d811222-68fa-0992-eeeb-97d1c6d09608@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Mar 2020 14:17:08 +0300
Message-ID: <CAHp75VdbRB109uZZ7HHNzgx68RtRsi64Re554bLtNiytRV3GGw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] power: supply: Add support for mps mp2629 battery charger
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 29, 2020 at 1:34 PM saravanan sekar <sravanhome@gmail.com> wrote:
> On 28/03/20 7:44 pm, Andy Shevchenko wrote:
> > On Sat, Mar 28, 2020 at 1:29 PM saravanan sekar <sravanhome@gmail.com> wrote:
> >> On 28/03/20 12:02 pm, Andy Shevchenko wrote:
> >>> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

...

> >>>> +       struct power_supply_config psy_cfg = {NULL};
> >>> { 0 }
> >>>
> >> NULL to make compiler happy.
> > Hmm... Can you share warning / error compiler issued in 0 case?
> >
> Please see the 0-day warning.
>
> "Reported-by: kbuild test robot <lkp@intel.com>
> sparse warnings: (new ones prefixed by >>)
>  >> drivers/power/supply/mp2629_charger.c:584:47: sparse: sparse: Using
> plain integer as NULL pointer"

I see. Grepping the code shows that for this certain structure other
drivers are using simple '{}'. Can you align with them?

-- 
With Best Regards,
Andy Shevchenko
