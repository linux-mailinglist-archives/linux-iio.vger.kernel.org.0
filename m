Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDE29F288
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgJ2RG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RG4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 13:06:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAFDC0613CF;
        Thu, 29 Oct 2020 10:06:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 15so2843109pgd.12;
        Thu, 29 Oct 2020 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVpaY1YKeBibYxcS0Jsq9BfQgPaCuKmR8DrB7YyXYUM=;
        b=V16mRfjTnLiOcKzWrUiq2+AwnQAYSsIfj/unr+JScYr+jS4MoAsFZZQ9ofWAouW9E0
         dZOLrnFdtaSyzEbIAFhTS71ZBGClzAPPkityCzcUkDP7jEnGCF57VamdazrL1DjE8/p+
         6ovpf2k2FzE+93ANKSA/iXzwfuw3ydOrHuE63PsEUAEiCdColgZpzdrCKDRUChRZLfmC
         41ntIXoYxzacmH2PEpQGfhePWw5yL5Olk7WZD0ZB6K9sZTUpKPIHhxqtoD/4DTQ+vYvO
         aKn484eHP+wdTNJovGyZAmLu2ZVLt3qMbSAHW5iPcvN9NZGkLLQgBTa+HOJlKlfLN4yq
         NXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVpaY1YKeBibYxcS0Jsq9BfQgPaCuKmR8DrB7YyXYUM=;
        b=OJ7ql43bUjZFe8/C4qdJ1QjknExf5SfrwopzYOvUZ+IOI0Aoow+6cBhfXqD0f6mvdu
         GtgNtCw0KlNvng8lGIuA6hUl9iAnvOsscV0AsRixH7PT+1eTgOtMt1dUv+QlTBzvoYNu
         7+4lg2cR7nNKxIXb01INwaU1JswmWVrRTS1ik8XX1cuEbHujnSOeLlrKv2ZMebD8emUW
         /6LcsHKpfQ0N+0P9q+rWuN/0YEsqEdFyLwYJXEy51XaRJXbYlnX7JTQeSwoE4FSxthXt
         bxpfFu/viYJnR7UBSXRcdnxu+4rqPnHS3VX1yMJgdKRX7emgpK/pYrcxpVp7jiCh/4GG
         jelw==
X-Gm-Message-State: AOAM532ERQD6fFCa8nCmc5Jnfim6Qk6l0Gylz+XR/9WZ0k46oueQSnGb
        OWuH2N37O2hB+3pPSS1bkgnaHDS2yviVTBbQo7zfIxjOXMA=
X-Google-Smtp-Source: ABdhPJzJgzwfx3ikkUEry19sCLyEQYilXlV8smoaT56t2Xkgo/3x5lLtprT1OvoJrm02omVy9AU9x8BUXNK0+oIBadY=
X-Received: by 2002:a63:1e02:: with SMTP id e2mr4730399pge.74.1603991216464;
 Thu, 29 Oct 2020 10:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201029074910.227859-1-coiby.xu@gmail.com> <20201029144007.77d967b0@archlinux>
In-Reply-To: <20201029144007.77d967b0@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:06:40 +0200
Message-ID: <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 29 Oct 2020 15:48:56 +0800
> Coiby Xu <coiby.xu@gmail.com> wrote:

> Please put a cover letter on your next series explaining the context.
> In this particular case some of the replies you have gotten are
> general at it is a lot easier to find these sorts of things via
> replying to the cover letter.

Looking at the number of duplicate messages I would suggest that one
needs to go through documentation on how to use git format-patch and
git send-email.

-- 
With Best Regards,
Andy Shevchenko
