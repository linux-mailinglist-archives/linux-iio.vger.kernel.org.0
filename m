Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDEB270E2F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgISNm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgISNm4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:42:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2A1208B8;
        Sat, 19 Sep 2020 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600522976;
        bh=EZ+P2TMRz3IYrbfRhm1PiziRs2gvuRjj0G2ZkynsCq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N919UunM7/JNEHcxXX+k4KbF3G/MV9YuEe01jjRNkn1R2QDR0OVOAqWQ7ZDN/J0HW
         JOMG4dQq7wPU/6ikxttgV0E1B3R1WHuwU9YHOMkeuw4ppT+mravsXpwaXtIjjKlSv2
         iwTrENt3OWrFk2sAWQcLX5ZN58RAuwjrwrZsDAXs=
Date:   Sat, 19 Sep 2020 14:42:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/20] dt-bindings:iio:adc:ti,twl4030-madc yaml
 conversion
Message-ID: <20200919144252.15e7bb7f@archlinux>
In-Reply-To: <20200915190108.GA2313284@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-3-jic23@kernel.org>
        <20200915190108.GA2313284@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:01:08 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:28 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Conversion from txt to yaml as part of a general move of IIO bindings
> > to the new format.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Sebastian Reichel <sre@kernel.org>
Applied. Thanks,

Jonathan

> > ---
> >  .../bindings/iio/adc/ti,twl4030-madc.yaml     | 48 +++++++++++++++++++
> >  .../bindings/iio/adc/twl4030-madc.txt         | 24 ----------
> >  2 files changed, 48 insertions(+), 24 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

