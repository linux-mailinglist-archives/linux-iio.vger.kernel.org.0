Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0B17143A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgB0Jjh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 04:39:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42377 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgB0Jjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 04:39:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id p18so2408878wre.9
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2020 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TEQSjnIQxM1VtgQo9ixFuHUcsHPXNxUSWJy38z7yyCk=;
        b=fLazak1ceSbh9cl2KSW8RUZXXlnNgA7sMBzwXBpDHLH0ku1kK6pT4Mk0hocAJAd2W7
         tbQpHVo30+YP4Nq6OnPFVu60l8U1iHOj7fvUL/fZm83UrHWE7j/ViVqzzM5rDD21/GOj
         ttOyYnJg5xDnE/OLXU5O+b0q9gpDa22/11FhY7qMzDW1Jv/DS06NPOLy0nnEGTuBzZnU
         BTZoL5jmChUs1fNL/nrCgbFDGCoOPKw+H4RrLXNdvDG8EHVzlYfyJpDBA7Vnbas05s+2
         j1i12eaEY4b5cf55efbBdcoFmluOMrkvCVPEITtrQ36jwCK0kU3cZSrqJ3KJjQ7bWZmU
         sWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TEQSjnIQxM1VtgQo9ixFuHUcsHPXNxUSWJy38z7yyCk=;
        b=t7S0rNBbrQLmutO2FHBp20V71qyzsM4/mjoh+mBXVYWJI6wOUt4LYmh2s+/UY+jtO/
         qg/NIuB+Z+AQuuik7Ih4zALceNhXE/TWTdONg4toDcgtq0PpvRLNlVitO9VhHK3gJmkE
         qYNkZ4nHY7NEWa+Z9CACJnjseOney10PTbLBMICuvxzfbGDXeXySPAq1tVp3PKU1+0jd
         jkYYmQssoRBeFifdBNcu1bvP+vCHbZmWIh0DGIdKP5b3B/ZEXYniV24FXwD5T1j8dmxj
         ihgeeGWC5amHzyPxlbKn+GmEgntQX/fLSXmEyVD8iANa/wfTgeYihlmPnT8XaiSEvcjp
         KovQ==
X-Gm-Message-State: APjAAAVIvFMf7uTc/zXXs0zFpfmcC0+Nin3GTG/2Zo8aqkeyr/E6/xwi
        F6Tamwe64YR1mu8ZgNwfBUxLFQ==
X-Google-Smtp-Source: APXvYqwyo9YBUm97LulROFQKlNIsaZHsT++CMBKTQZorQHur+Ruk+7la2C7a4CNxjFmCXhbUllE01A==
X-Received: by 2002:adf:f588:: with SMTP id f8mr3949793wro.188.1582796373705;
        Thu, 27 Feb 2020 01:39:33 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id t133sm7065652wmf.31.2020.02.27.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:39:32 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:40:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200227094006.GV3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
 <20200223131638.12130-2-andreas@kemnade.info>
 <20200226154055.GQ3494@dell>
 <20200226174914.047667d5@kemnade.info>
 <20200226174640.GR3494@dell>
 <20200226190028.0de5c095@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226190028.0de5c095@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Feb 2020, Andreas Kemnade wrote:

> On Wed, 26 Feb 2020 17:46:40 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Wed, 26 Feb 2020, Andreas Kemnade wrote:
> > 
> > > On Wed, 26 Feb 2020 15:40:55 +0000
> > > Lee Jones <lee.jones@linaro.org> wrote:
> > >   
> > > > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > > >   
> > > > > This adds a subdevice for the ADC in the RC5T619
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > > depends on:
> > > > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > > > 
> > > > > Changes in v3:
> > > > > re-added it to the series because of
> > > > > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > > > > (including mine) rebase and resend please?"    
> > > > 
> > > > Looks like there is still a conflict.  Sure, it's not a complicated
> > > > fix, but that's beside the point.  What tree is this set based on?
> > > >   
> > > It must be applied on top of my rc5t619 rtc series here:
> > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > 
> > > I expected it to make it into 5.6 and when I first sent the RTC series
> > >  (in October) I had no idea when I will continue with other stuff.
> > > 
> > > That is why I sent this ADC series separately, also to give the IIO
> > > maintainer plenty of time to review.   
> > 
> > If a patch-set can or should be applied on its own, you should send it
> > based on an upstream commit, or else things like this happen.
> > 
> It cannot without breaking bisectability. The RTC series adds IRQ support in
> the PMIC which is used here.

Then Kconfig should reflect that.

Or, if that's not possible, then you should not break-up and submit
sets which cannot be applied by themselves.  Either submit the whole
set together, or submit them piece by piece, not submitting the next
part until it's predecessor has been applied.

> > My advice would be to maintain topic branches, each based on an
> > upstream release, which you can merge together into an integration
> > branch for full coverage testing.
> > 
> > > Do you want me to resend all that pending stuff together in one series?
> > > I have little experience with this multi-subdevice process.  
> > 
> > It makes more sense to rebase this set onto the latest full release
> > and resubmit this set on its own.
> > 
> So, I resend the RC5T619 RTC series mentioned above as you answered
> upont Nikolaus question and wait with this series until review is
> through.
> Ok, so wait and rebase it onto 5.7-rc1 or 5.8-rc1 or whatever release
> the RTC stuff will appear.
> So you are not going to create an ib-mfd-rtc-iio branch.

As above.

If you go the whole-patch-set route, yes, either myself or someone
else would have to create an immutable pull-request, but you don't
have to concern yourself with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
