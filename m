Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21878189F62
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRPMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:12:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34669 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCRPMz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:12:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so11325136plm.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF8CFYJRZh0RDbh41QGHox+AieZTHYsKPH2kgQaSb8Q=;
        b=KGChfQgZNR4RjX+ojB8Znn8PEZ21Gn9PNZxpMBd/BlsB0tpg303AptQ4L/r5g+6fOO
         LGhmRc3Y+UOgg2mC8cXWrTv6noFZ4e8JDpRZh4ojf4fb61p4K4Kc5ICthPzIlF9zVmyr
         1/7xtoI0q7J0VYlTznffnvsIzqbMv/BjC47YRZtKuOiVA0dCtazgxE0PeDTrCMTY+6pJ
         Hvagdl86HPhGDObVZ4NWbqTBn8PxGqIs6orKk1VR0qLXjAdmEDuyz+rPcFg5QBWtU9zv
         5FyDJAEcomR8DYAlX7eyFk/NjETlhyl8a89Y7yNpLS66vFYSUbeoLkdvcTY0ocdm/7Zi
         Fe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF8CFYJRZh0RDbh41QGHox+AieZTHYsKPH2kgQaSb8Q=;
        b=T3uadmcfXcLXDo7FzI99denI6SAdHTyEyMxmXHz4fcV6tih0MY5zQ3PJ/jTSweO7f8
         NfTAStPx0M3ciXCotZY7bN0ErGxh7FowwDRWnJFSu0xNZLeY/g6grcmn49AOmFAc+wgN
         zjRsA4DoM3v92iF7ClGpfm/0AdeNvMsJIVJzopa5r08BYJbjqPph7TaWuHzA2yPUyOf4
         BtvAynQ5SMWr5eVDcL5iqIM2r9i+nNe4SWu5iWYp8tYsBjJWvPtg9HIMSkJJkBWwMl46
         6AF+3pBnd3RgOiegOi0YeLgW2FOdMttyDtdUuZS3ZLJM2WhxW8D1aMG+BOg8pykjD5lg
         8KJQ==
X-Gm-Message-State: ANhLgQ09r0dZu5NXK3i5AW82/7w5H7R3eUZM6j4a2JK0PadsZRPIE4Zc
        fWU01CgTLkbMfAKB0Rlon4s=
X-Google-Smtp-Source: ADFU+vssHDgWdvWaEVVsySVLc6yWikCgUq02CLAOIVnI967mCUvCbiIlTXg20iJMSW3oG9nibxbkaQ==
X-Received: by 2002:a17:90a:7f06:: with SMTP id k6mr5118122pjl.78.1584544371950;
        Wed, 18 Mar 2020 08:12:51 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id b133sm6550212pga.43.2020.03.18.08.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 08:12:51 -0700 (PDT)
Date:   Wed, 18 Mar 2020 20:42:45 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Reformat lines crossing
 80 columns
Message-ID: <20200318151244.GB22841@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318060004.GA1594471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318060004.GA1594471@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 07:00:04AM +0100, Greg KH wrote:
> On Wed, Mar 18, 2020 at 09:56:59AM +0530, Deepak R Varma wrote:
> > Macro arguments are computed at the time of macro invocation. This makes
> > the lines cross 80 column width. Add variables to perform the
> > calculations before hand and use these new variable in the macro calls
> > instead.
> > 
> > Also re-indent enum members to address checkpatch warning / check messages.
> 
> When you say "also" in a changelog description, that's a huge hint the
> patch needs to be broken up.
> 
> And that is what needs to happen here.
> 
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index bf3e2a9cc07f..0265f6607d75 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -156,8 +156,8 @@
> >   */
> >  
> >  enum {
> > -   AD7192_SYSCALIB_ZERO_SCALE,
> > -   AD7192_SYSCALIB_FULL_SCALE,
> > +	AD7192_SYSCALIB_ZERO_SCALE,
> > +	AD7192_SYSCALIB_FULL_SCALE,
> 
> Because this has nothing to do with the subject, please make it a
> separate patch.
> 

Okay. Got your point. I was thinking since this is a clean up patch I can include both
the changes for the same file in a single patch. No problem; I will
correct and send in a v2.

Thank you,
Deepak.


> thanks,
> 
> greg k-h
