Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22B11CA63
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfLLKRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 05:17:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47069 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 05:17:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so1229005lfl.13
        for <linux-iio@vger.kernel.org>; Thu, 12 Dec 2019 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nsjxm/xsVTVDpo/VXg1VeJFF1h4DkTUUCH1h89G0Zd0=;
        b=brj8PL4uRioYXwXT/Qsa2ut7sivw5CPbNF/C1uVPOiQJ6SVBIruISlsjUZylmX0qYs
         nbs/TBXflqGc/q74nsX+LLqBffC0+NZdPRePM0euTQHeD0D/eVnLzpREh198aPS6FO7w
         PS4jtzJmeLnG8W+zoIkFBUU8+051+GehMsdKfTSEN5ncf4CuxUfSmmt5k09DlH7OKkT2
         AtGZrMcwbDhTitJ+eT9wV7R/oKPPTYz02xDt75vVU5LX9u0k4j+hWzCesZU1SYOSf1Lc
         ElDBwABojO+pYTEFhmAl8b2Y+vH2kGkr5bUk6kYM0LWGndflpvw6O0eDAGV5HW+levmy
         uBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nsjxm/xsVTVDpo/VXg1VeJFF1h4DkTUUCH1h89G0Zd0=;
        b=jVZ1LRqkdwHalsqDVH70MaTEIEyO2HDc/vqYdmeeP1uSfs7NEE36fBZ3SkNToDak3H
         T507RHxho+Io4jxKSR2wtZJx/Y/qU2HWjTq15Da2vN6887vVXXBf26zNhLGSKZP0SD7a
         7mOu6RI5ZzY1PPhJVyiJzjzDBsqcLw6uKTQWP3i8UVAnzSVFRvkjx7gk25L2TYjnHJTg
         1QvBLKz8kM/mw2L6HooN+4mPuifp48aMacn4ISRg6Ao0VDefz2ISB7U6Sev96UMuKVsk
         pM2/ddTTa71MKsAH7O2XUsxr7xmGfAkVOPcYgFAYhiWGgPXb9c/BDsGG/tXzu3rh8CV2
         vf8Q==
X-Gm-Message-State: APjAAAV11prS49B2bq+LEUdrKWchxXfi3cradoFIGMsgtj3hbd2GgK2B
        mq6i3zByZOHFG+6iPvpg89FfqrJ+SBFYpC0Ex5kLcQ==
X-Google-Smtp-Source: APXvYqxyRNskvKt1YiIx2AO3iz21aIKpjYS1talkzQKvdDQ0CGu70+tqdA0tq0OfwohHhZzmsdo2c9dCihGvRXhHfMw=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr5125013lfd.5.1576145819071;
 Thu, 12 Dec 2019 02:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20191211010308.1525-1-dan@dlrobertson.com> <20191211010308.1525-2-dan@dlrobertson.com>
In-Reply-To: <20191211010308.1525-2-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 11:16:47 +0100
Message-ID: <CACRpkdb9O7RjpXdUPCtN1M+PLC+2hPomhsw2Q5Ehhg4pEVOStQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: bma400: add bindings
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

Hi Dan,

thanks for your patch!

On Wed, Dec 11, 2019 at 2:20 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
(...)

> +  Specifications about the sensor can be found at:
> +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf

As can be seen in page 113 in the manual this component
has VDD and VDDIO supplies and sooner or later someone
is going to have to model that so I'd say add vdd-supply and
vddio-supply regulator phandles as optional to the component
already from start.

Thanks!
Linus Walleij
