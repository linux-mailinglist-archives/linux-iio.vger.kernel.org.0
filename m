Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7432DB6A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCDUt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Mar 2021 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhCDUtT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Mar 2021 15:49:19 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02199C061574
        for <linux-iio@vger.kernel.org>; Thu,  4 Mar 2021 12:48:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u18so21411024ljd.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Mar 2021 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+wRNAf0Q85Frjl629r+QSA6MELaxL1cYBPYnhqcMls=;
        b=ZhET52GVqaFyRkKRREzt7me5mimbeOUR3gR3JVmbMxCrxvN2sIjssa9dNxud1sNl+j
         B+62ABkLeRCQrLcDwAv6AoRXKFgbgLMXp+8UymSfwxOUgZYlaiFcU0o+tsrJmvdCqdNW
         bx/is+oo8KMfAYELOkH+2blGkvq4GuBpHUag+PSyUYuEKsxCtWtjwaO3UIh0esw7vtIf
         aM3+kFQk/TZjVBjJKP5XAlX/2yMwaUa9dlM7+PXCrZvv18Uzw/LaGtV+Jm0zSZGNl2JV
         EbFqCtAv85OJMoGCjyeHpEWgW3VDpPE64rF1PdgAnHiRGEgjVcKpdl1gjbHAMM58q8Ue
         vpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+wRNAf0Q85Frjl629r+QSA6MELaxL1cYBPYnhqcMls=;
        b=VuiNnvtr1ouumdvqNQS6Lc+Ae3iJsvQji97g301iW+DwjDi9dHzD/qoo0D5dYQlP9X
         nkIDoLLfsp7l9TWkFLqefz/am7H0HJRDLlbyk6t38dCjragchg867CH25uOQZWRYx1s+
         xTkWX7K9wl4YWruXc9gh1wknSIhQOJZKcMNVQ50avUcGYYVxvq427zQdW044Ib8a9S7E
         cGziQtunV84WkwPXc5TCCuu2z84yAc+fOwfl5k6LFitN5Uhd5slXucCWaHm+7saM4Iir
         B01wnFVrFq2eXvKnMOf03FW8Nwqbvj62j/KlorkGvwbUBOwLkFiHBJaO+ZsTXlHKpJnx
         6iQA==
X-Gm-Message-State: AOAM533fhPwpwRHlcf4551zKJ1oKNM/W0lIzRMBp9y+OXfQydcCN05Hy
        9cBFA1N60bnqcmSSqpF9g8k8Fj8YBRaDoPt4j1W7Sg==
X-Google-Smtp-Source: ABdhPJyZNp5MeMgEdPVphCnPcuH/5EUPtN2HQlmc0Q4z2VrHi7EYbU6CsDGQ+FGJV6E+ALcB1SMEA2SJVR53CEuRF00=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr3282250ljj.438.1614890917049;
 Thu, 04 Mar 2021 12:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20210304154205.1918124-1-linus.walleij@linaro.org> <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
In-Reply-To: <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 21:48:25 +0100
Message-ID: <CACRpkdZcyWPUtJbjYMS=mWZW48ZkKe=arAydJbXK6E8jyQT=hA@mail.gmail.com>
Subject: Re: [PATCH] iio: event_monitor: Enable events before monitoring
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 4, 2021 at 5:00 PM Bastien Nocera <hadess@hadess.net> wrote:

> If I'm not mistaken, "-a" does that for the iio_generic_buffer tool.

Yeah I implemented that, and I thought about doing the same here
but ... the name of the tool sort of announce that one want to
listen to all events so I thought it should just default-enable
all of them in this case.

> Maybe moving enable_disable_all_channels() to a common location and
> using that would cut down on the duplicated code?

The event enablement is slightly different, the generic buffer
turns on various channels, which is conceptually different
from various events, but let's see what Jonathan says.

We are sharing most of the code already in the iio-utils.c
but I can try to break out more if it doesn't get to abstract.

Thanks Bastien,
Linus Walleij
