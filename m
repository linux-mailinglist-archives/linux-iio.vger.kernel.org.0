Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B454182ED
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhIYO5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 10:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhIYO5A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 10:57:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A438610CB;
        Sat, 25 Sep 2021 14:55:23 +0000 (UTC)
Date:   Sat, 25 Sep 2021 15:59:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Devajith V S <devajithvs@gmail.com>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: kionix,kxcjk1013: driver support
 interrupts
Message-ID: <20210925155911.3860770d@jic23-huawei>
In-Reply-To: <YUx2DII/y3FVNF04@robh.at.kernel.org>
References: <20210919203656.119742-1-david@ixit.cz>
        <YUx2DII/y3FVNF04@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Sep 2021 07:41:48 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Sep 19, 2021 at 10:36:56PM +0200, David Heidelberg wrote:
> > Driver has interrupts support, which description was missing in the bindings.  
> 
> You mean the h/w has interrupts which was missing?
Tweaked to
Device has interrupt support, ...

and applied to the togreg branch of iio.git which is initially pushed out as testing
for 0-day to see if it can break it.

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml        | 3 +++
> >  1 file changed, 3 insertions(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

