Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58627878C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgIYMrf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgIYMrf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:47:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBC221741;
        Fri, 25 Sep 2020 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601038054;
        bh=waynDFUfNe66Kqvdbzo+QDUJWYjky3ksuOgO4a7FTJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGF3xie6gTnh2P9PPICW/ipJB+LqwbtL1W40P0RS02Q+zq2lZu42mk+vakoe85u8U
         RraDq4WoIRMfI6LS/STdRslaabdX+uGaWZb/4/WEuY5s4QZJvnX4bFDmYfEhp3/dXd
         kpgHjfIPh2XwKwDf6rB/JhAOf/DIzYbN1s1wbabs=
Date:   Fri, 25 Sep 2020 13:47:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT
 properties
Message-ID: <20200925134729.4fbfcb4a@archlinux>
In-Reply-To: <160093423392.310579.10143738916599003618@swboyd.mtv.corp.google.com>
References: <20200903221828.3657250-1-swboyd@chromium.org>
        <20200906150247.3aaef3a3@archlinux>
        <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
        <20200909121550.00005ede@Huawei.com>
        <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
        <160093423392.310579.10143738916599003618@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 00:57:13 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Stephen Boyd (2020-09-23 16:25:43)
> > > > > > +
> > > > > > +  semtech,close-debounce-samples:
> > > > > > +    allOf:
> > > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > > +      - enum: [0, 2, 4, 8]
> > > > > > +    default: 0
> > > > > > +    description:
> > > > > > +      The number of close samples debounced for proximity/body thresholds.    
> > > > > 
> > > > > This feels like something that has more to do with the object motion than
> > > > > the sensor setup, so perhaps should be controlled from userspace?    
> > > > 
> > > > Sure. Is there an IIO sample property? Or I should make a custom
> > > > knob for this?  
> > > 
> > > It's kind of close to in_proximity0_thresh_period and that may be how they
> > > have implemented it.
> > > 
> > > That control specifies a number of samples for which a condition should be true
> > > before it is reported.  
> > 
> > Sounds good. I can do that. It looks like the driver reports close/far
> > via an event and these debounce values are the same for me so I can
> > write both fields (close and far) with the same thresh_period value from
> > userspace. If they need to be different between the two then this can be
> > reevaluated?
> >   
> 
> Or I can assign thresh_period to falling and rising corresponding to
> close/far debounce. Seems that the direction is the same, but that can
> be split apart and each direction gets a different sysfs file?
Ah I should have read on.  Yes,
thresh_falling_period and thresh_rising_period is fine.

Jonathan


