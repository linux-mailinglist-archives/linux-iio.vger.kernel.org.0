Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CE310792
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 10:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBEJR2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 04:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhBEJHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD50B64EE2;
        Fri,  5 Feb 2021 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612516006;
        bh=gZ94WgxTMurnQVt9+yZrw335kUu57BXtOuXer5oxb0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwTjU6TvNNlnaAPjlMJ9FPFxUZk5rbifePNrWJ8iqCD9xy//m2t1QMH6bvlVEbezv
         jbK0y6HTTzaRB305K4ARBfDbJh0ckEPwqya3gXpHfV8VCD8b9f4CmItc+y2GNMzaLH
         AF6tMVRlqFpQ/WZqTjPnKPUwVxQj6wzwDQBY5mWk=
Date:   Fri, 5 Feb 2021 10:06:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] Correct bit mask for ADC result according to ADC's
 resolution.
Message-ID: <YB0Kow28YADfJD05@kroah.com>
References: <20210204155430.GA557111@ubuntu>
 <YBwcv8SkGBmrq+ck@kroah.com>
 <CAMwq6HiFcW2niGaVhUOWiomXh1_HKw_2x37_mjMLcXPHEDhb1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwq6HiFcW2niGaVhUOWiomXh1_HKw_2x37_mjMLcXPHEDhb1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 04, 2021 at 06:17:46PM +0100, Wilfried Wessner wrote:
> On Thu, Feb 4, 2021 at 5:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 04, 2021 at 04:54:30PM +0100, Wilfried Wessner wrote:
> > > Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
> >
> > I know I can't take patches without any changelog text :(
> >
> Sorry, it's my first submitted patch, but what exactly do you mean by
> "changelog text"?

As my patch bot will say:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

Read that file and then resend (with the proper version information) and
all should be good!

thanks,

greg k-h
