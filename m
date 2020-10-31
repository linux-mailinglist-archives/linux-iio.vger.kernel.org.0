Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3A2A1561
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 12:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgJaLFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 07:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgJaLFQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 07:05:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EAD208B6;
        Sat, 31 Oct 2020 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604142316;
        bh=bC++FNQDGlVtlhYG/eM4NOko/C7l8F8wsOrtywcEjGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sj5mqSitEubbsf9QLznu4zo52+Yox8mjmmhQx5YYvsw80y+m6hqjr8CBWkhyJBMCb
         zxZw/5HvojnpM3I9cTDuDJY1G4g/wk+4fUcbcCjiz30vkg9n/grsBwhDPX02WsdxfH
         OIJLh7YV6T6iwwWta0jIeoPr1+fbub+laZkKmhC4=
Date:   Sat, 31 Oct 2020 11:05:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201031110511.515a2f0f@archlinux>
In-Reply-To: <20201030143410.pbixjo2cllhd27zp@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
        <20201029144007.77d967b0@archlinux>
        <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
        <20201030143410.pbixjo2cllhd27zp@Rk>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Oct 2020 22:34:10 +0800
Coiby Xu <coiby.xu@gmail.com> wrote:

> On Thu, Oct 29, 2020 at 07:06:40PM +0200, Andy Shevchenko wrote:
> >On Thu, Oct 29, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> >> On Thu, 29 Oct 2020 15:48:56 +0800
> >> Coiby Xu <coiby.xu@gmail.com> wrote:  
> >  
> >> Please put a cover letter on your next series explaining the context.
> >> In this particular case some of the replies you have gotten are
> >> general at it is a lot easier to find these sorts of things via
> >> replying to the cover letter.  
> >
> >Looking at the number of duplicate messages I would suggest that one
> >needs to go through documentation on how to use git format-patch and
> >git send-email.
> >  
> 
> Thank you for the suggestion! Actually it's a tree-wide change and it
> seems the kernel community prefer individual patches or series for
> subsystems having the same maintainer over a huge patch set so I wrote
> some scripts to automate the process. That's why you see ~50 emails
> with almost the same commit message. The only difference of these
> commit messages is the name of PM macro.

When doing a bit set like this, it's worth sending out a small subset
first to shake out issue like those seen here.

Once those get merged then send out out the reset.

Thanks,

Jonathan

> 
> >--
> >With Best Regards,
> >Andy Shevchenko  
> 
> --
> Best regards,
> Coiby

