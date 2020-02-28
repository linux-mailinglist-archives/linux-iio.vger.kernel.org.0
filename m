Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13491174035
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1TWO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 14:22:14 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41546 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1TWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 14:22:13 -0500
Received: by mail-pl1-f178.google.com with SMTP id t14so1610361plr.8
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2020 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JyAgR1xHt4ZKKNMWFuy8RSL5EdJea+cMc0LYP/n7mYE=;
        b=GT49QtJmKrOQXRHSEZ6VnNpmleLI/Zx6PCfMpWBuHm0fQRbjzsAUVAZafwNkG58Zb9
         ZoOz4poes0diXtjsdk7FEvc/fMMsNnmDpKls5GgKB0AT24ccd3CplYQfNCFETdajZMC3
         gJg0NOHlopoTw2CdO1V3E59EwXxorWLec7x2sdKMubSrtaJMZVsFIlSUn+su41KwlvT1
         bAq1kZotUi9m5lb/t1xt2UbZSyfY4pbdHfi/735Rbc9dVElYsDd1zE91SCokfEdoryrD
         TO0FQnPXfqIfkP09spKVqr+ESpj2dD6CtHiucHqg0gvNGk401KELlmKN7wumZwuEXjOq
         SB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JyAgR1xHt4ZKKNMWFuy8RSL5EdJea+cMc0LYP/n7mYE=;
        b=aQOeXWVZkpzY0t5EXuVEB3vXvCbHXaW8U60EY8ZXdBEASN14OX8aVfeeIxUWPYkQ2t
         +Jx4siSHMKUq07NVrSjBNEwgFSzB3EGlOmWOl+OXN0U8xNEW7IrXHEkZkX6HpWuxQ9dM
         TTM8qLzwn1DKZXYA+hrp4Ccm60UQuMaSEoMz3S0K8KyPaEmPPDtbFK2dvVya/7oR4Blp
         ku6AjCpBFFJxzAY90SrQ4XTxuPzbpGkX6PjtwhvSCwlDgUK8HYEthyQKtIpREcsvJjnv
         R1HTqBdMQrEkTviqnGY+6/bUg0kBQi6vkzrkaQSCbNyAK+/rUoeVWd1EitkHuIi2eyKL
         PKzQ==
X-Gm-Message-State: APjAAAUbl6VO5Fwe2rwBeqCkaLMn5uYJfUji49XeC2EiE1shjh8OXg+c
        DB4k50/2+Vx3w+01+png9wuQ0+rATbjXzA==
X-Google-Smtp-Source: APXvYqyhu6rfTP2yCTNHheiP6zRhDJNzlw9rfQzKq3paIspMweoZ3X4FP2pE+7eIwYHBL+FoeKCP/g==
X-Received: by 2002:a17:902:aa96:: with SMTP id d22mr5403188plr.204.1582917731879;
        Fri, 28 Feb 2020 11:22:11 -0800 (PST)
Received: from SARKAR ([2401:4900:3314:1957:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id m15sm10916426pgh.80.2020.02.28.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 11:22:11 -0800 (PST)
Message-ID: <5e596863.1c69fb81.99505.ce4e@mx.google.com>
X-Google-Original-Message-ID: <20200228192202.GB20947@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 00:52:02 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: query about locking in IIO
References: <20200225171150.GD24663@SARKAR>
 <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
 <5e56aa03.1c69fb81.3f3c3.8b05@mx.google.com>
 <a644fc06b461361e6d6b001fe2e4e50dbaba6943.camel@analog.com>
 <20200228132402.00002d9e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228132402.00002d9e@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 28, 2020 at 01:24:02PM +0000, Jonathan Cameron wrote:
> On Thu, 27 Feb 2020 06:58:11 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Wed, 2020-02-26 at 22:55 +0530, Rohit Sarkar wrote:
> > > [External]
> > > 
> > > On Wed, Feb 26, 2020 at 06:54:21AM +0000, Ardelean, Alexandru wrote:  
> > > > On Tue, 2020-02-25 at 22:41 +0530, Rohit Sarkar wrote:  
> > > > > Hi,
> > > > > Could someone explain why using indio_dev->mlock directly is a bad idea?
> > > > > Further examples of cases where it cannot be replaced will be helpful
> > > > >   
> > > > 
> > > > Jonathan may add more here.
> > > > 
> > > > But in general, each driver should define it's own explicit lock if it needs
> > > > to.
> > > > Some drivers need explicit locking, some don't.
> > > > 
> > > > A lot of other frameworks already define locks already.
> > > > Like, for example, when an IIO driver uses some SPI transfers, the SPI
> > > > framework
> > > > already uses some locks. So, you don't typically need extra locking; which
> > > > for
> > > > some IIO drivers translates to: no extra explicit locking.
> > > > 
> > > > I guess Jonathan also wants to move the mlock to be used only in the IIO
> > > > framework.
> > > > In some cases, if drivers use this mlock, and the framework uses it, you can
> > > > end
> > > > up trying to acquire the same mlock twice, which can end-up in a deadlock.
> > > > These things can sometimes slip through the code-review.  
> > > 
> > > This makes sense
> > >   
> > > > I guess the docs need a bit of update.
> > > > Because:
> > > > 
> > > > * @mlock:              [DRIVER] lock used to prevent simultaneous device
> > > > state
> > > > *                      changes
> > > > 
> > > > I think it should be converted to [INTERN]
> > > >   
> > > > > Thanks,
> > > > > Rohit
> > > > >   
> > > 
> > > As a follow up would I be right to assume that as long as the mlock is
> > > not being in the IIO framework, explicit locking should be the way to
> > > go?  
> > 
> > The question sounds a bit hard to follow.
> > Each driver should define it's own locking if it needs it.
> > mlock will continued to be used only in the IIO framework; it won't be removed.
> > [INTERN] is just a marker in the doc-string to make sure people don't use
> > these fields in drivers.
> 
> Yes.  That's basically it.  mlock is a framework internal lock and we may change
> how it is implemented at any time.
> 
> Various drivers using it make any such changes impossible and are much harder to
> reason about because the mlock uses in the core aren't visible within the
> driver.
> 
> So basically its a software architecture problem rather than there being any
> known bugs!

Got it, Thanks
> Thanks,
> 
> Jonathan
> 
> > 
> > 
> > > Thanks,
> > > Rohit  
> 
> 
