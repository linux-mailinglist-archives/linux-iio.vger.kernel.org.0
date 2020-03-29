Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80958196C1E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgC2JiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbgC2JiX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 05:38:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C901206DB;
        Sun, 29 Mar 2020 09:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585474702;
        bh=5/sjfqGBvQaQ/bZqHIQ8wFWgYnvyW4bUPB0a0RVIJRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PEl3YM218kYt/PXa98ariTLCnyIXiWqiAFdO0l1/DQXk1mIJixyk5uZkQgKIxrj01
         +fj/eog+BDVfwpUD3EoOTOIP2FupcL4cGN7INS3nvO0vKVr5PhVSelrAxdvjHx1uJ8
         AozR1kcDDEPUXiDm8tSlwvi+5XVJNPFBAy1lfjLg=
Date:   Sun, 29 Mar 2020 10:38:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Message-ID: <20200329103818.2fce9529@archlinux>
In-Reply-To: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 12:04:53 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> The debugfs_create_file_unsafe method does not protect the fops given to
> it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
> which makes the fops aware of the file lifetime.
> 
> Further using DEFINE_DEBUGFS_ATTRIBUTE along with
> debugfs_create_file_unsafe significantly reduces the overhead introduced by
> debugfs_create_file which creates a lifetime managing proxy around each
> fops handed in. Refer [1] for more on this.
> 
> Fixes the following warnings reported by coccinelle:
> drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> [1]: https://lists.gt.net/linux/kernel/2369498
> 
> Rohit Sarkar (2):
>   iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>     DEFINE_SIMPLE_ATTRIBUTE
>   iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>     DEFINE_SIMPLE_ATTRIBUTE
> 
>  drivers/iio/imu/adis16400.c | 4 ++--
>  drivers/iio/imu/adis16460.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
Hi Rohit,

You've opened a can of worms with this one.  There as a previous series
posted doing exactly this change back in 2019 by Zhong Jiang (cc'd)

At the time I did a bit of looking into why this had been universally taken
up cross tree and turned out there are some potential issues.

Alexandru added it to the list of things to test, but I guess it got
buried under other work and is still outstanding.

https://lkml.org/lkml/2019/10/30/144

Has Greg KH raising the point that file reference counting is changed (as you
mention) but that can cause subtle bugs.  It 'might' be fine but is
definitely one that needs a tested-by from someone with the hardware.

Jonathan
