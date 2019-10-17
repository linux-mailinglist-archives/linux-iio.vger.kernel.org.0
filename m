Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC14DB8E6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395060AbfJQVWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 17:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbfJQVWo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:22:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3A821835;
        Thu, 17 Oct 2019 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347363;
        bh=QPHojZxZwh6JkjwJnMxcwscYkRcsDB6akLK+CAlFzec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xpHNkUXk6D4cIqsWk/XgRHOVABOLAo7dM3fd/D728cS+wTT5SW7GQYlfP2RmcFooQ
         PjetuBxgPa6YDN9I2RRY6VQRtQ7S1m9nJAPXwskP/Zk/deO2DvZ408nEcEe2sIkKtU
         g1dxcBo62fghkY2zLCY3xRD5FXfqWwgkgIqV0mts=
Date:   Thu, 17 Oct 2019 22:22:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7 v4] mfd: ab8500: augment DT bindings
Message-ID: <20191017222238.673cd60b@archlinux>
In-Reply-To: <20191011134449.GA12969@bogus>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
        <20191011071805.5554-6-linus.walleij@linaro.org>
        <20191011134449.GA12969@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 08:44:49 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, Oct 11, 2019 at 09:18:03AM +0200, Linus Walleij wrote:
> > As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> > the bindings to account for defining the ADC channels in the device
> > tree.
> > 
> > Cc: devicetree@vger.kernel.org
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v3->v4:
> > - Fix the nodenames from "foo_node" to "foo-node"  
> 
> You forgot to update the example. With that fixed,
Given the number of these, I'm not that comfortable just
fixing this up.  Linus could you do me a follow up patch tiding
up this detail.

I don't want to delay the immutable branch any longer and
would hope the bindings are stable enough that no one will
need this little update in their tree as well as mfd 
(or IIO if Lee doesn't pick up the immutable)

Thanks,

Jonathan

> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > - Remove 0 prefix from @0n to @n
> > ChangeLog v2->v3:
> > - Change "adc-channel@" to "channel@" as per preferred notation.
> > - Add some full stops to the end of sentences.
> > - Reference the new ADC-specific documentation for channel specifier
> >   etc.
> > - Collect Lee's ACK.
> > - Rebased on v5.4-rc1
> > ChangeLog v1->v2:
> > - Rebased on v5.3-rc5
> > ---
> >  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
> >  1 file changed, 119 insertions(+)  

