Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E6436B64
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJUTh3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 15:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJUTh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 15:37:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC3D6108E;
        Thu, 21 Oct 2021 19:35:08 +0000 (UTC)
Date:   Thu, 21 Oct 2021 20:39:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, peda@axentia.se,
        devicetree@vger.kernel.org, kernel@axis.com,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
Message-ID: <20211021203918.17cb8d68@jic23-huawei>
In-Reply-To: <c944fba5-9f69-e043-d4f6-3d30f1393190@metafoo.de>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
        <16fab3ba-5dd9-50b3-aeae-acd68b22dfae@metafoo.de>
        <c944fba5-9f69-e043-d4f6-3d30f1393190@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 09:03:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/8/21 9:19 PM, Lars-Peter Clausen wrote:
> > On 10/7/21 3:46 PM, Vincent Whitchurch wrote:  
> >> On one of our boards we use gpio-mux with iio-mux to read voltages 
> >> using an ADC
> >> from a few different channels, and on this board the input voltage 
> >> needs some
> >> time to stabilize after a switch of the mux.
> >>
> >> This series add devicetree and driver support for this kind of 
> >> hardware which
> >> requries a settle time after muxing.  
> >
> > I have a board with the very same problem. And a similar solution, but 
> > you beat me with upstreaming. I've switched to your patchset.
> >
> > Whole series
> >
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Acked-by: Lars-Peter Clausen <lars@metafoo.de>  
> Oh, I just realized I messed up. I meant to write
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Fixed up.

Thanks,

Jonathan
