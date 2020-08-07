Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8E23EA53
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgHGJ3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHGJ3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 05:29:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E61C061574;
        Fri,  7 Aug 2020 02:29:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so634956pgb.4;
        Fri, 07 Aug 2020 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwqLIgdFSoAcnw6GHO+On5ux8ew4MdyPxUQX1pacN74=;
        b=O93kCnerzIl1YmyT0GQa8FMyfEFgK8eS0elulCcqBX1vyIEL2oUeMKym+bG/5HAMz/
         exdCspzs+xqJx/+sHdho67fFZnSsoQ97goiywPccUU/APwkl10ggrKGU+7WUWksCsUxw
         4H6UcCiI4HyNSp1YGi6HDRozHbE9Fye5GGSDfb47Jn2FlTZb5a9SOPSr3bdmt7iTADo/
         00gpipFJ6TAuAhb/IvXloZklpM/nPJEqxtEhgXibSQ1hXXMQZ+e9fS5xiF8mXb9ziAEL
         MdAMp1sxASYjtN8yXQ4Z8nVXI2p2m0w0syoKIm6GLCikTwGBXy2I4wyKlHnuWyjHKX1v
         MFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwqLIgdFSoAcnw6GHO+On5ux8ew4MdyPxUQX1pacN74=;
        b=AcbkP0PVpFI+DgMN3Jki9vqxlhYcOHUXjL3Ep53ZVYQQSeGVHb9uMTymH3gg2V942c
         yN4a60z+BVMSKTNrBCcWoG1DtxjQ/apoGexvlTaP2+i+IWZRGS1qV3tj0498UZG2RyZn
         nS3RRgvmPbQkjqQx8UxkCy1Ss25qLNhOx+FM63gadtEkNIBtru9SpE48I/t0elN8H7WW
         peeajTjeigUTcPONe8qsV2SSyR+Za5/X945Ta4bhiTUH9K+y1a1mRfPI2w6Wu2ZLBJey
         Wn92vvqHNLyEnxmkqEigaUH6L1TTgs/vEDI8hVQ8uQkmHKtqrgh3jBFqbXYHXUy/BsnV
         urIQ==
X-Gm-Message-State: AOAM5307thd5XiHIROtAY8SAPNZVx/K/M0QLuBYooIwyo0ujldktO/vB
        iUravanO4UPGhFBSfeo1l5ENpx1H6e7yNAo6GFQ=
X-Google-Smtp-Source: ABdhPJy30bL84G8d8XWMkfD6aJujeX4zZPF5+WRLIw0mQU9zMx2VFfLMi0HDegxzci3X0Y1bZG4nIBc137qhObQNMyw=
X-Received: by 2002:a63:9dc2:: with SMTP id i185mr3087118pgd.203.1596792556914;
 Fri, 07 Aug 2020 02:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200807091900.967047-1-cmo@melexis.com>
In-Reply-To: <20200807091900.967047-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Aug 2020 12:29:00 +0300
Message-ID: <CAHp75VcJ_h2_Lkn2DiG1B5AOQGmsRx5N5jU2ADX5bgq2cqBnYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: temperature: mlx90632: Add extended calibration calculations
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 7, 2020 at 12:22 PM Crt Mori <cmo@melexis.com> wrote:
>
> Since the second patch is dependent on the first and was still not
> merged, I have decided to send them together. First patch just makes
> second one more readable as it splits out the repeated calculation and
> that enables the second patch to tweak the variable to the new
> condition.
>

When at it, bump the version relative to the maximum of all patches
involved, like v2 should be for all patches in this series.
So, there is -v<X> option to git format-patch to help with this.



--
With Best Regards,
Andy Shevchenko
