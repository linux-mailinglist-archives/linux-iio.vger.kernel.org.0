Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4F3A480F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFKRrf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFKRre (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 13:47:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D45C061574
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 10:45:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so3038983pgv.10
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz3LbokVxAEU7e/8q/XwQaECxsUWBTQqaaFXBvmBB6M=;
        b=JHAKwMpJhYOh5VPnC2uwFVe5URwEETvdXn36LlDWzFG94iR95Z64JDph8ZO+6xnHhj
         eZE/kIS48MnLnYHf8nVP3OK2Qja97L+SDUgmlutYxXGWBxLA8xBbFWAjy1j15OxJRo+a
         f8W0wcFnT5kHpYGQ1l/q0McY5kZAiV0W7RLhvegw3UMiGrnxQtrqlbnjL9EXKhat6vdT
         1Rqr63ZTGTyqcYgnro5uyGt2XYOg17bJJYGlHmSXL/cR4U4MB1Obb4WNI8SftFrU1k40
         dCNstV84MzxW58tav2G4CJWzNiiWBiMs/QpEdhr84iklNVtHSK6HRAlyNhvC8QGomc3g
         pk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz3LbokVxAEU7e/8q/XwQaECxsUWBTQqaaFXBvmBB6M=;
        b=f9cum4Q5E6h9iV4Fi6I5QmQjhzgUhjD2XN2Kc7I1tpvUrPsuSt3i57pn9MySddZud8
         qrYjwnqZ+UsOGtNr/TkOuSCNGUrodMyh1I2eKmCVBu1to/+mnzHAxNzigOKgTu7iHWlr
         KD6mMYVFU4iCuwak6Mq+jnMTTm+rcPsx1KqAQThZn3jDfIxu1C/e/jC1IJUm63bwpHXF
         VoHx/K4JVlcThVTUicgJ9WIDZ5gwbEOYb9IIHdxaI3DZ5BhZtgXQ1svRkUNV+fMeadVT
         oSb7mjPAJueqWmtdpYCrrAHaqBWfwMJb7OJh0dp2qwXgbjJs4UouPC+OugaoUYy4vsUq
         8djg==
X-Gm-Message-State: AOAM532k9lgh5AG8SqMGcByabYdY11WkZW3XhwGhY/AM32pJ2WKuONBE
        mWagc3xnBzb5XTxm/0WTyJjC0ysDAeUTd7udBSo=
X-Google-Smtp-Source: ABdhPJy1yqS/TXM25H+rlrT3GOsuUAqdzjaIdYTDCCjffp+hiNqxZggWTS0UpeJ9SvUi+4m4j118sKXVO5uvNM2icv0=
X-Received: by 2002:a05:6a00:139c:b029:2f7:102c:5393 with SMTP id
 t28-20020a056a00139cb02902f7102c5393mr2542573pfg.40.1623433519792; Fri, 11
 Jun 2021 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152614.109361-1-jic23@kernel.org>
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 20:45:03 +0300
Message-ID: <CAHp75VfN93-B-UYCEMfxym-_XS_Edr+G07P6xO+83+gkMeC1LQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging:iio: Header cleanup
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 6:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 0-day recently started giving some reports from the include-what-you-use
> tool (needs LLVM builds).
>
> I was curious so decided to give it a spin.  It produces a wealth of
> information, but the suggestions require a high degree of interpretation
> and some choices are down to personal taste.
>
> This set covers resulting changes that I think make sense for remaining
> IIO drivers in staging (which I just noticed are all Analog devices ones :)

In general it's a good idea, but the tool doesn't know the project specifics.
I believe that half of what you have done is simply wrong. That is, we
have a lot of drivers that include kernel.h which is in its turn a
rabbit hole of all possible headers and (circular) dependencies. So,
for this and the other series, please double check that removed
headers are not removed due to kernel.h (I believe this is the case
for almost all if not all entries of slab.h, for example).

The other half seems correct. But due to the above I can't give any
tag on these...

-- 
With Best Regards,
Andy Shevchenko
