Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158071A6F14
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgDMW0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389547AbgDMW0A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:26:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADFC0A3BE2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:25:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m8so10435794lji.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUCDvQBuFOY6FntBajf86Ahrm42D1jbDg3+bQiczunc=;
        b=ZyRGNKsLPgDkDKERqhymWrQTaGTsLlekHVERP9HAfuLas0LlJqQJwstZGvfPXbWSLm
         4IAGi726gf+ZmNuhyIg4h2JFRqBLQ5sy+zmE8IJYa6zC6U5EvruB6A0OSBiZznP+0Zn5
         pl6qgycIZ2U1DqPUJ7SARvqteQpriX6YrHte671/7u8vDGqHq1PvSBXpAZYw6wu5TfSE
         NB0TL3jzH+iPXKAB1vLoqDqgjUljHaXTsfC0AD93/fV25u62CTETv6T815oK+vDtCSQ/
         Mo3mqU7CJuaVibNC6oPhdlWN7Q37BIKxHqBJZOLJYpFtYHWv3Q+Iq4USrf9lJrD12fjI
         T+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUCDvQBuFOY6FntBajf86Ahrm42D1jbDg3+bQiczunc=;
        b=acaZOdEvFSRw6xzF6q+pIYvxGH2ixOgVDqnCy3ye6swCOXN8PGOmCVAsF7tX196IwP
         NeV9GgJrTxOWFwN6Bg1oOQw559T7+Cv1O79n0Jv2Jb0LRoLGxQi/Fx1bjhBo6p7hD902
         pXQ7/GtIONlErCFcabfFH+Yr1NuIzFmTP5RgjJn7rwk/YMrh0IA9WmuC+2s0YFCwQkid
         BA2SI/WU7Rt3/TyvAK/1nKm1QcQbb4VL/KuidMZLawjta+d1LQDqeXZRpjyAhddjW1b3
         Ubb3jcqy4l04YebLLNBAhwo7i0iXKBjs2DLr16I+BzXDVE0zEW++VRuHkMSUVfVwP142
         HRtQ==
X-Gm-Message-State: AGi0PubkCCFa4iwti7c1+P7ykaBFWk4RLyzBepMX3xz8Ls0Ys/cWHatV
        f+7yxDJP/0nnMGcAWpB4Mf9Z1HbaDpaBBO9SuGvQLg==
X-Google-Smtp-Source: APiQypK/2ndHP8kURQ4Ts5/glyvQUwVgyvNBP+wEjHvHfdV2YnmCWGpR3I1/R0iVsua46EQmS6XHoD1eNZluPnrODaI=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr11256699ljn.125.1586816758021;
 Mon, 13 Apr 2020 15:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200406141350.162036-1-nick.reitemeyer@web.de> <20200406141350.162036-3-nick.reitemeyer@web.de>
In-Reply-To: <20200406141350.162036-3-nick.reitemeyer@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Apr 2020 00:25:47 +0200
Message-ID: <CACRpkdYy9kHw5X3UejiMSusaC2oPH6ZE4=D3uTeBEgMpExOhYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8974: add Alps hscdtd008a
To:     Nick Reitemeyer <nick.reitemeyer@web.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 4:24 PM Nick Reitemeyer <nick.reitemeyer@web.de> wrote:

> The hscdtd008a is similar to the AK8974:
> Only the whoami value and some registers are different.
>
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Also
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Works like a charm on the Skomer.

I don't know about the mounting matrix though.

Does anyone have a simple procedure for how to
calibrate the mounting matrix for a compass so it
makes sense? I suppose just run a sensor app on
a know working device and compare side-by-side
but something more formal?

Yours,
Linus Walleij
