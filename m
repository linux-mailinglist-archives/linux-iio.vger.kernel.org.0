Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360F6B2BB0
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfINOpH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 10:45:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfINOpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 10:45:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so947442pfa.1;
        Sat, 14 Sep 2019 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JG71HkT9GfHQiBTV2s/CbMFa+DhT7o2ElGam2LD6mpk=;
        b=Nfu46TS3bQLC1oWnXtSPZqaht4TjEjSuB4j0DaepRSdlIa8J1Bn7D8VcjcxoP5vvDH
         6SLdYUd/D4Ylg2+C3yDGy0CABzQlDFZOuJ9hSyODMmw55U03WhL8p91fNSf10LBIiuIn
         /6Nnsmp6bCyJey/hBey7YUiNFXdRSx8KF72HbyPwUPlJS5PsdItBmVMTLr3Qm5am902O
         sWiIQ1omzJClpe3DTHkjiHnXTc0uzqnzUpzUNd9BRkqKxiFF8PJ6ul4B1FhrWG+G1j+U
         Pj1Q/0W+zg6DKXw11ePWARb5vE9V42PGd/Gt29PltHzVi/nKKXNQCPg83QP19IDOI82L
         ChMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JG71HkT9GfHQiBTV2s/CbMFa+DhT7o2ElGam2LD6mpk=;
        b=Sy+TupzbZLqlmpIGL1enUS65ULBRL0PhvnMwDQAzyY5TLt1EO3xQYRvAqHVEmtHgQR
         cjxUqZ+r4wtiyOaqss3MyAukirebNJ+tbCd4UKhP0aSqyPdqxSjQsviImSNwEkBAJk/6
         ZvrNsd0k4nau3tNTgTPxYiy3sbWfp9MJ5whUV9uj3VBh7iJnI40pL62CzLVA29Clk8vr
         8ZI71XiqRMhnTkS3yAVMmv1fPQXjUcSmKo1GbDFvY5nU9J9WzWLXiSwZRVuhdjDjHAUw
         PlOcvgKjuYF9WO+dzE+eD8twQQ1hgVc9dyvM1VBnnBm2G7bgDX6hhhgNabvT/FwZQgYO
         KoQA==
X-Gm-Message-State: APjAAAXfPijMMkTSOfr/1lNZWnx0E7Z5Onxd4tBSpHvr2MSUa7j/2GSo
        aCDPFgrXvbjT8sCenLH842HUtayX3gIpPQ==
X-Google-Smtp-Source: APXvYqxf6Mi3dDhuaF11RxndaEu4Fq5aM7UaWrcjNEtwXb44B9DRXGLWwUciT4O7wPQFC1QJe5tqFQ==
X-Received: by 2002:a62:5302:: with SMTP id h2mr2360935pfb.237.1568472306546;
        Sat, 14 Sep 2019 07:45:06 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id w6sm61321610pfj.17.2019.09.14.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 07:45:05 -0700 (PDT)
Date:   Sat, 14 Sep 2019 20:15:01 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jay Aurabind <jay.aurabind@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
Message-ID: <20190914144501.GB7704@SARKAR>
References: <20190913173821.GA5986@SARKAR>
 <20190913180103.GB5986@SARKAR>
 <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
 <alpine.DEB.2.21.1909140756470.5193@hadrien>
 <20190914142527.GA4158@SARKAR>
 <alpine.DEB.2.21.1909141632100.2490@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909141632100.2490@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 14, 2019 at 04:35:13PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 14 Sep 2019, Rohit Sarkar wrote:
> 
> > On Sat, Sep 14, 2019 at 07:57:48AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Sat, 14 Sep 2019, Jay Aurabind wrote:
> > >
> > > > Hi Rohit,
> > > >
> > > > The required config options need to the objects in that folder to be
> > > > build. Apparently there is no way to automatically set the required
> > > > configs. You can look at the Kconfig files inside drivers/iio/accel
> > > > and see what are the dependencies for building various drivers.
> > >
> > > It looks like some of the drivers are individual files.  So you can also
> > > just compile them one at a time make staging/drivers.iio/accel/foo.o.
> > >
> > > julia
> > >
> >
> > Hey julia,
> > I ran a `make clean` on that directory by mistake which I realised I
> > shouldn't have done. Hence no object files are there.
> >
> > Giving me this:
> >
> > `
> > make drivers/staging/iio/adis16240.o staging/git/remove-include
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> > make[1]: *** No rule to make target 'drivers/staging/iio/adis16240.o'.  Stop.
> > Makefile:1772: recipe for target 'drivers/staging/iio/adis16240.o' failed
> > make: *** [drivers/staging/iio/adis16240.o] Error 2
> > `
> 
> OK
> 
> > I guess I will have to enable `CONFIG_IIO` and rebuild?
> > Although what I don't understand is if `CONFIG_IIO` was not enabled how
> > were there object files in the first place?
> 
> Perhaps the build system is just not very well designed here.
> 
> However, for me
> 
> make allyesconfig
> make drivers/staging/iio/
> 
> works, and after that it is possible to do:
> 
> make drivers/staging/iio/accel/adis16203.o
> 
> I didn't do anything explicitly with CONFIG_IIO.
> 
> julia

Bingo! :D
This worked.

Thanks everyone!

Rohit
