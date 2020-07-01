Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF96B2108B6
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgGAJz6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 05:55:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729109AbgGAJz6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Jul 2020 05:55:58 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E005BCE4174E1060B27B;
        Wed,  1 Jul 2020 10:55:56 +0100 (IST)
Received: from localhost (10.52.123.12) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 1 Jul 2020
 10:55:56 +0100
Date:   Wed, 1 Jul 2020 10:54:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Gow <davidgow@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc
 driver
Message-ID: <20200701105454.00002ca0@Huawei.com>
In-Reply-To: <CABVgOSnOo4iauOBGpJUZ4NRihCUU-1vue8hajZTCKAcH98_Lrw@mail.gmail.com>
References: <20200630070552.1110864-1-davidgow@google.com>
        <20200630110654.00001d40@Huawei.com>
        <CABVgOSnOo4iauOBGpJUZ4NRihCUU-1vue8hajZTCKAcH98_Lrw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.12]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Jul 2020 11:04:42 +0800
David Gow <davidgow@google.com> wrote:

> On Tue, Jun 30, 2020 at 6:07 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 30 Jun 2020 00:05:52 -0700
> > David Gow <davidgow@google.com> wrote:
> >  
> > > The Analog Devices AXI ADC driver uses the devm_ioremap_resource
> > > function, but does not specify a dependency on IOMEM in Kconfig. This
> > > causes a build failure on architectures without IOMEM, for example, UML
> > > (notably with make allyesconfig).
> > >
> > > Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>  
> > Hi David,
> >
> > Could you confirm what the build error is?  I thought the stubs added in
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bcbfbfdeb
> > were meant to allow us to avoid having lots of depends on IOMEM lines for the
> > few architectures who don't support it.  
> 
> No worries:
> /usr/bin/ld: drivers/iio/adc/adi-axi-adc.o: in function `adi_axi_adc_probe':
> torvalds-linux/drivers/iio/adc/adi-axi-adc.c:415: undefined reference
> to `devm_platform_ioremap_resource'
> 
> Alas, the devm_platform_ioremap_resource function isn't handled by the
> UML stubs: it all seems to be in drivers/base/platform.c and
> lib/devres.c, behind #ifdef HAS_IOMEM.
> 
> In any case, improving IOMEM support for UML (at least for the KUnit
> test case, which is my use case) is something I'd like to do. There
> are only three drivers[1,2] upstream at the moment which fail to build
> as-is, though, so it seemed worth trying to fix them in the meantime.
> That being said, I tried just getting rid of the few #ifdef HAS_IOMEMs
> around the various devm_*_ioremap functions, and everything seems to
> be working... So maybe that's a false dependency given the various
> stubs (at least on UML). I used this (hideously hacky) patch:
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index c0d0a5490ac6..b6f08c88e2b6 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -61,7 +61,7 @@ struct resource *platform_get_resource(struct
> platform_device *dev,
> }
> EXPORT_SYMBOL_GPL(platform_get_resource);
> 
> -#ifdef CONFIG_HAS_IOMEM
> +#if 1//def CONFIG_HAS_IOMEM
> /**
>  * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
>  *                                         platform device and get resource
> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..35c21af33b93 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -115,7 +115,7 @@ obj-y += math/ crypto/
> 
> obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
> obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
> -obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
> +obj-y += iomap_copy.o devres.o
> obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
> obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
> 
> ---
> 
> If this seems to work more broadly, I may try to clean it up and post
> it for broader review.

Looks like a good approach to me!

Jonathan

> 
> Cheers,
> -- David


