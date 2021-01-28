Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1D307147
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 09:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhA1ISp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 03:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhA1ISQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 03:18:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFEC061756
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 00:17:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m22so6458619lfg.5
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UUPO56zRHIcd1GGmE9q6C6hc7jbcbMJSOt0JbCE1PY=;
        b=tNYn5HjEhmrxYsyOI6paQCtk4XutacdpJb6s45x4bcruVIEvtNaxmpI9bJvYDCKQQB
         Maob1jxRcCHcmkx8Lu1JMQJ6pPdzo2f1ULgSzSnWIRBIkSAqGevrWQP4HtHitu/3xcgd
         CQE+RPWdOI0LSfqkfdmsVPVeUHV2k+RmxLX+s/m3EIncRDg70Rh9mXZzOwzw6yYORuXu
         XTHj7vmhuM+MGb8f6Znn1vjAfpaElwdmvyoMwjG8+Kx5RdEkLzHHKoVQKVFUGr1qJ/3D
         lQbY9P3QTQ9whmaremBq+ZaqzIoI80BKYXLlfJsceuKvi+n4GVTu5qztMwFudfAFkfBq
         7XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UUPO56zRHIcd1GGmE9q6C6hc7jbcbMJSOt0JbCE1PY=;
        b=kgdFLGGlLf+5MXtXtsqGMy9cL+0gtzpU++EarasAK55UJbotWBjsfP+jvSqXxNseP8
         oi+SiiSLIIsbg5ttQ+7/VgKT7dJ5ZVM91bdrx/lOf0nQIKlPPN6XsTGgXKuuQsO6EhSb
         ebTrsYID90qPFEUxPgsqieqRi+7rMgFMsJBzHKawIbD+GU40h6ZSNLSCqB823AUQMysu
         7sEOcrmNrJjPb5jXukS/FGyVsKiLwzBeDc42/HZtIBuZlbNDmgbvDNE9PXS88wQ8rOT9
         kAE7PCAUprAmIOcg8FejLUbL76Q3uqw7oHo22zLTC4hF/aBAPZi/+G67FRzl4xpXZSDg
         ufvw==
X-Gm-Message-State: AOAM530lODDF1uwjg77Biq0t2nQI7EXVaLUny2ata4+0FlY6fFJTUJ5M
        GVLWEBzztQHfLZak11XK2ZJ5ZpMWIY/lE2DQ+omzwQ==
X-Google-Smtp-Source: ABdhPJyFkTnYADY3GMqkCQcxbWIGND0JGm60R62dLMZIsQBHeSNbgkO3acjUCd+bes6A0vp2FBcf6/8Zf58N3zwRMfk=
X-Received: by 2002:a19:b8e:: with SMTP id 136mr7276317lfl.29.1611821854852;
 Thu, 28 Jan 2021 00:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20210126131239.8335-1-o.rempel@pengutronix.de> <20210126131239.8335-2-o.rempel@pengutronix.de>
In-Reply-To: <20210126131239.8335-2-o.rempel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jan 2021 09:17:23 +0100
Message-ID: <CACRpkdY2XYi2jqYiXaBUfRO1+UEK3QCC8JQ0duENVGoOfYTmBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: counter: add pulse-counter binding
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Oleksij,

thanks for your patch!

On Tue, Jan 26, 2021 at 2:15 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add binding for the pulse counter node
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
(...)

> +properties:
> +  compatible:
> +    const: virtual,pulse-counter

What is so virtual about this? The device seems very real.
However it is certainly a GPIO counter.

I would call it "gpio-counter" simply.

Define:
  $nodename:
     pattern: "^counter(@.*)?$"

> +    counter-0 {

counter@0 {

> +    counter-1 {

counter@1 {

Thanks!
Linus Walleij
