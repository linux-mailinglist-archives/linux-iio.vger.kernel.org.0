Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA343DAD9C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhG2Ubm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 16:31:42 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:37700 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2Ubm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 16:31:42 -0400
Received: by mail-io1-f49.google.com with SMTP id r18so8783098iot.4;
        Thu, 29 Jul 2021 13:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUWvqLY5dtYTcBMoP6MzaeBbDWJ4C0b6SsAxNWS8lfo=;
        b=ZLq0dZZyAnfRGtM2an19Wmy/yzELC2al21+FauFK+o8itA72QvLXskLzAwj0P1NC3B
         EIUEzPU3b07uRLHYstSqiwb/bejqsiyxFYNL4cCmXFg3ePS2bJm+Vpjvjd5/t6XCCHu6
         WbpQ31d8P/UyqOB+vB5v+2UEPu4zPGs5dDhMbs17JoKqMOwmRQgZ0ObIY3N/0eRDf+VK
         37KEwCww1jON2RZsRT/zyMbHw42JHkhoNZ8NbNCT4HzILr5CsBgJqrG/2wze8baB4SX4
         rHbqrc0nQvCghjYtnjP0hULBTETht6PO6qVB2R0znWXuhK2uoTOHDZMpAxYaoCGuEnQe
         k9ew==
X-Gm-Message-State: AOAM530gutzjkUF3hcjamV72TgVQCSm/rBeBW1bRy4xBzIK9KkEJbMKK
        ospssAqisIGVjUMlEEFVNA==
X-Google-Smtp-Source: ABdhPJwioEdi04/jbfnfuOGVu5hP7n0ehPaMIaPvCp13mUJRpi/eNyFwP4zVRi+5d9gf9aBvRLrKSQ==
X-Received: by 2002:a5d:8986:: with SMTP id m6mr5466807iol.87.1627590697396;
        Thu, 29 Jul 2021 13:31:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a3sm2101033ilj.39.2021.07.29.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:31:36 -0700 (PDT)
Received: (nullmailer pid 835093 invoked by uid 1000);
        Thu, 29 Jul 2021 20:31:35 -0000
Date:   Thu, 29 Jul 2021 14:31:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
Message-ID: <YQMQJ15KpM0eeLIb@robh.at.kernel.org>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-2-billy_tsai@aspeedtech.com>
 <20210723154456.00006744@Huawei.com>
 <E650AFD8-FFD1-4D87-87B0-42D20D9C3BB4@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E650AFD8-FFD1-4D87-87B0-42D20D9C3BB4@aspeedtech.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 26, 2021 at 06:53:07AM +0000, Billy Tsai wrote:
> Hi Jonathan,
> 
> On 2021/7/23, 10:45 PM, "Jonathan Cameron" <Jonathan.Cameron@Huawei.com> wrote:
> 
>     On Fri, 23 Jul 2021 16:16:14 +0800
>     Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
>     >   > The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
>     >   > Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.
>     >   > 
>     >   > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
>     >   We try to avoid 'wild' card type namings most of the time and instead
>     >   name after a particular part number.  I say try because clearly
>     >   we let a few in over the years :(
> 
>     >   It is very hard to know if this binding will apply to 'all' future
>     >   aspeed ADCs.
> 
>     >   As such I'm not sure this particular rename makes sense.
> 
> If I want to extend the yaml file to compatible more versions of the aspeed adc.
> Would you suggest to add new files call aspeed,ast2600-adc.yaml or just append it
> to the aspeed,ast2400-adc.yaml?

If 2600 is not backwards compatible with 2400, then probably a new 
schema file. Given you are adding new properties (which only apply to 
2600?), then most likely a new schema file. Depends at which point there 
are too many conditional (if/then/else) schemas.

Rob
