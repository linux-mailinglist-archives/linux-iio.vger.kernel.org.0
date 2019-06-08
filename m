Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D152C39F96
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfFHMJI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:09:08 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59772 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfFHMJI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 08:09:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 006B19E866C;
        Sat,  8 Jun 2019 13:09:06 +0100 (BST)
Date:   Sat, 8 Jun 2019 13:08:54 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] counter/ftm-quaddec: Add missing dependencies in
 Kconfig
Message-ID: <20190608130834.655555cd@archlinux>
In-Reply-To: <20190604151034.GA12804@icarus>
References: <20190604140326.12295-1-patrick.havelange@essensium.com>
        <20190604151034.GA12804@icarus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Jun 2019 00:11:15 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Jun 04, 2019 at 04:03:26PM +0200, Patrick Havelange wrote:
> > This driver uses devm_ioremap and of* functions. This fixes a
> > linking failure with e.g. ARCH=um.
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > ---
> >  drivers/counter/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 233ac305d878..c9e3f5c98484 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
> >  
> >  config FTM_QUADDEC
> >  	tristate "Flex Timer Module Quadrature decoder driver"
> > +	depends on HAS_IOMEM && OF
> >  	help
> >  	  Select this option to enable the Flex Timer Quadrature decoder
> >  	  driver.
> > -- 
> > 2.19.1  
> 
> Fixes: a3b9a99 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, would you pick this up through IIO?
Sure,

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> Patrick, I noticed the FlexTimer Module Quadrature decoder driver is
> missing an entry in MAINTAINERS. Please submit an additional patch to
> address that as well so that we'll have a point of contact listed for
> this driver.
> 
> Thanks,
> 
> William Breathit Gray

