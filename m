Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198D1CCA15
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEJKKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 06:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgEJKKD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 06:10:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC9F020735;
        Sun, 10 May 2020 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589105403;
        bh=XxCh+CGXiUL6qNcbhDup79bdNTtgu/khjj12Nti93p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTcQLe63y02EQHkxtR4MN3TaUt3u9hAwTjkNrOdAq/B0gkO2b+qNlRMjd7lRw672R
         IQQbXKX36gvBGb7IiqH4mvJsHET/TQX8cws/evCCWt9NZ+U23thBv8iGzTkOplpZpC
         EnndfQuFuO9J7u6WcFkbBSur2/coGMLJkYr5BfdE=
Date:   Sun, 10 May 2020 11:09:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Message-ID: <20200510110958.29046a18@archlinux>
In-Reply-To: <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 May 2020 10:52:14 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/8/20 3:53 PM, Alexandru Ardelean wrote:
> > [...]
> > What I don't like, is that iio:device3 has iio:buffer3:0 (to 3).
> > This is because the 'buffer->dev.parent = &indio_dev->dev'.
> > But I do feel this is correct.
> > So, now I don't know whether to leave it like that or symlink to shorter
> > versions like 'iio:buffer3:Y' -> 'iio:device3/bufferY'.
> > The reason for naming the IIO buffer devices to 'iio:bufferX:Y' is
> > mostly to make the names unique. It would have looked weird to do
> > '/dev/buffer1' if I would have named the buffer devices 'bufferX'.
> >
> > So, now I'm thinking of whether all this is acceptable.
> > Or what is acceptable?
> > Should I symlink 'iio:device3/iio:buffer3:0' -> 'iio:device3/buffer0'?
> > What else should I consider moving forward?
> > What means forward?
> > Where did I leave my beer?  
> 
> Looking at how the /dev/ devices are named I think we can provide a name 
> that is different from the dev_name() of the device. Have a look at 
> device_get_devnode() in drivers/base/core.c. We should be able to 
> provide the name for the chardev through the devnode() callback.
> 
> While we are at this, do we want to move the new devices into an iio 
> subfolder? So iio/buffer0:0 instead of iio:buffer0:0?

Possibly on the folder.  I can't for the life of me remember why I decided
not to do that the first time around - I'll leave it at the
mysterious "it may turn out to be harder than you'd think..."
Hopefully not ;)

Do we want to make the naming a bit more self describing, something like
iio/device0:buffer0?  Given the legacy interface will be outside
the directory anyway, could even do

iio/device0/buffer0 with link to iio:device0
iio/device0/buffer1 with no legacy link.

Ah, the bikeshedding fun we have ahead of us!

I think this set is going to take too much thinking for a Sunday
so may take me a little while to do a proper review...
+ I have a few other side projects I want to hammer on today :)

Jonathan

