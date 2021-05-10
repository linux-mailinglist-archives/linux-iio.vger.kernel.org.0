Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEC377C7C
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhEJGt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 02:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhEJGt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 02:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3883A61409;
        Mon, 10 May 2021 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620629335;
        bh=ASacdpOlQuH135AzXf7Jffw+O0OQ6HRYX3B7lI/zHqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyAYJYWsaPA8vtKzZrhefsMQaL/p5Sh8rTnmEtJOGy3LOCEXauRmbSTMIkYXDzJpZ
         Fl2arSdhFGxHli8rPsZJtQUq6o8p55U1bssP/+Vxnde9pgUDvxAKZEa8CS49YpVG0w
         DAWD4k898oJagldSEQvXpyGgnq31kbAF+MYog8rY=
Date:   Mon, 10 May 2021 08:48:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
Message-ID: <YJjXU/mBKnmknItg@kroah.com>
References: <20210503144350.7496-1-aardelean@deviqon.com>
 <20210508161643.5990ec15@jic23-huawei>
 <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
 <20210509111925.52f3f4e3@jic23-huawei>
 <CACRpkdZ2mC5V6PdphmtmtQKHZwPfc7mVgZ-FH3io2ihB8foA4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ2mC5V6PdphmtmtQKHZwPfc7mVgZ-FH3io2ihB8foA4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 09, 2021 at 05:29:10PM +0200, Linus Walleij wrote:
> On Sun, May 9, 2021 at 12:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, 8 May 2021 20:21:08 +0200
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > > Unless you really like to base your work on Gregs tree for
> > > some reason or other, that is.
> >
> > Definitely appreciate Greg's help (and patience), but no
> > particularly strong reason to waste his time dealing with my
> > mess ups. Hopefully they'll reduce now IIO trees are going directly
> > into linux-next though.
> 
> I'd suggest to move to sending pulls to Torvalds directly
> for IIO to cut the intermediary staging tree step, since
> now the subsystem is pretty large and see a bunch of
> frequent fixes that need an express path to Torvalds.
> 
> Pushing through Greg per se isn't really the problem,
> I think the problem is that IIO is going through the
> staging tree which (I guess) isn't a high priority activity
> and not expected to carry any serious critical fixes and
> I guess this can cause lags.
> 
> Maybe Greg has some other branch to take in IIO
> fixes and for-next but I don't really see the point.

I can take IIO changes in my char/misc tree like many other driver
subsystems go, if the staging portions are not involved.  Otherwise, I
really don't see the problem with it as-is, what problems is this
causing at the moment?

thanks,

greg k-h
