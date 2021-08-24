Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8214F3F5E06
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbhHXMdd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:33:33 -0400
Received: from first.geanix.com ([116.203.34.67]:37276 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237175AbhHXMdc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Aug 2021 08:33:32 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 83078440F5D;
        Tue, 24 Aug 2021 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629808366; bh=jhnO480Cc6mGF2xnqHwZ8lNOlITVllVmhuET/7Kvi8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=My3r7H3i8d6ZiRcDnFWXU9zn+Y5UyQ37XqepWjUeDw10Fk1hYxAyr9EW8E7r/Wtrq
         H/znu1Etv/lvo9QYUrtpa6vDmZ4tj+7tOgfFNTQ7iq/DLzm0s3c8hWdfefTpgvqDxa
         YZvdlRj74V7Kc+1iTxQ7u5dehKkX+PIWEqktLUEUY8PW6lBiaHDAUiIzO+FFCQPKBS
         V7AnDhVktPxTwDLTrBs4b67CvJjmQ4/dPQIenmuv+AnPk94gMUZUExHkmdQD434YVh
         Y5M+O645+AsxYpm6a1m+OJebabrSoKB1zxUK9HV3p97TFy/h1PB7ofasMhulbGnEaw
         L7caLDBfrt1NA==
Date:   Tue, 24 Aug 2021 14:32:45 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: add threshold event
 handling
Message-ID: <20210824123245.z5o452x5s5m2wcyx@skn-laptop>
References: <20210824113709.1834195-1-sean@geanix.com>
 <CAHp75VeMzs+xyksGB8Kcnr-09a740eoWYmEJQHgbhMNVbuzAwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VeMzs+xyksGB8Kcnr-09a740eoWYmEJQHgbhMNVbuzAwA@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 03:15:28PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 24, 2021 at 2:38 PM Sean Nyekjaer <sean@geanix.com> wrote:
> 
> ...
> 
> > Do we have some helper functions to do the 12 bit 2-complement numbers?
> 
> Probably not, look around where sign_extend32() is defined. More on this below.
> 
> ...
> 
> > +       return regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> > +                                mask,
> > +                                value);
> 
> One line?
> 
> ...
> 
> > +       /*
> > +        * Add the same value to the lower-threshold register with a reversed sign
> > +        * in 2-complement 12 bit format.
> > +        */
> > +       data->lower_thres = (~val & GENMASK(11, 0)) + 1;
> 
> This looks suspicious.
> 
> 0 => 0xfff + 1 => 0x1000. Is it what is wanted?
> I thought that -val & mask is what you need.
> 
> Can you explain more in the comment (maybe with examples) on what is
> coming and what is expected?

It's a bit messy I know :)

Some examples:
val = 0 => upper = 0x0, lower = 0x0
val = 500 => upper = 0x1F4, lower = 0xe0c
val = 1000 => upper = 0x3e8, lower = 0xc18

Guess it could work if we special case val = 0...

It doesn't even makes sense to write 0 to this register as noise would
trigger events.

> 
> > +       data->upper_thres = val & GENMASK(10, 0);
> 

/Sean
