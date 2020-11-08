Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B62AAC0D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 17:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKHQAz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 11:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHQAz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 11:00:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF18720B1F;
        Sun,  8 Nov 2020 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604851254;
        bh=qpld0sZoZwZiEaTCm7sxX8a3FU2VoZ6d77Ajih5uXUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=reft4RyaMWs92tat9LSuFLpCB38CpQ3ZcnoHE2GHKYqtECbzHpgshj9SwsXSDXu4I
         biAFIrFj66zukogu+klCf118FzQkKDbNhuU504Fqc4b5hQmDAZN2WAArVCHqPou1EP
         oMSsENPCsayL2q+hvuBcfw4ycJC6JiWwVqMXsmM4=
Date:   Sun, 8 Nov 2020 16:00:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH 09/10] dt-bindings:iio:light:capella,cm3605: txt to yaml
 conversion.
Message-ID: <20201108160050.042c043a@archlinux>
In-Reply-To: <CACRpkdbuuiwxmr4BdOHn2LRckhc7+cRb7JCaoVpsL8aR9s65tA@mail.gmail.com>
References: <20201031181242.742301-1-jic23@kernel.org>
        <20201031181242.742301-10-jic23@kernel.org>
        <CACRpkdbuuiwxmr4BdOHn2LRckhc7+cRb7JCaoVpsL8aR9s65tA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Nov 2020 15:46:14 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Oct 31, 2020 at 7:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Simple conversion using the new iio-consumers.yaml binding in the
> > dt-schema.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> FWIW Kevin Tsai has listed himself to maintain all Capella
> drivers, also this one, so maybe he should be added as
> binding maintainer as well?
Sure.  +cc Kevin.

Kevin. Do youmind being listed as maintainer for this binding?

> 
> CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> M:      Kevin Tsai <ktsai@capellamicro.com>
> S:      Maintained
> F:      drivers/iio/light/cm*
> 
> Either way:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

