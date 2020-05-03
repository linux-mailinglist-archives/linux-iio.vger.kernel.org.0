Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36B81C2CE7
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgECNzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 09:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbgECNzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:55:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B6D2071C;
        Sun,  3 May 2020 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588514145;
        bh=lB1MrnqLhDuBmhewC/KHu5UxvhwZtOeoZoAFi6K4OtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x0jSkAlaSi/d1spb8wNspsRKfZDQZOPIhG4wR0EqkPc/YOmyeTnkwz3YEFHFstxfS
         acHLEriJMt5si74nFbUzTWOkgo9RFZz28q2ZWK6wijRhwwKx/chmRi0jMeAziRaFiL
         1JudVeNs5vcBq/KUsrFe/R6ncUF7m7l1AmnKvddI=
Date:   Sun, 3 May 2020 14:55:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] iio: vcnl: Add interrupts support for
 VCNL4010/20.
Message-ID: <20200503145540.419b37d2@archlinux>
In-Reply-To: <20200503092959.8806-1-m.othacehe@gmail.com>
References: <20200503092959.8806-1-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 May 2020 11:29:54 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Hello,
> 
> Here's a v7 fixing Jonathan remarks.
> 
Great thanks.  All applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> Thanks,
> 
> Mathieu
> 
> Changes from v6:
> * Add a missing Signed-off" tag in the first commit.
> * Clean exit pattern in vcnl4010_buffer_postenable.
> 
> Changes from v5:
> * Fix i2c measure reads that are broken on the current driver for be16
> platforms.
> * Use read_avail callback for sampling frequency.
> * Move scan_index setting to the correct patch.
> 
> Changes from v4:
> * Rename vcnl4010_in_periodic_mode into vcnl4010_is_in_periodic_mode
> and vcnl4010_thr_enabled into vcnl4010_is_thr_enabled.
> Also fix bitmask checking in those functions.
> * Refactor vcnl4010_write_proxy_samp_freq to loop in the
> other direction.
> 
> Changes from v3:
> * Use i2c_smbus_read_byte_data and i2c_smbus_write_word_data
> for read and write functions.
> * Rename vcnl4010_prox_threshold to vcnl4010_config_threshold.
> * Do not lock i2c accesses as they are already protected.
> * Fix a typo in irq name.
> * Do not provide ALS sampling frequency operation, as ALS data
> are not buffered anymore.
> * Return bool in vcnl4010_in_periodic_mode and vcnl4010_thr_enabled
> functions.
> 
> Changes from v2:
> * Rebase on iio testing branch.
> * Remove useless test in vcnl4010_probe_trigger.
> 
> Changes from v1:
> * Split into four different patches.
> * Use iio_device_claim_direct_mode to protect
> raw access from buffer capture.
> * Requesting a sampling frequency above the limit is no longer possible.
> * Inline read_isr and write_isr functions.
> * Remove IIO_LIGHT data from buffer capture.
> * Make sure postenable and predisable functions respect the common form.
> * Do not set the trigger by default.
> * Remove the devm_iio_triggered_buffer_setup top half.
> Mathieu Othacehe (5):
>   iio: vcnl4000: Fix i2c swapped word reading.
>   iio: vcnl4000: Factorize data reading and writing.
>   iio: vcnl4000: Add event support for VCNL4010/20.
>   iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
>   iio: vcnl4000: Add buffer support for VCNL4010/20.
> 
>  drivers/iio/light/Kconfig    |   2 +
>  drivers/iio/light/vcnl4000.c | 753 ++++++++++++++++++++++++++++++++---
>  2 files changed, 689 insertions(+), 66 deletions(-)
> 

