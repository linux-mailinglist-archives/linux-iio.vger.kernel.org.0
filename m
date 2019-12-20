Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3821280C0
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLTQfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 11:35:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45984 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTQfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 11:35:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so7468238lfa.12
        for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2019 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BihX16lmLcl6BldTpsH0OGFl1OVMMJgUyjg3R2fKcVU=;
        b=EmiUr5y3Kd58+fVYmxfPM0pyDKslB1iDO9S9msO5xxUeZIp7Oo+1W9nsF/jWqZ6XEJ
         JsRnlCqsuqlSz/lUB8FUh0tHu5FiAmUU7iGLbgDvvs3dsWWtP660bJfXbQYcR47Az7/n
         fNk2w47VtbPgMWhK4Xiqyrh+PiME/NBtIMMi+SfURAjO2KkBN42TOYge+KSXjaBNIQ22
         ZnqwrWMntyjZA0GtlpN3Oj1G0IShPuZqPDBRvh5vze6Gv+t44X3L2LYsjuO59ANnwq01
         qrqKJRJ5SnRk1Y3+VEYlzW3dDtK4dVfqVUnlpIiyugd/hoUEeZJ/xAifmc4bb2ofXeeo
         EfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BihX16lmLcl6BldTpsH0OGFl1OVMMJgUyjg3R2fKcVU=;
        b=iSNDdHCCNbf4LmlSwzURDcMIbJiPBt13eyJEMbt3lnjYDL4hhz3Jl4+bZLqS11cT7r
         FcfGeVnLdHR7z8dJthrcfD3LlTFK6R8pWP3cjGHM3FIR2OYi4bqZZZppi9gDXWLH3c6o
         2hLhkfSqZlqqsaCeMiwOCzdQl86rDLXbQmnrX9DJW56m9fVXefusDCslS5BMVA3NcE8G
         KEnv76CauYN/UFxRhmGNzw7NH8SMfcKY2x8uTdaDOEH0cWoVknMvkqITg+olnoWkdyyP
         QyYKfEJTtz+KHZ56bF6i5vSazgLVd4jAdekKnyi+wRTdvcc7AimALtfEpkvFwOyyRM+c
         OoMA==
X-Gm-Message-State: APjAAAXQEKXgYp8098SLc2POu4MvMX5+MY/dXAxZjxruw3Mq2XFLdD/n
        DRUJBali2nfAn5nDH1wIsUwsjT6TySWAn8q8ZYVsiQ==
X-Google-Smtp-Source: APXvYqyONHUapWq71uGWVwAZl8s5Y4Swig6bZPiBWn7kpEpTM9J0RVPQRYFiNRxU1bGREdojEqknlhtFlC5l2emladw=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr9445593lfp.133.1576859736469;
 Fri, 20 Dec 2019 08:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20191220160051.26321-1-dan@dlrobertson.com> <20191220160051.26321-3-dan@dlrobertson.com>
In-Reply-To: <20191220160051.26321-3-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Dec 2019 17:35:25 +0100
Message-ID: <CACRpkdZupt+Q-QOuu99QcDVDJqAMtwjndSpdTRihgXjbOq-Msw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Fri, Dec 20, 2019 at 5:17 PM Dan Robertson <dan@dlrobertson.com> wrote:

> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
