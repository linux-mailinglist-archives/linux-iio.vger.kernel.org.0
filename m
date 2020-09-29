Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7590527CF9E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgI2Nmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 09:42:44 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45675 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbgI2Nmo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 09:42:44 -0400
X-IronPort-AV: E=Sophos;i="5.77,318,1596492000"; 
   d="scan'208";a="470076349"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 15:42:38 +0200
Date:   Tue, 29 Sep 2020 15:42:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-iio@vger.kernel.org,
        drbd-dev@tron.linbit.com,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Lechner <david@lechnology.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
In-Reply-To: <5f0d2b20f5088281363bb4a35c5652a2c087f159.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009291542090.2808@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>  <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>  <20200929124108.GY4282@kadam>  <alpine.DEB.2.22.394.2009291445050.2808@hadrien>
 <5f0d2b20f5088281363bb4a35c5652a2c087f159.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Tue, 29 Sep 2020, Joe Perches wrote:

> On Tue, 2020-09-29 at 14:47 +0200, Julia Lawall wrote:
> > On Tue, 29 Sep 2020, Dan Carpenter wrote:
> > > The times where commas are used deliberately to replace curly braces are
> > > just evil.  Either way the code is cleaner with semi-colons.
> >
> > I also found exaamples like the following to be particularly unforunate:
> >
> >                                 fprintf(stderr,
> >                                         "page_nr %lu wrong count %Lu %Lu\n",
> >                                        page_nr, count,
> >                                        count_verify[page_nr]), exit(1);
> >
> > The exit is very hard to see, unless you know to look for it.
>
> I sent that patch last month.
> https://patchwork.kernel.org/patch/11734877/
>
> It's still not applied.

OK, thanks.  I'll not send those then :)

julia
