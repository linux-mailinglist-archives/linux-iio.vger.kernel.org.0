Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CDC1D9D1B
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgESQon (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgESQom (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 12:44:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84672C08C5C0;
        Tue, 19 May 2020 09:44:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so143679wrn.6;
        Tue, 19 May 2020 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VqC8rxTTkCeV8e6ysDgNotLUcsV868zIffxxJilbTVg=;
        b=YWyV3xqfslc9r+swGji8dPqRm1Lfbv3kwe/eMh0BbjbO+6H5AF2bcnTJ8UEqFbe6mx
         EQkaJ8rJYEmXKxSVFIorQsPnIp6mDtoedIxYUCRoglAfoj2wEbyNU3p/I8XOAqnvtOwS
         LEqIQTJtyKttjObDOojC9GqgiNJksXGQN8dd521h9IZjpueNsCFSbvAwrbVzZ1qD8tpB
         oTcvLk2IEZ/OW6VpyiOXrGxRflwQeWI9icXheaUSVFWXKEQJ/Ewa9QgIVHw3vKt+ethK
         FGT/mLWh6jEcab3W2YWKrsmyFjAIuWnHhTNjtwJVU7d+pqMgfJuRSU2E7kzhaHOXSaW9
         FiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VqC8rxTTkCeV8e6ysDgNotLUcsV868zIffxxJilbTVg=;
        b=Zx/TVhMvHLSDkci/pVsLjZRv4cx3DwDhWKAl68PvI4cQ9ct6O7CsY0rkDZWZc4OCj2
         4gbzkv/yhgzjSzVWHqNXaQPkU/U/iyb4/aDdNEdVYma0IdnS44V3skWsoR+BlY3E7Ny4
         hBXm1gHBg33x0DptWcMoTjkeDfvAC56Mw8t+Nj2tEmHp3xEFQIiCQbrWQw3OSvQ0kwye
         WSW86EnabzgTAn4e7r85h8GdDPY2rFOTXJVNTc1wjyvBDpUry7OoUXplgK3erhBcH6EE
         SuXXqYUrny1nuffgOouRB4FUEuYWRnj0RnpCD4J8k50xh7PWiEt736QPodOi0CJ8hX30
         Rs6w==
X-Gm-Message-State: AOAM532XYrEBygJc0AyndQLe6Qs0aUqov+eAjvoKpaGx4ZugP5s4Qub3
        DBVLk6VY8CZvXGkb2YPslTg=
X-Google-Smtp-Source: ABdhPJwSe6JzoKEGUpPYAynD9BDmuOFYIj6qReIqYmiaR8ffpFG20UDn7uYCl9Ig5eN+Td+tCyjfhw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr27357671wrt.185.1589906681081;
        Tue, 19 May 2020 09:44:41 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id j190sm271138wmb.33.2020.05.19.09.44.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 09:44:39 -0700 (PDT)
Date:   Tue, 19 May 2020 18:44:33 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200519164433.GA8726@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-2-jonathan.albrieux@gmail.com>
 <20200519132207.GA4623@gerhold.net>
 <20200519140354.GB30573@ict14-OptiPlex-980>
 <20200519160137.GJ1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519160137.GJ1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 07:01:37PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 04:03:54PM +0200, Jonathan Albrieux wrote:
> > On Tue, May 19, 2020 at 03:22:07PM +0200, Stephan Gerhold wrote:
> > > On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:
> 
> ...
> 
> > > > +maintainers:
> > > > +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> > > 
> > > Should probably add someone here, although I'm not sure who either.
> > > 
> > 
> > Yep I couldn't find a maintainer for that driver..what to do in this case?
> 
> Volunteer yourself!
> 

While I'd really like to, I have to decline the offer as I currently don't have
enought knowledge to become a maintainer :-) but thank you! (Who knows, maybe in
a couple of year!) Now I'll make the final edits and will submit a new
patchset soon with all the changes

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Jonathan Albrieux
