Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A868219318C
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYUAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 16:00:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38389 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbgCYUAU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 16:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585166416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcnmO7fRGNuZ1u/wocvqveXwUy5+lAiES0Bl8oMnk2c=;
        b=C9MlnW0heff8l2FMa6JARyU7LP6Td0/jWBEWyl9kXeSp3GPJMcJLSjjGfv2KWxJ2IPyaJw
        GBmbqqAoBrPJ2t0rlG8LnowJl3mRwBD8IZbu4LxdLhaCi2oiu1mxBcT/7XGYMJT4mYBbt9
        N9tlopzhTsbZFVxlXSyPpkPYHzuPI4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-0_FNnFoGPlyYnbdq0gc69w-1; Wed, 25 Mar 2020 16:00:13 -0400
X-MC-Unique: 0_FNnFoGPlyYnbdq0gc69w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50CF8107B765;
        Wed, 25 Mar 2020 20:00:10 +0000 (UTC)
Received: from localhost (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00EFC5C1D8;
        Wed, 25 Mar 2020 20:00:03 +0000 (UTC)
Date:   Wed, 25 Mar 2020 20:59:40 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     DEEPAK VARMA <mh12gx2825@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc:
 ad7192: get_filter_freq code optimization
Message-ID: <20200325205940.06bc84b6@redhat.com>
In-Reply-To: <20200325173815.GA28246@deeUbuntu>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
        <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
        <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
        <20200323014935.48048405@elisabeth>
        <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
        <20200323131531.1d6c8f93@elisabeth>
        <20200323175223.GC22110@deeUbuntu>
        <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com>
        <20200325173815.GA28246@deeUbuntu>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 23:08:17 +0530
DEEPAK VARMA <mh12gx2825@gmail.com> wrote:

> On Tue, Mar 24, 2020 at 08:06:34AM +0000, Ardelean, Alexandru wrote:
> > On Mon, 2020-03-23 at 23:22 +0530, DEEPAK VARMA wrote:  
> > > [External]
> > > 
> > > On Mon, Mar 23, 2020 at 01:15:31PM +0100, Stefano Brivio wrote:  
> > > > On Mon, 23 Mar 2020 11:28:52 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >   
> > > > > On Mon, Mar 23, 2020 at 2:49 AM Stefano Brivio <sbrivio@redhat.com> wrote:  
> > > > > > On Mon, 23 Mar 2020 01:44:20 +0200
> > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:    
> > > > > > > On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > > wrote:    
> > > > > > > > Current implementation of the function
> > > > > > > > ad7192_get_available_filter_freq
> > > > > > > > repeats calculation of output data rate a few times. We can simplify
> > > > > > > > these steps by refactoring out the calculation of fADC. This would
> > > > > > > > also
> > > > > > > > addresses the checkpatch warning of line exceeding 80 character.    
> > > > > > > 
> > > > > > > I'm not sure you did an equivalent changes. I believe in the original
> > > > > > > code precision is better. Consider low clock frequencies when 10 bit
> > > > > > > right shift may hide some bits of the division.    
> > > > > > 
> > > > > > Note that those bits are eventually "hidden" in the same way later,    
> > > > > 
> > > > > Even if mathematically (arithmetically) evaluation is correct, we have
> > > > > to remember that computers are bad with floating point and especially
> > > > > kernel, which uses integer arithmetic. That said, it's easy to get
> > > > > off-by-one error (due to precision lost) if we do big division before
> > > > > (not so big) multiplication.  
> > > > 
> > > > That's exactly the point I was trying to explain below: swapping steps
> > > > in a sequence of DIV_ROUND_CLOSEST() (*not* of arithmetic divisions),
> > > > *should* not affect quantisation ("off-by-one") error.
> > > > 
> > > > I'm not entirely sure in this case, so a quick "demonstration" in
> > > > Python or suchlike as you suggested would be nice to have, indeed.
> > > >   
> > > > > > despite the different sequence, due to DIV_ROUND_CLOSEST() being used
> > > > > > at every step (both before and after the change) without other
> > > > > > operations occurring.    
> > > > > 
> > > > > By the way, where AD7192_SINC3_FILTER and AD7192_SINC4_FILTER
> > > > > multiplications disappear and why?  
> > > > 
> > > > Those were in fact divisions (multiplications of the divisor). Overall,
> > > > these steps are now arranged in a way closer to how they are presented
> > > > in the datasheet mentioned here (up to "Chop Enabled" paragraph, page
> > > > 26).
> > > >   
> > > 
> > > Thank you Andy and Stefano for your comments. Its very thoughtful. I am
> > > not much familiar with Python so far, but thinking on evaluating your
> > > suggestion in a sample c program. I will share the outcome shortly.  
> > 
> > +adding Mircea Caprioru
> > 
> > Umm, this math-cleanup looks pretty dangerous.
> > If possible, I wouldn't change it.
> > At least without some testing on HW.
> > 
> > Maybe doing math-simulations in Python scripts would also work, but not sure.
> >   
> 
> Hello All,
> I further reviewed current and proposed implementation of the
> get_filter_freq() function[Thank you Stefano for your time]. We realised that I
> was wrong in swapping DIV_ROUND_CLOSEST calls with mixing
> multiplication in it. It is indeed incorrect to mix multiplication if we
> want to reorder the calls.

Specifically, my wrong assumption was that we were just reordering
DIV_ROUND_CLOSEST() operations -- that's actually fine: with rounding,
integer division (not mixed with other operations) is associative.

However, here, we had those 0.23, 0.24, 0.272 factors. I missed them.

If we factor together these multiplications and do them first, of
course, the result is more accurate, which, I assume from the usage of
DIV_ROUND_CLOSEST() and the typical application of the ADC, is quite
relevant here.

The observation here is that, by doing all of them first, the code is
more accurate (e.g. with a fclk of 2458464 and 904 as "mode" we get 722
for freq[4] instead of 723 -- 722.377747 with real division) and
actually becomes more readable, too.

> [...]
>
> May I please request you to review the attached test program, verify the
> results and share your feedback.

As an alternative to what Andy suggested, I guess you could also post it
inline, just like we do for patch reviews. Commenting becomes natural
and the discussion can be referenced later via archives.

-- 
Stefano

