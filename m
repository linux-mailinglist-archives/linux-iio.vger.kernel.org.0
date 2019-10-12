Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E41D4F9E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfJLMUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLMUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:20:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B292089C;
        Sat, 12 Oct 2019 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570882824;
        bh=WsAJcCbCqdRQyqqdkfWrgfSvWbhNoUNwa/6TREiLW1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CieUPL+mdmZVgvjFGRQwwpKAjBqyGxmaB4FklXrAWLLAMTOAbk/n67danMnjyfRPX
         upHal5pRxoReYAYWF5MMDudzh3kY8urtQFZp0bmswD2e1MepsrufcwodMHAXvOylVG
         ys9qQ3TPd/Yx7ysMUDdQdO+1I5sE56w9Pzp7y0t4=
Date:   Sat, 12 Oct 2019 13:20:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/13] various st_lsm6dsx fixes and missing bits
Message-ID: <20191012132020.412e9595@archlinux>
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:21:54 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> This series fixes some corner cases introduced with LSM9DS1 support and with
> the one that has added wake-up event support. In particular it fixes a crash
> due to missing HW FIFO support for LSM9DS1.
> Moreover I introduced the missing wake-up event support for LSM6DSO/LSM6DSOX
> sensor
> Add missing dts documentation for wake-up event and the capability to enable it
> through platformdata.
> Code cleanup.

Hmm. This is going to be very messy.  In theory quite a few of these apply
to stuff in 5.4 but I assume won't cleanly apply given other changes.  You
may want to think about doing backports of the important parts to 5.4.

I'll apply the lot for 5.5.

Thanks,

Jonathan

> 
> Lorenzo Bianconi (13):
>   iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in
>     st_lsm6dsx_report_motion_event
>   iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
>   iio: imu: st_lsm6dsx: move irq related definitions in irq_config
>   iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not
>     supported
>   iio: imu: st_lsm6dsx: move bdu/boot and reset register info in
>     hw_settings
>   iio: imu: st_lsm6dsx: always check enable_reg in
>     st_lsm6dsx_event_setup
>   iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked
>     configuring events
>   iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
>   iio: imu: st_lsm6dsx: fix checkpatch warning
>   iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
>   iio: imu: st_lsm6dsx: add missing kernel documenation
>   dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source
>     property
>   iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  35 +-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   3 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 588 ++++++++++++------
>  .../linux/platform_data/st_sensors_pdata.h    |   2 +
>  5 files changed, 440 insertions(+), 189 deletions(-)
> 

