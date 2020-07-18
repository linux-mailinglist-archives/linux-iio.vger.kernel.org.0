Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C798A224D00
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGRQ1k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgGRQ1k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:27:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDA12080D;
        Sat, 18 Jul 2020 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595089660;
        bh=6IXEM/Ew6XODAtUiOIC0Y7ZZ+5YYWMBMsAf6AGNt6NU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wuX/JIvwzWATp3/voXlQAF0+mBooQnUcPhpOgxqIhn6ZTIrV/09NGF/5KDgJCyfsH
         fxTnbPBalD5IKW2I3pECosi5CFpOFnI/gp0PjZjsBNy/0AhfCcyWJXhuOpdnZMjzS3
         8lmC0elV56CUdA9eumnc1RDTfMGAg7iFK9CpzgRk=
Date:   Sat, 18 Jul 2020 17:27:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: kionix,kxsd9 yaml conversion.
Message-ID: <20200718172736.3c92f8f0@archlinux>
In-Reply-To: <20200715202514.GA759901@bogus>
References: <20200628203205.49915-1-jic23@kernel.org>
        <20200715202514.GA759901@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 14:25:14 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 28 Jun 2020 21:32:05 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Convert and flesh out a bit the binding docs for this simple 3 axis
> > accelerometer.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > Sorry, typo in iio mailing list in first try at sending this out.
> > 
> > .../bindings/iio/accel/kionix,kxsd9.txt       | 22 -------
> >  .../bindings/iio/accel/kionix,kxsd9.yaml      | 65 +++++++++++++++++++
> >  2 files changed, 65 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.

Thanks,

J
