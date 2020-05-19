Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17E61D9435
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgESKT5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 06:19:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3747C061A0C;
        Tue, 19 May 2020 03:19:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so15284608wrt.1;
        Tue, 19 May 2020 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pnjDftxxSSPg8a99O3CMzTvnM8zCPLUpID8zm/35UjQ=;
        b=j92WI0OIbflFRPQPu3EVYEQCvUEHlpg8TNKie8Beddr2IZAmB12I4LVEPNspm91VhN
         JGjXQtCh/T9GV70oOyMtjSPW0EupYoofuknbthtxs3AQ+wyZAInAArOUkaLuS/XfEdVs
         cK3coxk8E4uQjdJgipJRssjbq9EiOsN/sYI98xSiOefKyCmr0J/u387xBUphmoHMbkkl
         VUi/SfYUYd/uRah0Zu9WgsbFLNd+e8tEdu4siwlc+cTMCd5eQ4R3IwkiCSEm+aC6ygB4
         t2z6egwiRYZ5V5uGKfpyZLY+kratcqS/UBWtS0MdLEKm/UAFvNVZZILxdZK5tDE+9ijZ
         FMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnjDftxxSSPg8a99O3CMzTvnM8zCPLUpID8zm/35UjQ=;
        b=n+jTHeuBQVIfclbKSmlpZS0Mmmm1lPvYsoEnjVsLCXDgETq+EPj3OqvgfX5Sgg1Khg
         f0onkM9cTtF6drc0xwOFHONBBAsdE3wWCYATPe4R7PO/GWon8668odYZRKEGszLcCZaj
         dF6F/sV68so8Wt9arh6cNCZxEBzo1ohaCsa5W+clTyRzajCIByByU0gQj6iCht9jINl4
         N4kZpv8Fx1HJIDLl1nAy0+1v3FJ+UDLP0jRhskBqh1ThmWfgeLXV7Yt1WojXOUuCUX0l
         HqfQ0/lVc7BCcKJDkeJzY06Si+I8/ocLIGukhdwiZrhyR8bVqRMwmVtJNzdmMJzIRN9T
         hK6A==
X-Gm-Message-State: AOAM530jFtIRWvYcjcdmudYTOp/Fia8oXhSr8XtfSCZ1Q0bUWajK67TI
        s8okAJ9VeyZ8K2q30wjJK1g=
X-Google-Smtp-Source: ABdhPJwAAtM0HgwUVFHhrsukc4a3ep+2NwtT5kMvoesLWOhh1z3TGoe3Ra/t6CXKylk7qCMmjyUatg==
X-Received: by 2002:adf:db52:: with SMTP id f18mr24759961wrj.258.1589883593425;
        Tue, 19 May 2020 03:19:53 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id g6sm20265410wrp.75.2020.05.19.03.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 03:19:52 -0700 (PDT)
Date:   Tue, 19 May 2020 12:19:50 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519101950.GC10391@ict14-OptiPlex-980>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
 <20200519092212.GT1634618@smile.fi.intel.com>
 <20200519094835.GB10391@ict14-OptiPlex-980>
 <20200519100815.GA1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519100815.GA1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 01:08:15PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 11:48:35AM +0200, Jonathan Albrieux wrote:
> > On Tue, May 19, 2020 at 12:22:12PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 19, 2020 at 08:57:40AM +0200, Jonathan Albrieux wrote:
> 
> ...
> 
> > > I dunno if it's your first submission to Linux kernel project or other OSS,
> > > but here you missed a changelog. Rule of thumb is to provide a summary of
> > > the changes done in the history of the evolution of a patch series.
> > > 
> > 
> > Oh thank you and sorry for not having included it. 
> > 
> > Does the changelog needs to be added to all patch files or just on the ones
> > subject of the changes?
> 
> Up to you and maintainer of the corresponding subsystem.
> 
> My common sense tells me that
> 1) if there is a cover letter, just put a joined changelog there
> 2) otherwise, put changelog in each patch.
> 
> I saw in practice all possible variants, i.e.
> a) cover letter w/o changelog + changelog per patch;
> b) cover letter w/ changelog + changelog per patch;
> c) cover letter w/ changelog.
> 
> I think any of it is fine in general.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you for the tips, will work on it!

Best regards,
Jonathan Albrieux
