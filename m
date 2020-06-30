Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5720F235
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgF3KH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 06:07:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732234AbgF3KH7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Jun 2020 06:07:59 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 80D0CC09CB50DA5C418F;
        Tue, 30 Jun 2020 11:07:57 +0100 (IST)
Received: from localhost (10.52.125.17) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 30 Jun
 2020 11:07:57 +0100
Date:   Tue, 30 Jun 2020 11:06:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Gow <davidgow@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc
 driver
Message-ID: <20200630110654.00001d40@Huawei.com>
In-Reply-To: <20200630070552.1110864-1-davidgow@google.com>
References: <20200630070552.1110864-1-davidgow@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.17]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 00:05:52 -0700
David Gow <davidgow@google.com> wrote:

> The Analog Devices AXI ADC driver uses the devm_ioremap_resource
> function, but does not specify a dependency on IOMEM in Kconfig. This
> causes a build failure on architectures without IOMEM, for example, UML
> (notably with make allyesconfig).
> 
> Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.
> 
> Signed-off-by: David Gow <davidgow@google.com>
Hi David,

Could you confirm what the build error is?  I thought the stubs added in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bcbfbfdeb
were meant to allow us to avoid having lots of depends on IOMEM lines for the
few architectures who don't support it.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ff3569635ce0..f5009b61b80c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -263,6 +263,7 @@ config AD9467
>  
>  config ADI_AXI_ADC
>  	tristate "Analog Devices Generic AXI ADC IP core driver"
> +	depends on IOMEM
>  	select IIO_BUFFER
>  	select IIO_BUFFER_HW_CONSUMER
>  	select IIO_BUFFER_DMAENGINE


