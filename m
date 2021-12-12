Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB9471B7F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Dec 2021 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLLQMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Dec 2021 11:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLLQMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 11:12:16 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99128C061714;
        Sun, 12 Dec 2021 08:12:15 -0800 (PST)
Received: from [81.101.6.87] (port=48016 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mwRSC-0007iv-3U; Sun, 12 Dec 2021 16:12:04 +0000
Date:   Sun, 12 Dec 2021 16:17:05 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5755: drop unrelated
 included.
Message-ID: <20211212161643.0bf33d18@jic23-huawei>
In-Reply-To: <Ya5whKgsd7O3gZW4@robh.at.kernel.org>
References: <20211204165817.2768110-1-jic23@kernel.org>
        <Ya5whKgsd7O3gZW4@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Dec 2021 14:20:20 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, 04 Dec 2021 16:58:17 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Probably a cut and paste error, but the binding header used in the
> > example is for the wrong device and nothing from it is used.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day have a go and finding issues.

Thanks,

Jonathan


