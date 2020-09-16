Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694B26C6B1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgIPSAX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgIPSAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 14:00:01 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD95C06174A;
        Wed, 16 Sep 2020 11:00:00 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C8A3F9E003C;
        Wed, 16 Sep 2020 18:59:36 +0100 (BST)
Date:   Wed, 16 Sep 2020 18:59:36 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: yaml conversions of some simple ADC
 bindings.
Message-ID: <20200916185936.12a1e790@archlinux>
In-Reply-To: <20200830161154.3201-1-jic23@kernel.org>
References: <20200830161154.3201-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Aug 2020 17:11:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Remaining binding conversions for which changes were needed based on v1
> reviews.
Series applied.

Thanks,

Jonathan

> 
> Jonathan Cameron (2):
>   dt-bindings: iio: adc: ti,adc12138 yaml conversion.
>   dt-bindings: iio: adc: ti,ads7950 binding conversion
> 
>  .../bindings/iio/adc/ti,adc12138.yaml         | 86 +++++++++++++++++++
>  .../bindings/iio/adc/ti,ads7950.yaml          | 65 ++++++++++++++
>  .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
>  .../bindings/iio/adc/ti-ads7950.txt           | 23 -----
>  4 files changed, 151 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
> 

