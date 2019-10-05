Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F2CCA75
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJEO3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJEO3v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:29:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8756720867;
        Sat,  5 Oct 2019 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570285790;
        bh=gTTOXZzJ7SZUwzYSIK7oby/7p3yeI1CkELSTEhee4cM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHmXTlF4+DYLAxXhoKZ7K2WthP1055bfqWZcafwpN51LftwPicjUHlqNNzdaDN//X
         ljeL9lw44bRUEhLyXVzfedzS8VlqAE7gy0nqSi0XYefaTl354dJomJzl5yHzv4SeH6
         9c3V/trApYfmXIyH5lycz+DMl1Q70bP9sTbpSK4M=
Date:   Sat, 5 Oct 2019 15:29:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org,
        alexandre.torgue@st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix a kernel-doc warning
Message-ID: <20191005152933.7920455d@archlinux>
In-Reply-To: <20190925235112.GC14133@icarus>
References: <1568809361-26157-1-git-send-email-fabrice.gasnier@st.com>
        <20190925235112.GC14133@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Sep 2019 19:51:12 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Sep 18, 2019 at 02:22:41PM +0200, Fabrice Gasnier wrote:
> > Fix the following warnings when documentation is built:
> > drivers/counter/stm32-lptimer-cnt.c:354: warning: cannot understand
> > function prototype: 'enum stm32_lptim_cnt_function'
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  drivers/counter/stm32-lptimer-cnt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> > index bbc930a..28b6364 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -347,7 +347,7 @@ static const struct iio_chan_spec stm32_lptim_cnt_channels = {
> >  };
> >  
> >  /**
> > - * stm32_lptim_cnt_function - enumerates stm32 LPTimer counter & encoder modes
> > + * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
> >   * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
> >   * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
> >   */
> > -- 
> > 2.7.4  
> 
> Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
> 
> Jonathan, please pick this fix up through IIO.
> 
> Thanks,
> 
> William Breathitt Gray
Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan


