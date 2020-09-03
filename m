Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D325C999
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgICTii (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTii (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 15:38:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7998C061244;
        Thu,  3 Sep 2020 12:38:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so2951888pgm.0;
        Thu, 03 Sep 2020 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+PRg9GJGmbl7YnYKQJ3ieRwri+lWyr1AoHJtFqqzfU=;
        b=XDTyrwxiwUj7AHZETwvXFoo35HWRbPoXlwP/FbsBaf6Al2eQNbsHAnW+0iPGFKbmaq
         nejcoLn/Zvm4JkTzGT9ua9vZRd/ftmciHfydFU1GK9huJ3nv6DaGNijFsDrmexhGLvAu
         emVMGNOzKzXTVtFthAPtR4nRpYMqXH/ST309n91/2L1MKENf019On8PhBFSOrtLf/gCX
         ffLEEbt4SE1uIz0SujJGf0pY5KCDVnTil+FEmAIHFUteTw07DRYBOAAHkK3gm+Oj3woC
         eoz0EEEWXe9xcZkHgoE3bt51DEt6DCzeQEKYCEUBqjuV8ShMdJqaJE+yEyooSLLBwnO3
         e2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+PRg9GJGmbl7YnYKQJ3ieRwri+lWyr1AoHJtFqqzfU=;
        b=cKygzNboLj+n/YHMY1sb/jMD+W8XQS1M5VjcUyAE7P69VUozCeYSZu2h+JegBeiI6E
         Bjz7HJ4I6qlFB1GjyoPa56Wq0sqeSWWcQSRk0lHqwwu/yTr4Z7Zc7+uD5ZLNOLUGBLs2
         42qWP2joF0CsQBwjC4TFUYOmGhp0STyOzrKNGgyDeu7SurXs4bqHmNzRdP151fP/bbQs
         V4J1Mi0quNUUJjDHe9aY6CvopHFTzKJ/iCF2hpx8dKohOH/jtd+TVdTttJx3WeR2JyyR
         4qXVyMvgeq68e8nar1mG15DwsugBcLXhv8IPu2087R8kfS0Y90l5e4qBsDJsN/zP27uf
         6O7w==
X-Gm-Message-State: AOAM531DTBfD1JkLWeYuWhY0AnVNqZKJ9Gm+dQ0O3G5XNYV/8P2VcGAE
        fh5rtks4UYXc4SYg485eLmq58CS/Q7sOXM01NkM=
X-Google-Smtp-Source: ABdhPJyVxxnHI3bjYTsaxgfjK/z4EYEYmnWMZOirCUvB2jFfpE6i5/Rp3uLLOtnEo459xCBB5O5oXfrTaEL7cNefMGY=
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr5445613plr.226.1599161915506;
 Thu, 03 Sep 2020 12:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org> <20200903132109.1914011-5-dmitry.baryshkov@linaro.org>
In-Reply-To: <20200903132109.1914011-5-dmitry.baryshkov@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 22:38:18 +0300
Message-ID: <CAHp75Vf0yz1U3W03YEths5Eay7dOY10JGC6QqRkekZQx3MdRtg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 5:33 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Use new function fixp_linear_interpolate() instead of hand-coding the
> linar interpolation.

...

>                 /* result is between search_index and search_index-1 */
>                 /* interpolate linearly */
> -               *output = (((s32)((pts[i].y - pts[i - 1].y) *
> -                       (input - pts[i - 1].x)) /
> -                       (pts[i].x - pts[i - 1].x)) +
> -                       pts[i - 1].y);
> +               *output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
> +                                                 pts[i].x, pts[i].y,
> +                                                 input);

I'm wondering if it's related to linear_range.h API
https://elixir.bootlin.com/linux/latest/source/include/linux/linear_range.h


>         }
>
>         return 0;


-- 
With Best Regards,
Andy Shevchenko
