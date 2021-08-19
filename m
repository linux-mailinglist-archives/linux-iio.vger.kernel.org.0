Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE13F13DB
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 08:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhHSGy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 02:54:27 -0400
Received: from first.geanix.com ([116.203.34.67]:37266 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhHSGy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Aug 2021 02:54:26 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 36CB2440976;
        Thu, 19 Aug 2021 06:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629356029; bh=JZNIA/BNMc7Ln7N7ur+RnMi5im49J+T5e1TZ3i0N+EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cW8ls6gFNwaus8gBvs9VL2wElDRri6N47X/jw9gsuCReWPp78mjU1x0VuHB/aF7K+
         WmTQpNaMpAd9C1ZHX2GS928sBlAj40RUPKLQU4tJ2t8V0LOvOmHTFY7RwS9vV59DS8
         mLqAf0ovQ0Pw+7cfdZ85CqA0zJ/Y72lKUCw1xitiyS/QFVg9OpKPx0NcBJQQMMbMqO
         xJf0Z1pGVcxmxJ5n4vdSwYQ54kc+jV2tZaxFWRM4/YzBqsjin5v0xPlQ0T6IuIWjvx
         +OE1BwSlWha/loeXkf8WIJHep6+xW5J02uerjuCWJlPaXsqwlUALYwmLCa8ib0suGP
         Oc/cdIBsGlYhg==
Date:   Thu, 19 Aug 2021 08:53:47 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: fxls8962af: add wake on event
Message-ID: <20210819065347.zliwr6cbh4xubcpc@skn-laptop>
References: <20210818092741.2114155-1-sean@geanix.com>
 <20210818092741.2114155-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818092741.2114155-2-sean@geanix.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 11:27:41AM +0200, Sean Nyekjaer wrote:
> This add ways for the SoC to wake from accelerometer wake events.
> 
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
> If the buffer is enabled it will be deactivated before suspend, as the
> buffer is quite small.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

I notice when using IRQ_TYPE_LEVEL_LOW, the IRQ will loop on resume
until wdg is restarting the system.
If I use IRQ_TYPE_EDGE_FALLING it will only fail once with -13 EACCES.
Maybe I2C isn't up and running when it tries to handle the irq.

/Sean
