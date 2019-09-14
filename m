Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C2B2A02
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfINF5u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 01:57:50 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32187 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfINF5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 01:57:50 -0400
X-IronPort-AV: E=Sophos;i="5.64,503,1559512800"; 
   d="scan'208";a="401705630"
Received: from 81-65-53-248.rev.numericable.fr (HELO hadrien) ([81.65.53.248])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 07:57:48 +0200
Date:   Sat, 14 Sep 2019 07:57:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jay Aurabind <jay.aurabind@gmail.com>
cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
In-Reply-To: <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909140756470.5193@hadrien>
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR> <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Sat, 14 Sep 2019, Jay Aurabind wrote:

> Hi Rohit,
>
> The required config options need to the objects in that folder to be
> build. Apparently there is no way to automatically set the required
> configs. You can look at the Kconfig files inside drivers/iio/accel
> and see what are the dependencies for building various drivers.

It looks like some of the drivers are individual files.  So you can also
just compile them one at a time make staging/drivers.iio/accel/foo.o.

julia

>
> On Sat, 14 Sep 2019 at 00:58, Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >
> > On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
> > > Hi,
> > > I was trying to compile a particular folder in my kernel tree.
> > >
> > > AFAIK the way to do this is:
> > > `make drivers/staging/iio/` from the kernel base directory.
> > >
> > > This gives me the following output:
> > > `
> > >   CALL    scripts/checksyscalls.sh
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   DESCEND  objtool
> > > `
> > >
> > > No object files are generated.
> > > I feel like I am missing something.
> > >
> > > Thanks,
> > > Rohit
> >
> > I ran `make clean` in the `drivers/iio/accel` directory which removed
> > all object files in the first place. However running make after that
> > doesnt seem to compile the modules.
> >
> > Thanks,
> > Rohit
>
>
>
> --
>
> Thanks and Regards,
> Jay
>
