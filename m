Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A13270E69
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgISOM1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOM1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:12:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7342085B;
        Sat, 19 Sep 2020 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524746;
        bh=fKbtO5wb4DXVnj6NUy2cvcKObNdGrHEtYsuuIhAXqb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jYWJMfhdB0LJEHLdw8RiW5/QYvU6VARZbt6i4VDoHmRTykLbQBFhZV6GKVI2eLeZW
         QT/28V8d0eHhtLVHfvbtoqyZP8GHJgzDw7HpW6qnJelWHyZJGbwqq+1t3Ug2XxJKTy
         PTcHm06bK3gk9QQ2hmE5hsffgE1KlNehutRpIFlM=
Date:   Sat, 19 Sep 2020 15:12:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 16/20] dt-bindings:iio:adc:ti,ads1015 yaml conversion
Message-ID: <20200919151221.49d3ceed@archlinux>
In-Reply-To: <20200915191658.GA2339714@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-17-jic23@kernel.org>
        <20200915191658.GA2339714@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:16:58 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:42 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This binding was moved over from hwmon some time ago so is a bit
> > unusual in terms of IIO bindings.  However, conversion was fairly
> > straight forwards.
> > 
> > I've listed both Dirk (who think wrote original binding) and Daniel
> > who added the IIO driver for this device.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Dirk Eibach <eibach@gdsys.de>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ads1015.txt   |  73 -----------
> >  .../bindings/iio/adc/ti,ads1015.yaml          | 113 ++++++++++++++++++
> >  2 files changed, 113 insertions(+), 73 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Dropped Dirk as maintainer on this one as I don't have an up to date
address.  That leaves Daniel as the sole listed maintainer.

Hope that's fine!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to maybe run some tests on it.

Thanks,

Jonathan

