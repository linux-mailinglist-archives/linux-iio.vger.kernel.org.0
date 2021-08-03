Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A43DEE28
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhHCMsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:48:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3571 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhHCMsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:48:08 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfF5Y6VPrz6GD1n;
        Tue,  3 Aug 2021 20:47:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 14:47:55 +0200
Received: from localhost (10.210.169.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 13:47:55 +0100
Date:   Tue, 3 Aug 2021 13:47:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alexandru.tachici@analog.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: Fix flags in sigma-delta drivers
Message-ID: <20210803134726.000067f0@Huawei.com>
In-Reply-To: <20210803091741.8924-1-alexandru.tachici@analog.com>
References: <20210731150926.42a2da31@jic23-huawei>
        <20210803091741.8924-1-alexandru.tachici@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.87]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Aug 2021 12:17:41 +0300
<alexandru.tachici@analog.com> wrote:

> In Sigma-Delta devices the SDO line is also used as an interrupt.
> Leaving IRQ on level instead of falling might trigger a sample read
> when the IRQ is enabled, as the SDO line is already low. Not sure
> if SDO line will always imediately go high in ad_sd_buffer_postenable
> before the IRQ is enabled.

ok. That last bit sounds like a good justification.  It might do the
wrong thing on initial startup.  Please resend with that in the patch
descriptions for those you are modifying.

For those where it is being introduced, we probably want to leave the
interrupt type to firmware (i.e. patch 1)

> 
> Also the datasheets seem to explicitly say the falling edge of the SDO
> should be used as an interrupt.

Reference?

> 
> -Alexandru

