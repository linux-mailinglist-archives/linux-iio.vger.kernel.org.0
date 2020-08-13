Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1D2439B4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMMUA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMMT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 08:19:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F580C061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 05:19:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597321197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpIw0ZIlicdG1Y5Boae3L0WCr8Cl5XhQiPqIiSAIt8E=;
        b=UbTmakx7da9RsZplrOxwEjfEHHgfZEj+9ZmSQ05AM2iyzammFKqdACIemukQnpv09+t2mp
        IFVBBBft/Pm6jBWPnTaAS9bB0mwysk6zApiMX8kQmT07b9ynTu20g8ynARuH41mX2f/hMA
        bTZ6Yj7Lelsi1V79ZFk325Q/cPy7nW8KJqKT918IFsc8oK/l8A0fvXmA143rA34DY+ksQT
        3eFa/CMOEFS9BA8sDWx+4cYywSxOfpO4AaaZMW7j0JimhmIasyymsXQceYQq5xoQcJNnm/
        eaLYRP6fX49KmEgT1yC+jUZ+9BqUrE6Lx8vUi7P1uhKEOfTxCfV7LVbXGkveuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597321197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpIw0ZIlicdG1Y5Boae3L0WCr8Cl5XhQiPqIiSAIt8E=;
        b=UpXRrsTq6AfTTxwujLFmJ+eSn7auB/iVLMaoJ3h4zfw1C4wOx4HG6GhhRzch3qyd++MFUf
        wBoq1lzFsa4+osBQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard interrupt context
In-Reply-To: <20200813112741.grdytusuwrlskpwa@linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de> <20200813091107.kjelslak2jxkkc42@linutronix.de> <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de> <20200813112741.grdytusuwrlskpwa@linutronix.de>
Date:   Thu, 13 Aug 2020 14:19:57 +0200
Message-ID: <877du2louq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:
>> If you are running with forced IRQ threads the only thing that will then
>> happen in the actual hard IRQ context is the launching of the IRQ threads.
>> Th e IRQ handler of the device driver will run in a threaded IRQ.
>
> So if it is really just the wakeup of the IRQ-thread then it should be
> okay.
> One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
> would invoke trig->ops->try_reenable callback if available.
> I grepped and found
> - bma180_trig_try_reen() 
>   It appears to perform i2c_smbus_read_byte_data() and smbus sounds
>   sleeping. I don't know if it attempts to acquire any spinlock_t but it
>   will be wrong on RT.

It's wrong even on !RT. i2c reads cannot be invoked from hard interrupt
context.

