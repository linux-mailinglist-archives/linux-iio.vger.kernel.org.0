Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45B31E0C3B
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgEYKx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 06:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 06:53:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1CC061A0E;
        Mon, 25 May 2020 03:53:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r3so7889560qve.1;
        Mon, 25 May 2020 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tm3Go7vlJDeWhXTFLsUD2Etyj1ppGrFIkUDns+ap1rs=;
        b=TEJn7fytMxwiwk/IDTfV+jOUDjw28Ean0pawpZJ7O11nveJmrbmJPoHR6PrdgWVWdn
         y/8MiD2Zc/FCdXFH95FbAERR8tVjZIfBfw+UC2N3aMX1NInAFjbHzsc9yQxBez+aEawg
         +SOpdpSAVMZ+LP5lN2WbSmmx7aO0eSQYz1Vh6LoJc0XRNpf/CC3rMvs7X8m2h5qbIiRC
         ObC7GDrdji3HgynDDOOpv3d+1+2d38ghHcrVn9AhSVFRscLBioleRKE9oG+DoGaC5Gq+
         tcVzQ+07FErdbEv1WwBZqE20bTBfqpDfiTN66kDVqLRx+xvNCNp8lQFEkqM3Rvl7AXNq
         O/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tm3Go7vlJDeWhXTFLsUD2Etyj1ppGrFIkUDns+ap1rs=;
        b=VCOcuc5FoR461bw7sTR3eZr90bqMNpITHYBHcCPZi0uPL9Ql5kukkF4vB+NMMpxwRm
         bihmVBA5R3Kpoyk9wLsatYY+FZs5Qq6rWFtiov1QIfsqemMYI7niUXJkxfpNXXtPT27i
         DsSpnHleEgb7+oxnpMxELjVQtIJkWu4AxFIhGWC9uqMjbpkWcE+T+lnUk4OADGT5aWq+
         rVUBvRsVOEm5HbogPcg7UlsOIdikfS9isblZlk05wA+zMbeFJUgYtdjXSTjpoJ4ajAYV
         5HgnlOikGoz6S/PcbJ0MAVbG5mgb2P1Rt0zOg4ZqP4RS6Mhl9WAf/Gg1n4uSeoFqCcfu
         aDuw==
X-Gm-Message-State: AOAM530gODLxXvSFpDOyp9AvZCVK17cPfjeCzTsP7uMGk7t6m3xFi8/J
        JeeiYsMD6W07z8FLcTIk//E=
X-Google-Smtp-Source: ABdhPJxmxS4+SVnH/5iUVhzSIPk2ZBFcYygdBgO6pQ/xxa9Fhqm4xZQ+a0yFcdQ9biP1tFVfO2HMxA==
X-Received: by 2002:a0c:e9c9:: with SMTP id q9mr14886070qvo.215.1590404006285;
        Mon, 25 May 2020 03:53:26 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id z10sm15054624qtu.22.2020.05.25.03.53.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 03:53:25 -0700 (PDT)
Date:   Mon, 25 May 2020 12:53:20 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200525105320.GD18690@ict14-OptiPlex-980>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-3-jonathan.albrieux@gmail.com>
 <CACRpkdZrcie3Op2aLoTQgwT-2so+s2FqKn0R4B8VQ7qcxz2oCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZrcie3Op2aLoTQgwT-2so+s2FqKn0R4B8VQ7qcxz2oCg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 10:43:35AM +0200, Linus Walleij wrote:
> On Mon, May 18, 2020 at 3:37 PM Jonathan Albrieux
> <jonathan.albrieux@gmail.com> wrote:
> 
> > +  reset-gpio:
> > +    description: an optional pin needed for AK09911 to set the reset state
> 
> This kind of properties should always be plural, so
> reset-gpios please.
> 
> Yours,
> Linus Walleij

Thank you, will include this change in current patch version I'm working on.

Best regards,
Jonathan Albrieux
