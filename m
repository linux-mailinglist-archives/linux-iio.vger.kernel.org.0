Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24DEED31D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 12:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfKCLZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 06:25:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfKCLZq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 06:25:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB602080F;
        Sun,  3 Nov 2019 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572780345;
        bh=iVW9cBPnp0fjG+zTXydLaRUI+YAsffRYMHdiQGWeTNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KnLJ+ocoKBFLnYGZIbVgwmWNxa5NTEVReT7rXqEDHZFdSgW8ESY92vPuukCGO5mN5
         y9vqz0hcZ3nU0N3F5FZomd4QzsIqsOyxrHhXvE+x5X+YxUZ9W2fXjI1LxKiU3qhAkW
         xI7w+lUfCUUpXO6DQQ9rXH3gMMs4gyKQZjNPR5QU=
Date:   Sun, 3 Nov 2019 11:25:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE
 to define debugfs fops
Message-ID: <20191103112540.5fdfccad@archlinux>
In-Reply-To: <5DB958DA.7080305@huawei.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
        <1572423581-59762-2-git-send-email-zhongjiang@huawei.com>
        <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
        <5DB958DA.7080305@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Oct 2019 17:33:14 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> On 2019/10/30 17:13, Ardelean, Alexandru wrote:
> > On Wed, 2019-10-30 at 16:19 +0800, zhong jiang wrote:  
> >> [External]
> >>
> >> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> >> operation rather than DEFINE_SIMPLE_ATTRIBUTE.  
> > Not sure if "more clear" is the word.  
> Should be more clearly. :-)
> > But it is more correct to use DEFINE_DEBUGFS_ATTRIBUTE(), since they are
> > debugfs attrs.
> >
> > In any case, this is no big deal.
> > So:
> >
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >  
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
I started looking into why this attributes were introduced.
There are potential issues, so Alex can you confirm you've tested this
series.  Whilst it looks right, it seems some other patches making this
change have had to switch over to the unsafe registration functions.

https://patchwork.kernel.org/patch/11051725/
https://lkml.org/lkml/2019/10/30/144

The reference counting is subtly different between the two versions.
Seems you are getting some push back on similar patches.

Perhaps a v2 with reference to the other threads if those get resolved
to say it is sensible to make this change.

Thanks,

Jonathan


> >> ---
> >>  drivers/iio/imu/adis16460.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> >> index 6aed9e8..2e7a582 100644
> >> --- a/drivers/iio/imu/adis16460.c
> >> +++ b/drivers/iio/imu/adis16460.c
> >> @@ -87,7 +87,7 @@ static int adis16460_show_serial_number(void *arg, u64
> >> *val)
> >>  
> >>  	return 0;
> >>  }
> >> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
> >> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
> >>  	adis16460_show_serial_number, NULL, "0x%.4llx\n");
> >>  
> >>  static int adis16460_show_product_id(void *arg, u64 *val)
> >> @@ -105,7 +105,7 @@ static int adis16460_show_product_id(void *arg, u64
> >> *val)
> >>  
> >>  	return 0;
> >>  }
> >> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
> >> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
> >>  	adis16460_show_product_id, NULL, "%llu\n");
> >>  
> >>  static int adis16460_show_flash_count(void *arg, u64 *val)
> >> @@ -123,7 +123,7 @@ static int adis16460_show_flash_count(void *arg, u64
> >> *val)
> >>  
> >>  	return 0;
> >>  }
> >> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
> >> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
> >>  	adis16460_show_flash_count, NULL, "%lld\n");
> >>  
> >>  static int adis16460_debugfs_init(struct iio_dev *indio_dev)  
> 
> 

