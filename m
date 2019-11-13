Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4A6FAF5A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKMLJr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 06:09:47 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:42176 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKMLJr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Nov 2019 06:09:47 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id F3E16A36F6;
        Wed, 13 Nov 2019 12:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1573643384;
        bh=9wU6KxqnR0Kw42lkPxAxiBvKKDA/fl3xWaNuzyFDdRA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=q7O49WJ9UPTuSY8FWNuY1DbYfGo+E3Td6y5HLBlXCQo6DkcVhhXmEapuYzX4hLyr8
         E38aa7uBq8U5sRsYzpw0LKlNZLV9T8fM+6j1DbX5CS2Xt/ixvEdkEKOKz3jzfOU7bs
         oC3A+0dKkyyLxPEl0mX8opeUKNjgUyEI1+eD4YD0=
Subject: Re: [PATCH 3/5] iio: ping: add parallax ping sensors
To:     Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191107130045.rt3ix2atyjd3gekr@arbad>
 <20191110170650.00527b8b@archlinux>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <196ba1f0-9d9f-9f46-c86e-2c41a7835c59@ysoft.com>
Date:   Wed, 13 Nov 2019 12:09:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191110170650.00527b8b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10. 11. 19 18:06, Jonathan Cameron wrote:
> On Thu, 7 Nov 2019 14:00:47 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
  
[snip]

>> + *
>> + *          +---+            +------------------------+
>> + * GPIO     |   |            |                        |
>> + * ping:  --+   +------------+                        +----------------
>> + *          ^   ^            ^                        ^
>> + *          |<->|            interrupt                interrupt
>> + *         udelay(5)         (ts_rising)              (ts_falling)
>> + *                           |<---------------------->|
>> + *                           .  pulse time measured
>> + *                           .  --> one round trip of ultra sonic waves
>> + *                           .                        .
>> + * ultra           +-+ +-+ +-+                        .
>> + * sonic           | | | | | |                        .
>> + * burst: ---------+ +-+ +-+ +-----------------------------------------
>> + *                                                    .
>> + * ultra                                    +-+ +-+ +-+
>> + * sonic                                    | | | | | |
>> + * echo:  ----------------------------------+ +-+ +-+ +----------------
> 
> Nice diagram ;)

Using the '+' characters at the edges and '-' characters for levels makes it
not easily readable in some cases. Especially for the short subsequent bursts.
What about this?

      * GPIO      ___              ________________________
      * ping:  __/   \____________/                        \_________________
      *          ^   ^            ^                        ^
      *          |<->|            interrupt                interrupt
      *         udelay(5)         (ts_rising)              (ts_falling)
      *                           |<---------------------->|
      *                           .  pulse time measured
      *                           .  --> one round trip of ultra sonic waves
      *                           .                        .
      * ultra                     .                        .
      * sonic            _   _   _.                        .
      * burst:  ________/ \_/ \_/ \_________________________________________
      *                                                    .
      * ultra                                              .
      * sonic                                     _   _   _.
      * echo:   _________________________________/ \_/ \_/ \_________________
      */

Michal
