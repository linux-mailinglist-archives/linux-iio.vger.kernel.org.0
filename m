Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BEE494C15
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiATKus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jan 2022 05:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376402AbiATKsa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jan 2022 05:48:30 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE020C06173F
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 02:48:29 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p9so5768478qkh.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drofg5bZM2qwAB7ATZ/cfW3+3FZXwgKGVP69ItIqA10=;
        b=lSFrpwW1wuAfDYgH03cW7I7OjP1WbLut0KjRhMrnTuGvNcnMybeWIQyMH1JIx00use
         yizqAk+va/sg/eFSjqoeYOXH0HLzvW3eaS930YNZ7e5h9ip0eD9d1p3WN/CjBKya/85l
         mcfYW4HK49fyHi+z6g7gsttn0/XTRnkA0JrcbZ8vAEFMc99HRXqRBh9g54gh8kCdMIHP
         Uy/leO8tXeu8VOapVIT9ExqJ1h2JsDwxr8R0jV4kFsVzHWQZ4duKK2h5zTEq+mJc5xwY
         pwglT+eOqfCVyz7nHNeUkkpmHVf/KXR4zpWZ1F4jD8ezJL5uWmGaPXIaZhEiHCZrb0Nw
         P/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drofg5bZM2qwAB7ATZ/cfW3+3FZXwgKGVP69ItIqA10=;
        b=wWqWTEXOKObgaIBjdEJSr/Rq6VxGTnVx1r2EDV+BqG8GyfhmgI8W5UToY/d1vAGFJa
         tch91sPGXTjOs8wEaUb0XtyEEGEliUynwRsTxA9vE/SQ5XZ9GXZV0XSPX83U+aYgZ9+c
         nsv2buQ+y5ec4WS/zj0Gp4ohYKY6g0yPIAyySIaBwZT/2CVYHDUkmg0oLZ6SsxIwVd81
         Qhcf/pGxwRRlW65oHrY8BBHsYAA/KwKnfonVxT3s7wlQnau92iz8R+oAWQy5JcVTH0Nw
         +zeib8stt9PtKDb1TcdskaGMUDiAT5ByjIStuuf2rCGyEa/qf/B2XSUyvWaoWwGsCDtB
         s+Xw==
X-Gm-Message-State: AOAM531+tu465tiuK5gq307tbUCCcE4tKUEjYqvtpHCIsW9d0kvjgeqB
        EmmbOASf55JguAmodl1NvPDwvS6gNg1T6IiHekq1iw==
X-Google-Smtp-Source: ABdhPJytHAAGxtq/qSZOpc+YupHixT4TRIrIOSLNgZfB6xUrCUXkckzmPRmlM/mOoCMvKsJgp3kOntmGDDsXWw0Jxwk=
X-Received: by 2002:a05:620a:1382:: with SMTP id k2mr18319057qki.447.1642675708891;
 Thu, 20 Jan 2022 02:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20220120104009.159147-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120104009.159147-1-krzysztof.kozlowski@canonical.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Thu, 20 Jan 2022 11:48:18 +0100
Message-ID: <CABxcv==EkNd9MrpJuyECzY1EdnWiZ_ffz8OXoTy8X76R_Ty4Xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: drop Enric Balletbo i
 Serra from maintainers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-input@vger.kernel.org,
        =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[adding Enric's personal email address to Cc list]

Hello Krzysztof,

On Thu, Jan 20, 2022 at 11:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Enric Balletbo i Serra emails bounce:
>
>   <enric.balletbo@collabora.com>: Recipient address rejected: User unknown in  local recipient table
>
> so drop him from the maintainers, similarly to commit 3119c28634dd
> ("MAINTAINERS: Chrome: Drop Enric Balletbo i Serra").  Add generic DRM
> bridge maintainers to Analogix ANX7814.
>

I'm adding Enric in case he is still interested in maintaining these
and prefers to update his email address instead.

Another option is to add an entry to the .mailmap file.

Best regards,
Javier
