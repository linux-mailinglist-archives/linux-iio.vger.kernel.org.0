Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7C214C55
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGEMGG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGEMGF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2020 08:06:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7082C061794
        for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2020 05:06:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so6403398pfc.6
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2020 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9gGLAtdTNLLuOtqrem0idEzGGwAm+4JXlYOcyzbgx4=;
        b=XnVjoK5pN7wm1BLIEAfS+KxoVjASZcFsbQZ2VTCPONlmLZQZiU76eV4TG1fGrdPjCD
         lrmehEEiBbRFZBtEtf23vfgf7mfcVVPHXcPQEDJ7ra5AypOWqEXhe3JS/Fwj7ydrfjnT
         3nvWmtPFdtI5ncdcDvjZvg47jaRB2nabSCUwkZ7F8j9debanifno+twAkFZX3rXEyVox
         cp+QIM/zkCagIxKS338S93TnCxYMdI3QgUjBhj8AdifQDcd2q3BnkeDK4UfNmSXzkCXE
         3q2q6aOgFmu7S1c3BVTr5P7aUtvU0UN7XpQ9TfTXT5/OLTBRPJD1986eddQRBZvyEwt2
         uJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9gGLAtdTNLLuOtqrem0idEzGGwAm+4JXlYOcyzbgx4=;
        b=lA55YTQwlsVXTTg283bBu7ox93euHKPT9Hh323RjEqiVNWaTMeh2eZt9JENQRmfOs0
         cA2bOlKvD8v+1m8Cf6V5MLiT0WymHFCU/pFr+txyqXClQIjpCqkKQwmgFx6PiRV8imeQ
         qhkMdzAvjNXGN0h1LQ29lu5UHuCpKcRTH8QyCTG//aMOG1I7EwODrcMSkgg+EVHo+qqK
         2UCSBONbkTXSlodZ/EOIWD6bCIQtQPqKBbCnQyyizG3DHfp4yJiSoeUPDfYP6D5uzhg4
         LeAcZqjupHWlo9b43Nv0DcsYDbeLyyMTqFVnCo8ryiXezSDOqqAyhLkgXDl5Id9rsVC6
         Cjgw==
X-Gm-Message-State: AOAM531we4t8bbjzJ/qfVse24Q5zavuZHjYmVp4aeYpkx0KppIErceL4
        egb9lp5f9TjuWrYyanvH2wYUqOInJXDviCQVGTpROYGT
X-Google-Smtp-Source: ABdhPJzK+yqC1MMXTDJVH4/+hfR/DwILfINdvy9vvw3tbJ6PHEO3gceRcsXbj557wfenXlFfb+bdX5689yMZK3zoocY=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr26830886pfd.170.1593950765200;
 Sun, 05 Jul 2020 05:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200607155408.958437-1-jic23@kernel.org> <20200607155408.958437-12-jic23@kernel.org>
In-Reply-To: <20200607155408.958437-12-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Jul 2020 15:05:49 +0300
Message-ID: <CAHp75Vea7Haj7ZwHOytHXfDB5ywCWSU6UoK3jZBBK+_-mpZ3Ow@mail.gmail.com>
Subject: Re: [PATCH 11/32] iio:light:st_uvis25 Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 7, 2020 at 6:57 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> +       /* Ensure timestamp is naturally aligned */
> +       struct {
> +               u8 chan;
> +               s64 ts __aligned(8);
> +       } scan;
>  };

...

> -       err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
> +       err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR,
> +                         (unsigned int *)&hw->scan.chan);

Despite knowing that this is okay, from a language perspective this
casting is not good. Potential mine for all kinds of static analyzers.

I think it should use a temporary unsigned int (or what regmap API
wants) variable.

-- 
With Best Regards,
Andy Shevchenko
