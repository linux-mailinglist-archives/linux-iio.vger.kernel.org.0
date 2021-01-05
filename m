Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F72EA6C2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbhAEIzl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 03:55:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:56953 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbhAEIzl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 03:55:41 -0500
IronPort-SDR: Q1c0kG7s2YnwY1gCCsA8cO2JLfti1V7UrDF+EzipfcfjMtWkvChgxZKTqDVImNJdJXSuqFE0JD
 YDuMys4hYDFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164148816"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="164148816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 00:53:53 -0800
IronPort-SDR: KDcy5nlc2M5a3F1AkokL5ng8OMfBO+uzjs+ZguTqlOE3IvFfiOWuxDcaUDK1CX+Tg23TPRPrcJ
 GomAapLVui3g==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="346204892"
Received: from lbotell-mobl1.amr.corp.intel.com ([10.212.34.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 00:53:48 -0800
Message-ID: <ed6a6de1c0b2339d467a3ffd341130342b41c3bc.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/6] add timestamp channel for hid-sensors
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Jan 2021 00:53:44 -0800
In-Reply-To: <20210105072203.5701-1-xiang.ye@intel.com>
References: <20210105072203.5701-1-xiang.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-01-05 at 15:21 +0800, Ye Xiang wrote:
> This patch series add a timestamp channel for hid sensors,
> including gravity sensor, gyro sensor, magnetometer sensor,
> ambient light sensor, inclinometer sensor, and rotation sensor.
> 
> With this patch series, user can get the time when sensor yield
> a sample.
> 
I think this series is v1 for upstream not v3.

Thanks,
Srinivas

> ---
> v3:
>   - hid-sensor-magn-3d: fix iio_val buffer len issue.
>   - hid-sensor-accel-3d: refine commit message
> 
> v2:
>   - remove unrelated changes.
> 
> Ye Xiang (6):
>   iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
>   iio: hid-sensor-gyro-3d: Add timestamp channel
>   iio: hid-sensor-als: Add timestamp channel
>   iio: hid-sensor-magn-3d: Add timestamp channel
>   iio: hid-sensor-incl-3d: Add timestamp channel
>   iio: hid-sensor-rotation: Add timestamp channel
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
>  drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-----
> --
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
>  drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++-------
> -
>  6 files changed, 134 insertions(+), 88 deletions(-)
> 


