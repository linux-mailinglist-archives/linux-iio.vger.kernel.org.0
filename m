Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72789BE93D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbfIYXxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 19:53:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41757 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733311AbfIYXxO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 19:53:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id x4so104068ybo.8;
        Wed, 25 Sep 2019 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cyFQHO0gt5mJktt3yKr7R9c1YLgMmxQPz4clIN4BByc=;
        b=NX4N++Ilhb/J+QxCl+m9OQKuUep7vJMws423VnLxrI+JJZb5igg7Ogezjt8G6BXZ37
         eBuYE2PXNvyxQncoy1SlWgggQP4mi/THz6D4OzUqZnWQK1horxAdXZaOv0iqYoJeqhqq
         jxopXY9GPAAub44F6/pzw4LBObdtDZhYX13loPzxMGZ1Qxe22MtqUpkBmCdMgwKIKSxc
         CV9AhCou7Ps3aYHlF4I74Pu/uipvq+O9ZBi7ZXJn/yUlpRhWC4hTw6xpKG1Z/q2pj11M
         ak/wzvln0BXE9SykOMtCUYfrpjvB7tD67nt9VFxZtw+Xv2iz/Kq9JQqBpfXAdUFGGeIv
         LHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cyFQHO0gt5mJktt3yKr7R9c1YLgMmxQPz4clIN4BByc=;
        b=S51a3Q5Tie8aR1s3lI3DDSfDTLsS5AGWn4QvMFgyHpQGRC/gvII3LV11SUOcH7+6+9
         qv+z5coNj5/rHPJv1aQ5r+gC7LD5tA6am47Ne4t+TLCZPAL81m8mrO/WJ5BCLalsJQcU
         L8ziLIKFSwbaaLw1mHYhxRYA98ciddUGXMMDFiMqal+PedaRBiLp6e/OUUkcIz/xema+
         FsgaptI0fkuyexUTiHHJ20qfwQYrjEyIj3fyVnLUSgsNfHgxj+ZzzpuOheVDzTRndhO1
         dp6Xb79WWVPofuxgYLz7FZaceOAknogQ4Ys4YA4wMahHwF1wzSn7uBIofDs9qhakGc6o
         M6ag==
X-Gm-Message-State: APjAAAUuV7VCviXIrVtnvYRSO1PsP3wYpDt9/oqcVwVCcJADoTFxuKAA
        jBlPxwgMk4pWIOiz/lUCbtc=
X-Google-Smtp-Source: APXvYqyCs6ReFo44FRjG9X8YZDHHS+am/bMANP6oopGV1Zd787odaVvfpd//Pc4OS1/U5biQgJ7CJg==
X-Received: by 2002:a25:a469:: with SMTP id f96mr185130ybi.23.1569455593438;
        Wed, 25 Sep 2019 16:53:13 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id x145sm77056ywx.2.2019.09.25.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:53:12 -0700 (PDT)
Date:   Wed, 25 Sep 2019 19:53:10 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        jic23@jic23.retrosnub.co.uk
Cc:     jic23@kernel.org, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix a kernel-doc warning
Message-ID: <20190925235310.GD14133@icarus>
References: <1568809323-26079-1-git-send-email-fabrice.gasnier@st.com>
 <20190925234927.GB14133@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925234927.GB14133@icarus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 25, 2019 at 07:49:27PM -0400, William Breathitt Gray wrote:
> On Wed, Sep 18, 2019 at 02:22:03PM +0200, Fabrice Gasnier wrote:
> > Fix the following warning when documentation is built:
> > drivers/counter/stm32-timer-cnt.c:37: warning: cannot understand function
> > prototype: 'enum stm32_count_function'
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> > index 644ba18..e425dd1 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -28,7 +28,7 @@ struct stm32_timer_cnt {
> >  };
> >  
> >  /**
> > - * stm32_count_function - enumerates stm32 timer counter encoder modes
> > + * enum stm32_count_function - enumerates stm32 timer counter encoder modes
> >   * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
> >   * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
> >   * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
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

Sorry, that's the wrong Fixes line. Here's the right one:

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")

William Breathitt Gray
