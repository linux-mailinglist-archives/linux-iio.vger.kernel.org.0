Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ACA283D61
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgJERgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgJERgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 13:36:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99BC0613CE;
        Mon,  5 Oct 2020 10:36:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a1so214385pjd.1;
        Mon, 05 Oct 2020 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B12lNYkc01u2Acv3Am3wZ/68gfdostrz6Gt7LZK1x7k=;
        b=MKR/BTv4LNrhfqNo4XlpjFnb0c2x51PifsjbEO214HVcZGvzE8qLV2HVIB03QyM9bM
         wGhv67RSC8rlinm79Kn+LFvlJ0076i/B/7kSsNtLvElaZZx3yqXoQ7Ldv2WwRlGwgLhV
         Bc5LLf4AT6wr8oOv+w5Y66k11jb1n0liBQD9IXPNEG3OMVEri2msg9gx6/9csPwtohoZ
         YC6txZ/D21a/zRWysqQ/O+2Zenq4Ed5jnrzQ2PTj3e22zGIyIuHXtZR2jYs33S8kXrDV
         4lCkeikuW/shAvAbzOi9v0DOul+ZuhtLGMmy22r7df6FmMvetng7sT0xfAAO1B9dMGOW
         w5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B12lNYkc01u2Acv3Am3wZ/68gfdostrz6Gt7LZK1x7k=;
        b=AqNuHQXPskNPJuHpSCyudBgK8lrOC6kBzq+MdbhIWmKkitHrwZOH6srpk3LAPsY+GF
         uJtjhYb7ggYSzWJwoJYHeBgHEoI5C+KENVrD63+b7wHOTtzUOLjLdOSZPP6AMAGLs39H
         1Km33NbRyg6bmSa1ZPjNwSoJ0PV8+uks2FOMDktr1xw5gR0MkA7BXWT0k59FWClLKpwH
         f9muRAdQ6jpkotoip8viRDbToQkKfbkESYh4oiCGSlTI27Th7QVqqJkj12ier3I2kZzy
         QsU+x3Dv5X9rH+UNvJ7eTzzYcw6efqvIPrmSD8ub7vCRFaU6cUHeaMVNIqEqFh2u/dbr
         Jcjw==
X-Gm-Message-State: AOAM531UdXHZ7gJWSvToT2PMtKO9iexVZC5E0d/kSp1+1jJIKWuyyr/R
        Z8DyfVbyRNdAR6I3IJXjp07MfjHZwTA=
X-Google-Smtp-Source: ABdhPJwr2w1fviKBXfG28+ZbJQGJp9t+0uOX4T5p5ap8qKHKxnRh7JamghPS+8V22u5orpZUml+m6w==
X-Received: by 2002:a17:90a:e00e:: with SMTP id u14mr483317pjy.153.1601919399587;
        Mon, 05 Oct 2020 10:36:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id y4sm157457pjc.53.2020.10.05.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:36:39 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:36:36 -0700
From:   dmitry.torokhov@gmail.com
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201005173636.GK1009802@dtor-ws>
References: <20201005052420.GA3262631@dtor-ws>
 <20201005110908.GA3243@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005110908.GA3243@qmqm.qmqm.pl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Michał,

On Mon, Oct 05, 2020 at 01:09:08PM +0200, Michał Mirosław wrote:
> On Sun, Oct 04, 2020 at 10:24:20PM -0700, dmitry.torokhov@gmail.com wrote:
> > The order in which 'users' counter is decremented vs calling drivers'
> > close() method is implementation specific, and we should not rely on
> > it. Let's introduce driver private flag and use it to signal ISR
> > to exit when device is being closed.
> > 
> > This has a side-effect of fixing issue of accessing inut->users
> > outside of input->mutex protection.
> > 
> > Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/iio/adc/exynos_adc.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index 22131a677445..7eb2a5df6e98 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -135,6 +135,8 @@ struct exynos_adc {
> >  	u32			value;
> >  	unsigned int            version;
> >  
> > +	bool			ts_enabled;
> > +
> >  	bool			read_ts;
> >  	u32			ts_x;
> >  	u32			ts_y;
> > @@ -633,7 +635,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
> >  	bool pressed;
> >  	int ret;
> >  
> > -	while (info->input->users) {
> > +	while (info->ts_enabled) {
> >  		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
> >  		if (ret == -ETIMEDOUT)
> >  			break;
> > @@ -712,6 +714,8 @@ static int exynos_adc_ts_open(struct input_dev *dev)
> >  {
> >  	struct exynos_adc *info = input_get_drvdata(dev);
> >  
> > +	info->ts_enabled = true;
> > +	mb();
> >  	enable_irq(info->tsirq);
> >  
> >  	return 0;
> > @@ -721,6 +725,8 @@ static void exynos_adc_ts_close(struct input_dev *dev)
> >  {
> >  	struct exynos_adc *info = input_get_drvdata(dev);
> >  
> > +	info->ts_enabled = false;
> > +	mb();
> >  	disable_irq(info->tsirq);
> 
> This should be WRITE_ONCE paired with READ_ONCE in the ISR.

Why? I can see that maybe full memory barrier is too heavy when we set
the flag to true, but the only requirement is for the flag to be set
before we disable IRQ, so any additional guarantees provided by
WRITE_ONCE are not needed. On the read side we want the flag to be
noticed eventually, and there is no additional dependencies on the data,
so it is unclear what READ_ONCE() will give us here.

> 
> But is the check really needed? I see that this is to break waiting for
> a touch release event, so I would assume this shouldn't wait forever
> (unless the hardware is buggy)

It is not hardware, it is user. Do you want to delay indefinitely
close() just because user has a finger on the touchscreen?

> and breaking the loop will desync touch
> state (I would guess this would be noticable by next user).

Upon next open driver will service the interrupt and provide new set of
touch coordinates. Userspace is supposed to query current state of
device when opening it before starting processing events. Or you are
concerned about some other state?

In any case, this is current driver behavior and if it needs to be
changed it is a topic for a separate patch.

Thanks.

-- 
Dmitry
