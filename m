Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0379229E4C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgGVRTC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 13:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgGVRTC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 13:19:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363E92071A;
        Wed, 22 Jul 2020 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438341;
        bh=ia3Drrpb8R286Xl10CkSuL9nEqLtKvC8Ftw8IXrdn/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Llbo/CbeIrHS36qg4Tav3ymVIZ6aEUb70v3+IRetVM7dfFtTJ05OA67XrrwaYZ6Y7
         DOH5dhovSD6XxQjJXy9IrN4W3avampo7relGtesnasxUuwBe2q8f5X2xzD9xKnJH2I
         +lEtbG7fHzaVDIH8mEbYE1D/wqf+fVmDMVPMK64o=
Date:   Wed, 22 Jul 2020 18:18:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] dt-bindings: iio: adc: Maxim ADC yaml conversions
Message-ID: <20200722181857.57917132@archlinux>
In-Reply-To: <20200722171224.989138-1-jic23@kernel.org>
References: <20200722171224.989138-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 18:12:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These 3 are all fairly simple (I think) so should be uncontroversial.
> My biggest question is with Jacopi and Akinobu are happy to be
> explicitly listed as maintainers for these bindings.

I'll leave these for now, but just realised I didn't put
additionalProperties: false in the last 2 and I'm fairly sure
it should be fine to do so in both of them.

Jonathan


> 
> Jonathan Cameron (3):
>   dt-bindings: iio: adc: maxim,max11100 yaml conversion
>   dt-bindings: iio: adc: maxim,max1118 yaml conversion
>   dt-bindings: iio: adc: maxim,max9611 yaml conversions
> 
>  .../devicetree/bindings/iio/adc/max11100.txt  | 18 ------
>  .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
>  .../devicetree/bindings/iio/adc/max9611.txt   | 27 ---------
>  .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++
>  .../bindings/iio/adc/maxim,max1118.yaml       | 59 +++++++++++++++++++
>  .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++
>  6 files changed, 157 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
> 

