Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A58386C82
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhEQVpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbhEQVpi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 17:45:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0877C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 14:44:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i22so10877341lfl.10
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csdWjW1cBvN8ly67d30X0KBHCJnajtFtJnhMZldr7DQ=;
        b=X8c1ILfF0ZzCL+qQFnCDw2IY2gfXLRgMvv+w8Tckt/71uXOJjLFC4kOula2ID9fw2L
         vrE3mRM1xDUaDQ7Ti/ArQR6d37maQ49Iq5w7lJV8GRuh3cIYAW8djEj2uDGc+bqtjEpd
         sMyzW4pHarhiojkX7PY01ju26IbDJEZ1kS77lv47wkXkB0ruWeGsaGscEKyMgP+SdTsP
         uXopCru+XOV8bW4I79AB/CyBL0YPuq2kexx6FX22KbZq3OQTycm8ij0OB+DEW4ELdoc+
         vVQrVaSivpMJsCxSEBwldt+Icl04XlACveTUSeGDdMqn5ZvBfSniuASTR05kAopLwMzz
         CPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csdWjW1cBvN8ly67d30X0KBHCJnajtFtJnhMZldr7DQ=;
        b=SBRCSTv9rU4tzP2Di2zL7O9D5tG9z8TSTeK5TkBUNAghRrnBPpplpba0lFwJmdZJ/a
         dNWaBgQjphB29i+T524cAfHOJwcq6rTCq5ypqssMuumSdRx8gLlYC2Nf2pRLPpLipN7D
         FkclAX9SKGgf/5XXkRs62bcspUqZNz+Zwwfxsrg3QGJLgkXr5U/JOpmZC4LiD3owcaBv
         mjp/VXaOR4M17d8wZiit5TQNodIvGmKqIsdkTKz3BryZ7yWNzPUqq0XS4ly4UB/8dc90
         4Q41p1JQ/upiWxUbVR4QcxsfLpyc35VWC2O9p69zk/+ZBMzcmNFvl88nt7TitXN1h3IA
         Zk0Q==
X-Gm-Message-State: AOAM531t4/WbYCSzd/JlhTnrEzkLki1go48FvYZcxGyhF9X6VMQLT4Rx
        7bmxehfZR7kll4RF96uzN+MuKuMGMXuVRewp35kNGw==
X-Google-Smtp-Source: ABdhPJx8y/v+HeLyrsmexLFJ2tAaSkwimFtfg4aUESvp51GcxVgT89cheOBkHD4DXuk71vsJ3XHlibYFHKhUI1wmZY4=
X-Received: by 2002:a05:6512:1050:: with SMTP id c16mr1327134lfb.586.1621287860169;
 Mon, 17 May 2021 14:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210509113354.660190-1-jic23@kernel.org> <20210509113354.660190-3-jic23@kernel.org>
In-Reply-To: <20210509113354.660190-3-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 23:44:09 +0200
Message-ID: <CACRpkdb0yDo5vgs1wnc-8VipP43Job9z2oGQb7Y4LwBrgXoEdA@mail.gmail.com>
Subject: Re: [PATCH 02/28] iio: light: isl29028: Balance runtime pm + use pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 9, 2021 at 1:36 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Whilst we are here, use pm_runtime_resume_and_get() to replace open
> coded version.

Wow that is a new API. Why didn't I know about it...
Oh it is only from november last year that is why.
I guess we should switch to this everywhere.

> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
