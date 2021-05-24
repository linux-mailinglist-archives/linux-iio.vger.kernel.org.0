Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC54C38E641
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhEXMJe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhEXMJd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 08:09:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D5C061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 05:08:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b12so26012950ljp.1
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTg7vm4pMEpR4uU5fit+ewi8JjBhW91KZBkpLnssSAU=;
        b=UOjcuWtRE8ZvaCFKvkm8afFSb+UkRHwi+EM3f61MTMRipwXj+ryZ7ypL6qugExCOzr
         H2Pt2L5lZB3grehpmZvb8QHDd/LZ6jP+0ZAbv5mmrX/4ExFxMuHaeU8OBa4SgJF3qIEr
         w1B9V4burZf2We6hYUzqpE5rw1RvIkDdxoJHhKTAhFTSgbPu797sIdyd0OaRWSAwKoe4
         zsQycnNP3EzanrXB7JSgD/g0FAipB+54+fRUHSGTP3V9T6nYYbpyWJnMqQSB6D1ndpKx
         iDB2bua7gViWEcY7vwOTqJZI16AWCKD+qlxP1N0sSl1VjkxQe5ikVNB4cQr4gcHeO7cK
         8h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTg7vm4pMEpR4uU5fit+ewi8JjBhW91KZBkpLnssSAU=;
        b=DSRLXL5eeRR/itN/FIxziqXKDmDnNR+eZ4wAuFw4ByxB6jFAFVXCtccIp3LuFK60Dd
         Y6T1f9+Wtm7KaQFIgYRuKCjOH9+hGM6XaUS7a3GRSoL+iQP8Mu4F38+NHnrQ4X+m6iTu
         udDhxroGyMbwH2EH117zc2mBMdooQ5a3o7dOMIDeDNyTiWjsYFWCYKOhAtnVhCssTMud
         1QawGtT9XvxHQ99ULdoQwKfJML54C6Ofme+8h4vPdespVwDA/YjuO86rw/+A4tUZyYC1
         CtopDwZMeq8e4Vjp8f7kcx/1QadqH/ZnJPIW6eMyWIP9OV7gG1ijxgrzJ8VdtsfnTw9C
         SPRA==
X-Gm-Message-State: AOAM531UvDLo5nJ/IV7swRuFFNwdfLq3iZogKy6D1/278Adgzt9SBCDu
        5MpsnrINKH+m+GSg6Ip4sVFud8P/pohK50XCLux5Ng==
X-Google-Smtp-Source: ABdhPJyieMB2C2IRG21yk6NFSZteTH3v01BEPAggAJbGOLWC82SHLhiMVoLgKUL2uPxxLhiqoN3itjkuwz+1sX3p5Aw=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr16759965ljt.200.1621858084220;
 Mon, 24 May 2021 05:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210518230722.522446-1-linus.walleij@linaro.org>
 <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com> <20210522191527.228f795a@jic23-huawei>
 <CACRpkdZu0PjH4ciJMSRZ0bywYFjrfWvvfvcpxPQQ+4P=rTNmTw@mail.gmail.com> <20210524105042.00002e59@Huawei.com>
In-Reply-To: <20210524105042.00002e59@Huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 May 2021 14:07:53 +0200
Message-ID: <CACRpkdb9D01p=qsSEFSKz_KSRcQdA5L8J65oQ+c3X2OsdqE=kg@mail.gmail.com>
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 24, 2021 at 11:52 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> That only adds the Reviewed-by for patch 1 which was not Hans'
> intention.  If the reply was to a cover letter it would apply to all of the patches.

Aha I see, yeah that makes a lot of sense.
I'll try to put cover letters on my series!

Yours,
Linus Walleij
