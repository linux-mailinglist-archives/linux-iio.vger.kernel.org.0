Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E81ADB8A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgDQKrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbgDQKrq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:47:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD262C061A0C;
        Fri, 17 Apr 2020 03:47:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so896155pfb.4;
        Fri, 17 Apr 2020 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDjT4OI5wAggtMEPQfLGg4TgWcxeq6e+1z/RZEK3k/Q=;
        b=ohSZaYGOmNuNFEanszOuM7+luXQqfhRyGlZsZNWPDwh+0lJ2cN1jFLW8NxNFM65C93
         L27TuGpU/q8RxsiQiELyiKgym5Ys84fGonBmwOWfwBOt9jfoCvxqTr/WPXsWUxTzvO3v
         87J5qKT9NMi4efvgptr1D/EXTAfF1VWy2cVXDqxLMuz75nDkctFjizlgQ3C9xzjnzsXd
         O2jW8wizVSw5RYLlqy7qbwQqvmUYoE9aAr9H3I1lv6+F1Jc0OYzyGHkr2bkDIPhvornr
         mqalj6BI/de+uHfiLgOh8w7Xl56MMdszbAELAJhlrrR6ee+Kvrj2+Q+MDhAr52hy6wVz
         qkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDjT4OI5wAggtMEPQfLGg4TgWcxeq6e+1z/RZEK3k/Q=;
        b=qYCoSlxiTrnZKYogx3rpvYzf7tZoslHA03p8PXN+Z1IkRdi4+Kj5NL0Pk+xpU0X8JQ
         QhbUaoquBQ9GriSk5S850CZRijYf8YXTvOsIq8OKfilq4f7xtMCFTQbkjY2sN62sytnf
         mxZoaafdOOakDqIHOUSF2wmeHf+3RipuNfB1kzCGkkpOEXp9Fw4I8DR8j1aLldVVbyT8
         FM0ECHvOaBJNOVu4RznR9N/GgxscC4WXrJG/eNyXG8rQPPqc1lb9t+3/n+LvP46ZzQQF
         nwinAjbgBOvuAJLw6VYr7JdPfDwfQ2AmTB3VKCvlDVlCpAJ6GskgVdu22mSa4/RHbgTF
         h1ag==
X-Gm-Message-State: AGi0PuZQIhfRSMZo3i6c7RKJVaUOHeue87NWCsztPX1KuCDISDgWixuP
        GRPCjW3bM+7UYAHcnaq08fZw3TUMJQbRqOy/cV8=
X-Google-Smtp-Source: APiQypLwYX31r/2oriZVds06GsoIRDXLR2ni8jZ606fzcV0mK+e+rtloFjvizPTu/NLYB/tb4L3Ld/xkJyGUEAjW0BY=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr2349391pgb.74.1587120465482;
 Fri, 17 Apr 2020 03:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
 <20200416205428.437503-2-alexandre.belloni@bootlin.com> <CAHp75Vddt-UKkP+b8W2CDYjt5kzggwQ+gTjrieigeYhM=e4Tig@mail.gmail.com>
In-Reply-To: <CAHp75Vddt-UKkP+b8W2CDYjt5kzggwQ+gTjrieigeYhM=e4Tig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:47:33 +0300
Message-ID: <CAHp75VeUdj4kkGMaapZu2i96faxmdnhC4a4GF1UoGfSKAVtg6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 1:44 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > The first received byte is the MSB, followed by the LSB so the value needs
> > to be byte swapped.
> >
> > Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> > bytes to get the last bit.
> >
>
> Can you show example of what is read and what is expected to be a correct value?
> Because it seems I have been reported with similar issue on other TI
> ADC chip [1]. Perhaps we have to fix all of them?
>
> [1]: https://github.com/edison-fw/meta-intel-edison/issues/108

Also, forgot to mention that TI ADC are 16 bit word, so, we need to
read two u16 rather then bytes.

Some configuration won't allow to do byte reads.

> > Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
With Best Regards,
Andy Shevchenko
