Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A88320B43
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUPJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 10:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBUPJy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:09:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC41864EE6;
        Sun, 21 Feb 2021 15:09:11 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:09:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: vcnl3020: add proximity rate in hz
Message-ID: <20210221150907.2161b964@archlinux>
In-Reply-To: <20210216145346.18304-3-i.mikhaylov@yadro.com>
References: <20210216145346.18304-1-i.mikhaylov@yadro.com>
        <20210216145346.18304-3-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 17:53:46 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Describe the possible proximity values in herzes for vcnl3020.
Hertz

Why does this belong in DT?

DT bindings should reflect physical characteristics of the device, so how
is wired up, whether there are plastic windows over it that might affect
calibration - that sort of thing.   A rate of sampling proximity seems
like a policy decision best left to user space.

Jonathan

> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> index fbd3a2e32280..1bb6ca1770f3 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> @@ -43,6 +43,12 @@ properties:
>             180000, 190000, 200000]
>      default: 20000
>  
> +  vishay,proximity-rate-hz:
> +    description:
> +      The rate of proximity measurement.
> +    enum: [1, 3, 7, 16, 31, 62, 125, 500]
> +    default: 1
> +
>  required:
>    - compatible
>    - reg

