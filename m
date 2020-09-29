Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A773427C77D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgI2LyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 07:54:17 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32180 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730629AbgI2Lq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 07:46:28 -0400
X-IronPort-AV: E=Sophos;i="5.77,318,1596492000"; 
   d="scan'208";a="470044784"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:46:20 +0200
Date:   Tue, 29 Sep 2020 13:46:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mark Brown <broonie@kernel.org>
cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-acpi@vger.kernel.org, David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        openipmi-developer@lists.sourceforge.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
In-Reply-To: <20200929113745.GB4799@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2009291344590.2808@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <160132172369.55460.9237357219623604216.b4-ty@kernel.org> <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com> <20200929113745.GB4799@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Tue, 29 Sep 2020, Mark Brown wrote:

> On Mon, Sep 28, 2020 at 05:45:24PM -0700, Joe Perches wrote:
> > On Mon, 2020-09-28 at 20:35 +0100, Mark Brown wrote:
>
> > > [1/1] regmap: debugfs: use semicolons rather than commas to separate statements
> > >       commit: 7f4a122d0b50b40c64d24a5cf7aafe26dd9487ee
>
> > Rather than replying to the 0/n cover letter to a patch
> > series, can you reply to each of the specific patches in
> > the patch series you are applying?
>
> > Otherwise, it's a bit difficult to figure out which patches
> > you are applying.
>
> Feel free to submit patches to b4.  Ideally things like this wouldn't be
> being sent as serieses in the first place, there's no dependencies or
> interactions between the patches.

It was suggested (a long time ago, not with respect to this patch in
particular) that sending such patches in a series is useful because it
allows people who are not interested in the 18 patches to skip over them
more easily.  So there are two conflicting needs...

julia
