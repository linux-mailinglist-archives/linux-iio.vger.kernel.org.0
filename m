Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A51A7F35
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbgDNOIZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 10:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbgDNOIV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 10:08:21 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E7D20578;
        Tue, 14 Apr 2020 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586873301;
        bh=/CZzkResPf7E6hFzJrBZJpNXxg20WuFvxi09S+Jl+kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXrG9szbWzZ5+DwgtEzkXznw9odEhttqrZKiFSwnf/FMDGvPw0zy1UkmnbKQDArDu
         EScbiV+INt+/GnPfqiVz6VkmXKSltccDN+TejgOMSzSsyby9mwgPj2mHFKabDUybFq
         AaQA0t8DAZywA46W81/T4L0HBmqVcLJJmsEXhyGI=
Date:   Tue, 14 Apr 2020 19:38:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: chemical: Add binding for CCS811
 VOC sensor
Message-ID: <20200414140808.GB29491@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-2-mani@kernel.org>
 <20200414132717.GA15437@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414132717.GA15437@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 08:27:17AM -0500, Rob Herring wrote:
> On Mon, 13 Apr 2020 00:06:56 +0530, mani@kernel.org wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > This commit adds devicetree binding for AMS CCS811 VOC sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  .../bindings/iio/chemical/ams,ccs811.yaml     | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Error: Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dts:24.38-39 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1269473
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 

Ah, sorry. I did run 'dtbs_check' but forgot that it won't report errors in the
binding schemas.

Will run `dt_binding_check` hereafter.

Thanks,
Mani

> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
