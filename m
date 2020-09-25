Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2BC27862E
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIYLnw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 07:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYLnw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 07:43:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C04C2083B;
        Fri, 25 Sep 2020 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601034232;
        bh=1dd58u3+WPGcmiZcuDM5pkmt+Kw/pnUGVJdzX2xsQCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DJDqnOqcXALbb6olpWGOK556DpPa9cTkNM4iSsrLS5ZF+hYMkCb8UCQyJjHqhjrQc
         ygca2WgaPc9URYPvn3y49hrOrviryiyaZYsOhD+8MmNVjCditF47+iFWA/o8yUN92e
         aG0lQkP5KRWT215tT+wgpwEoHq0bcqbv1xoX4UGo=
Date:   Fri, 25 Sep 2020 12:43:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/1] dt-bindings:iio:adc:amlogic,meson-saradc yaml
 conversion
Message-ID: <20200925124347.1afea8cf@archlinux>
In-Reply-To: <CAFBinCDr=eD-DO_jzWYmcf=MLjwab=Ns0fqJUKdeG_pq4CqrCw@mail.gmail.com>
References: <20200920135436.199003-1-jic23@kernel.org>
        <20200920135436.199003-2-jic23@kernel.org>
        <CAFBinCDr=eD-DO_jzWYmcf=MLjwab=Ns0fqJUKdeG_pq4CqrCw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 15:02:02 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Sep 20, 2020 at 3:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This binding is non trivial due to the range of different parts
> > supported having several subtle quirks. Martin has helped
> > clarify some of them.
> >
> > Note, I haven't restricted the amlogic,hhi-sysctrl to only
> > be present on the relevant parts if nvmem stuff also is, but
> > it would seem to be rather odd if it were otherwise.
> >
> > Perhaps we look to make this binding more restrictive at a later date.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> this is looking great - so in case it's not too late please add my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> 
Thanks Martin,  I've added your tag.

Jonathan

> Best regards,
> Martin

