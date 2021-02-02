Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB0730CDC4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhBBVLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 16:11:05 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42615 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBBVLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 16:11:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id f6so21245236ots.9;
        Tue, 02 Feb 2021 13:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACNCazD3MlpP5iMyo5wr9ychCe9RpGqKRslN6Q5WHUc=;
        b=Ckmg7jf0yCe2YuK5KFq/WMqbgwWpyAo/dbYEhOmEJSBTC0bohBjuSsF3ep7i4TZNYn
         FONaK0MuhOXBzYYyLaVaUwBcW/mjplSDH+ekdBekUpIA/i9WnRg5ue37L4Dmj3qq3D8C
         PkLSEUOa14w3/CXNdH0TfvtAYrvi7F/MUW87I9ARkSf2mBI4NpAbzsfJx3s3CP985cK/
         HAb0Xh/WD2qpL8rRMNajQ8scpwIEBkYk86+vW2cIpHDYCbXnIlliLQJv8HmTKWyq4Uhz
         XM0OlNguIuNvw9sJ5e7MxFcPkDTY1ClI4CvwLtyJr8nQM3M/+pKgUaH7hf5Tse8Odt0H
         LA9w==
X-Gm-Message-State: AOAM532e026xEpGUwbnJvo3mix4sbnnG9sYtt9KyXKgV5F+3Wg3mPJq3
        Eln4eEm4zjwYJEPIUNJsiA==
X-Google-Smtp-Source: ABdhPJwdWGH3TzTANI6O2oPwaPLSf2+UagT3svyTXUbTOwpxGp1B2Yg5ygEbEMiDWYEyyj089AI9ug==
X-Received: by 2002:a9d:6056:: with SMTP id v22mr17211306otj.266.1612300223844;
        Tue, 02 Feb 2021 13:10:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 93sm9002ots.36.2021.02.02.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:10:23 -0800 (PST)
Received: (nullmailer pid 47284 invoked by uid 1000);
        Tue, 02 Feb 2021 21:10:22 -0000
Date:   Tue, 2 Feb 2021 15:10:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: Add missing ad5686 compatible
 strings
Message-ID: <20210202211022.GB3706951@robh.at.kernel.org>
References: <20210202181427.3934218-1-robh@kernel.org>
 <efbfbb94-bf61-5503-9833-df23709f56a2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbfbb94-bf61-5503-9833-df23709f56a2@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 02, 2021 at 09:55:56PM +0100, Lars-Peter Clausen wrote:
> On 2/2/21 7:14 PM, Rob Herring wrote:
> > The example uses 'adi,ad5686', but the schema fails to document it. Given
> > the filename and there is a similar part AD5686, let's just add the
> > compatible strings including the 'r' variant.
> 
> There are two variants of this chip. One with a SPI interface and one with a
> I2C interface. This binding document only describes the I2C variants. But
> the ad5686 is a SPI variant.

Right, I should have noticed that.

> I think this is a typo and we should replace ad5686 with ad5696, including
> the document name.

Though we do frequently document both I2C and SPI variants in the same 
binding, given there's no existing SPI support and the example is wrong 
I agree.

> > 
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Michael Auchter <michael.auchter@ni.com>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > index 8065228e5df8..190919291828 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> > @@ -19,6 +19,8 @@ properties:
> >         - adi,ad5338r
> >         - adi,ad5671r
> >         - adi,ad5675r
> > +      - adi,ad5686
> > +      - adi,ad5686r
> >         - adi,ad5691r
> >         - adi,ad5692r
> >         - adi,ad5693
> 
> 
