Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076191DB70D
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETOaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETOaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 10:30:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA62BC061A0E;
        Wed, 20 May 2020 07:30:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 142so3714352qkl.6;
        Wed, 20 May 2020 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnlZoevgT2PApLtssSG5/dDA/6NMSDx5IuYHuh8rwQQ=;
        b=qGcAh6zKpxjPoqmOHri3tXoMSOSyjaMG9ePXTwJBItYxsEIB6i1R9UAXx4KrVWcFbB
         pS+BDbRLq08x3uozXcjZf0xUZSa6XDlyhA67H2IYsxj3VZRFA8sATk3O9C/QJV+ipVO3
         zFppRGiOu4JDc4UtTkumPi0BB4ytaMqXlwX2pEXGRD5Tj2AIRY2ZxLdm9oXasnAFmUdz
         C5eB7YatIYW3oYH+xyBufZA7c2keh26EkYQ6u+zie6QfjdAsrTi38gpNEVS4Z0VAm+qz
         sPKYwv3VjnrcAT/yCwcfElaKpQ871WKU2VSLHyOqKoVaBSCi7VJ1TMqkgw39xEjn1+MY
         YCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnlZoevgT2PApLtssSG5/dDA/6NMSDx5IuYHuh8rwQQ=;
        b=TyyZzYpZxkAfDvo0b/Ug7CFGwnX7XM9e1CnAm9SylLawVROJlv9rYMgyuGCrKp67aX
         U/ZjRQda1craPgeB1s79k6Pnnp/ixF27FHTtqSXIIynTZoNFeVSB4DvWG58WnhOj4L+f
         1E/QcB1HnglowaA8FQnVmoQhXwH5/Bj0Q9lybJQWvC40vL4JMd965F1KghykwInTNc30
         o4TpkY8DAk2ajDQ7h1leYZfm0HhqTHwr8USBY8IahuH4svV/aCcdF0GegNw/pAXNf4hF
         ZcgBujDv9zOdUDzza5yjd7Roca54o9eMCOWRf/s31kAexMMSNPnxaWzxThrYn1KFl1uD
         V/6w==
X-Gm-Message-State: AOAM533XwSMnzArhFdu7l+XC/eOzhLvlx5pEWZA/kip9DvpwR/huAPe2
        GNQGlkKp7OfGyxQ72kxadkw=
X-Google-Smtp-Source: ABdhPJzA6/XHH/E6E8lr686JCngM6pwIMIniACTyHxdAXyEDE3MaXy/JRhRp2sZiDeEhGG9f7XYdDw==
X-Received: by 2002:a05:620a:1379:: with SMTP id d25mr4972883qkl.173.1589985008726;
        Wed, 20 May 2020 07:30:08 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id n7sm2347513qtr.40.2020.05.20.07.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 07:30:07 -0700 (PDT)
Date:   Wed, 20 May 2020 16:29:50 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Allison Randal <allison@lohutok.net>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200520142950.GA22222@ict14-OptiPlex-980>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
 <20200520073125.30808-2-jonathan.albrieux@gmail.com>
 <CAHp75VcWBe=3j68t9pmRk=xigsym_f_EHG4HLLKe_cmQi5E6mA@mail.gmail.com>
 <20200520134416.GA6875@ict14-OptiPlex-980>
 <20200520135401.GS1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520135401.GS1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 20, 2020 at 04:54:01PM +0300, Andy Shevchenko wrote:
> On Wed, May 20, 2020 at 03:44:16PM +0200, Jonathan Albrieux wrote:
> > On Wed, May 20, 2020 at 11:23:18AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 20, 2020 at 10:32 AM Jonathan Albrieux
> > > <jonathan.albrieux@gmail.com> wrote:
> > > 
> > > > +maintainers:
> > > > +  - can't find a maintainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> > > 
> > > Alas, you'll never go forward with this.
> > > One (easiest way) is to drop this patch completely if you won't be a
> > > maintainer of the binding.
> > >
> > 
> > That's too bad. How can I be a maintainer of the binding?
> 
> Put your name there as Jonathan and me suggested. :-)
> 
> maintainers:
>   - Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Ok I'll prepare a new patch then :-)

Thank you!!
Best regards,
Jonathan Albrieux
