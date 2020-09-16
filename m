Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD6626C6F8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgIPSNm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgIPSNd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 14:13:33 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97FC06174A
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2020 11:13:22 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 13E149E008B;
        Wed, 16 Sep 2020 19:13:20 +0100 (BST)
Date:   Wed, 16 Sep 2020 19:13:21 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/4] staging: iio: Cleanup some docs in staging
Message-ID: <20200916191321.38381808@archlinux>
In-Reply-To: <20200905174721.216452-1-jic23@kernel.org>
References: <20200905174721.216452-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Sep 2020 18:47:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Some of these simply got left behind when drivers moved out of staging.
> Others were improved upon no end by more recent documentation under
> Documentation/ and are inaccurate or incomplete.
> 
> For now I've left a few files in the staging/iio/Documentation directory
> * inkernel.txt:  We need an equivalent in the main IIO docs but more than
>   a simple rst conversion and move is needed.
> * sysfs-bus-iio-dds: DDS drivers are still in staging so let us keep this
>   with them for now.
> * sysfs-bus-iio-adc-ad7280a: The driver is still in staging, so we need
>   to deal with that before moving or removing this one.
> 
> Comments on removing these of course welcome, but this is a rare occasion
> when I'll probably just apply these whether or not anyone reviews the series.
As mentioned, I'm not that bothered by reviews on patches removing docs so
I've applied these with just the addition of the ack that Brian gave.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (4):
>   staging:iio:dac:max517 remove documentation
>   staging:iio:light: Move tsl2x7x ABI docs to correct location.
>   staging:iio:light: drop stale ABI docs
>   staging:iio:documentation: Drop most generic docs
> 
>  .../ABI/testing/sysfs-bus-iio-light-tsl2772   |  0
>  drivers/staging/iio/Documentation/dac/max517  | 41 ----------
>  drivers/staging/iio/Documentation/device.txt  | 74 -----------------
>  .../staging/iio/Documentation/overview.txt    | 57 -------------
>  drivers/staging/iio/Documentation/ring.txt    | 47 -----------
>  .../iio/Documentation/sysfs-bus-iio-light     | 79 -------------------
>  drivers/staging/iio/Documentation/trigger.txt | 31 --------
>  7 files changed, 329 deletions(-)
>  rename drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x => Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772 (100%)
>  delete mode 100644 drivers/staging/iio/Documentation/dac/max517
>  delete mode 100644 drivers/staging/iio/Documentation/device.txt
>  delete mode 100644 drivers/staging/iio/Documentation/overview.txt
>  delete mode 100644 drivers/staging/iio/Documentation/ring.txt
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light
>  delete mode 100644 drivers/staging/iio/Documentation/trigger.txt
> 

