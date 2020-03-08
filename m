Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0617D53E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 18:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgCHRbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 13:31:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCHRbT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2020 13:31:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so3016613plo.11;
        Sun, 08 Mar 2020 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9qnB7QZOlUFXtCcAkVq3BX6tJPsQ7OsVoBtR0r8PgQ=;
        b=E34oMEN10iVxMyUJ+phXZZF8V4aBEG6HuYoJ5hzlZxHQ+uJrxSdvWNVYX2BV1VNecG
         09q0A4up/lRzCKoQFUkc9OCxWS1NyJuOgBJsswREY5frlZelZnNvYA4wsB8CeYUPO2JQ
         AEr8nTnQnGTG6/UP6Jq3CrjSvMq029QkjkCOGEXXlD6Bpm6jazOmuBy/x1WSdFel5Uam
         +0NvZ6b/ayCMRFe72QMVaAV3E7nbzXy3sf0G4t5++vxudlE4b/ekJ5luzZGZIxZKr8Wu
         VhS08UjGDfbZl5u6FB/ZSZ95ZbKry3a30a9dec9l1Dl1lJhh+JMVrhEGeHstQdDfItWU
         jjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9qnB7QZOlUFXtCcAkVq3BX6tJPsQ7OsVoBtR0r8PgQ=;
        b=Wfj2Ux+uHPi9HwUM5+/9TrpiR+1duL9OSbDVJoKgH2noievjGbL8PHwMU4Etgt5I9L
         kRh2SVeRBGddml+C08Hng4/u0VrLewHF6wvn2xyp8LtU+KvnEyxAmIv4dvmHtPtO3/Ia
         sihx8/baDnTpE7ZZ23KgH4SbPFLUcQZ9gPBctCszWDteCCYBFrAmvsmlAdA3jeI2wPOP
         +aKkOYfgC9HtDftxJLLB3J+es8ZN3dOLwm5OGAo/szUcIx54Lu4bErvgl4wE6ByDiMHP
         czhhR8G0PGK/yFJmrifZHDlEw1h3PocZMppdftREiHFiHAqkYAyRI61osm7lRGnMPG7N
         fL/Q==
X-Gm-Message-State: ANhLgQ1VGE+twdmeUQFWAWzUWEB7vr/aGOayZL5dRmEEge8Gs1SHqdWb
        6Pk/cIc9u89w9iIGxjdMMrN58hLR9tg=
X-Google-Smtp-Source: ADFU+vuwPWtkQ/fYgwEC65GgR3rod6W5q+rHrwr+KCxdIOPQ4nbCJFoV15A7RVlSMjzpOdfbofYU7w==
X-Received: by 2002:a17:90a:6448:: with SMTP id y8mr14361094pjm.126.1583688678122;
        Sun, 08 Mar 2020 10:31:18 -0700 (PDT)
Received: from SARKAR ([43.224.157.37])
        by smtp.gmail.com with ESMTPSA id f9sm15855697pje.43.2020.03.08.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 10:31:17 -0700 (PDT)
Message-ID: <5e652be5.1c69fb81.bdd67.92b5@mx.google.com>
X-Google-Original-Message-ID: <20200308173052.GD12716@rohitsarkar5398@gmail.com>
Date:   Sun, 8 Mar 2020 23:01:12 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com, dragos.bogdan@analog.com
Subject: Re: [PATCH v4] iio: adc: max1363: replace uses of mlock
References: <5e6355a8.1c69fb81.36f2c.ab37@mx.google.com>
 <20200307141946.79661dd0@archlinux>
 <5e640c05.1c69fb81.4dd6f.a3c8@mx.google.com>
 <20200308161426.716d1ffb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308161426.716d1ffb@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 08, 2020 at 04:14:26PM +0000, Jonathan Cameron wrote:
> On Sun, 8 Mar 2020 02:32:56 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > On Sat, Mar 07, 2020 at 02:19:46PM +0000, Jonathan Cameron wrote:
> > > On Sat, 7 Mar 2020 13:34:51 +0530
> > > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> > >   
> > > > Replace usage indio_dev's mlock with either local lock or
> > > > iio_device_claim_direct_mode.
> > > > 
> > > > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>  
> > > 
> > > There is a subtlety in here (which is why this one never
> > > got cleaned up before).  We need to protect against:
> > > 
> > > 1) Driver state being accessed from multiple places concurrently.
> > >    That will use your new lock.
> > > 2) Doing actions that cannot occur if in buffered mode.  The
> > >    claim_direct_mode stuff is for that.  
> > I did consider using both, the local driver lock and the claim_direct in
> > some places, however I noticed that the claim_direct_mode internally uses
> > the mlock, hence I didnt think it was necessary to set the local lock as
> > well, as according to my understanding once a process acquires the mlock
> > no other process can run the critical section before the initial process
> > releases the mlock. Thus the driver state also remains consistent.
> 
> Any state changes in the driver done under the local lock can still happen.
> There is also a question of 'obviousness'.  The driver code should not
> 'care' what the internals of claim_direct_mode is doing.
> That can be expected to protect against moving out of direct mode, but
> not anything about 'how'.
> 
> Hence, take them both.

That does make sense, when I thought about it again I realised doing
this is essentially what was wrong with the code in the first place.
Thanks for the pointers. Will send out an update.
Thanks,
Rohit
