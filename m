Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35232729E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhB1OkK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 28 Feb 2021 09:40:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2611 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1OkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 09:40:09 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DpQqz6BDPz67XZl;
        Sun, 28 Feb 2021 22:33:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Feb 2021 15:39:28 +0100
Received: from localhost (10.47.88.221) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 28 Feb
 2021 14:39:27 +0000
Date:   Sun, 28 Feb 2021 14:38:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/5] Touch Bar and ALS support for MacBook Pro's
Message-ID: <20210228143819.00003f10@Huawei.com>
In-Reply-To: <20210228012643.69944-1-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.221]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Feb 2021 17:26:38 -0800
Ronald Tschalär <ronald@innovation.ch> wrote:

> This patch set provides Touch Bar and ALS support on MacBook Pro's
> 13,*, 14,*, and 15,*.
> 
> Some time a go an earlier version of these were posted to the list;
> all code comments from there have been incorporated. In addition the
> approach has been cleaned up, especially given that we now know how
> the 15,* models are implemented, so that the ibridge driver is only
> needed for the pre-15,* models and the ALS and Touch Bar drivers work
> unchanged for all models.

Please keep the version numbering increasing (even if the series has been
restructured like here) or at very least include a link to the archive
on lore.kernel.org (I think this is the latest earlier version)

https://lore.kernel.org/linux-iio/20190612083400.1015-1-ronald@innovation.ch/

Thanks,

Jonathan

> 
> Ronald Tschalär (5):
>   HID: Recognize sensors with application collections too.
>   iio: hid-sensor-als: Support change sensitivity in illuminance too.
>   HID: core: Export some report item parsing functions.
>   HID: apple-ibridge: Add Apple iBridge HID driver for T1 chip.
>   HID: apple-touchbar - Add driver for the Touch Bar on MacBook Pro's.
> 
>  drivers/hid/Kconfig                |   26 +
>  drivers/hid/Makefile               |    2 +
>  drivers/hid/apple-ibridge.c        |  682 +++++++++++++
>  drivers/hid/apple-ibridge.h        |   15 +
>  drivers/hid/apple-touchbar.c       | 1523 ++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c             |   57 +-
>  drivers/hid/hid-ids.h              |    1 +
>  drivers/hid/hid-quirks.c           |    3 +
>  drivers/hid/hid-sensor-hub.c       |    6 +-
>  drivers/iio/light/hid-sensor-als.c |    8 +
>  include/linux/hid.h                |    4 +
>  11 files changed, 2302 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/hid/apple-ibridge.c
>  create mode 100644 drivers/hid/apple-ibridge.h
>  create mode 100644 drivers/hid/apple-touchbar.c
> 

