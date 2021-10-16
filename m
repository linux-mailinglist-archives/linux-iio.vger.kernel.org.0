Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE70430389
	for <lists+linux-iio@lfdr.de>; Sat, 16 Oct 2021 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhJPPxt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 11:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhJPPxt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 11:53:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B2F60F70;
        Sat, 16 Oct 2021 15:51:38 +0000 (UTC)
Date:   Sat, 16 Oct 2021 16:55:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nikita Travkin <nikita@trvn.ru>, lars@metafoo.de,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, stephan@gerhold.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Document liteon
 vendor prefix
Message-ID: <20211016165552.680b2438@jic23-huawei>
In-Reply-To: <YWiS2J8qdrAitOUZ@robh.at.kernel.org>
References: <20211006163058.145842-1-nikita@trvn.ru>
        <YWiS2J8qdrAitOUZ@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Oct 2021 15:28:08 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, 06 Oct 2021 21:30:55 +0500, Nikita Travkin wrote:
> > Add vendor prefix for LITE-ON Technology Corp.
> > 
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git which is initially pushed
out as testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan
