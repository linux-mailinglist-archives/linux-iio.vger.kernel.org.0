Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41F1254B5
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRVcl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 16:32:41 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17135 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfLRVcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 16:32:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576704740; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fopuKl6X7nwuqbKIN0NWl80XmS0rVH50syK5VUYsTWgIZWPZ0fVWF6s8hwOO4Ev6JbB4Ut/rIIkrEq9J0PQMYp9v3T3j5wbYPPRX0mLCxxR37QruJoTMzM26A+jgY6IDn1xxd9AH9cdL5m9hCfJSH08u185LyDBVm2jJ9gTOGG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576704740; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZuWivZQNCjEIQTE0UeXySpEi24grBZCVk2N664VkHcE=; 
        b=HUEvAW1jikIq/hgWeBdAhP0UpwG6NiQFCeyR2RDdRPSR24encSMn7GwYu+rlNKhqCP3tDhymZpw+c39Hse4jSvNPDR+1RtNqEcTi17b3LnD3WGAY8P4fgMjgLTdQVbvA/SlpK29SswZEoGL/KPtiChi40BeFg+AGKMClXG+QLOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576704738019713.1804762581256; Wed, 18 Dec 2019 13:32:18 -0800 (PST)
Date:   Wed, 18 Dec 2019 21:16:48 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191218211648.GA4664@nessie>
References: <20191211010308.1525-1-dan@dlrobertson.com>
 <20191211010308.1525-2-dan@dlrobertson.com>
 <CACRpkdb9O7RjpXdUPCtN1M+PLC+2hPomhsw2Q5Ehhg4pEVOStQ@mail.gmail.com>
 <20191218170515.GA18325@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218170515.GA18325@bogus>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 18, 2019 at 11:05:15AM -0600, Rob Herring wrote:
> On Thu, Dec 12, 2019 at 11:16:47AM +0100, Linus Walleij wrote:
> > Hi Dan,
> > 
> > thanks for your patch!
> > 
> > On Wed, Dec 11, 2019 at 2:20 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > 
> > > Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> > > accelerometer sensor.
> > >
> > > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> > (...)
> > 
> > > +  Specifications about the sensor can be found at:
> > > +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
> > 
> > As can be seen in page 113 in the manual this component
> > has VDD and VDDIO supplies and sooner or later someone
> > is going to have to model that so I'd say add vdd-supply and
> > vddio-supply regulator phandles as optional to the component
> > already from start.
> 
> And interrupts too. Doesn't matter what the driver currently uses.

Will do. I plan to work on adding support for interrupts in a follow-up patchset,
but I'll add this to the devicetree documentation.

Cheers,

 - Dan

