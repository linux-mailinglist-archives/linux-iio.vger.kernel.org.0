Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E702916E4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJRKMD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 06:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgJRKMD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 06:12:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728CA21655;
        Sun, 18 Oct 2020 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603015922;
        bh=gLbxEEWfSmwUSe05MiWq3mo7ZfbPoHNGLJwjOIXi0Ns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mVb/p5PqtX1Ur4SDhPiSyPIfiP5qm7JC7p8dBJXufoqiLtKpDI6F5vvvuHUtpUIOb
         PjlBq1bmDfmhOzM6t5Pqmh91ljdhQOrO0y555RN2Ssv4QrvgkY/vqDKiIc1E78cZV4
         BoAzIafQAYoZn2EfHXVZMsya+e5wZoJL7pGXp+zk=
Date:   Sun, 18 Oct 2020 11:11:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: auxadc: add doc for MT8516
 SoC
Message-ID: <20201018111157.490962a9@archlinux>
In-Reply-To: <5ac4afb0-3950-3b11-1f5c-01bbf74e64a4@gmail.com>
References: <20201012205218.3010868-1-fparent@baylibre.com>
        <5ac4afb0-3950-3b11-1f5c-01bbf74e64a4@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Oct 2020 08:00:25 +0200
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> On 12/10/2020 22:52, Fabien Parent wrote:
> > Add documentation for the auxadc binding for MT8516 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>  
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it (or do nothing given it's
a txt file ;)

Jonathan

> 
> > ---
> >   Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > index 78c06e05c8e5..1b7ff9e5615a 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > @@ -17,6 +17,7 @@ Required properties:
> >       - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
> >       - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
> >       - "mediatek,mt8183-auxadc", "mediatek,mt8173-auxadc": For MT8183 family of SoCs
> > +    - "mediatek,mt8516-auxadc", "mediatek,mt8173-auxadc": For MT8516 family of SoCs
> >     - reg: Address range of the AUXADC unit.
> >     - clocks: Should contain a clock specifier for each entry in clock-names
> >     - clock-names: Should contain "main".
> >   

