Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78544B37A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhKITsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 14:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236838AbhKITsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Nov 2021 14:48:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8667760462;
        Tue,  9 Nov 2021 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636487128;
        bh=p9Y/dU1F7KFvXv+uOv8g6d3iTqOQx6WvyXkbzl2bxnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRoOKFqwbXYAFDwTUFDfpzXgQKrM+aAU/jShD6+u2o0XMh6ALuDGN1NfJHOQQYMSO
         sOQSe7tx10oBmahxdqR5y4Lt41dcZon3djA0jFBcVZCttxlzQwbqwREGYok+SVsfRO
         EYVhB5wqOIsfWLvfidMHuIL31JzJkucWD5ISlyLc=
Date:   Tue, 9 Nov 2021 20:45:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] device property: Adding fwnode_irq_get_by_name()
Message-ID: <YYrP1RS5Uyf0MzD7@kroah.com>
References: <20211106173909.34255-1-puranjay12@gmail.com>
 <YYeOVJjiz6huHv4y@kroah.com>
 <CANk7y0jsy9m3YLdSgjsoP-w_NcS-QZx3UTd+jnMHdRrhQ8zgeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0jsy9m3YLdSgjsoP-w_NcS-QZx3UTd+jnMHdRrhQ8zgeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 01:00:26AM +0530, Puranjay Mohan wrote:
> On Sun, Nov 7, 2021 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 06, 2021 at 11:09:08PM +0530, Puranjay Mohan wrote:
> > > While working on an IIO driver I was told to use of_irq_get_byname() as
> > > the generic version is not available in property.c.
> > > I wish to work on this and have written a function that may work.
> > > I am not sure about its correctness so I am posting this patch early for
> > > review.
> >
> 
> Hi Greg,
> 
> > Please test your code, and also provide a user for it.  We can not take
> > new functions that no one uses as that usually means they do not work.
> 
> Actually, I just wanted to get a review of this code before I test it.

No, please test your code first, before asking others to review it.

Do you want to spend your time reviewing code that the creator has not
even tested themselves?

thanks,

greg k-h
