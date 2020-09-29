Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3870227CDF7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbgI2MsJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:48:09 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38307 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729646AbgI2Mrg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:47:36 -0400
X-IronPort-AV: E=Sophos;i="5.77,318,1596492000"; 
   d="scan'208";a="470060117"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:47:29 +0200
Date:   Tue, 29 Sep 2020 14:47:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Ard Biesheuvel <ardb@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-iio@vger.kernel.org, drbd-dev@tron.linbit.com,
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
        Joe Perches <joe@perches.com>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
In-Reply-To: <20200929124108.GY4282@kadam>
Message-ID: <alpine.DEB.2.22.394.2009291445050.2808@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com> <20200929124108.GY4282@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Tue, 29 Sep 2020, Dan Carpenter wrote:

> On Tue, Sep 29, 2020 at 02:20:00PM +0200, Ard Biesheuvel wrote:
> > On Sun, 27 Sep 2020 at 21:56, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> > >
> > > These patches replace commas by semicolons.
> >
> >
> > Why?
> >
>
> In the best case, these commas are just uninitentional mess, like typing
> an extra space character or something.  I've looked at them before and
> one case I see where they are introduced is when people convert a
> struct initializer to code.
>
> -	struct foo {
> -		.a = 1,
> -		.b = 2,
>  		...
> +	foo.a = 1,
> +	foo.b = 2,
>
> The times where commas are used deliberately to replace curly braces are
> just evil.  Either way the code is cleaner with semi-colons.

I also found exaamples like the following to be particularly unforunate:

                                fprintf(stderr,
                                        "page_nr %lu wrong count %Lu %Lu\n",
                                       page_nr, count,
                                       count_verify[page_nr]), exit(1);

The exit is very hard to see, unless you know to look for it.

julia
