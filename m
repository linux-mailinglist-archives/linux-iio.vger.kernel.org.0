Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84D2AAC07
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgKHP4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHP4E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:56:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295D420B1F;
        Sun,  8 Nov 2020 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604850964;
        bh=scJd3tD3NXcxSWH4agUabxrb8sw63GVC66pSKDi2NX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mtxnBnnG4q4z4RmaAZ9aEK1MQKa5cAYQ5ECm+LQoBv3PGk/O9Ooq9u9d2BmxsbTpp
         CcO14ac5m1TBtNodB6IMgieD+RuJBqdSKR/dsjz6vxT1HAjuTV1vuacnSgVSwUqFo5
         Mx0fgSvubgj5qRzZKkHpcWpoY+9fNSzt3ATE0Ttw=
Date:   Sun, 8 Nov 2020 15:55:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 24/46] dt-bindings:iio:magnetometer:asahi-kasei,ak8974:
 txt to yaml format conversion
Message-ID: <20201108155559.4f28cddd@archlinux>
In-Reply-To: <CACRpkdYTn59+NJm1f6cYfAZU9+9UaPE5PFbCMMDCcTVO3jbMdA@mail.gmail.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-25-jic23@kernel.org>
        <CACRpkdYTn59+NJm1f6cYfAZU9+9UaPE5PFbCMMDCcTVO3jbMdA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Nov 2020 15:47:56 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Oct 31, 2020 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simple conversion.  I have pruned descriptions that did not add much useful
> > detail.  Note that the mount-matrix description will form part of a generic
> > IIO binding.  No need to repeat that in every driver that uses it.  
> 
> Writing the mount-matrix YAML binding is going to be interesting!

Would be amusing to try and fully constrain it to a valid rotation matrix
but for now it's a 9 element string-array.

I'm planning to move the huge amount of documentation to the main docs rather than
bury it in the dt-schema repo.  I'll probably add some cross references
so people have some hope of tracking down that doc.

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

