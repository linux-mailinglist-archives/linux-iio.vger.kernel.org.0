Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36731A49D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhBLSeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 13:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhBLSeO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 13:34:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5AA064E8E;
        Fri, 12 Feb 2021 18:33:32 +0000 (UTC)
Date:   Fri, 12 Feb 2021 18:33:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: add labels with accel-location to bmc150 and
 kxcjk-1013 drivers
Message-ID: <20210212183332.7769e70b@archlinux>
In-Reply-To: <20210207160901.110643-1-hdegoede@redhat.com>
References: <20210207160901.110643-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Feb 2021 17:08:58 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> Here is a patch-set implementing the standardized "accel-display"
> and "accel-base" label sysfs-attributes defined in my earlier
> "[PATCH 1/2] iio: documentation: Document proximity sensor label use"
> "[PATCH 2/2] iio: documentation: Document accelerometer label use"
> series.
> 
> This patch sets adds these labels to the bmc150 and kxcjk-1013 accel
> drivers.
Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Note we are almost certainly too late for coming merge window so this
will be next time around.

Thanks,

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (3):
>   iio: core: Allow drivers to specify a label without it coming from of
>   iio: accel: bmc150: Set label based on accel-location on 2-accel
>     yoga-style 2-in-1s
>   iio: accel: kxcjk-1013: Set label based on accel-location on 2-accel
>     yoga-style 2-in-1s
> 
>  drivers/iio/accel/bmc150-accel-core.c | 18 ++++++++++++------
>  drivers/iio/accel/kxcjk-1013.c        | 14 ++++++++++----
>  drivers/iio/industrialio-core.c       |  6 ++++--
>  3 files changed, 26 insertions(+), 12 deletions(-)
> 

