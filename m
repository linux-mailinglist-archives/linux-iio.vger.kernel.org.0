Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22B51752F3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 06:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgCBFDS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Mar 2020 00:03:18 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:55876 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCBFDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2020 00:03:17 -0500
Received: by mail-pj1-f49.google.com with SMTP id a18so3892948pjs.5
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2020 21:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9efADigF+j2ORhDdb2aiX8pZv2aCbsCjKsUkwlbt9k=;
        b=vEfA9Sa9xrjHJwnZTQgM2aMeiAeWMIYLkuWOnWPtCiYBlVG95HYyx5GsNlg8eIcZPI
         oSRZj7qvfOr7QIacBTNIi9071H1QrG2fMWEW0phoc1Dnyc0OwPak62vVJ+Ogo5cLMDrJ
         bQK5HyAbtE8eA4Fsf7CpZNGnep5AaGHLi6ypy2yjzRJTHEJFicKAwb5nc4L41psK2a8j
         BuTDJ+u39e2lt0YQqmTx9BfzHSkttUHSazuBhbAABS7CflQHatPkUw5zMNLFnOo6UwoP
         WhTF7LUG9uS9tuJ/u6KOHvJTeRCTbI7NtnO3o7uXIM6IsSakALb1eyctjn0nwEB3RIls
         hMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9efADigF+j2ORhDdb2aiX8pZv2aCbsCjKsUkwlbt9k=;
        b=TVYobO3qmsT7Kb78yw8d2pYB0PrOdQXQICUFSQZ9jFUJZZCgeJqxLYFNXwpnZ+elgX
         jOGWVjuA4LoM8mJiQU3u7NjdCm/7iZNJwQjPUtiCN+Y1frhqkh/b665CJCkyNlDnFzOG
         ZfVpHAZ659DLAM/wYlPM1kn2ZF6here4wifkp8P5asxFjqT4RNEWVomKUkNm6tEKqQBE
         2YBqFPH6S0cHbz5D1AeMqDPy303ejQBDZFEmSxbBd1Whp7OxGANAwkXow4Ze9toztDfL
         MbMZ/wpoZ752mbjr6mtx/Y98CE8BQNCvOBDNJdRSg7Oyol14GyYSCek233sn604kUjUv
         hxyw==
X-Gm-Message-State: APjAAAV8DgkE8flRcdPuhQeDuqDdFWzNm2DgH6WYqBU+6HDs5dUs9dOZ
        3/8Ibf5SgUPuP9wfYocmLl+GTyRdu8CmhQ==
X-Google-Smtp-Source: APXvYqxbF92FxVmGYXKwvttT5WvsYQOmE4njzJaUjY/8uUQL/xhhQuw989V7RyuWKXTcOkb8uWuM1g==
X-Received: by 2002:a17:90a:2085:: with SMTP id f5mr19367425pjg.101.1583125396103;
        Sun, 01 Mar 2020 21:03:16 -0800 (PST)
Received: from SARKAR ([49.207.56.215])
        by smtp.gmail.com with ESMTPSA id y193sm3285200pfg.162.2020.03.01.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 21:03:15 -0800 (PST)
Message-ID: <5e5c9393.1c69fb81.18044.9bc8@mx.google.com>
X-Google-Original-Message-ID: <20200302050308.GB10725@rohitsarkar5398@gmail.com>
Date:   Mon, 2 Mar 2020 10:33:09 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dragos.bogdan@analog.com, JManeyrol@invensense.com,
        linux-iio@vger.kernel.org
Subject: Re: [GSOC][RFC] Proposal
References: <5e55473d.1c69fb81.82355.928d@mx.google.com>
 <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
 <20200301143418.438ce7f9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301143418.438ce7f9@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 01, 2020 at 02:34:18PM +0000, Jonathan Cameron wrote:
> On Fri, 28 Feb 2020 00:50:15 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > On Tue, Feb 25, 2020 at 09:41:37PM +0530, Rohit Sarkar wrote:
> > > Hi,
> > > I am proposing to work on the accelerometer MPU6050 as my primary
> > > project for the summer. The work items are outlined in [1] thanks to
> > > Jean.
> > > If time permits (which it should), I will be picking up other tasks
> > > outlined in [2] by Jonathan and Alexandru.
> > > 
> > > 
> > > Would like to hear people's views on this.
> > > 
> > > [1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
> > > [2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
> > > Thanks,
> > > Rohit
> > >   
> > 
> > Hey guys,
> > would love some feedback on this.
> > There are no proposals as such on the GSOC IIO page [1].
> > Was wondering if there is any new iio driver that can be made into a
> > gsoc project.
> 
> Hi Rohit,
> 
> A couple of questions.   Do you have a gsoc mentor lined up?

On the GSOC IIO page (https://wiki.linuxfoundation.org/gsoc/2020-gsoc-iio-driver)
Dragos has been listed as a mentor. Haven't really heard back from him
yet.

> You should discuss a proposal with whoever that is.
> 
> My gut feeling is that the features suggested by Jean-Baptisite
> do not form a particularly good focus for the body of a gsoc project.
> There are too many rather disassociated items, without a connected
> 'story'.
> 
> They are good items for getting familiar with the subsystem and
> a particular driver but for the actual project you probably want
> something that is more 'yours' in the sense that you drive it from
> initial prototypes through to final upstream code.
> 
> Previous projects have (I think) mostly centred on support for a new
> driver. 

Makes sense. Is there any new driver that needs to be added though? And
if not what else can qualify as a project?

> Thanks,
> 
> Jonathan
> 
> 
Thanks,
Rohit
