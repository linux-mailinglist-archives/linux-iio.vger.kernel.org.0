Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7616C4B
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEGUfw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 16:35:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37298 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGUfw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 16:35:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so8734897qtp.4;
        Tue, 07 May 2019 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6gYEqTbmv77FQYhVi46xNiLmwAMPiLYwUgMBGFBieA=;
        b=DP4a2KW5qtKsIGNZTbytzYP7dwD1YeVKxt5nKVusb5m2B9WbYuR5Jf/HLcnroDEl3F
         ZDZSYuCplS0pSppqUPkpUzCv3/Y3T9WdzWUkVqjmKRy00gSOLHRjUTqlmmKPPrwndkLu
         ifcBifvdYmBG40jasDnyuJpDXu01VtHRtHk86MiHT9yI8jFdciqilPFn86X6QMaGz1AO
         AKk1rBcVS8JJ5z7/AQvUtbkChQBnSFNwnV7jzbz4ulZlNPy9bfZ7b2O8xF/e2M0ltQUt
         IdKjGtG154Pj1mRvnRxyFKI9bqSQp/QEs3//JYoI7aZPq0KIJqdwNa0yKJuXhBvqR6eq
         bKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6gYEqTbmv77FQYhVi46xNiLmwAMPiLYwUgMBGFBieA=;
        b=T9OTGnWxgKayN61SNvKUA/YNhjw0Imjout8qJeBudCFSDpETiGTksX2ze/aGctMIYG
         nsUvhJhi/fBUNMyGmIFw57Mk2vGgOPbJxQdygoZOdUQpvOIKJ78eMDc/p3ei2cvTZkn5
         MeLQojWoHHEyTcTZLngs7aXMnloxt0wT7aDP3y7NnRtAyN1zg6EK82PcZMtFh4kQ7m7A
         qSCGelONyLzHzkp5MVUrAYEXagusQNAtefobco3H00aeSztOtn0wgWaDzYmIA+BvJTpO
         OPzA1tt7lQL4VANtiRMKLVW19xw2SORYjlnkelYjDSbV49n9w3VPGFPLkTxTYq6DvAwg
         Lyxg==
X-Gm-Message-State: APjAAAUSDbQYsPa74PlTE8NTf4drULHWjhjSG4WTWtTXfUs7WIR1VWAI
        nRPdARrzvGMyQcuQpHXRhCE=
X-Google-Smtp-Source: APXvYqzosXvm/SegHMlT/UBeJMN/OuZyRFk1+Vu46ooovqfZMwVzQXDxBuUoSQWqKDxd1jpJ0eQf1Q==
X-Received: by 2002:ac8:222f:: with SMTP id o44mr29115731qto.198.1557261351365;
        Tue, 07 May 2019 13:35:51 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j25sm9197094qtc.24.2019.05.07.13.35.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 13:35:49 -0700 (PDT)
From:   Melissa Wen <melissa.srw@gmail.com>
X-Google-Original-From: Melissa Wen <melissa.srw>
Date:   Tue, 7 May 2019 17:35:43 -0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 0/4] staging: iio: ad7150: improve driver readability
Message-ID: <20190507203543.dpold6kx5j2pjar2@smtp.gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
 <CA+U=DsqiRBAdGK0aqp5Chv-AtuL8W47tu+Bq6O_Pc97HYbewkQ@mail.gmail.com>
 <20190505140510.62b42abe@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505140510.62b42abe@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/05, Jonathan Cameron wrote:
> On Sat, 4 May 2019 14:12:22 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> 
> > On Sat, May 4, 2019 at 1:24 AM Melissa Wen <melissa.srw@gmail.com> wrote:
> > >
> > > This patchset solves readability issues in AD7150 code, such as clarify
> > > register and mask definition, fashion improvement of mask uses, reduce
> > > tedious operation and useless comments.
> > >  
> > 
> > Hey,
> > 
> > Two patches seem a bit noisy/un-needed.
> > The other 2 are fine from me.
> > 
> > This driver does need some work to move it out of staging.
> > I am not sure what would be a big blocker for it, other than maybe it
> > needs a device-tree binding doc (in YAML format).
> > Maybe Jonathan remembers.
> > 
> > Some other low-hanging-fruit ideas would be:
> > 1) remove the code for platform_data ; that one seems forgotten from
> > some other time; the interrupts should be coming from device-tree,
> > from the i2c bindings
> > 2) you could do a AD7150_EVENT_SPEC() macro (similar to
> > AD7150_TIMEOUT() macro) and use it in the ad7150_events[] list; that
> > would reduce a few lines
> > 3) similar to 2), you could do a AD7150_CHANNEL(x) macro ;
> > 4) in ad7150_event_handler() the checks could be wrapped into a macro,
> > or maybe some function ; i am referring to "(int_status &
> > AD7150_STATUS_OUT1) && (chip->old_state & AD7150_STATUS_OUT1)" checks
> > ; those seem to be repeated
> > 5) add of_match_table to the driver
> > 
> > I (now) suspect that the reason this driver is still in staging is this comment:
> > /* Timeouts not currently handled by core */
> > 
> > I wonder if things changed since then ?
> > If not, it would be interesting to implement it in core.
> Hmm. Timeouts are 'unusual' to put it lightly.
> I'm thinking the ABI needs to perhaps be more specific but not sure what
> a good naming is.
> 
> Otherwise, I just took a quick look and can't see anything much else
> that needs doing.  Obviously something might come up in a thorough
> review prior to moving it though!
> 
> Jonathan
> > 
> > Thanks
> > Alex
> > 

Hi Alexandru and Jonathan,

Thank you for your help! Soon I will send a v2 with the fixes pointed out.
I'm also including the ideas above in the work plan for this driver.

P.s.: Sorry for having previously sent an email with HTML.

Melissa
> > 
> > > Melissa Wen (4):
> > >   staging: iio: ad7150: organize registers definition
> > >   staging: iio: ad7150: use FIELD_GET and GENMASK
> > >   staging: iio: ad7150: simplify i2c SMBus return treatment
> > >   staging: iio: ad7150: clean up of comments
> > >
> > >  drivers/staging/iio/cdc/ad7150.c | 102 ++++++++++++++-----------------
> > >  1 file changed, 47 insertions(+), 55 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >  
> 
