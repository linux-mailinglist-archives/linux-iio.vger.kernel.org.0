Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BEC170604
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 18:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgBZRZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 12:25:25 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38100 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgBZRZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2020 12:25:25 -0500
Received: by mail-pf1-f177.google.com with SMTP id x185so111167pfc.5
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2020 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWXv7Gc+l6QU3oDuO/GFjBWVOBd8VwE2ilSO4XMdJwY=;
        b=u9J98fCZobJCVAT4CgpJtzW82nX5aWkDLmPxMTmxzZyWSlUPq5i7UzMXT68sW2WYvv
         1ToorMC/Ixqf5cHjddW4SaLIQ0ORGoSPmHwN1N1wlX+d7sTpV+Tv+EQ2yMy58CWr87ZX
         683CPz6eXEaaWNrONGlmHf/432Gg7CQnCIOWSr66X8W+S72nmhSGHhjdA+5uSGlwU2rb
         WDgg9QO/Ld6uxr9pFXFqcl0oK+DpEx6KkxojEn2c6A91O/oql7jtfG4zTpGRykXBRJI9
         4qvQeS8OmRiTVeJ3Ps68hwqAADaXnaW1y3gDYZEWIvG5rA+Bt1q+n9cKGTPNF6lk9odN
         d6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWXv7Gc+l6QU3oDuO/GFjBWVOBd8VwE2ilSO4XMdJwY=;
        b=sQEVtvT/ssYf4resQwnWlbYnwYe5ZMjVME42I6XNTof38vjGsrYfio3ogUdSn/eo4n
         oPgemnH8XhayniY9PX4swc7PlbhSiaZREF27dCI7+Slih2p/I0XvSPObwTLM2KRaojCb
         buXLqkq0DLu1AlPDNFauwW2kqjGYTobkIUhnAViE2LySx3dM+I7s4UEEsdjEWJd/foLi
         pnzPGxdbwE8itMB1vC1ayLoDUb1ga9Exz/du6111yJc4wh9tbbb4G8kctU4zsWNPYHu6
         Ag5lCUb7xV+GlmUE4/1S1lb6PsoSDSfXb2Qu53mxIXXR8NF5RMhl2pBvkOjow9Mavvvg
         EX+A==
X-Gm-Message-State: APjAAAWEelNl30xz4msDwfoN9t5u5xQ/BKIVMMhwbduFeRMcJRy23smt
        1n3KqoYekIou6EuJvgJcS1+epDSYKzk=
X-Google-Smtp-Source: APXvYqwWHVkleVpQIW0ESMimU+r7KzL6dFroDat1r/cHafJ9Nq2g15oiMFpQ9IejvBQn/aJIFDs/JQ==
X-Received: by 2002:a63:4d43:: with SMTP id n3mr4753767pgl.169.1582737924393;
        Wed, 26 Feb 2020 09:25:24 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id v9sm3423018pja.26.2020.02.26.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:25:23 -0800 (PST)
Message-ID: <5e56aa03.1c69fb81.3f3c3.8b05@mx.google.com>
X-Google-Original-Message-ID: <20200226172520.GA8432@rohitsarkar5398@gmail.com>
Date:   Wed, 26 Feb 2020 22:55:20 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: query about locking in IIO
References: <20200225171150.GD24663@SARKAR>
 <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 26, 2020 at 06:54:21AM +0000, Ardelean, Alexandru wrote:
> On Tue, 2020-02-25 at 22:41 +0530, Rohit Sarkar wrote:
> > Hi,
> > Could someone explain why using indio_dev->mlock directly is a bad idea?
> > Further examples of cases where it cannot be replaced will be helpful
> > 
> 
> Jonathan may add more here.
> 
> But in general, each driver should define it's own explicit lock if it needs to.
> Some drivers need explicit locking, some don't.
> 
> A lot of other frameworks already define locks already.
> Like, for example, when an IIO driver uses some SPI transfers, the SPI framework
> already uses some locks. So, you don't typically need extra locking; which for
> some IIO drivers translates to: no extra explicit locking.
> 
> I guess Jonathan also wants to move the mlock to be used only in the IIO
> framework.
> In some cases, if drivers use this mlock, and the framework uses it, you can end
> up trying to acquire the same mlock twice, which can end-up in a deadlock.
> These things can sometimes slip through the code-review.

This makes sense

> I guess the docs need a bit of update.
> Because:
> 
> * @mlock:              [DRIVER] lock used to prevent simultaneous device state
> *                      changes
> 
> I think it should be converted to [INTERN]
> 
> > Thanks,
> > Rohit
> > 

As a follow up would I be right to assume that as long as the mlock is
not being in the IIO framework, explicit locking should be the way to
go?

Thanks,
Rohit
