Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5206447E2B1
	for <lists+linux-iio@lfdr.de>; Thu, 23 Dec 2021 12:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348065AbhLWLyL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 23 Dec 2021 06:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348053AbhLWLyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Dec 2021 06:54:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE49C061759;
        Thu, 23 Dec 2021 03:54:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA4661E5C;
        Thu, 23 Dec 2021 11:54:09 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 50A78C36AE9;
        Thu, 23 Dec 2021 11:54:05 +0000 (UTC)
Date:   Thu, 23 Dec 2021 11:59:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     haibo.chen@nxp.com, robh+dt@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org, festevam@gmail.com
Subject: Re: [PATCH 1/2] MAINTAINERS: add imx7d/imx6sx/imx6ul/imx8qxp and
 vf610 adc maintainer
Message-ID: <20211223115940.10074064@jic23-huawei>
In-Reply-To: <20211221131124.GA23836@chq-T47>
References: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
        <20211221131124.GA23836@chq-T47>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Dec 2021 21:11:24 +0800
Cai Huoqing <cai.huoqing@linux.dev> wrote:

> On 21 12月 21 15:49:59, haibo.chen@nxp.com wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > Add myself as imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > 
> > ---
> > 
> > First, thanks Cai Huoqing upstream the i.MX 8QXP ADC driver, really appreciate!
> > 
> > For some unknown issue, I miss all imx8qxp adc related mail threads,
> > now I actively maintain all i.MX ADC downstream drivers, so add myself
> > here as maintainer, and make sure I can be cc/to when there is any new patch.
> > 
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c87a3f5e302a..210bded08641 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13792,11 +13792,23 @@ F:	drivers/gpu/drm/imx/dcss/
> >  
> >  NXP i.MX 8QXP ADC DRIVER
> >  M:	Cai Huoqing <cai.huoqing@linux.dev>
> > +M:	Haibo Chen <haibo.chen@nxp.com>
> > +L:	linux-imx@nxp.com  
> This driver is based on the work of Haibo Chen <haibo.chen@nxp.com>,
> it's ok to add this, here.
> 
> Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>

Series applied to the togreg branch of iio.git and initially pushed
out as testing as other stuff on that branch will benefit from 0-day
poking at it.

Thanks,

Jonathan

> 
> Thanks,
> Cai
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> >  F:	drivers/iio/adc/imx8qxp-adc.c
> >  
> > +NXP i.MX 7D/6SX/6UL AND VF610 ADC DRIVER
> > +M:	Haibo Chen <haibo.chen@nxp.com>
> > +L:	linux-iio@vger.kernel.org
> > +L:	linux-imx@nxp.com
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> > +F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > +F:	drivers/iio/adc/imx7d_adc.c
> > +F:	drivers/iio/adc/vf610_adc.c
> > +
> >  NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
> >  M:	Jagan Teki <jagan@amarulasolutions.com>
> >  S:	Maintained
> > -- 
> > 2.25.1
> >   

