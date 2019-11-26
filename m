Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E010A105
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2019 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKZPQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 26 Nov 2019 10:16:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2119 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfKZPQZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Nov 2019 10:16:25 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C6504D71AEE6C5D2E981;
        Tue, 26 Nov 2019 15:16:23 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Nov 2019 15:16:23 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 15:16:23 +0000
Date:   Tue, 26 Nov 2019 15:16:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oezguen Guenyeli <oezguen.guenyeli.wg@renesas.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Problem about Read Multiple Raw Function
Message-ID: <20191126151621.0000687c@Huawei.com>
In-Reply-To: <OSBPR01MB2326981343F90B11AB6CA23DB1450@OSBPR01MB2326.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2326981343F90B11AB6CA23DB1450@OSBPR01MB2326.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Nov 2019 12:56:11 +0000
Oezguen Guenyeli <oezguen.guenyeli.wg@renesas.com> wrote:

> Hi, 
> I am developing Linux iio driver for one sensor and sensor provides 15 measurement samples that have to been sent the user-space for high level algorithm. 
> I can read data from dev/iio:device and I can apply high-level algorithm. However, I have problem about read_raw_multi function. Max_len pass value as INDIO_MAX_RAW_ELEMENTS in iio_read_channel_info function that locates in industrialio-core.c file and INDIO_MAX_RAW_ELEMENTS is defined 4 in iio.h file.
> Is there any specific reason to define 4 ? Because in that way I cannot pass 15 values to user space with read_raw_multi function. 

Yes.

The intent is that read_raw multi is used for well defined types.  The
largest of those that has been defined in the IIO ABI is quaternions, which
have 4 elements, hence the limit.

There is little point in using IIO for a device such as the one you describe as
no generic userspace code is ever going to work with it.

If you have a series of values that are separate well defined channels, but need
to sample them in one go, then use the buffered interface and read them via
a chardev.  If not and there is a good reason why these 15 numbers represent
one 'thing' then pitch the new userspace ABI and we can consider changing
that limit.

Thanks,

Jonathan

> 
> Thanks, 
> 
> Özgün Kemal Günyeli
> 


