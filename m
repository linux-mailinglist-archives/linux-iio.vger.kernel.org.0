Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913E930F92F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhBDRKj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 12:10:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2497 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbhBDRI0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 12:08:26 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWlJT5qGCz67jPc;
        Fri,  5 Feb 2021 01:04:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 4 Feb 2021 18:07:41 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 17:07:40 +0000
Date:   Thu, 4 Feb 2021 17:06:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 01/11] docs: ioctl-number.rst: reserve IIO subsystem
 ioctl() space
Message-ID: <20210204170655.00001b03@Huawei.com>
In-Reply-To: <20210201145105.20459-2-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-2-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.115]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Feb 2021 16:50:55 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Currently, only the 'i' 0x90 ioctl() actually exists and is defined in
> 'uapi/linux/iio/events.h'.
> 
> It's the IIO_GET_EVENT_FD_IOCTL, which is used to retrieve and FD for
> reading events from an IIO device.
> We will want to add more ioct() numbers, so with this change the 'i'
> 0x90-0x9F space is reserved for IIO ioctl() calls.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alex,

Thanks for tidying this up.  My bad from a long time ago to not register
this at the time.

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a4c75a28c839..9ebde26b7e32 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -245,6 +245,7 @@ Code  Seq#    Include File                                           Comments
>  'i'   00-3F  linux/i2o-dev.h                                         conflict!
>  'i'   0B-1F  linux/ipmi.h                                            conflict!
>  'i'   80-8F  linux/i8k.h
> +'i'   90-9F  `uapi/linux/iio/*.h`                                    IIO

I think the uapi/ bit is effectively implicit. I checked a few of them and the
definitions are in uapi/linux/

>  'j'   00-3F  linux/joystick.h
>  'k'   00-0F  linux/spi/spidev.h                                      conflict!
>  'k'   00-05  video/kyro.h                                            conflict!

