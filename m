Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1356B45B0F6
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 01:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhKXBBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 20:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhKXBBu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 20:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637715521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+AOGJqzXkRjiPKKyc56m1ImTVIuHv8K9Go66drprd4=;
        b=Py0b3rcqw8cjt2S9Ma+YIoxGucwaaAksiOUidg1kglo5e6ZSmwJYx3FZEtaJydinqN6sSK
        6t8yu1Euh4lK/xb5uYafl6YOjFzQn/gSkbk++UxIx1dEEliYZ+TQn6Pb6wEebcRYWR/zo9
        HxgrZxgWEn+WmYjOK7Nz/PdDxU/7Rqk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-IcB6hjpAO8aSm-7VjVWgdg-1; Tue, 23 Nov 2021 19:58:40 -0500
X-MC-Unique: IcB6hjpAO8aSm-7VjVWgdg-1
Received: by mail-qv1-f71.google.com with SMTP id g12-20020a0562141ccc00b003c0322ea7b6so620677qvd.19
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 16:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+AOGJqzXkRjiPKKyc56m1ImTVIuHv8K9Go66drprd4=;
        b=Xob9Jo+0VGyOEeoL2uh/E6fAJno28T9DYoPWktrjfeFQN+X/Iatwh+5up0Rdykaiv6
         biCzEuRPTjmsnyNDIKbSR7L/dNSYJy82vGVcvFlPxoGudVwml7RkBumNsc2S10ihQZ7j
         tgx3J/66kycvAnMs1vYKQ6Q3AkForT5TflxKVPLJUmTGQA8M0B1sH3Zg2OQvhnjLr67n
         zcDKiiHJM1VK9eLawne9gH7aFGcEEzHf8xAbsZNjzxqatNujlMIMpe0Jl7ZZ4Zv1Rwc1
         XxU+1TQ47cZw06891uVUNhUwliGtEdoNBdaJywjqXfiYBozoYtm9U7SIkdeshHr5Pwj1
         osDQ==
X-Gm-Message-State: AOAM531LZ3VWkXA7XOezVT6bvTRBk12dmrsPG1s78eUeL6mee+IY3Tu1
        t416bF7A9g1aAomnivaUBXL4VWH3m+yRlMe4kPGa4Vi3AWdS9TJX8PEur2JYLwJ9JduP0bVIdiq
        Grug3ae6mCJJ5M88lk+0C
X-Received: by 2002:a37:9244:: with SMTP id u65mr1857804qkd.46.1637715519549;
        Tue, 23 Nov 2021 16:58:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnwKvChimrTt548vjsEc06cmy8TXp1un48zvKQn5P9bU6ZC8gKPT2WU6NcOU/tQvM7IHAOiQ==
X-Received: by 2002:a37:9244:: with SMTP id u65mr1857781qkd.46.1637715519351;
        Tue, 23 Nov 2021 16:58:39 -0800 (PST)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id u21sm7194985qtw.29.2021.11.23.16.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 16:58:38 -0800 (PST)
Date:   Tue, 23 Nov 2021 19:58:37 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martijn Braam <martijn@brixit.nl>,
        Maslov Dmitry <maslovdmitry@seeed.cc>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
Message-ID: <YZ2OPcfTluJbJEqb@x1>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 09:09:30PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note this series includes many drivers that are quite old and I'm not
> sure have active maintainers.  Hence if anyone has time to look at some
> of these beyond their own drivers and sanity check them it would be much
> appreciated!
> 
> Two motivations behind this set.
> 1 - General code reduction and improvement in readability in these drivers.
> 2 - Reduce change I'll have to ask people to change how they do this in
>     future patches.
> 
> Mostly this is just a case of letting the compiler work out it can remove
> the PM related functions rather than using #ifdefs in the code to do so.
> 
> The __maybe_unused markings make it clear we are intentionally building
> functions that the compiler can see are unused and remove in some build
> configurations.
> 
> The new pm_ptr() macro is rather convenient to got futher than many of
> the drivers were and when CONFIG_PM is not define ensure that the
> struct dev_pm_ops can also be removed.  Note there is a subtlty in that
> we only remove that whe CONFIG_PM is not defined whereas a few of these
> drivers were using CONFIG_PM_SLEEP which is a tighter condition (will
> remove the structure in more configurations).  I think that's a small
> price to pay for the convenience this macro brings.
> 
> I did this set as one patch per driver, as personally I prefer that
> option for all but the most trivial patches because it makes backports
> that cross with this series simpler and also avoid the complex
> tag giving we get for sets touching code from many authors.
> 
> All comments welcome.

Nice cleanup! Assuming that you add the missing pm_ptr() to patch 2
(iio:accel:da280) you can add this to the series:

Reviewed-by: Brian Masney <bmasney@redhat.com>

