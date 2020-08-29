Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA525688A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgH2PMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2PMf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:12:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3533207DA;
        Sat, 29 Aug 2020 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598713955;
        bh=Eo1SPeKsRz96wh4QVnp5DUv/YnwSpFSnWVxosehIdY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CKH6M2Nsn5O96NeAQmzTf/D7LHo8bUNvO5Wti/bGujxzgUNNQ+/C0Vt0EZaEsRtRt
         uTHwbP/ZIskdkI2zx8eZEwGTl67ggc77S7fAVaJNYia+Xa7HgZEqSUXDs5CeIhw67v
         zVZGII2z58uz4PFuTHExhrQD5S+lWtNB4JHMcKFY=
Date:   Sat, 29 Aug 2020 16:12:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
Message-ID: <20200829161230.398e0051@archlinux>
In-Reply-To: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 17:01:18 -0700
Douglas Anderson <dianders@chromium.org> wrote:

> On one board I found that:
>   probe of 5-0028 returned 1 after 259547 usecs
> 
> There's no reason to block probe of all other devices on our probe.
> Turn on async probe.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: I haven't done any analysis of the driver to see _why_ it's so
> slow, only that I have measured it to be slow.  Someone could
> certainly take the time to profile / optimize it, but in any case it
> still won't hurt to be async.

Hmm. It is vanishingly rare to use that flag so I'm not particularly
keen on starting to deploy it when we don't know why a particular
driver is taking so long.  I agree it should be safe but I don't
like oddities I don't understand!

There are some sleeps in there but they are all of the order of a few
msecs.

Could it be there is a regulator that is coming up very slowly?

Any other ideas?

Jonathan

> 
> This is a very safe flag to turn on since:
> 
> 1. It's not like our probe order was defined by anything anyway.  When
> we probe is at the whim of when our i2c controller probes and that can
> be any time.
> 
> 2. If some other driver needs us then they have to handle the fact
> that we might not have probed yet anyway.
> 
> 3. There may be other drivers probing at the same time as us anyway
> because _they_ used async probe.
> 
> While I won't say that it's impossible to tickle a bug by turning on
> async probe, I would assert that in almost all cases the bug was
> already there and needed to be fixed anyway.
> 
> ALSO NOTE: measurement / testing was done on the downstream Chrome OS
> 5.4 tree.  I confirmed compiling on mainline.
> 
>  drivers/iio/proximity/sx9310.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index dc2e11b43431..444cafc53408 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1054,6 +1054,7 @@ static struct i2c_driver sx9310_driver = {
>  		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
>  		.of_match_table = of_match_ptr(sx9310_of_match),
>  		.pm = &sx9310_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe		= sx9310_probe,
>  	.id_table	= sx9310_id,

