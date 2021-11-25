Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AAC45DF4D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbhKYREN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 12:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbhKYRCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 12:02:12 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D760C0613F6
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:07 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s139so13626519oie.13
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i1v7Qdr36LiuinZGWZtMoRxDTA/JGAsTQ6soRNZn3A=;
        b=HnACZe0vf0KnFezolIMiqbGWyLPtoXLbKjWfNxQkjgEc+nD7kcQ5Wsb+ZIZpNlWpfn
         jCfr8q+0mqGWnXupA6TxFNcZ+kOcSMm2X28tf0wZViFYvqub+NdhdDAqIalYWJM2e9cG
         UyC0gEUkkBYEJzqAEPbBc+lDUT7gX31CDD0YprpCaPEKOScAyiFdaTR3q4517Edd++6E
         E75doscBz2E9amQhvnaniUlDDURmVmayr1vrzSVlHF+8968lwbFuFknbW1K2yTUshURH
         kI4r3o4fLU95ojCflgUETuCYfj5vlRelky0LMyz8UXoIGHrj/ke5GkaRfDWaalPjRX1j
         fzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i1v7Qdr36LiuinZGWZtMoRxDTA/JGAsTQ6soRNZn3A=;
        b=I6sLNyUr6cGa0djPztj0WlqWWlzkl4PESBRHw3l8OULbufsEtqYqcZaSm16D6x1jdx
         217aoVmsisNjV0+oIt101uuhhRm9vXEEHtVmy93xIQ4EVJrLMALkmQMuXj1Xj7Gpti6R
         /SRPDMnKwQEFbGCuF+xl2seov15t2jivK28SA6iJ/0cYJg/hglrvVKicqySBaigieCVF
         /x94Yfo32EbcXhgyioeXKhm8ColbUYKn0kk32ZbWPiYWpyhgock75j4ZiiVZ8HtqHMci
         27YCLyPUInXljIz3ppO3Pg0V79zdre3KIK1PImxFpt5wWnTlvG2TONhL3IRqTuwLHmkx
         fpFg==
X-Gm-Message-State: AOAM530qT2KjMTeC1wDhmjFWyX7ay+OXwAINIXvsnMBeFgjFXJxidUzq
        52lYRfUh1hJK+7PdrX4/BG36N9v+0uApA674HsNYHJFwefk=
X-Google-Smtp-Source: ABdhPJyjnWaPd8kVPI+njDExw7S21cWjUpM5BC79ApGgr1JVgWbTiSW/Zs8ySFuWpEkuutFWQDjtu5OxbWd7SzU0DNM=
X-Received: by 2002:aca:120f:: with SMTP id 15mr16755683ois.132.1637859366427;
 Thu, 25 Nov 2021 08:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-12-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-12-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Nov 2021 17:55:55 +0100
Message-ID: <CACRpkdaqF3BC0BeA7LApg-8ne8W8_ot-X1VyxSq_phXAk7dyaw@mail.gmail.com>
Subject: Re: [PATCH 11/49] iio:adc:ab8500: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 10:06 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
