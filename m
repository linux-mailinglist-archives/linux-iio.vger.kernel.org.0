Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B6CCA72
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJEO2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfJEO2U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:28:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4759520867;
        Sat,  5 Oct 2019 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570285700;
        bh=0HytaZ1Qi8pY6GlOq+DBjycReyqLhaTKhTi+ABILHH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1vFSC5X6EvPe318HJvAuNvuIcag3zPq2fH5UP82biM+c8M0DRehQvabjwK/gJLTgm
         mup0Lv5VnlXBVgRXlu87Wd+s148f4hdWuwLVz/o51x5Ebrs1yZeZrigSynKzes/znX
         JmEwbrVbV2XQE3Q1NaxciA/Wk4W/Y72XY4mDzkQk=
Date:   Sat, 5 Oct 2019 15:28:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org,
        alexandre.torgue@st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix a kernel-doc warning
Message-ID: <20191005152805.49eec3b8@archlinux>
In-Reply-To: <20190925235310.GD14133@icarus>
References: <1568809323-26079-1-git-send-email-fabrice.gasnier@st.com>
        <20190925234927.GB14133@icarus>
        <20190925235310.GD14133@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Sep 2019 19:53:10 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Sep 25, 2019 at 07:49:27PM -0400, William Breathitt Gray wrote:
> > On Wed, Sep 18, 2019 at 02:22:03PM +0200, Fabrice Gasnier wrote:  
> > > Fix the following warning when documentation is built:
> > > drivers/counter/stm32-timer-cnt.c:37: warning: cannot understand function
> > > prototype: 'enum stm32_count_function'
> > > 
> > > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > > ---
> > >  drivers/counter/stm32-timer-cnt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> > > index 644ba18..e425dd1 100644
> > > --- a/drivers/counter/stm32-timer-cnt.c
> > > +++ b/drivers/counter/stm32-timer-cnt.c
> > > @@ -28,7 +28,7 @@ struct stm32_timer_cnt {
> > >  };
> > >  
> > >  /**
> > > - * stm32_count_function - enumerates stm32 timer counter encoder modes
> > > + * enum stm32_count_function - enumerates stm32 timer counter encoder modes
> > >   * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
> > >   * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
> > >   * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
> > > -- 
> > > 2.7.4  
> > 
> > Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
> > 
> > Jonathan, please pick this fix up through IIO.
> > 
> > Thanks,
> > 
> > William Breathitt Gray  
> 
> Sorry, that's the wrong Fixes line. Here's the right one:
> 
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> 
> William Breathitt Gray
I've picked it up, but please be more formal and also give an
Acked-by: in future.

Applied to the togreg branch of iio.git and pushed out as testing though
I doubt automatic testing of kernel-doc is occurring.

Thanks,

Jonathan


