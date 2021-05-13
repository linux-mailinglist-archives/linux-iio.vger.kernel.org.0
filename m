Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3C37FB57
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhEMQTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhEMQTA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:19:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FA26108D;
        Thu, 13 May 2021 16:17:47 +0000 (UTC)
Date:   Thu, 13 May 2021 17:18:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWlj?= =?UTF-8?B?aGHFgiBNaXJvc8WCYXc=?= 
        <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] iio: accel: kxcjk-1013: Add support for
 KX023-1025
Message-ID: <20210513171855.4bbeca6b@jic23-huawei>
In-Reply-To: <20210511142402.4457-1-stephan@gerhold.net>
References: <20210511142402.4457-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 16:23:59 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> KX023-1025 [1] is another accelerometer from Kionix that has lots
> of additional functionality compared to KXCJK-1013. It combines the
> motion interrupt functionality from KXCJK with the tap detection
> from KXTF9, plus a lot more other functionality.
> 
> This patch set does not add support for any of the extra functionality,
> but makes basic functionality work with the existing kxcjk-1013 driver.
> 
> At first, the register map for the KX023-1025 seems quite different
> from the other accelerometers supported by the kxcjk-1013.
> However, it turns out that at least most of the register bits
> still mean the same for KX023-1025.
> 
> This patch set refactors the kxcjk-1013 driver a little bit
> to get the register addresses from a chip-specific struct.
> The register bits can be re-used for all the different chips.
> 
> The KX023-1025 is used in several smartphones from Huawei.
> I tested these changes on a Huawei Ascend G7, someone else reported
> they also work fine on the Huawei Honor 5X (codename "kiwi").
> 
> [1]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf

Series applied to the togreg branch of iio.git and pushed out as testing
for the bots to see if they can find anything we missed.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Make register structs static (reported by kernel test robot)
> 
> Stephan Gerhold (3):
>   dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
>   iio: accel: kxcjk-1013: Refactor configuration registers into struct
>   iio: accel: kxcjk-1013: Add support for KX023-1025
> 
>  .../bindings/iio/accel/kionix,kxcjk1013.yaml  |   1 +
>  drivers/iio/accel/kxcjk-1013.c                | 217 ++++++++++++++----
>  2 files changed, 176 insertions(+), 42 deletions(-)
> 

