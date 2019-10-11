Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1BD496E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfJKUsh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 16:48:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKUsh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 16:48:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so11102661ljj.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ne45OOuZthQYHqAxI8oWivwi4QRQHkoUZ/4MHkifmk=;
        b=h4hTDUE3MBQdSmPKJouvgzwU1Kl/H5vVWHsA+9vof6BnPrfsrNiuXft1C0h8gVYG3+
         LthkONU5GjNHkA6714Y/s6UHDM2/JNfNQxwuHkA9hjgrICG2oQCJgXV7SUVrHj+EfTYk
         ZUfLamA8DQ1UCyWOIdh/1R9VCwT3RmqZcGJLpHz6VQ8rbiI/AScDKOMdhirMXzKU+3lX
         cNDfuYMN+UnA+a4UXfbykULscWfXm8loTNsx8lYIqPumlizVdZaotZ9Pa4ihjmwtZl4G
         pT0DQCkx/f5gjlKl59QmcM6Z7fGvGGq1vOuWJlZdVbnhI92fqtUKuqhhNweCkmXJHFRY
         +Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ne45OOuZthQYHqAxI8oWivwi4QRQHkoUZ/4MHkifmk=;
        b=iL3+5jZdLecaFlIeflzo0e9S5vxYCP1+wS7J5XbOxpuF95tFmBmpaNXX+nTcRy+C/s
         WxaaQ6T9eqyDbb4R2nxCqxITyszVvrXiB8xUamLTW5WvApZkXugT6xu2T8NiKLHi8X7W
         hCDxtn51Y3FYMvanUB9zh+Ro5PfOnHK9HG9DdUNckWJyUZkky8e6OIV0zOdkCdoHTc5X
         n09wUws1VPVBML2Jqn3fJxY0qvsdFgeLM+KTRL5P4QmZ8G2yGtDdBDU7/vBh9CQn8Ws6
         JdwBg1kFcbZCnwSoZU5lrSKB1K1Jb/EoN7U6Y9ujBlpPUatjXvv2CHLiK7hT5QW/rwiZ
         pLOQ==
X-Gm-Message-State: APjAAAWfZVpzgAdIAwBkD7retkffFamPPR+I1Upu5spq6R1wCWgtrsNe
        fXNKVNejnZChnUBTn7mcIAIr7/kKXJchx/eGS38z3w==
X-Google-Smtp-Source: APXvYqyREgAzuso3i3qVhiA4XwA0ih/BYK6VAVsCT3qsqf5q1dKcP+qzaDtCJudqoVvwAGvwsYcJQKrU3C3a3g/uG3w=
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr10365882ljg.118.1570826915378;
 Fri, 11 Oct 2019 13:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191011071805.5554-1-linus.walleij@linaro.org>
 <20191011071805.5554-5-linus.walleij@linaro.org> <b192d50a-3bcf-6d4b-f2f5-2d6276601cf4@roeck-us.net>
In-Reply-To: <b192d50a-3bcf-6d4b-f2f5-2d6276601cf4@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Oct 2019 22:48:24 +0200
Message-ID: <CACRpkdbZA6kDWWP0_HCwMH1nFSwAFWjiFhaQXBi3cDgZ0ahapA@mail.gmail.com>
Subject: Re: [PATCH 4/7 v4] hwmon: ab8500: convert to IIO ADC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 11, 2019 at 3:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/11/19 12:18 AM, Linus Walleij wrote:

> > This should not be applied to the hwmon tree right now, it
> > will be applied along with the other changes in ARM SoC.
>
> I assume this is still true ?

Yeah the plan is to merge all patches through the IIO tree.

Thanks,
Linus Walleij
