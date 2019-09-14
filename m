Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADA3B2BA6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbfINOha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 10:37:30 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45543 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbfINOha (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 10:37:30 -0400
Received: by mail-pg1-f173.google.com with SMTP id 4so16812552pgm.12;
        Sat, 14 Sep 2019 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWEvH2caI7RQtF7M5MexA/Ii8oFWxL+r0RkvPq36gTg=;
        b=jDOaU3F2C9kd12H1s+Jiix0tstSsbRMnCb8AIMgCwESWoxX1+oAjUs2yH45gsIkPKq
         Xo6vDfZQv7iCCuBBu26KTpjRLPVWv6U5DdJvuioQpBHfvgt/biXbxp3gS7/hVDkLICRx
         wu1EEsTq+JERiKQfgJfRjVQ41U9myTqk3nR0YU10BpIKKARDFjLBjBhevb0yOt1SXorH
         FGEuqYGiGf0fcEkdtFXOwCZO/HtGAbsj6JxFnej4aL3prGE02ICy/bs67n/avgAZQv8Z
         t5jL7QGKnhkPs+gyZdiA/mYpmQuRHts3Ip82MY11o0tNDKcgzuOKjL7yH3vkOPtUql3g
         0Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWEvH2caI7RQtF7M5MexA/Ii8oFWxL+r0RkvPq36gTg=;
        b=sJyrJ56lpsPq4qKPlGWN17rUd9fYmQcTxgf9o6DMdgW8A/0TNL6ytsQpnADFt5LFaq
         eK8/fmI118bPYal56ljDcqG+iwsD+fYor5TNP01qWlf/Q8uYA3bsKUQhGblbF01gvLm4
         nMTqPzA8cjfjuxEftxApxcTNftnWvEZ4+1X7In3747cnYM+0GATnt+GNTl0IWZvmJ27B
         Vx0UguSxd1O+xwHt+cwY16QtfRr7AZQlEX26gXS7FRCxfSsnWnIhrNAUbFXTmHeYQzRE
         p6iJW1Gbi2DiDWRn4uleXshwNMQQv9/Oqi8HNfAB/spw9cz6EMsWjZpm8TOUfWHkPEYc
         qItQ==
X-Gm-Message-State: APjAAAWBMn1J6Pw2xHb/4Og59ZnKmGF2brYZN03eVrgwRwT00+edER4u
        aZZ6fOV6A55pMD04gQQ6vQh9ONz/GjGYvw==
X-Google-Smtp-Source: APXvYqwgGj308gaLG5ESHArJZfz+tcX4VSiq3SI2mNFjp1mFLMOwHFrGNgVtWNNKUoXkcxx2CAc42w==
X-Received: by 2002:a17:90a:f485:: with SMTP id bx5mr11075732pjb.61.1568471849171;
        Sat, 14 Sep 2019 07:37:29 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id t14sm28896205pgb.33.2019.09.14.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 07:37:28 -0700 (PDT)
Date:   Sat, 14 Sep 2019 20:07:24 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jay Aurabind <jay.aurabind@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
Message-ID: <20190914143723.GA7704@SARKAR>
References: <20190913173821.GA5986@SARKAR>
 <20190913180103.GB5986@SARKAR>
 <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
 <alpine.DEB.2.21.1909140756470.5193@hadrien>
 <20190914142527.GA4158@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914142527.GA4158@SARKAR>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 14, 2019 at 07:55:27PM +0530, Rohit Sarkar wrote:
> On Sat, Sep 14, 2019 at 07:57:48AM +0200, Julia Lawall wrote:
> > 
> > 
> > On Sat, 14 Sep 2019, Jay Aurabind wrote:
> > 
> > > Hi Rohit,
> > >
> > > The required config options need to the objects in that folder to be
> > > build. Apparently there is no way to automatically set the required
> > > configs. You can look at the Kconfig files inside drivers/iio/accel
> > > and see what are the dependencies for building various drivers.
> > 
> > It looks like some of the drivers are individual files.  So you can also
> > just compile them one at a time make staging/drivers.iio/accel/foo.o.
> > 
> > julia
> > 
> 
> Hey julia,
> I ran a `make clean` on that directory by mistake which I realised I
> shouldn't have done. Hence no object files are there.
> 
> Giving me this:
> 
> `
> make drivers/staging/iio/adis16240.o staging/git/remove-include
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
> make[1]: *** No rule to make target 'drivers/staging/iio/adis16240.o'.  Stop.
> Makefile:1772: recipe for target 'drivers/staging/iio/adis16240.o' failed
> make: *** [drivers/staging/iio/adis16240.o] Error 2
> `
> 
> I guess I will have to enable `CONFIG_IIO` and rebuild?
> Although what I don't understand is if `CONFIG_IIO` was not enabled how
> were there object files in the first place?
> 
> Thanks,
> Rohit

For reference:
This is the result of `make drivers/staging/iio/`
`
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  AR      drivers/staging/iio/accel/built-in.a
  AR      drivers/staging/iio/adc/built-in.a
  AR      drivers/staging/iio/addac/built-in.a
  AR      drivers/staging/iio/cdc/built-in.a
  AR      drivers/staging/iio/frequency/built-in.a
  AR      drivers/staging/iio/impedance-analyzer/built-in.a
  AR      drivers/staging/iio/meter/built-in.a
  AR      drivers/staging/iio/resolver/built-in.a
  AR      drivers/staging/iio/built-in.a
`

Rohit

