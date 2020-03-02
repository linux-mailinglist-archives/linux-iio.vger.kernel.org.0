Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D311752EB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 05:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCBE4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 23:56:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35767 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBE4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Mar 2020 23:56:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 7so4806745pgr.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2020 20:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vBk8y9meWPdR0TaZ2HBNwrP3tbXHLzf6XFkZda6pg8=;
        b=omKcPtV0r+XUG1uxD/08V+0T0im1T3iDalejiL/uwZSOlkRhCDMQjLAv2MmM5Nm8B5
         m9XWOcW8FFLLjxHRoOJI5ny2a8FuSld+adUyGgf5MekFT5Wffdb4k8xAnYutGi2fwVPk
         oNYveMMx7WK67qsNfDgJQoe4FNVeKat/s/pQ0cs7z42M3ARiIIUqGSZogAeG0PJlyju5
         Rx82cucgZaS4vUpzijZT4Ax3xlecGTOQT1zSzWK2mI5pPpia+9RWunBdeFgJoTgBI+vv
         zxz+4+4/hRMD6L4MH/+dYBvbLldyB/tGkb73RpckojFDB4uW8XZn4K0/+H7/X1cUrgYN
         +r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vBk8y9meWPdR0TaZ2HBNwrP3tbXHLzf6XFkZda6pg8=;
        b=sD9qMyjif+ipSinJHElx0gMSNQ+aUaSOnr+GoYr4d3BYZtQ5fbeOFJBUME2GB+vKO5
         UiyS2i9++AQ4lXt5uUyYG9z7et4WP4YZW/F7r8UmlEoPo2v4NZz+NCiYGfkcY/77vzPT
         ps7ThsTWf4z32r0F+sgg4IJGd7BW6v26hMmUkxqHqr6perkcJui5RThem/mfR5MZXDhr
         3eICEXJyTY642umX8Ex/qYbUDufpBg0T2C0DY0V2GcicJyIih5Y3zkvgmorUR2DJgnl9
         5XJ8qWVe1NRxhVxDoukQFAPsxNwbjTVjrB6QzfI1BaytCzlcYg2WLIrbh06YiqI01rL+
         jspw==
X-Gm-Message-State: APjAAAX9jdHTK0eUbWIRBpmBYC/L0ntXdg0aiKVxV65ioNvyDfIQ9dfp
        B18yF8VxP/Tf1NMglXxpQZE=
X-Google-Smtp-Source: APXvYqxg7tJs5gZlN3V8QpXCeLgmA97RQ6zpxzKzcAqKNEflCUunLpOfaljr5eyptxa3Z38O8IG0vA==
X-Received: by 2002:a63:9143:: with SMTP id l64mr17020637pge.75.1583124979563;
        Sun, 01 Mar 2020 20:56:19 -0800 (PST)
Received: from SARKAR ([49.207.56.215])
        by smtp.gmail.com with ESMTPSA id i5sm10884393pfg.40.2020.03.01.20.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:56:18 -0800 (PST)
Message-ID: <5e5c91f2.1c69fb81.25aee.deaf@mx.google.com>
X-Google-Original-Message-ID: <20200302045612.GA10725@rohitsarkar5398@gmail.com>
Date:   Mon, 2 Mar 2020 10:26:12 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, grekh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] staging: iio: update TODO
References: <5e5a6fbd.1c69fb81.f08c3.4cf0@mx.google.com>
 <20200301114922.6117def9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301114922.6117def9@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 01, 2020 at 11:49:22AM +0000, Jonathan Cameron wrote:
> On Sat, 29 Feb 2020 19:35:45 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Since there are no uses of the old GPIO API, remove the item from
> > the TODO.
> > 
> > Changelog
> > v3: Remove new items added.
> > v2: Add work item mentioned by Alexandru in
> > https://marc.info/?l=linux-iio&m=158261515624212&w=2
> Change log belongs below the --- as we don't want this info in the
> git history. I've tidied up and applied to the togreg branch of iio.git
> (pushed out as testing for the autobuilders to play with it).
Will keep that in mind, Thanks!
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/staging/iio/TODO | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> > index 1b8ebf2c1b69..4d469016a13a 100644
> > --- a/drivers/staging/iio/TODO
> > +++ b/drivers/staging/iio/TODO
> > @@ -1,10 +1,4 @@
> > -2018-04-15
> > -
> > -All affected drivers:
> > -Convert all uses of the old GPIO API from <linux/gpio.h> to the
> > -GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
> > -lines from device tree, ACPI or board files, board files should
> > -use <linux/gpio/machine.h>.
> > +2020-02-25
> >  
> >  
> >  ADI Drivers:
> 
