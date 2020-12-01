Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90112CA3FB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 14:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgLANht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgLANhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 08:37:48 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3803C0613CF
        for <linux-iio@vger.kernel.org>; Tue,  1 Dec 2020 05:37:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so1144141pfn.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LbyBTg3M++nO8MNEIhO8QMZXDPhnKMAiSGiYIyviTo=;
        b=pAAlF6RHW3CSwAI2/qOLEJSLtfuJnLS9LrVWIz/jfhsH9j7gF1DWpuFjli4THlP6OO
         vBlYSjStvxpAhvvom8wSZNBh5ByTgnHpSmQC6b0H5EdN3N/mr4aTgVb6TIA4Xngj86ks
         pTVMGkp105QdPO7YNTepF+SW6do7FnLqL4wSc6BIMUDj1o8EgVroepEcX/Ad8DCnrMe4
         oPYYC8whg8vKepy6UkBiYimFnMFXPh6bRlxyF+/IJ8Cy7EsVLLTdgKQEqoxn5HRXR06d
         W41tCrVQC6ujiikc373UVobENsw/YOsOi7ztK3aEWoOzdfAzVTQmIbIt5vdI2H0pSgx9
         V9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LbyBTg3M++nO8MNEIhO8QMZXDPhnKMAiSGiYIyviTo=;
        b=VoSxEAyMgU7nAQnYQh9EtZ3StmONDsbDsoFrMnjXVcL2U5QSwAePPe8NNkqbtUCuVr
         cFh1Fhe5QE7X+97wU74Xc03iGPgdPQ+4E9mjjoV2Cg2VSbfrpQfq4gjbsUvB+wegzW9G
         XdBFhfgpm0865n0jYTlezg8tM4b/HXNyeRqQfYkn92NpacQnfFjIvYk95anupX2ul/XT
         mDsPylxLNzf2lKZZ8kJHyJJkJ7elIWrFuLX5L+tqo8gtLc7uUFtSU2Q8oC2z+QlZiXGz
         SAN7NBSvbjZkq4sii2Hfnm/zRdSwa6iU7c6vOci3yVqlGwSPEdm5/369YTOR0aqEz0ez
         oVQw==
X-Gm-Message-State: AOAM5320XREC6VHld9InHolesbsQAS3sapUfpplLPSS5I+0PjtZsXQAs
        lAvIZJRpY1rtHhSPWDjbbnQQQeRZoBIxY+y7oZvilTlZTb4=
X-Google-Smtp-Source: ABdhPJzDN81cDdVvyfbbUNJkJsoObMQetI/T1VV83mFxSUiZxyr6jxlXwypJ1iRNmjYGN6ACG+VcmOArL8NqgTwPJ40=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr2526225pfc.7.1606829828159; Tue, 01 Dec
 2020 05:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20201130141954.339805-1-hdegoede@redhat.com> <CAHp75Vd2Jhep0z7i3_5jnvsnMN2zyudCRM6YNy_neCd6_ydSvw@mail.gmail.com>
 <20201130204536.71d67c07@archlinux> <0ed3fc11-2de7-716d-d2c2-d6ba00d3aa73@redhat.com>
In-Reply-To: <0ed3fc11-2de7-716d-d2c2-d6ba00d3aa73@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 15:37:56 +0200
Message-ID: <CAHp75VeYkhZz3WH7bqgf5zoT7RtWft46eOxNhcSP9-GD5oxLSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: Removed unused
 bmc150_accel_dat irq member
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 1, 2020 at 2:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/30/20 9:46 PM, Jonathan Cameron wrote:

...

> And sorry for not catching this myself, some of the ACPI functions are stubbed
> when CONFIG_ACPI is not set and I was relying on this here. But I missed acpi_device_hid()
> not being stubbed.
>
> I was aware I was using some unstubbed things in patch 3/3 so that already had the #if CONFIG_ACPI.

acpi_dev_hid_uid_match() has a stub.

-- 
With Best Regards,
Andy Shevchenko
