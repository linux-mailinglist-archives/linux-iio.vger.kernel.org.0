Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BC124EC8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLRRFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 12:05:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35403 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLRRFR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 12:05:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id f71so3323076otf.2;
        Wed, 18 Dec 2019 09:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PD5U+2SR2S3PBby+YHCi7p7S30Rgc2SUwgngBgYddnU=;
        b=X1sVbjbzh60L/tQBVM2PZz/pLPMbOIZwofd3lcPO79rYmFU9HhJV7w+34Wd/w5TB//
         jnaBkFkroGcp+XJsz/5IkEKT+lc3DkgFngH6q8sbcF+MxXL0esz1WRknKF8gB3a55dRv
         Mr1UNJb8RFY9G8gkbHwNnG+aPDpj9dqgZNbwGFIeAEdr0l43eSOcif5+HI/SfhFdeqFl
         CAG8okUdvT5LH9gArkkWkFy/qJOSd23OCaCO9cK/XxzWCn/0ttArmGUkiFFlgAPGwBbC
         6kmFDlNUmZTH0BZEfxe0wLu8Mo3A+kkhnIKlp8Nzi34akdRF2LS2JA9QpKtnjedf9y5C
         zCRA==
X-Gm-Message-State: APjAAAXl6mFXlCe/DdG5Azm03VhuDmTUsE9GAlGSf8J+Mmtn7vH65uLn
        mXotap4v/PpNUeO9KsK7xw==
X-Google-Smtp-Source: APXvYqxbyyHqkZAVE/BxQQwoPuYT4HycoQIdeZzY8ADptumdL0UmuvCMqhFfuh9KGGrSQ4QujtqKgw==
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr3725268otq.75.1576688716753;
        Wed, 18 Dec 2019 09:05:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j20sm984444otl.5.2019.12.18.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:05:15 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:05:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
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
Message-ID: <20191218170515.GA18325@bogus>
References: <20191211010308.1525-1-dan@dlrobertson.com>
 <20191211010308.1525-2-dan@dlrobertson.com>
 <CACRpkdb9O7RjpXdUPCtN1M+PLC+2hPomhsw2Q5Ehhg4pEVOStQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb9O7RjpXdUPCtN1M+PLC+2hPomhsw2Q5Ehhg4pEVOStQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 12, 2019 at 11:16:47AM +0100, Linus Walleij wrote:
> Hi Dan,
> 
> thanks for your patch!
> 
> On Wed, Dec 11, 2019 at 2:20 AM Dan Robertson <dan@dlrobertson.com> wrote:
> 
> > Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> > accelerometer sensor.
> >
> > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> (...)
> 
> > +  Specifications about the sensor can be found at:
> > +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
> 
> As can be seen in page 113 in the manual this component
> has VDD and VDDIO supplies and sooner or later someone
> is going to have to model that so I'd say add vdd-supply and
> vddio-supply regulator phandles as optional to the component
> already from start.

And interrupts too. Doesn't matter what the driver currently uses.

Rob
