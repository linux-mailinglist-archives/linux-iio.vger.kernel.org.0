Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC893456EA
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 05:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWEj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Mar 2021 00:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWEjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2021 00:39:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC13C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 21:39:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x26so12985271pfn.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uw4ibmKuahlIUNACHg5Vg8iFdqbYKu+LzF/GoRIS8O4=;
        b=B02H+FUdDGCbu65bs0d8Tk1ERYX+HTMzqwx7p5hyPfWUBw9Th9lAnM/poTCS9pDUzQ
         cXbeb+v+VhMcUSJj3/IIGxJVlyEUbz5McIL91X5tsrG7y2sMIzjUbZraS7j1tNIlkXrg
         8Y9Qhi/YiTJv9PhOURzZIiK8OskhnrKzmTOnGmODpt42Z4y6zknopZBXZYQMPll36fVH
         AotRvtYQTVRzATUUkCQIHeBnJ+POhxyuBPKjEY2CuUNboOGmMRJxuyXmg5Fr5uCB0pFE
         rkZT8bvxHkwPNYDA4uUQZn7KPstVh+GuU4RGnLPRKLhiJJdHVC49TssvuhB0E5C5Cs5N
         Uwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uw4ibmKuahlIUNACHg5Vg8iFdqbYKu+LzF/GoRIS8O4=;
        b=oT3Etzxj+DsXTQO3087ez3WTcwaKFXfwkrJoxdARe4yDs7J5vSDCUVNsNqMQFK9auQ
         szgjg07Fu3c4u5uSMP2zKiQH/tO8rMPDGwuGoMSIMjo0So3+nF2WEmP/teMm02oQtmvb
         IdzWZuzXq0nJZK2O0dQkOwyor3PT/kTwniGcWwqqmDXd0gNh/YevAmmRFhoNpxNrAPMH
         DA7ERRko4TRXUWn39xU2WrAJX8ajLJiYC+kjmhHiPpk2BdQn07Kik9ao3gQkzMYY1BtL
         3A93jGH90FYOE+m+FS9YPaoMWOAX02iZ3R06AyD1ODhIb75dj3gbj1y2gIV3BGwzVRdG
         TR8A==
X-Gm-Message-State: AOAM533yqImQCOIcgZbLSgwSiAPPz4tvdMg9ncApgZaZxGRVo0z9jOYW
        9BeGz7g6OMtAiwklyKw/XYe/VgvCLvYz8/dE
X-Google-Smtp-Source: ABdhPJzq+VFWqgIRHxh2NnwDHnXr5SHdUFs7lX6jOpzZVs+zcYt/35tArP6E/1f9113aBossBg7C4w==
X-Received: by 2002:aa7:848b:0:b029:1ef:4e98:6bb6 with SMTP id u11-20020aa7848b0000b02901ef4e986bb6mr3018304pfn.58.1616474359853;
        Mon, 22 Mar 2021 21:39:19 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:75f9:d347:f722:e669])
        by smtp.gmail.com with ESMTPSA id p17sm907656pjv.49.2021.03.22.21.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 21:39:19 -0700 (PDT)
Date:   Mon, 22 Mar 2021 21:39:17 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org
Subject: Re: iio: adc: anyone working on TI ADS7066?
Message-ID: <20210323043917.GA517382@x1>
References: <20210320035234.GA95301@x1>
 <20210320182609.5e4e7f3c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320182609.5e4e7f3c@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 20, 2021 at 06:26:24PM +0000, Jonathan Cameron wrote:
> On Fri, 19 Mar 2021 20:52:34 -0700
> Drew Fustini <drew@beagleboard.org> wrote:
> 
> > I have a board with a TI ADS7066 8-channel ADC [1] that I want to get
> > working in Linux.  I see there is already driver support in iio for
> > ADS1015, ADS79xx, ADS8344, ADS868x and ADS124S0x.
> > 
> > Is anyone already working with the ADS7066 or a similar part in that
> > series?
> > 
> > If not, I'll take one of the existing TI drivers as a template for the
> > ADS7066 driver.
> > 
> > Thank you,
> > Drew
> 
> Hi Drew,
> 
> I've not seen anything for this part.
> 
> From a 10 second glance at the data sheet I see it's capable of
> ADC / GPIO on each pin.   If you plan to support that functionality
> at somepoint make sure to define dt bindings and similar to specify
> which channels are enabled and dynamically create the iio_chan_spec
> array to match.  It can be a bit ugly to retrofit later.

Thanks for the feedback.  The GPIO functionality is not used on the
custom hardware that I have, so I am thinking I would only implement
the ADC functionality.  Is that too short sighted?

> Oh. It does daisy chaining as well. That is always fun to support
> though I guess you may well not have it wired up to do that.
> Oversampling as well - though that looks nice and simple for once.

The hardware I have has two ADS7066 wired up in parallel so I don't
think I would be looking at implementing dasiy chain initially.

Is that ok just implement what I am actually using or is the preference
to have a driver implement all the latent functionality before it would
be merged?

Thanks,
Drew
