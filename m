Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45637A98A
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhEKOj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:39:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:30198 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhEKOj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 10:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620743892; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RFZ2r1V2cqaQO6sy1PYJIeZCG/h/LuwOUnUly6xdSyNzCUPP+ZB4N/u6muBqj8V0pP
    ztfBjkJNtJWlyNUekzSf6euaemsouoq7k3MfWvkFzYBiEXmn1IWgOjNtBb4QJ3KJeLGx
    19vrtKnPo+MkyFTzEDcnrHzOIejvP3I6ofcpRoLtSZZbbvy/vW6xZdf217gPoUoeCBeF
    yED1++mKn9evDvZwDoT6we5RBtj0CfkLYV7Oigg1b7BXWygR20vyXXklS/owKm783Z3x
    9OcPNRx7neZnhSereDqimo437ZM1NFX49+lMrAbLMjePhXERDdScik4K42RfG5RO5AH+
    +Hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743892;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=429UznI4cBHnKlIOaSLptH17drvMWQFYSsAHzOJfaWs=;
    b=Ddgk4aSXXL0+H4lAYqkqg8QbV36eL65b22sAQm57C+q4juUJDnp3Wc3cYHceznhoXh
    Kzpv2S3ia/ulwD6F3/yzckIOIlrb1hgazwxhQnCtTWdrbJuuKWh6U9YE5FjJfJN8Z0cn
    66JknNuc2EKXBQS/2ccAV2QSBx42N7G8Dm639FIrRMqxbsuisMrxwlq4si61x1CVZehr
    XRMifDIBfdkNNdlq+pKrPifD0yZoeSnE0hhR+NwS1VXAoyO0BJNGydfKh3xMp6Z0yyCi
    tnrcB2IsUT7TmRFvnaCN77awxwwx7dKF3sY5akJYuq7vqkktej6qgdpBmtWOKk89dL+3
    3O+Q==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743892;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=429UznI4cBHnKlIOaSLptH17drvMWQFYSsAHzOJfaWs=;
    b=pMAV5gCfVsz6eo/D5bG8zFSzdPebar0GpI7VYpY+lbaBbAPYcuIpXIlp1NPb+bNml3
    iXnmibe4u6zuV1luyjoa55Aw+LPMsBj8TKpf4D9pPZFi9owKE8dnw37Zq0zHpkdo7M8t
    t2RjubhiXAKHqOCrzU6kPmdKQYqbsoIQKe4FUlRUOxMH0y+znsD+pCXiNm+4lPi+DzkX
    W6PoEJmFdGjsQSWJDw+zYrJNfiuVqvmmktJmRrUgYKXlXYgH3wiQe2r3wNJ6N4WMH9ZA
    J4d92kezVFf8rioOj3Wm1E0obgs36WRv1ekuPbjsposHOWEGmeLss6BmDZu6j8OJjpxv
    ug2w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8IczFY4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id j06c13x4BEcC0qb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 16:38:12 +0200 (CEST)
Date:   Tue, 11 May 2021 16:38:06 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Message-ID: <YJqWzgmxVEvfElZj@gerhold.net>
References: <20210511095409.9290-1-stephan@gerhold.net>
 <20210511142847.GA4413@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511142847.GA4413@qmqm.qmqm.pl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Michał,

On Tue, May 11, 2021 at 04:28:47PM +0200, Michał Mirosław wrote:
> On Tue, May 11, 2021 at 11:54:06AM +0200, Stephan Gerhold wrote:
> > KX023-1025 [1] is another accelerometer from Kionix that has lots
> > of additional functionality compared to KXCJK-1013. It combines the
> > motion interrupt functionality from KXCJK with the tap detection
> > from KXTF9, plus a lot more other functionality.
> 
> When I researched KXTF9 support it occurred to me that the -10xx part is
> duplicating the information in 'KXyyy' - it seems to be a project number
> or something. I would suggest to use just 'kx023' prefix for the code
> and DT but leave the full identification in the comments/description.
> 

There do seem to be two different KXTF9 from Kionix, a KXTF9-4100 [1]
and a KXTF9-2050 [2] with separate datasheets. Have you checked if there
is a meaningful difference between them?

In any case, I think for KX023 there is only KX023-1025,
so I suppose I can omit it. I used KX023-1025 as name mostly for
consistency, although I did change the convention a bit already since
"kionix,kx0231025" was terribly readable.

So both the current "kionix,kx023-1025" and "kionix,kx023" would be fine
with me, any other opinions?

Thanks!
Stephan

[1]: https://kionixfs.azureedge.net/en/datasheet/KXTF9-4100%20Specifications%20Rev%206.pdf
[2]: https://kionixfs.azureedge.net/en/datasheet/KXTF9-2050%20Specifications%20Rev%207.pdf
