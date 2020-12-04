Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910542CED70
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgLDLrw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 06:47:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:23463 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgLDLrv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Dec 2020 06:47:51 -0500
IronPort-SDR: z0wxT/YFD4Isl/H/t7CN07hlH2yT2HkAf2yiDnqDWUZ1BRXSydXNMwBGi75R2aMY/Ag7H3NDDa
 YRyplyJDkjpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173519530"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="173519530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 03:46:10 -0800
IronPort-SDR: b/EZCUkSMIKhXp9sytwU2rgnnqY79FSByzTHVkslKxyrfy05FKPwO4H42c2Jne3p6e1VPC/su8
 cq4slRisNJ7Q==
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="331189433"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.181.204])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 03:46:09 -0800
Message-ID: <a921aecf97915bd7c618e99e8959f6bf60ea7f6d.camel@linux.intel.com>
Subject: Re: add custom hinge sensor support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Dec 2020 03:46:08 -0800
In-Reply-To: <20201203035352.13918-1-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-12-03 at 11:53 +0800, Ye Xiang wrote:
> Here three separate iio devices are presented which presents angle
> for
> hinge, keyboard and screen.
You are presenting one IIO device now with three channels.

> 
> This driver works on devices with Intel integrated sensor hub, where
> hinge sensor is presented using a custom sensor usage id.
> 
> Here the angle is presented in degrees, which is converted to
> radians.
> 
> Changes since v2:
>   - use 1 iio device instead of 3 for hinge sensor.
>   - use indexed channel instead of modified channel and added channel
>     labels.
>   - remove 2,3 patch in last version, add a document patch to
> describe the
>     hinge channels.
>   - hid-sensor-custom: use meaningful return value in 
>     get_known_custom_sensor_index and checked in call side.
>   - hid-sensor-ids.h: use HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)
> to 
>     define custom sensor value.
> 
> Changes since v1:
>   - fixed errors reported by lkp
> 
> Ye Xiang (3):
>   HID: hid-sensor-custom: Add custom sensor iio support
>   iio: hid-sensors: Add hinge sensor driver
>   iio:Documentation: Add documentation for hinge sensor channels
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  17 +
>  drivers/hid/hid-sensor-custom.c               | 181 ++++++++
>  .../hid-sensors/hid-sensor-attributes.c       |   2 +
>  drivers/iio/position/Kconfig                  |  16 +
>  drivers/iio/position/Makefile                 |   1 +
>  .../position/hid-sensor-custom-intel-hinge.c  | 393
> ++++++++++++++++++
>  include/linux/hid-sensor-ids.h                |  14 +
>  7 files changed, 624 insertions(+)
>  create mode 100644 drivers/iio/position/hid-sensor-custom-intel-
> hinge.c
> 

