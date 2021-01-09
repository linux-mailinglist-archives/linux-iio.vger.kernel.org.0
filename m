Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C535B2F0379
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAIUez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 15:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbhAIUez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 15:34:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08E323AFB;
        Sat,  9 Jan 2021 20:34:13 +0000 (UTC)
Date:   Sat, 9 Jan 2021 20:34:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add timestamp channel for hid-sensors
Message-ID: <20210109203409.161bfe4b@archlinux>
In-Reply-To: <20210105093515.19135-1-xiang.ye@intel.com>
References: <20210105093515.19135-1-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Jan 2021 17:35:09 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> This patch series add a timestamp channel for hid sensors,
> including gravity sensor, gyro sensor, magnetometer sensor,
> ambient light sensor, inclinometer sensor, and rotation sensor.
> 
> With this patch series, user can get the time when sensor yield
> a sample.
> 
> Ye Xiang (6):
>   iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
>   iio: hid-sensor-gyro-3d: Add timestamp channel
>   iio: hid-sensor-als: Add timestamp channel
>   iio: hid-sensor-magn-3d: Add timestamp channel
>   iio: hid-sensor-incl-3d: Add timestamp channel
>   iio: hid-sensor-rotation: Add timestamp channel
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
>  drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-------
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
>  drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++--------
>  6 files changed, 134 insertions(+), 88 deletions(-)

Series applied with a bit of fuzz and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> 

