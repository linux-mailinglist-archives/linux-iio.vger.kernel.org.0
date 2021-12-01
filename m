Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFF46597B
	for <lists+linux-iio@lfdr.de>; Wed,  1 Dec 2021 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbhLAWxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Dec 2021 17:53:34 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38875 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLAWxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2021 17:53:33 -0500
Received: by mail-oi1-f171.google.com with SMTP id r26so51690643oiw.5;
        Wed, 01 Dec 2021 14:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDut9FDjyS7cvZ6OtKt3ZhA8ckXBN4QI5o6gqsIbxQU=;
        b=ZdKm+zlxqog0LTsVnvU0TwIZCThAug5yP2zS+JsOS8Or0l/ttBaoQSJVT80UqwveIE
         wBSDjdA+ygx/AT16kPCJu1BGTqqa1nnR4rWBmkNxJ/3vsrxsA8ZZ5/fl02v1bvEgvmPO
         0TrAzh0jCbE+bcIHRE9nuXEIm3BaK/yojnm2Si/d6x0i7OQlDXCr3jcRn8TqpJOC7h0L
         yZ7jMzfH54zZASoztyzpPhYG3XqwXwufW5tW7iKmHzCG4hDvdguRcKnk8I6KzIW4ZI2m
         z3sgz1/RKi4977wedLEJGp4ZA+fDp8gF/8qaCqlOsLKqHIZcTcckCMfVVARSzecSOF6X
         eySw==
X-Gm-Message-State: AOAM530gKDkzRWt+PS2nZDJbmgMSFWoN1wflfWheuWNzFnx2/aI0I55G
        5HmKJipH0/BdPhxu5xgOCl43X0kfVw==
X-Google-Smtp-Source: ABdhPJx5+/+tgHcjnm0WO+tKo1il1G9G5wjCb2EVFfjoCYR+Hp83LHdRTEyX/xQy5SrSCFXzK1w2EA==
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr1244447oic.123.1638399011641;
        Wed, 01 Dec 2021 14:50:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y192sm506680oie.21.2021.12.01.14.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:50:11 -0800 (PST)
Received: (nullmailer pid 2995089 invoked by uid 1000);
        Wed, 01 Dec 2021 22:50:10 -0000
Date:   Wed, 1 Dec 2021 16:50:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in
 example
Message-ID: <Yaf8IkypvCTHi3xO@robh.at.kernel.org>
References: <20211125152154.162780-1-geert@linux-m68k.org>
 <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
 <20211127174343.1b9dcabe@jic23-huawei>
 <CAMuHMdVWZEai-EYvoWc5eToSqK9N8KsXi6u0Ej6fQzQE77aNoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVWZEai-EYvoWc5eToSqK9N8KsXi6u0Ej6fQzQE77aNoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 29, 2021 at 09:22:35AM +0100, Geert Uytterhoeven wrote:
> Hi Jonathan,
> 
> On Sat, Nov 27, 2021 at 6:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Thu, 25 Nov 2021 16:26:16 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> > > On 25/11/2021 16:21, Geert Uytterhoeven wrote:
> > > > "make dt_binding_check":
> > > >
> > > >     Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
> > > >         From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > ---
> > > >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > >
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > >
> > This doesn't particularly feel like we need to rush it in, so applied
> > to the togreg branch of iio.git which will go in next merge window.
> >
> > Shout if I should pull it to a fixes branch.
> 
> Thank you, that's fine. We're still far from the point where we can start
> enforcing "no errors" in "make dt_binding_check dtbs_check".

No errors/warnings is the rule for dt_binding_check, but not dtbs_check.

Jonathan, Can you drop this and I'll apply with some other fixes I have 
for 5.16.

Rob
