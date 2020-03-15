Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CD8185C16
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgCOK5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:57:32 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55098 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOK5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 06:57:32 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so6524397pjb.4;
        Sun, 15 Mar 2020 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i14Cy+qHQvcRYik37Qgbi12uesnn0JzZqE03ZogEXJc=;
        b=cp9QiejKjRe92539znGORxdJnz/s92/VO+x1lRBOKAG2XwMpTT8jz9pwG6IxcyNoQi
         wij7QwCtg/6YUTFgh26JIA4AfD3+4zmZXjtOlRBV32fbeuKwU6b3iNPhpTEiSIm38wPX
         AfSqchVKqdyy08eWk2lLklktY4VpbzA9kKlvm6ndhOFsIBZRyVblKle+gwoLQ5OjjV5G
         LkYfhki/4RmmcgUZIbiuCxUeHriqE/UzbaCzhRZYhIt4SkRNSMDy93d/hDXLDj86Y+Wm
         bOAgZ7oSCbALwFHD1p/m5GGOpIoxC2/FgP8hJ3Xc+QT/zAHb97LZRGxMsRblWcJtuIRf
         2ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i14Cy+qHQvcRYik37Qgbi12uesnn0JzZqE03ZogEXJc=;
        b=ObqaC110H/IPc5eNyxsSsWlctyGnBLPJ3pZ/7z27YJb2Kyck5x1HgdqbWwh341oCPn
         DDVIKlAz26CmuAdo4/8JtOd7smFNDDOYbHnRPhueZJcjVezR8sfOpnW6/9Mfnknm2Gkf
         NfLNWWRL+yLL5ulu1Wq7Q7dVd+ozSYjjjnlE55BEVXshT5Wi/0fUukvzESi1ojk2lAm3
         TloDfWJR930W4MaN5wvIspCFc9os+76a+1RBgvY3XQaz/FW5HQK6gqH5mF7qn05tKhdj
         a2u8TE/4djHCQe9hK0Z81OkP5/HrZBGcz5xzuoQPukoYCNdr6Wunahzh451jlvuv4gQL
         3nSw==
X-Gm-Message-State: ANhLgQ0AnStAqv99DG2ogE3xC/1MWzbV2xCVej38DcV0ALS8pIMYR4oW
        gnqpBshOSVlSC48978ZG0fg=
X-Google-Smtp-Source: ADFU+vu/SYr70+1nQJ7wC4Ha9lpGCwPceQjx2xzWHsE5kCQ7vD9Bi5qvlHiXcru9AvAmxFa2hmWkVg==
X-Received: by 2002:a17:90b:2390:: with SMTP id mr16mr19568199pjb.149.1584269850687;
        Sun, 15 Mar 2020 03:57:30 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id b70sm23876045pfb.6.2020.03.15.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 03:57:29 -0700 (PDT)
Message-ID: <5e6e0a19.1c69fb81.432d5.f12c@mx.google.com>
X-Google-Original-Message-ID: <20200315105724.GB21153@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 16:27:24 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt.ranostay@konsulko.com
Subject: Re: [PATCH] iio: health: max30100: remove mlock usage
References: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com>
 <20200315094604.62dc96be@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315094604.62dc96be@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 09:46:04AM +0000, Jonathan Cameron wrote:
> On Tue, 10 Mar 2020 00:01:28 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Use local lock instead of indio_dev's mlock.
> > The mlock was being used to protect local driver state thus using the
> > local lock is a better option here.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> 
> Matt.  Definitely need your input on this.
> 
> > ---
> >  drivers/iio/health/max30100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > index 84010501762d..8ddc4649547d 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> >  		 * Temperature reading can only be acquired while engine
> >  		 * is running
> >  		 */
> > -		mutex_lock(&indio_dev->mlock);
> > +		mutex_lock(&data->lock);
> 
> Hmm.. It's another complex one.  What is actually being protected here is
> the buffer state, but not to take it exclusively like claim_direct does.

So just to check if I understand correctly, let's say we did not use any
lock in this case. If an execution thread reached the
iio_buffer_enabled() check and found the buffer to be enabled, but
the buffer got disabled simultaneously, the temperature readings that we
get will be corrupted. Does this make sense?

> Here we need the inverse, we want to ensure we are 'not' in the direct
> mode because this hardware requires the buffer to be running to read the
> temperature. 
> 
> That is the sort of interface that is going to get userspace very 
> confused.
Agreed

> Matt, normally what I'd suggest here is that the temperature read should:
> 
> 1) Claim direct mode, if it fails then do the dance you have here
> (with more comments to explain why you are taking an internal lock)
> 2) Start up capture as if we were in buffered mode
> 3) Grab that temp
> 4) stop capture to return to non buffered mode.
> 5) Release direct mode.
> 
> I guess we decided it wasn't worth the hassle.  
> 
> So Rohit.  This one probably needs a comment rather than any change.
The code already mentions that the "Temperature can only be acquired
while engine is running.", should I add something like "mlock is
acquired to protect the buffer state..." to the same comment.

> We 'could' add a 'hold_buffered_mode' function that takes the mlock,
> verifies we are in buffered mode and continues to hold the lock 
> until the 'release_buffered_mode'.  However, I'm not sure any other
> drivers do this particular dance, so clear commenting in the driver
> might be enough.   Should we ever change how mlock is used in the
> core, we'd have to fix this driver up as well.
Understood.

> Hmm.  This is really hammering home that perhaps all the remaining
> mlock cases are 'hard'.
A nice sideffect of me investigating these is that I am getting some
good insight into how iio works. I will see if I can investigate a
couple more cases
> Thanks,
> 
> Jonathan
> 
> >  
Thanks,
Rohit
> >  		if (!iio_buffer_enabled(indio_dev))
> >  			ret = -EAGAIN;
> > @@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> >  
> >  		}
> >  
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&data->lock);
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val = 1;  /* 0.0625 */
> 
