Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC43124B1FB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHTJRw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 05:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgHTJQq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Aug 2020 05:16:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F512075E;
        Thu, 20 Aug 2020 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915005;
        bh=JevydDBhYMPRDxc3sy5EdELKloWyBwLFSSgotFi8qx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wbCD2B2QCYbOUdAejCCGRVJBV1ssR3IOwQSOiT0RuW7J6D/KV6PqZ/CS+GF47NfVu
         OaYnyXuA4L01d/ZW2NWCLqqmjsS2fpUE5Yi7DOWsr/HblndRq8JBHqJ6IsRcq6R4QM
         QydfJQudJ0ADu+UvjSHaY9EZxyXbXxuSodCcCFkA=
Date:   Thu, 20 Aug 2020 11:17:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>, Mario TESI <mario.tesi@st.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Message-ID: <20200820091705.GA1122903@kroah.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
 <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
 <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
 <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
 <20200820100100.00000d33@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820100100.00000d33@Huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 20, 2020 at 10:01:00AM +0100, Jonathan Cameron wrote:
> 
> +CC: GregKH as this will pass through his tree.
> 
> As a quick summary, it seems we have some cloned parts that appear to be compatible
> with certain ST micro parts, but have different whoami address values.
> 
> Entirely reasonably, Denis is not happy to have them added to the ST maintained driver
> given the potential for future incompatibilities.
> 
> I don't particularly mind a separate driver, though I would ask that we remove
> a lot of the abstractions from the ST driver as they won't be necessary given
> the much more restricted parts being supported,
> 
> Greg, I'm guessing this is far from the first time this has happened.
> Any advise?

Yes, this happens all the time.  Do not create a whole new driver if at
all possible, that way lies duplicated work and madness.  Just add the
new ids or whatever to the existing driver and have everyone work with
it together.

"future incompatibilities" are never something to plan for, we can deal
with that when/if that ever happens.

thanks,

greg k-h
