Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20534311EB2
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBFQkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 11:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBFQkF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 11:40:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA97364E41;
        Sat,  6 Feb 2021 16:39:22 +0000 (UTC)
Date:   Sat, 6 Feb 2021 16:39:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] resolve read hystersis return invalid argument
 issue for hid sensors
Message-ID: <20210206163919.7993d392@archlinux>
In-Reply-To: <20210201054921.18214-1-xiang.ye@intel.com>
References: <20210201054921.18214-1-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Feb 2021 13:49:19 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> This patch series move get sensitivity attribute to common layer and
> resolve read hystersis return invalid argument issue for hid sensors als,
> incli-3d, rotation, and press on intel ISH Platform.
Hi Ye Xiang


Series looks good to me.

Now this series touches a few bits of code outside of IIO so ideally
I'm looking for acks from:
@ Jiri for the header
@ Alessandro / Alexandre (+CC) for RTC

Both changes are trivial but might cause them some noise in other work
going on in their subsystems.

For reference:
https://lore.kernel.org/linux-iio/20210201054921.18214-2-xiang.ye@intel.com/

Thanks,

Jonathan

> 
> ---
> v2:
>   - separate the add relative sensitivity patch to the next patch series.
> 
> Ye Xiang (2):
>   iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
>   hid-sensors: Add more data fields for sensitivity checking
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 23 ++++++-------
>  .../hid-sensors/hid-sensor-attributes.c       | 17 +++++++++-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 19 ++++-------
>  drivers/iio/humidity/hid-sensor-humidity.c    | 16 ++++------
>  drivers/iio/light/hid-sensor-als.c            | 20 +++++-------
>  drivers/iio/light/hid-sensor-prox.c           | 27 +++++-----------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 32 ++++++-------------
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 20 +++++-------
>  drivers/iio/orientation/hid-sensor-rotation.c | 24 ++++++--------
>  .../position/hid-sensor-custom-intel-hinge.c  | 20 ++++--------
>  drivers/iio/pressure/hid-sensor-press.c       | 20 +++++-------
>  .../iio/temperature/hid-sensor-temperature.c  | 16 ++++------
>  drivers/rtc/rtc-hid-sensor-time.c             |  4 ++-
>  include/linux/hid-sensor-hub.h                |  4 ++-
>  14 files changed, 111 insertions(+), 151 deletions(-)
> 

