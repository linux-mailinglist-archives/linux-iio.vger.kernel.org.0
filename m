Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D43E9588
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhHKQHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHKQHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 12:07:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE00C061765;
        Wed, 11 Aug 2021 09:07:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u15so1159430ple.2;
        Wed, 11 Aug 2021 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KffArpOyUib3xLvmma0gw4eoYf5u08GOHiGqQNefyKY=;
        b=HPsATQBC1TxP9YXDvO6/HpnceepixH7+UmUBemM9O8th0lKUu49VkCwyUE7hgiKJu+
         E1iB419oPuAm3guuO9cghFv2L5raN/td2TeRpx8iWqYlB8ywGC7lulfVrCfIzTtYgb9+
         MuIW3p2ylatMLkI/DzZAxcCcacf6cU7voMhmWY+fGW/Jz+DlqTUZ9Ol7crc//34rGb3z
         nGCYRTyyJt4n2ndvZkeSY32nfSc8EjljyrDblJ9asrt2s17SgPkWVeXs9U9XsYHhLpX9
         It0+K+mdbanfy+JZ79Rgb7JcHhAiMr4T4hk9bED+aVJ15CHQ6vK5lEMicRCC5Sr04DiG
         2ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KffArpOyUib3xLvmma0gw4eoYf5u08GOHiGqQNefyKY=;
        b=TFMm101y16MTRkM1ztaLpyNkb4gBRKtT7PAmWSWjuHjGa+Ooi/RPrZdppqCnQ95DDh
         sKlxJKDm+Zx2pb0tWWTc6VDxL2tmoD/TZ8AnIxY6H19gfsFDzQ5HrOi+rJb7UELE9a4l
         NhhG1J+2rlGH66VZHMowkDuBEpBJccImWP7Dnxr2j+Srz4saCUgWr0Qmbe3mhid4oYNs
         h/rdrzcqsrPGfLLKvmt/16tbHHx/CFZvYg6LTKz1ERfPPFob+lwPnzHszh7Bq6Pvgi88
         kji1Sa2afDcPjsjEGOBHmLdlIfqKisq2GTjROHfHhcd3gGs7d7IitoT4XPy09O/23vsy
         VLcw==
X-Gm-Message-State: AOAM531yrmRZkDmEchEh35eMmC7QHO6o6HzqF+camIMlYjEujgcyUMad
        jtLnpx5kLmD3sZbT/YTId7HPSl/kMPqnXf5tkmg=
X-Google-Smtp-Source: ABdhPJxT/bamFNOzxnUwiKPLoYVj6shFGLY6RHKownLvpNsQtzfsSR4MoEDaHdyJpn6tl9YNSsIMvQ8w5e31/7xAJIE=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr4813354plb.21.1628698043540; Wed, 11
 Aug 2021 09:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075745.160042-1-dmugil2000@gmail.com> <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com> <013bcb79-c496-44d8-2e93-57eb57834ee0@metafoo.de>
In-Reply-To: <013bcb79-c496-44d8-2e93-57eb57834ee0@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 19:06:43 +0300
Message-ID: <CAHp75VcvA=dDOJXSFzgz69JVgbez4Lz27EGOEF7JWUehyrwQrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 11:15 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 8/10/21 2:49 PM, Andy Shevchenko wrote:
> >
> >> +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> >> +       if (!(val & BIT(7)))
> >> +               data->tol *= -1;
> > Shouldn't you simple use corresponding sign_extend*()?
> The data is encoded a sign-magnitude. sign_extend() works for two's
> complement numbers.

Good catch!
I'm wondering if it's a good idea to have a sign_magnitude_to_int()
helper or so?

-- 
With Best Regards,
Andy Shevchenko
