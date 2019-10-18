Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75EDCEB3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394766AbfJRSu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 14:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfJRSu2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:50:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8BF920640;
        Fri, 18 Oct 2019 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571424627;
        bh=mBCbESykaiql21i5z3MeFLLIzBQvMXKPhRjTaP29XqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rmsVZ6dLhy86IJ3wOGHxjWTc/etDmvTTyy0boE9a7YSSnqs2JwBm73r7v5AlmJRSk
         xIk0xHnJcCI3Kg0QPW+j19Vr7/swnEEms916bVVOp6g782qFU6++5dnfgLTfr/1ynZ
         REhhArQimulOFWj5DMZ47MV+0YQ30oPxr5+/dWT8=
Date:   Fri, 18 Oct 2019 19:50:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:stmpe-adc: Cleanup endian type of local
 variable
Message-ID: <20191018195023.013da2ff@archlinux>
In-Reply-To: <28f616a36507f0473aa37857fe58f3763bee4f5e.camel@toradex.com>
References: <20191013091541.1382009-1-jic23@kernel.org>
        <28f616a36507f0473aa37857fe58f3763bee4f5e.camel@toradex.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Oct 2019 07:50:33 +0000
Philippe Schenker <philippe.schenker@toradex.com> wrote:

> On Sun, 2019-10-13 at 10:15 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Nothing stops data being of type __be16, which fixes the warning:
> > 
> > CHECK   drivers/iio/adc/stmpe-adc.c
> > drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
> > drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
> > drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
> > drivers/iio/adc/stmpe-adc.c:202:29: warning: cast to restricted __be16
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Philippe Schenker <philippe.schenker@toradex.com>  
> 
> Thanks for fixing that.
> 
> Reviewed-by: <philippe.schenker@toradex.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/adc/stmpe-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > index bd72727fc417..0f88048ea48f 100644
> > --- a/drivers/iio/adc/stmpe-adc.c
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -175,7 +175,7 @@ static int stmpe_read_raw(struct iio_dev
> > *indio_dev,
> >  static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> >  {
> >  	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
> > -	u16 data;
> > +	__be16 data;
> >  
> >  	if (info->channel <= STMPE_ADC_LAST_NR) {
> >  		int int_sta;  

