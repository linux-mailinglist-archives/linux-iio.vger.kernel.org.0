Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B41B2BAF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfINOoc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 10:44:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62295
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbfINOoc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 10:44:32 -0400
X-IronPort-AV: E=Sophos;i="5.64,505,1559512800"; 
   d="scan'208";a="319400522"
Received: from 81-65-53-248.rev.numericable.fr (HELO hadrien) ([81.65.53.248])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 16:44:29 +0200
Date:   Sat, 14 Sep 2019 16:44:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
cc:     Jay Aurabind <jay.aurabind@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
In-Reply-To: <20190914143723.GA7704@SARKAR>
Message-ID: <alpine.DEB.2.21.1909141641270.2490@hadrien>
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR> <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com> <alpine.DEB.2.21.1909140756470.5193@hadrien> <20190914142527.GA4158@SARKAR> <20190914143723.GA7704@SARKAR>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Sat, 14 Sep 2019, Rohit Sarkar wrote:

> On Sat, Sep 14, 2019 at 07:55:27PM +0530, Rohit Sarkar wrote:
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
> >
> > I guess I will have to enable `CONFIG_IIO` and rebuild?
> > Although what I don't understand is if `CONFIG_IIO` was not enabled how
> > were there object files in the first place?
> >
> > Thanks,
> > Rohit
>
> For reference:
> This is the result of `make drivers/staging/iio/`
> `
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   AR      drivers/staging/iio/accel/built-in.a
>   AR      drivers/staging/iio/adc/built-in.a
>   AR      drivers/staging/iio/addac/built-in.a
>   AR      drivers/staging/iio/cdc/built-in.a
>   AR      drivers/staging/iio/frequency/built-in.a
>   AR      drivers/staging/iio/impedance-analyzer/built-in.a
>   AR      drivers/staging/iio/meter/built-in.a
>   AR      drivers/staging/iio/resolver/built-in.a
>   AR      drivers/staging/iio/built-in.a

Perhaps you have already compiled the .o files that are used to produce
these .a files?  There seem to be some files that are simply not possible
to compile.  Perhaps they can be compiled for some other architecture.
But you can also just work on the files that you are able to compile.

julia
