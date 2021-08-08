Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045253E3AC6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhHHOZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 10:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhHHOZi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 10:25:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E52E60EE0;
        Sun,  8 Aug 2021 14:25:16 +0000 (UTC)
Date:   Sun, 8 Aug 2021 15:28:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Siddharth Manthan <siddharth.manthan@gmail.com>,
        linux-kernel@vger.kernel.org, nikita@trvn.ru,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, ktsai@capellamicro.com, lars@metafoo.de
Subject: Re: [PATCH 1/2] dt-bindings: Add bindings for Capella cm3323
 Ambient Light Sensor
Message-ID: <20210808152807.5d4fc31c@jic23-huawei>
In-Reply-To: <YQhk2NImkpPc162/@robh.at.kernel.org>
References: <20210728110048.14593-1-siddharth.manthan@gmail.com>
        <YQhk2NImkpPc162/@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 15:34:16 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 28 Jul 2021 16:30:47 +0530, Siddharth Manthan wrote:
> > Update trivial-devices.yaml with Capella cm3323 Ambient Light Sensor
> > description.
> > 
> > Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> > ---
> > This patch was previously sent using outlook email provider. Unfortunately
> > I had no knowledge of outlook being banned from mailing lists. I am
> > resending these patches using gmail. Please ignore the previous patches.
> > 
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Seems we have two versions of this series, only one of which made it to the archive.

Anyhow, I've tweaked the message for patch 2 to remove implication that
the of_device_id table is 'necessary' for dt based probing rather than nice
to have.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed before I make a mess of linux-next.

Thanks,

Jonathan
