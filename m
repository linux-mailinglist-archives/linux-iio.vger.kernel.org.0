Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA318FBE9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWRwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 13:52:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41264 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCWRwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 13:52:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so6218559plr.8
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTsJVXFyBe5n2J4yvrNhtYB6s8FILu94rLXAvDE+4Gk=;
        b=QqKcyBZOabFgMGkIZO+TEilyn0nNbsds6TzI6VKrhH3UaZ316WHPhXT7W5z9ibLcZZ
         0WdK7LJGolrpMlmObvNl33iYMNE61QNV1WO1tprnzIqew5+YnkZIANSR1iiAMKMm7VtQ
         /vDMVoM84lf7I0A3r279o3Hg4Sbkj2/4xSsTrIgsSnJdfRrZe80ayPyuzNv9mNi/KUMz
         o/yC18rucrBUcU20OwrRBN3QQQOPA/CZ9r/Nu+5DZU2BMv97KWGVRWbAT6R7QYiQlH84
         l+HUcnufMcljStmESnn9dZnDawarsJkIqEC4xSKgtUnsUXOp8s51XqBVhzd1LqMhQRwM
         U1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTsJVXFyBe5n2J4yvrNhtYB6s8FILu94rLXAvDE+4Gk=;
        b=JNIvcz7W8MLKOsejkQEmJ0aRuTqeX4xXDalvqC1hVDq0fJS6iDa8f2c0QlzN+Y/Sge
         6sopbeqEHWDvpsV3SwIg0weHjAP54dvb14f1hm6aTPZICuG6opPLwhO/8WFL1TAUZPJE
         R/VAqhqTU/KJR4vE6YNMJcl2gmQjWXWkwJCCFPxnVXwVbzVhVn691sCx6+PEDimeltfY
         Rf2GkujyybYYwXB8FRz9f/bvNQcO1cU7E1I85uf0k1D35xSj38fgweSwMq3hfrR2ybJx
         QFN4frg6t0ntKT8+BkEDiX7LWA6KhlbXFOO5aPsKQHL3WIKXl1PsiK0Q3ujf/26Xw8qK
         U8AA==
X-Gm-Message-State: ANhLgQ1hRut480srqHdPYRU++/nFCA8qfHdw3u1R0HZd1xXG5zkpqr8M
        m9kXUdVkvRjpHl3ExAwGMaM=
X-Google-Smtp-Source: ADFU+vuYP7OS5jVAvY0oLvrokrcY96CYIAJFNHNrsBj4EmVocePSJeFsEI3QicVVWxxXtbusYmNWBQ==
X-Received: by 2002:a17:90a:fa96:: with SMTP id cu22mr482775pjb.187.1584985952666;
        Mon, 23 Mar 2020 10:52:32 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id 189sm4195902pgh.58.2020.03.23.10.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 10:52:32 -0700 (PDT)
Date:   Mon, 23 Mar 2020 23:22:24 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Message-ID: <20200323175223.GC22110@deeUbuntu>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
 <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
 <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
 <20200323014935.48048405@elisabeth>
 <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
 <20200323131531.1d6c8f93@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323131531.1d6c8f93@elisabeth>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 01:15:31PM +0100, Stefano Brivio wrote:
> On Mon, 23 Mar 2020 11:28:52 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Mon, Mar 23, 2020 at 2:49 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > On Mon, 23 Mar 2020 01:44:20 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:  
> > > > >
> > > > > Current implementation of the function ad7192_get_available_filter_freq
> > > > > repeats calculation of output data rate a few times. We can simplify
> > > > > these steps by refactoring out the calculation of fADC. This would also
> > > > > addresses the checkpatch warning of line exceeding 80 character.  
> > > >
> > > > I'm not sure you did an equivalent changes. I believe in the original
> > > > code precision is better. Consider low clock frequencies when 10 bit
> > > > right shift may hide some bits of the division.  
> > >
> > > Note that those bits are eventually "hidden" in the same way later,  
> > 
> > Even if mathematically (arithmetically) evaluation is correct, we have
> > to remember that computers are bad with floating point and especially
> > kernel, which uses integer arithmetic. That said, it's easy to get
> > off-by-one error (due to precision lost) if we do big division before
> > (not so big) multiplication.
> 
> That's exactly the point I was trying to explain below: swapping steps
> in a sequence of DIV_ROUND_CLOSEST() (*not* of arithmetic divisions),
> *should* not affect quantisation ("off-by-one") error.
> 
> I'm not entirely sure in this case, so a quick "demonstration" in
> Python or suchlike as you suggested would be nice to have, indeed.
> 
> > > despite the different sequence, due to DIV_ROUND_CLOSEST() being used
> > > at every step (both before and after the change) without other
> > > operations occurring.  
> > 
> > By the way, where AD7192_SINC3_FILTER and AD7192_SINC4_FILTER
> > multiplications disappear and why?
> 
> Those were in fact divisions (multiplications of the divisor). Overall,
> these steps are now arranged in a way closer to how they are presented
> in the datasheet mentioned here (up to "Chop Enabled" paragraph, page
> 26).
> 

Thank you Andy and Stefano for your comments. Its very thoughtful. I am
not much familiar with Python so far, but thinking on evaluating your
suggestion in a sample c program. I will share the outcome shortly.

Deepak.


> -- 
> Stefano
> 
