Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FE125CB7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLSIdI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 03:33:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35559 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSIdH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 03:33:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so3738438lfr.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2019 00:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKdZfjZH2e9GPk64PhPrvn+Af7qtk63t1BrhD8ePLsU=;
        b=ups+DeAFHChjjhe00lTLkddxXH/4Fj4vJxKQxTZyRQUhNa5WYcT4QLFVaOYgIG9r11
         XZjY6i2KSGElJ85ll3SVN9fSLBUUnDpLdtvHv6ij7Kx3Kat91MkOSlk73ASzPJPqAAWA
         IYhXOv9N59rxPghhC5IaLpRXKdjN0DeiNFlNpWuvXHHWbYuNXsZZUla0UsCKpd+r14z7
         0khEuAjteuDiUihfU6aNrx6+5Dgs+XNpoqFSm90V60ro55cP2ZDIgMW90B4N2AbZ5Wf+
         l7euIyQ6SYTeF8sXuKMX3kooTwhq+MOUafqIzgO3OQgdIh7ek+W9F33brCanGDw0CfL5
         bOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKdZfjZH2e9GPk64PhPrvn+Af7qtk63t1BrhD8ePLsU=;
        b=i4VLxwQ2xV1k0B1dHcW/OVcEfFlBsn8Pols5SCbUoVunwxleNua1K4khg4nH51GHNU
         h7M99xjwvj4xuI6uYvANeEjYDhzkWE8Tz/tU6lccPpElHuB7vipdxDe2Kg1LmL8047O7
         zbMPigqsOITKcPyLvA0SMh8e6foliVGeAgK7zzuCNQISMy03WgbWnDbUTCPVtfm3/NJb
         dmxWvlyTZB55X+EGrvdYaQnhUadz4hvRoNIWELKd8RnKvXGid5UHqp9Z3bVsJ5meeLiW
         m9YPsteDlLWLXijyYBLg+HhcIYDwK8byK/rg297ngsQIjVMe4IKymc88lz3A6VJIbNKi
         K9SQ==
X-Gm-Message-State: APjAAAU5kSRq3+FYiDOJBHIz/2DqQ5QsuSJd45igZ4/wRMSGrQQPdetr
        t/gRro9+IRU+2fvrZk0hOd8FNnNFWpti22YXid9tOg==
X-Google-Smtp-Source: APXvYqzaAgCVHUdj5DNEslSqFxuU1AVBFaR71PPbkZqONekNTb+Jgw52NqXDCfJNyzkThI+t+ljGL6aObMtlDFqv8Ps=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr4543811lfp.133.1576744385217;
 Thu, 19 Dec 2019 00:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-2-dan@dlrobertson.com>
In-Reply-To: <20191219041039.23396-2-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 09:32:53 +0100
Message-ID: <CACRpkdbNZMfUtpYXEJVNyHA+TnoT_vAnR5c++_LDZ3XADZYOkg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: iio: accel: bma400: add bindings
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 5:27 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
