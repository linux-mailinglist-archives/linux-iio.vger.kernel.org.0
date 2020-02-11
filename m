Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F7159C3A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 23:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBKWaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 17:30:46 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44405 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKWaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 17:30:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id f21so6207799ybg.11;
        Tue, 11 Feb 2020 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CHoiFuVyPb6jGydbvdkP7hbmi4a+GAh7Qj76wkBaMrw=;
        b=KqXh8ljWsaeJuL5FZXSBYEMOEtwIDGtNhPOg0K+XUvNK9WNzlf102sQ8jl82PFo8XF
         s+Ljzb/2DZuO0hfDjig0E+42lrnPZv/TPE7RJ8Aqcx5xI9V7autaDv1tzexHXbY8iQty
         emEUEpwNSlANK1zORXQhRhy5tNQf2Ob0zLmcHG55uqs/alcX9ODLzR5BetAN9ZF5rmQ2
         L25xAQtPyXz4zTfuqZZ/CpTP5vh7LsBhN8NpOxxgp0t58Zctl7vxGJbVRa2ovEgfn55s
         i7Ls6CX0QpJTP0yd4t9igAHATrBZ+sxcHJfF2O09c0ls0c51XDilEOQdV2YfxfRxZoPj
         KfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CHoiFuVyPb6jGydbvdkP7hbmi4a+GAh7Qj76wkBaMrw=;
        b=KdSoHhjkmF8+9QF0hlURq0C116oVY6hm7M8wSwZ0ulNqUei6pLlCFXShzIFMt+zN2Y
         lSNfRwOYbeldU9r2VwMbbSSAHx8VxaN8tC5kcK0NNHpjikK1m0IMs/b47O2+P7UVpQt2
         u5NcYqGfr3r8I3JEFsX3OxPJmCMHR/MrGSYiqxWsn0StM+iZw7co91ZyeLLbD234oik8
         DeQUFpd+t3qIucZjO8GDCeMNu7LnF49OSUnIJHZ33+3kTR+XzFqpnallAUHILKEmJF6l
         Mly0d1U9oFrHUKFHi1FkWGxFbQnG4cUDAwMprVVrw5locLsSXCnS5yTP/Wls5Hqzwkf0
         6Jsw==
X-Gm-Message-State: APjAAAVDKaqjWLDAB1h36pY43rps0qF71RQniRyhX24u5vTuJGuvNHgM
        eAYZcPdvPrWfG4ZIbsi5kCU=
X-Google-Smtp-Source: APXvYqyilsRsa87oczzBpnbDDzSd9mSalUhB8qVYON+pfbtfykYkhrGIfyKeqrrb88A0edcvtP8mkQ==
X-Received: by 2002:a25:8290:: with SMTP id r16mr7654104ybk.4.1581460245400;
        Tue, 11 Feb 2020 14:30:45 -0800 (PST)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id q130sm2560552ywg.52.2020.02.11.14.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:30:44 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:30:28 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     jic23@kernel.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: add power management support
Message-ID: <20200211223028.GA7369@icarus>
References: <1581355198-30428-1-git-send-email-fabrice.gasnier@st.com>
 <20200210174550.GA4626@icarus>
 <b1e2930a-eeaf-dcfe-3e2c-b666908262bf@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1e2930a-eeaf-dcfe-3e2c-b666908262bf@st.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 11, 2020 at 11:54:17AM +0100, Fabrice Gasnier wrote:
> On 2/10/20 6:45 PM, William Breathitt Gray wrote:
> > On Mon, Feb 10, 2020 at 06:19:58PM +0100, Fabrice Gasnier wrote:
> >> Add suspend/resume PM sleep ops. When going to low power, enforce the
> >> counter isn't active. Gracefully restore its state upon resume in case
> >> it's been left enabled prior to suspend.
> >>
> >> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >> Changes in v2:
> >> - Don't refuse to suspend in case the counter has been left enabled.
> >>   Gracefully disable it and restore its state upon resume.
> >> ---
> >>  drivers/counter/stm32-timer-cnt.c | 63 +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>
> >> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> >> index 3eafcce..50496f4 100644
> >> --- a/drivers/counter/stm32-timer-cnt.c
> >> +++ b/drivers/counter/stm32-timer-cnt.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/iio/types.h>
> > 
> > Unrelated to your patch but it caught my eye: are iio headers necessary
> > for this file? I suspect they are not needed since this driver does not
> > make use of the IIO interface.
> 
> Hi William,
> 
> Yes, you're right. Thanks for pointing this!
> I'll push a patch on top of this one to fix it. BTW, I'm not sure if
> this needs to be a marked as a fix, as this seems a quite minor issue?
> 
> Best Regards,
> Fabrice

No need for a Fixes tag in this case since this is not a bug fix, but
rather just a minor clean up of the included headers.

Thanks,

William Breathitt Gray
