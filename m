Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA7270E4D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISOD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOD1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:03:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70F321481;
        Sat, 19 Sep 2020 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524206;
        bh=5H+kZp7w2EpfoW58pTv2wQpSgZtpe+WgUF7CWW6OXIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yuX6+qZY3BPfsRPs/GmLoEwxAzwyN/eIId4I+TTSX9UWJA+UXkRkUdg33UrjC0qis
         IEvlPKfhu8MIDCI1Y4/Fev0yLQF4OKYY6TMsQl4E9dvIE42A2qVB271viFJIJnzNfQ
         jdzM7eAICzL2NLFvV9DZnYL6VVBUgELheJ6m00F0=
Date:   Sat, 19 Sep 2020 15:03:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings:iio:adc:nuvoton,npcm750-adc yaml
 conversion
Message-ID: <20200919150321.36fa5dae@archlinux>
In-Reply-To: <20200915190724.GA2323735@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-9-jic23@kernel.org>
        <20200915190724.GA2323735@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:07:24 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:34 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Renamed the file to reflect the only compatible.
> > Added #io-channel-cells to make it easier to support consumers of the
> > ADC channels this device provides.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,npcm-adc.txt     | 26 --------
> >  .../bindings/iio/adc/nuvoton,npcm750-adc.yaml | 64 +++++++++++++++++++
> >  2 files changed, 64 insertions(+), 26 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to possible poke at it.

Thanks,

Jonathan
