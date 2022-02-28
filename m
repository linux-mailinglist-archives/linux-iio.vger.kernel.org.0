Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0834C6FA7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiB1OiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 09:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiB1OiG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 09:38:06 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB4F0F
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 06:37:24 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c0so110604797b3.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVpTo5tPx3PMdktiKIMZkyByWle1NPQ1YD4EpGj4GSg=;
        b=mLaRadXO9R6BwQBCon+f1xm+IT7RKrQStLCaHefdAtJaVWjN7e2lAMQDkdB/vJjDyg
         z7UXU5u/zZaDLsjOyEUsv9DM9PPIDmHcGKlnhFrra4017CzQ26z0RmObueVzlQ87fV+m
         EaEAmzIKYNH90Zw3Hs7CNVEJS9BRKq2Cr+J0kTxTACXR1JPXlq+/WqHGB+O4UTPd9uUu
         S+hfkGn4iPpv2ftOnSO8zZhMMpagRk8DJ0EOjxRISMWokmAjR6ajTg0auGGl+ROT0aPC
         OJ2asPzw1+1Mp/4i+bjDIwQXMmJ7gDqo57D6PW/Ul5HQrcuClEOGqRQwp74tiL6+cMeH
         fswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVpTo5tPx3PMdktiKIMZkyByWle1NPQ1YD4EpGj4GSg=;
        b=w1UYRG/05nvMabyxC+Bq7AvbsybOJQrB4oo4cGeUMOm5H5LLXmXg4sWyB20TZBV1xp
         Qjgx07pdqDk2eyoEAy7E1G641C2w2lnxhH5deABA00CKLQ89bEMDAeVXr4WsTVQ/Jctb
         6at9FuwsseTZvY7dQ8aMNvl8GDk1dDmYtfhb9uS1xZnEQJRDHT4C7fImhvyNFvX+Nfrp
         yeLGJ2qL2+Y3YbONK1FJjUChDXR9/dClnJP0WXJwnKNDUeMsUFeaPbJmGM+fKbZ+sdBt
         yeHvX/Z3drVPoeGU+OIbVp/LNdQtcs3brvk0258HWENWjTbKED8e1/EKWno5zdHf9BfE
         PYTw==
X-Gm-Message-State: AOAM530i+atHrzVovEXIkj7AvnSuFQ9FMpYzJwD9uSIpO8CGiuAp52vs
        uXdvmy5sQh70uNkZOzBXba8JQR7eYvZccIryrD/nG4jevfpdkA==
X-Google-Smtp-Source: ABdhPJzQNN20OGB6fLuabC4QjTuGoZ9qIREifW+/q1ibj3JW1DkurROdQ8xfOP+aQn0JJPGnDESe7yupGKvrGsnPAGE=
X-Received: by 2002:a81:f92:0:b0:2d0:5383:7ca with SMTP id 140-20020a810f92000000b002d0538307camr20081621ywp.268.1646059043696;
 Mon, 28 Feb 2022 06:37:23 -0800 (PST)
MIME-Version: 1.0
References: <Yhv9M/aXptQSKQju@tp440p.steeds.sam>
In-Reply-To: <Yhv9M/aXptQSKQju@tp440p.steeds.sam>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Feb 2022 15:37:12 +0100
Message-ID: <CACRpkdajZLz4kRDpN0ETx=ZNavr0L7bKBW22LrjDmdmkQkg60Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: st,st-sensors add LIS302DL
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 27, 2022 at 11:37 PM Sicelo A. Mhlongo <absicsz@gmail.com> wrote:

> Update st,st-sensors bindings for STMicroelectronics LIS302DL variant
>
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
