Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0B435080
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTQre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 12:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJTQrb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 12:47:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906E761355;
        Wed, 20 Oct 2021 16:45:14 +0000 (UTC)
Date:   Wed, 20 Oct 2021 17:49:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>, kernel@axis.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/3] dt-bindings: iio: io-channel-mux: allow duplicate
 channel, labels
Message-ID: <20211020174932.3d315769@jic23-huawei>
In-Reply-To: <YW833Ty3IwyBrKD3@robh.at.kernel.org>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
        <20211007134641.13417-3-vincent.whitchurch@axis.com>
        <815d858d-3c67-c184-2413-9d6b487a853e@axentia.se>
        <YW833Ty3IwyBrKD3@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 16:25:49 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, 09 Oct 2021 00:11:30 +0200, Peter Rosin wrote:
> > This is needed since an empty channel label is used to indicate an
> > unused channel, and there can be more that one of those.
> > 
> > Fixes the following problem reported by dtbs_check:
> > envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
> > 	arch/arm/boot/dts/at91-tse850-3.dt.yaml
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

4 + 5 applied to the togreg branch of iio.git and pushed out as
testing for 0-day to give it a dry run.

Thanks,

Jonathan
