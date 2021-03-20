Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF0342F04
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 19:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTSe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 14:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhCTSei (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 14:34:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97D961927;
        Sat, 20 Mar 2021 18:34:37 +0000 (UTC)
Date:   Sat, 20 Mar 2021 18:34:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: Start conversion to sysfs_emit()
Message-ID: <20210320183434.38d1228a@jic23-huawei>
In-Reply-To: <20210320071405.9347-1-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 08:14:01 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> sysfs_emit() and sysfs_emit_at() are new helper functions for output data
> for sysfs attributes. They are preferred over raw s*printf() for sysfs
> attributes since it knows about the sysfs buffer specifics and has some
> built-in sanity checks.
> 
> This patch series updates the IIO core to make use these new helper
> functions instead of raw s*printf().
> 
> In addition all the powerdown callbacks of DAC drivers are also updated to
> use sysfs_emit().
> 
> There remain many instances of s*printf() in individual drivers for now.
> These can be converted in follow up patch series.
> 
> But in many cases rather than doing the conversion from s*printf() to
> sysfs_emit() it will be better to convert those drivers to implement
> read_raw() or read_avail() callbacks and let the IIO core do the
> formatting.
> 
> Implementing read_raw() or read_avail() instead of directly implementing a
> sysfs attribute has the advantage that the data can then also be accessed
> through in-kernel APIs and is available to in-kernel consumers.

Looks good to me. I'll let this sit on the list for a little while
though as obviously touch a lot of drivers + core code so others
may well want to check we haven't missed anything!

Jonathan

> 
> Lars-Peter Clausen (4):
>   iio: core: Use sysfs_emit() (trivial bits)
>   iio: iio_enum_available_read(): Convert to sysfs_emit_at()
>   iio: __iio_format_value(): Convert to sysfs_emit_at()
>   iio: dac: Convert powerdown read callbacks to sysfs_emit()
> 
>  drivers/iio/dac/ad5064.c           |  2 +-
>  drivers/iio/dac/ad5360.c           |  2 +-
>  drivers/iio/dac/ad5380.c           |  2 +-
>  drivers/iio/dac/ad5446.c           |  2 +-
>  drivers/iio/dac/ad5504.c           |  4 +-
>  drivers/iio/dac/ad5624r_spi.c      |  4 +-
>  drivers/iio/dac/ad5686.c           |  2 +-
>  drivers/iio/dac/ad5755.c           |  4 +-
>  drivers/iio/dac/ad5758.c           |  2 +-
>  drivers/iio/dac/ad5770r.c          |  2 +-
>  drivers/iio/dac/ad5791.c           |  2 +-
>  drivers/iio/dac/ad7303.c           |  2 +-
>  drivers/iio/dac/ltc2632.c          |  4 +-
>  drivers/iio/dac/max5821.c          |  2 +-
>  drivers/iio/dac/mcp4725.c          |  2 +-
>  drivers/iio/dac/stm32-dac.c        |  2 +-
>  drivers/iio/dac/ti-dac082s085.c    |  2 +-
>  drivers/iio/dac/ti-dac5571.c       |  2 +-
>  drivers/iio/dac/ti-dac7311.c       |  2 +-
>  drivers/iio/industrialio-buffer.c  | 20 ++++-----
>  drivers/iio/industrialio-core.c    | 70 +++++++++++++++---------------
>  drivers/iio/industrialio-event.c   |  2 +-
>  drivers/iio/industrialio-trigger.c |  4 +-
>  23 files changed, 71 insertions(+), 71 deletions(-)
> 

