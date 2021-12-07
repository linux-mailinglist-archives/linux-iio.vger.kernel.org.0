Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83046C07F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Dec 2021 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhLGQRO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 11:17:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4227 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhLGQRN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 11:17:13 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7lg02jXrz67Pyr;
        Wed,  8 Dec 2021 00:11:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 17:13:40 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 16:13:39 +0000
Date:   Tue, 7 Dec 2021 16:13:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Henk <yoda@deathstar2.nl>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio display large numbers
Message-ID: <20211207161338.000012bd@Huawei.com>
In-Reply-To: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
References: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Dec 2021 13:40:19 +0100
Henk <yoda@deathstar2.nl> wrote:

> Hi,
> 
> I derived the LTC6951 driver from an existing analog devices LTC6952 driver.
> However for my situation this clock synthesis/buffer uses quite large 
> output frequencies (2.5GHz) which does not fit in the IIO_VAL_INT size 
> when retrieved with iio_info.
> 
> I wonder if there is a way to represent such long integers within the 
> iio_framework. I believe currently there isn't right?
> 
> Regards,
> 
> Henk
> 

Two options for this.  If the thing we are controlling is the raw channel then
we have the option to provide _scale reflecting the fact that a large value
e.g. GHz is not normally controlled at a Hz granularity.

Where that doesn't apply or the range is really very big we do have the
slightly nasty option of IIO_VAL_INT_64

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6bb835f3d00467c9a5e35f4955afa29df96a404e

This is very new, so not in mainline yet, though it is queued up for the
next merge window and should be linux-next.

Hope that helps,

Jonathan
