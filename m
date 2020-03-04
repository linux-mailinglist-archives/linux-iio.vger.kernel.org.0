Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511E4179751
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 18:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgCDR5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 12:57:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53266 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgCDR5o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 12:57:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id cx7so1222531pjb.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2020 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1lMZOf+CrLPEvaqZThM8hJp5ddcaH/vaT+qmLLqSX0=;
        b=uwe7YH1J3h7ta7EWvPMU0OuKh1vXynscEYCmmzWSVL+gFTrEQ1cVKd7qwo9iuxjDs6
         LxukAYOZ5sZ5g7GnsxW/HAdnuspknGqDmKAVGN0eqpZ3xsIuRs9v+T/VQdttCoNEMFLd
         IOnx51Oeu102t6vJFJGOlwdBNM6DuUy131zOPbOAuFNIQZ+1jVRWWn+lwK1ds0dxo9fn
         SPpLvrqjufa5eRv4HT5GB79ygy/6OkIGmQ+ct7owpRPh+z+eLaqCba41XAOlvdiPC8Xm
         6e9uNxXFbF0jxE8Dfj1dmrNOoHUtjiYc8zFjpMEKh8BWuTdDMXrCYVcpr1TL3GXFPPgo
         5G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1lMZOf+CrLPEvaqZThM8hJp5ddcaH/vaT+qmLLqSX0=;
        b=FLTBTyWWNsAGY9s+QfKVZVduq73hbAtR4FXDqM+2MHUXiTSbv/PhnADWBVVWABgIdi
         gltgJhYKVmkhP79WWgAbZuTMQB4ob8XzE8xiDbw2GEV0IBn+7QoEBd9ceK6FVehRD3HB
         8Zoh7JLJGWNmfwMINIBpDvCite7KbVXzxQ/2qEihVj8xESzNlYXL6Dj0poeajWMi/ePv
         KJvMSganB7d5C9JWgtX4oVGWz5iJDD4woRHJkEyprms5t6Uddt3Zy4+yIJ6zekooHjzs
         HXz5fuGTGzItUpUg3Fcgzhe14NBZnytuJeUrFpvaauGYN9onKC5aI3wVqzpxQvr14YnY
         tkSQ==
X-Gm-Message-State: ANhLgQ0SPgL0rFhmlPjx+1MBAFAqaTQNhp1+NFncEJP8jjVoLNeICZQx
        j17JhEqaoe0bvvb+S9lol2sKLpyko6k=
X-Google-Smtp-Source: ADFU+vv11654DysSQVeNU70sKnYWokrKJ0TQqRGIdfPtzsXfPFRucED2tIMcWa13JMBzRDqUVp2ZSg==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr4066815plt.224.1583344662751;
        Wed, 04 Mar 2020 09:57:42 -0800 (PST)
Received: from SARKAR ([43.224.157.39])
        by smtp.gmail.com with ESMTPSA id x65sm30560835pfb.171.2020.03.04.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:57:42 -0800 (PST)
Message-ID: <5e5fec16.1c69fb81.b144.0870@mx.google.com>
X-Google-Original-Message-ID: <20200304175737.GA12716@rohitsarkar5398@gmail.com>
Date:   Wed, 4 Mar 2020 23:27:37 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dragos.bogdan@analog.com, JManeyrol@invensense.com,
        linux-iio@vger.kernel.org
Subject: Re: [GSOC][RFC] Proposal
References: <5e55473d.1c69fb81.82355.928d@mx.google.com>
 <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
 <20200301143418.438ce7f9@archlinux>
 <5e5c9393.1c69fb81.18044.9bc8@mx.google.com>
 <20200303202950.1bc0dfc5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303202950.1bc0dfc5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 03, 2020 at 08:29:50PM +0000, Jonathan Cameron wrote:
> On Mon, 2 Mar 2020 10:33:09 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > On Sun, Mar 01, 2020 at 02:34:18PM +0000, Jonathan Cameron wrote:
> > > On Fri, 28 Feb 2020 00:50:15 +0530
> > > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> > >   
> > > > On Tue, Feb 25, 2020 at 09:41:37PM +0530, Rohit Sarkar wrote:  
> > > > > Hi,
> > > > > I am proposing to work on the accelerometer MPU6050 as my primary
> > > > > project for the summer. The work items are outlined in [1] thanks to
> > > > > Jean.
> > > > > If time permits (which it should), I will be picking up other tasks
> > > > > outlined in [2] by Jonathan and Alexandru.
> > > > > 
> > > > > 
> > > > > Would like to hear people's views on this.
> > > > > 
> > > > > [1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
> > > > > [2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
> > > > > Thanks,
> > > > > Rohit
> > > > >     
> > > > 
> > > > Hey guys,
> > > > would love some feedback on this.
> > > > There are no proposals as such on the GSOC IIO page [1].
> > > > Was wondering if there is any new iio driver that can be made into a
> > > > gsoc project.  
> > > 
> > > Hi Rohit,
> > > 
> > > A couple of questions.   Do you have a gsoc mentor lined up?  
> > 
> > On the GSOC IIO page (https://wiki.linuxfoundation.org/gsoc/2020-gsoc-iio-driver)
> > Dragos has been listed as a mentor. Haven't really heard back from him
> > yet.
> 
> I would definitely be looking to discuss this with Dragos.
>  
> > > You should discuss a proposal with whoever that is.
> > > 
> > > My gut feeling is that the features suggested by Jean-Baptisite
> > > do not form a particularly good focus for the body of a gsoc project.
> > > There are too many rather disassociated items, without a connected
> > > 'story'.
> > > 
> > > They are good items for getting familiar with the subsystem and
> > > a particular driver but for the actual project you probably want
> > > something that is more 'yours' in the sense that you drive it from
> > > initial prototypes through to final upstream code.
> > > 
> > > Previous projects have (I think) mostly centred on support for a new
> > > driver.   
> > 
> > Makes sense. Is there any new driver that needs to be added though? And
> > if not what else can qualify as a project?
> 
> There might be something, but that sort of project is much harder
> to structure than a clear implement something.
> 
> There are always new devices that don't have drivers that someone
> is interested in supporting.  The main requirement is to find
> find something that the mentor things is the right balance of
> complex and not too complex to support.
> 
> The link you have above suggests Dragos was thinking of an Analog
> devices part (which makes sense given his day job ;)
> 
> You are still fairly early (which is great) so it may well be that
> Dragos hasn't yet spun up for this round.
> 
> Jonathan
Thanks for getting back!
I have indeed reached out to Dragos and it seems the IIO GSOC page has
been updated since this mail chain was started.

Hijacking this mail thread for another question I had:
The page mentions that the recommended hardware is a Raspberry pi model
3 B+, I recently got a RPi 4 model B to facilitate my development in the
iio subsystem, will that be fine?

> > 
> > > Thanks,
> > > 
> > > Jonathan
> > > 
> > >   
> > Thanks,
> > Rohit
> 

Thanks,
Rohit
