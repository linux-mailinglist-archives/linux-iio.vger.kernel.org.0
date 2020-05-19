Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B21D93C5
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgESJsk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgESJsj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 05:48:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F7C061A0C;
        Tue, 19 May 2020 02:48:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so15177330wrq.2;
        Tue, 19 May 2020 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxO8/IXQNqCh0h2e7bYaTvlD1TxQQB6hOMKor8r5w+M=;
        b=I1M/E+owJV4EfENz4l65z+14J0ht2BSRPF0lESD68h+3VDvnWexWznPnud07EhbS95
         phb3Z4dBR3BslzYIE3FhThEHuh/xWKovhaNn+x49F1ysIzyeQPWm2kyAmT5/oHfidMlv
         xgWjnBPSlh9ib2Z6tprfyDuGR9yHz0kVXkDVOucSpxq+fHDa2X1Pgemv2uq7tY9cvlRp
         bGnF3dcWbA7Q79wzPJDJPKdO1eCU0CTHbrcA0FQtef336JmmzIU/kAzrm1/GALui9uGb
         eVHhzrRWgia+Dd7bBbFM6r63YR/kHRIlsLxpEmQAUbqZ1z/PvNyZpuVKERCADPJPRsss
         rjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxO8/IXQNqCh0h2e7bYaTvlD1TxQQB6hOMKor8r5w+M=;
        b=s+lClDz3nVVizjBH5QiDHh4SEjzdxdBwseGkZnAZgTitUHt5fadBpzwwsIfdY9ShgO
         X9fn99dthuPR9oPp8Ckr2MeZ67I11ts9GrcRn9R+tonEVyjLkMwAj9CftHbx0sD4or7e
         gPXyJ3j6jAqn4ZryR6+UqIGJ0osaeNpNRTCX8HXCMKFWvsR1gRYp30roA+sEoRM35gPi
         AHjRdDq/ji8QnuJuEZY9F7X6M1wCyZ54vTbjDmlMF8QOieKCVzLHcVv6vr8sqHFObj1d
         jewwb0l6YYPLd16exi/+7/9YeRNkBXIHpmtt3OqxyyMHuk42xDMREwQ7S4JI6ip994Zw
         bAKA==
X-Gm-Message-State: AOAM531UKvSKNAyX5fsHxbz6HK6onKMh+tea6gaUwWbuKeVhubPTa3Oi
        GuPMF5wmZXDVitlZQLaPmz4=
X-Google-Smtp-Source: ABdhPJxHzin111tuyClhSHahzHhjUR9f6GbkrVxzMT/CakjTJ3o6V77M8IpxpTfe7tKVRZAHiY+TWA==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr23759324wrq.136.1589881718095;
        Tue, 19 May 2020 02:48:38 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id w13sm19591852wrm.28.2020.05.19.02.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 02:48:37 -0700 (PDT)
Date:   Tue, 19 May 2020 11:48:35 +0200
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
Message-ID: <20200519094835.GB10391@ict14-OptiPlex-980>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
 <20200519092212.GT1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519092212.GT1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 12:22:12PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 08:57:40AM +0200, Jonathan Albrieux wrote:
> > Convert documentation from txt format to yaml. Add documentation about
> > reset-gpio. 
> 
> Trailing white space (though it doesn't matter here, in cover letter).
> 

Ok will fix it!

> > Deassert reset on ak8975_power_on, assert reset on ak8975_power_off.
> > 
> > Without reset's deassertion during ak8975_power_on, driver's probe fails
> > on ak8975_who_i_am while checking for device identity for AK09911 chip
> > 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheed says that, if not used, reset pin should be connected
> > to VID. This patch emulates this situation
> 
> I dunno if it's your first submission to Linux kernel project or other OSS,
> but here you missed a changelog. Rule of thumb is to provide a summary of
> the changes done in the history of the evolution of a patch series.
> 

Oh thank you and sorry for not having included it. 

Does the changelog needs to be added to all patch files or just on the ones
subject of the changes?

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Jonathan Albrieux
