Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB39A3CC9A8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhGROvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 10:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGROvk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:51:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4898B61073;
        Sun, 18 Jul 2021 14:48:39 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:51:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] dt-bindings: iio: accel: bma255: Fix interrupt type
 / merge bma180
Message-ID: <20210718155102.2fee5fb1@jic23-huawei>
In-Reply-To: <20210614163150.7774-1-stephan@gerhold.net>
References: <20210614163150.7774-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 18:31:47 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> This patch series first fixes the interrupt type in the
> bosch,bma255.yaml schema and then combines it with the
> bosch,bma180.yaml schema since they are pretty much identical.
> 
> Stephan Gerhold (3):
>   dt-bindings: iio: accel: bma255: Fix interrupt type
>   dt-bindings: iio: accel: bma255: Sort compatibles
>   dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema
> 
>  .../bindings/iio/accel/bosch,bma180.yaml      | 61 -------------------
>  .../bindings/iio/accel/bosch,bma255.yaml      | 23 ++++---
>  2 files changed, 16 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
> 

Series applied to the togreg branch of iio.git and pushed out as testing
to let 0-day have a shot at them.

I 'think' the outstanding discussion was all about potential follow up patches
rather than anything here, but if I've missed a reason we should hold off
on these then shout.

Thanks,

Jonathan
