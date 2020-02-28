Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D807017407F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1Tqc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 14:46:32 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39991 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Tqb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 14:46:31 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so1710018pjb.5
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2020 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XT5kdwKInx86xYPChyLEQEih1H00tNRWX3e9smtI6ZQ=;
        b=JFyQVKWPOkBLpyfjrYXvXlSOTqojRYh+ZpWb8+a/hJeqF1mxKbbg78boqCtRV2uldR
         9HveKwVhoW1jL5kNu3suArh05zCGWfssmEnP73MC5bMPdXSm1PGbx3zCMVqkG6jeTw1m
         ddkuEWKQYPgzpmF9fCcVPCIsuurz+GzOh4wL7Rayk8EP8fOWHbYcvIEKtglLAsx5+GrB
         UCpiWOcFJBM1OONiNYGo4Se/XpXlyMkBsbUCzV1ESTBwjkRj3Ni/LznlSoewg7BOR0Iw
         NqwYY7abVz9Sawxq+n61cW1lWIhd7I6vE8bTtx3d0HoCG9rwQT+gbzu8YFncXaJGTs4O
         H88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XT5kdwKInx86xYPChyLEQEih1H00tNRWX3e9smtI6ZQ=;
        b=tXdsPBcCTOUIwedx+II3ZKUjShmynNKNEeNuxbj4KUhDvrQMLTcawNh7MlfMr3FhZR
         Ag076LWZprscwLY8OG5Q4llOOHYixwj2augbGYPcgt88KgHO6nuCnJ8EdgbZCCMvsXgz
         viTshB40TFzgUYIt+TixXsxSGgqpUaR6a2EgLczPo21eil7bWZYsIVglT92p7oPW0ge2
         0Eb++oK2Ze1yvb5/F/9x1B5jHIrzNRjIkYpOC2+dE3DvPGIOflNx/OXdzqlIAsD3OnRY
         w1YhvZn6Du3kpe7DtOYZ4kOCNRw7IkF3uz5SehzFYjY8RWLYxJWws1IwLIn5LPPQ0CSe
         7Yjg==
X-Gm-Message-State: APjAAAUHsZ/EDbJ3mhOVDBfvaedVj1WrUfCldzXQLk7ULE/RHoHCG/oJ
        bzZ1sEDcIP/cs3hDU86XxBY=
X-Google-Smtp-Source: APXvYqwkYd8KidIGmBo7eUwBXfnbwdOAP9orkSOfOXK+zILrWKTiQWTpzA/ptyCfNahECqCWbK7hpQ==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr5416561plo.90.1582919189272;
        Fri, 28 Feb 2020 11:46:29 -0800 (PST)
Received: from SARKAR ([2401:4900:3314:1957:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id j38sm8037068pgi.51.2020.02.28.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 11:46:28 -0800 (PST)
Message-ID: <5e596e14.1c69fb81.ff3e8.5655@mx.google.com>
X-Google-Original-Message-ID: <20200228194621.GC20947@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 01:16:21 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v2] staging: iio: update TODO
References: <20200224195915.GA8371@SARKAR>
 <20200225144933.19876-1-rohitsarkar5398@gmail.com>
 <20200228173615.00003c16@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228173615.00003c16@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 28, 2020 at 05:36:15PM +0000, Jonathan Cameron wrote:
> On Tue, 25 Feb 2020 20:19:33 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > since there are no uses of the old GPIO API, remove the item from the
> > TODO and some new items.
> > 
> > Changes from v1:
> > Add work item mentioned by Alexandru in https://marc.info/?l=linux-iio&m=158261515624212&w=2
> 
> My main issue here is we are adding to the "staging" todo,
> a list of tasks that are relevant to all drivers, not those
> in staging alone.

While I was making this patch I actually had the same concerns.
> Please break this into a simple patch removing the gpio stuff
> that is no longer relevant and a second patch to propose additions.
> That way I can pick up the uncontroversial part and we can talk
> further about whether it makes sense to put system wide TODO entries
> in here.

Makes sense, will do.

> Thanks,
> 
> Jonathan
> 
Thanks, Rohit
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/staging/iio/TODO | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> > index 1b8ebf2c1b69..e54510c2ef5f 100644
> > --- a/drivers/staging/iio/TODO
> > +++ b/drivers/staging/iio/TODO
> > @@ -1,11 +1,17 @@
> > -2018-04-15
> > +2020-02-25
> >  
> > -All affected drivers:
> > -Convert all uses of the old GPIO API from <linux/gpio.h> to the
> > -GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
> > -lines from device tree, ACPI or board files, board files should
> > -use <linux/gpio/machine.h>.
> > +- Documentation
> > +  - Binding docs for devices that are obviously used via device tree
> > +  - Yaml conversions for abandoned drivers
> > +  - ABI Documentation
> > +  - Audit driviers/iio/staging/Documentation
> >  
> > +- Replace iio_dev->mlock by either a local lock or use iio_claim_direct.
> > +  (Requires analysis of the purpose of the lock.)
> > +
> > +- Converting drivers from device tree centric to more generic property handlers
> > +  Refactor old platform_data constructs from drivers and convert it to state
> > +  struct and using property handlers and readers.
> >  
> >  ADI Drivers:
> >  CC the device-drivers-devel@blackfin.uclinux.org mailing list when
> 
> 
