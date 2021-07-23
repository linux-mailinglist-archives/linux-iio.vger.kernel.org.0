Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8C3D3F17
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGWREA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 13:04:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3480 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGWRD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 13:03:59 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWbxd5htXz6H730;
        Sat, 24 Jul 2021 01:32:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 19:44:31 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 18:44:30 +0100
Date:   Fri, 23 Jul 2021 18:44:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Puranjay Mohan <puranjay12@gmail.com>,
        <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Dragos.Bogdan@analog.com>,
        <Darius.Berghe@analog.com>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210723184404.0000001d@Huawei.com>
In-Reply-To: <20210723171422.GK5221@sirena.org.uk>
References: <20210722062155.32998-1-puranjay12@gmail.com>
        <20210722062155.32998-3-puranjay12@gmail.com>
        <20210723181022.000032bd@Huawei.com>
        <20210723171422.GK5221@sirena.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 18:14:22 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jul 23, 2021 at 06:10:22PM +0100, Jonathan Cameron wrote:
> 
> > @Mark.  This has come up a few times recently.  Are we now safe to assume
> > that regmap will always copy data when used with SPI and hence we no
> > longer need to ensure DMA safe buffers?     
> 
> Only for single register I/O, I'd not assume that for things like raw
> I/O.

Thanks for the confirmation.  So in this driver that means we
need DMA safe buffers for the regmap_bulk_ calls.  Easiest approach
is probably to use a __cacheline_aligned buffer at the end of the
iio_priv() structure.

> 
> Note that my name is spelt Mark.
> 

I'll blame Friday.

Thanks,

Jonathan


