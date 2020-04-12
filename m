Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAE1A5ECF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgDLNsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:48:16 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49068 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLNsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 09:48:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 9174C9E78F9;
        Sun, 12 Apr 2020 14:48:14 +0100 (BST)
Date:   Sun, 12 Apr 2020 14:48:12 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls
Message-ID: <20200412144812.1c65e88a@archlinux>
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If anyone is bored and fancies sanity checking the ones in this series
that have had no eyes on them yet, it would be much appreciated!

Thanks,

Jonathan

On Sun,  5 Apr 2020 19:03:15 +0100
jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of Andy Shevchenko's recent patches tidied a case of this up
> and a quick grep showed we had some more.
> 
> The main focus of this set is calls to regmap_bulk_read /
> regmap_bulk_write.  Both are used with buffers of many and varied type,
> but as they take a void * there is never any need to cast a pointer
> to said buffers to anything explicitly.
> 
> Whilst I was here I used sizeof(buf) in various places to reduce
> the use of explicit values when we could derive it from the source
> / destination buffer.
> 
> This isn't remotely urgent, but I'd like to clean these out to avoid
> replication in future.  Not I didn't go after any other unnecessary
> casts in the files because that would have take thought and its Sunday
> evening and about time for a beer.
> 
> Jonathan Cameron (6):
>   iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read
>     calls
>   iio:chemical:atlas-sensor: Drop unnecessary explicit casts in
>     regmap_bulk_read calls
>   iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
>   iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
>   iio:magn:mmc35240: Drop unnecessary casts of val parameter in
>     regmap_bulk*
>   iio:light:ltr501: Drop unnecessary cast of parameter in
>     regmap_bulk_read
> 
>  drivers/iio/accel/mxc4005.c                |  4 +--
>  drivers/iio/chemical/atlas-sensor.c        |  7 ++---
>  drivers/iio/chemical/bme680_core.c         | 36 +++++++++++++---------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  4 +--
>  drivers/iio/light/ltr501.c                 |  2 +-
>  drivers/iio/magnetometer/mmc35240.c        |  4 +--
>  6 files changed, 32 insertions(+), 25 deletions(-)
> 

