Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5A1B87E6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDYRBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbgDYRBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 13:01:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E24C09B04D
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 10:01:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so6405175pfn.5
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DPf+EwH5OC8j0XXb+5msqneokhmCuJmIGM0FQ1prTI=;
        b=hZrvMlW8HdGC3OFjVmw1jFlDLrY0RvNJAqZo8q5cMYjDRA27qduqwQNbX8lQoCAHUJ
         JNB9EJKgHTHfY2CfSD2biiK6Qb2Dw3wjIxm6UbUoNncp8y5YQ86V29gM/55cu216vzxt
         BlRf2w5reT5yqHIWUtBdmm5WrgBJSUzvXMXcfoHTk+cAEbpwISmhIQT9JxZGH1x+yXej
         MB9v7hDn0Uf7Uvb/vahNFEd3vT65wkBDvWDUvnj5Pj1AU7KBTQwt82eJgxM296j2OzlP
         RGMcnNZkUEYwgqhjd6LoXe62pZ0tToKR0v7tMQRUyPdyvNKRZsIce4w0gNTu0/MVXKA5
         pyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DPf+EwH5OC8j0XXb+5msqneokhmCuJmIGM0FQ1prTI=;
        b=rqtBzDgOMgLevbhNsNR2QGQ6K2Tk58iGhRTd6M0ShZiBfARMyczO2zyg3bYsH7Qaxt
         mgIrLH1YBWG6EEwzp03ieHDsfxVeZtxK+Z8QIygs682PLkPtIOBto4FhhEP1Pc0pj5K+
         jfZM7CY8inb0l2EwtEjUy+9C5ql5rNMPVsmMQqSkdE2Q1gvuE/26bgMpz8SIm10KddT4
         IcnDPh+bgUz10ytZi1fkOhAj9tBeD+Px95U+qZzYt4PGrFyi/aUZPZg6Kawp1Ie2Mnss
         CNAoF3d2JRZwhtL+eAi8HRsQS0a1Z+3gidemTFz5odh8MzlwvwalwzD6ieODKT72F/ZP
         fiuw==
X-Gm-Message-State: AGi0PuYAucj6lVnUuyGC9BaWV3N7Wpt58nIP14vqo+vMSnWyE81meB1W
        IqH3mwgo/dcftEY+jLQ/npnHnyZW24Xmj+dr7DkMWYaqm5s=
X-Google-Smtp-Source: APiQypLSwtj75Qv2IK8137kFHfZ2+EgZXtV1lNtp286g5PCGsj2zcAmIeK79wA1xtiQ1u6RsDx6S9zOlKViD2bm2dSk=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr15573150pgb.203.1587834111421;
 Sat, 25 Apr 2020 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
 <20200421003135.23060-3-andriy.shevchenko@linux.intel.com> <20200425172441.2f2c3dab@archlinux>
In-Reply-To: <20200425172441.2f2c3dab@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Apr 2020 20:01:40 +0300
Message-ID: <CAHp75VeC+ZBxNoJM697+LU1WtNiQmujqSgt6p_JEueq=13F+bQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/16] iio: adc: ti-ads124s08: Use get_unaligned_be24()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 21 Apr 2020 03:31:22 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > This makes the driver code slightly easier to read.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Added
> #include <asm/unaligned.h>
> and applied.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
