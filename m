Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD3107E51
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfKWMV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKWMV6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:21:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D957520714;
        Sat, 23 Nov 2019 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574511717;
        bh=86VxRLf1DOjqgJ9W3NpRGBGe6avDoiryNAD/GGEwBng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uM6YXZuVtsJx6h1No1L+Z5LvqBTW+eeX7fYBKevgddmbMcKwprj/+KjXMc9U7VMq6
         l0s86HUPyUmT9xuoxMZwcEj0E/gExiKYeOt2lRj8u5A/QA9JGS5VYjNJz18jeJdx1D
         TTelovGtMF9vCV+4HH2PevldY2Qkjq7ZSFwlGZrY=
Date:   Sat, 23 Nov 2019 12:21:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 00/11] iio: imu: adis: cleanup lock usage
Message-ID: <20191123122153.76fbbc2a@archlinux>
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Nov 2019 15:24:10 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There is a general effort for cleaning up `indio_dev->mlock` usage in IIO
> drivers. As part of that some ADIS drivers also need to do that.
> 
> This changeset does a little more, by reworking the `txrx_lock` from the
> ADIS library to be used as a general `state_lock` to protect state between
> consecutive read/write ops.
> 
> As such, all users of the ADIS lib have been verified to have their usage
> of mlock checked. Some just needed the mlock usage removed (as done in
> 
> Changelog v1 -> v2:
> * this patchset has got more testing in our repo since last time - also
>   found a bug in v1
> * tested with `make ARCH=x86_64 allmodconfig` ; seems this is how Greg
>   found the issue and we didn't
> 
> Alexandru Ardelean (11):
>   iio: imu: adis: rename txrx_lock -> state_lock
>   iio: imu: adis: add unlocked read/write function versions
>   iio: imu: adis[16480]: group RW into a single lock in
>     adis_enable_irq()
>   iio: imu: adis: create an unlocked version of adis_check_status()
>   iio: imu: adis: create an unlocked version of adis_reset()
>   iio: imu: adis: protect initial startup routine with state lock
>   iio: imu: adis: group single conversion under a single state lock
>   iio: imu: adis16400: rework locks using ADIS library's state lock
>   iio: gyro: adis16136: rework locks using ADIS library's state lock
>   iio: imu: adis16480: use state lock for filter freq set
>   iio: gyro: adis16260: replace mlock with ADIS lib's state_lock
> 
>  drivers/iio/gyro/adis16136.c  |  31 ++++---
>  drivers/iio/gyro/adis16260.c  |   6 +-
>  drivers/iio/imu/adis.c        |  94 +++++++++++----------
>  drivers/iio/imu/adis16400.c   |  51 ++++++------
>  drivers/iio/imu/adis16480.c   |  17 ++--
>  drivers/iio/imu/adis_buffer.c |   4 +-
>  include/linux/iio/imu/adis.h  | 150 ++++++++++++++++++++++++++++++++--
>  7 files changed, 258 insertions(+), 95 deletions(-)
> 

All applied to the togreg branch of iio.git and pushed out as testing to
get some build coverage.

Thanks,

Jonathan
