Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B6410C8F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhISRKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhISRKS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:10:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DF461028;
        Sun, 19 Sep 2021 17:08:49 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:12:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Mihail Chindris <mihail.chindris@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] Documentation:devicetree:bindings:iio:dac: Fix
 val
Message-ID: <20210919181231.67ab39c8@jic23-huawei>
In-Reply-To: <CA+U=Dsp+p+s9sv1jGh0QPMvoyGtqZn11p+Wtrm-NOKSFWt7AZg@mail.gmail.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-6-mihail.chindris@analog.com>
        <CA+U=Dsp+p+s9sv1jGh0QPMvoyGtqZn11p+Wtrm-NOKSFWt7AZg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Sep 2021 10:53:02 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Sep 17, 2021 at 9:08 AM Mihail Chindris
> <mihail.chindris@analog.com> wrote:
> >
> > A correct value for output-range-microvolts is -5 to 5 Volts
> > not -5 to 5 milivolts
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
+CC DT maintainer and list.

Please provide a suitable Fixes tag.

Thanks,

Jonathan


> 
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > index d5c54813ce87..a8f7720d1e3e 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> > @@ -54,7 +54,7 @@ examples:
> >
> >            ad5766@0 {
> >                compatible = "adi,ad5766";
> > -              output-range-microvolts = <(-5000) 5000>;
> > +              output-range-microvolts = <(-5000000) 5000000>;
> >                reg = <0>;
> >                spi-cpol;
> >                spi-max-frequency = <1000000>;
> > --
> > 2.27.0
> >  

