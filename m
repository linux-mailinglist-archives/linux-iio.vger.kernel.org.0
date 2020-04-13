Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133661A6F0A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbgDMWXk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728183AbgDMWXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:23:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C852C0A3BDC
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:23:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so10430901lji.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO7GrPNetmdR0BRplZ8joqlR6+g0nmzlZ3ZAN/HxoxU=;
        b=mEZwI6LnrfdXvRaG0Kde9NnIgbjXuzg9iIGO1yT6N76afmjUaU4l/N2en41UcoCZ4C
         M4tKqZsZkitXLRTrRK5j2l/q7vES0G2bm07kqQVh17ZGSfiC4L5NQKfKPzacoZpJ11AK
         YgG2QfnAGzQGklzabiW73F6ijEmNEC/urcvrbGZGIAD3geFxngiCMDbYMnPehjzGbIia
         yJhWu74KvE3U35Sr6cbJzZpPdgavSAgZuKEqOeYoJkO/gQoUUIfwlArz/Sks63GxrJYo
         CrD62SgDIS69o4RWfithv7rfYu7o+KhaUp4J0rGQPN5KpSz3e/fb3a3v3dULUPtRh2/y
         AbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO7GrPNetmdR0BRplZ8joqlR6+g0nmzlZ3ZAN/HxoxU=;
        b=bhODo7NMl6DGclUAeeUsl4fpuCYCEj3EwICfWzdkD+PfN6A32bxLvxgHcbA+OcaCb3
         N1ZnTsR81MpFp3y9u6whidg+3NFR78rXyI6hGpLNTZIkuCbyRDkaRYfoSS4uI34+wQtT
         uaemcXzwgcNvCKCd7br5ev00+epgzrSSEtsMzNbSC98WlXiVFIqmY+4gDduW67Wku4gO
         yXWTLgHe1lt/jeBfbTGHMG76XhtFsus3Lmz4ruoHB/k7y8yiEF1vS2fzFCuRjimmIeqO
         VBT7cQgj2ZQVrGHtMBik1n7inOqgUyH4itQaT65frfWqTV1Fji+nDyTKLzGPe66+MhBN
         T7eA==
X-Gm-Message-State: AGi0PubmZN9XWxdHJ7G9HC4/y34KTsESLCVDlAwC7ASkWsDr78wAiVW+
        GF8o+E75QH2CHVxL0x+pbWR1/hf9qdy3m3rFEomB7w==
X-Google-Smtp-Source: APiQypL6L1l9yVGcwlBWq8a8A43u6FR9g6WHFZ04KouAm0YqYK1D2zNeJ7aWgM6ye+HHxGJ5k6ZuxKrq3u+6pcLvFN4=
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr11979366ljo.223.1586816616804;
 Mon, 13 Apr 2020 15:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
In-Reply-To: <20200406141350.162036-1-nick.reitemeyer@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Apr 2020 00:23:25 +0200
Message-ID: <CACRpkdY1p3jBzm6cTY9OJJRPmwhKQa=HGUFSXUFuTOD0FNdQNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Alps
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

On Mon, Apr 6, 2020 at 4:23 PM Nick Reitemeyer <nick.reitemeyer@web.de> wrote:

> Alps Electric Co., Ltd. is a japanese electronics company:
> https://www.alps.com/
>
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
