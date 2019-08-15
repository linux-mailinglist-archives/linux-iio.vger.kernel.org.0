Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0168E2D1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2019 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfHOCjR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 22:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfHOCjR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Aug 2019 22:39:17 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6FD216F4;
        Thu, 15 Aug 2019 02:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565836756;
        bh=6QbandalLnAk7UTLMfGCysXOvMZVD8zDiXVztaTkPvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RSkuKlm0NGGu8APyg6jy9o40Z1GL5PDioKvTTmrex2ngWcAfSwaqqWhLdUzWmdLnj
         FCqCB23jZjq+fQ52yCvopkjQDq9yjnmAiKyiArsa5D+Ge0uCmV9dKeEWUvhdHYdL5H
         wo2RFawVbhBV8ymWz3Wj+DR8D0Zq93/KI15G/CnE=
Received: by mail-qt1-f178.google.com with SMTP id y26so974455qto.4;
        Wed, 14 Aug 2019 19:39:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWu0YdL4095pudP9m7riRw6zPz3UIHnjCMf3oSgYes05+kr7Trk
        nugsbe2d00vMn0Sv0XnA8y42aNRH1Y7GF/bxvg==
X-Google-Smtp-Source: APXvYqy720b+TBPiY3xSErK/uPvy00ygrhACFau+Inlb5PS4ZryBu4TZuITCQtM7YmMF5mIDTHqb7h7I0JYxps+k0mk=
X-Received: by 2002:ac8:386f:: with SMTP id r44mr2221226qtb.300.1565836755669;
 Wed, 14 Aug 2019 19:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190814073150.4602-1-mircea.caprioru@analog.com> <20190814073150.4602-4-mircea.caprioru@analog.com>
In-Reply-To: <20190814073150.4602-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Aug 2019 20:39:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKONxFbS-nUMc1c=-9HcXCrOVmOOfn9htKOJOjAS6HCKg@mail.gmail.com>
Message-ID: <CAL_JsqKONxFbS-nUMc1c=-9HcXCrOVmOOfn9htKOJOjAS6HCKg@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 14, 2019 at 1:32 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> This patch add device tree binding documentation for AD7192 adc in YAML
> format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V2:
> - remove description from spi and interrupt properties
> - changed the name of the device from ad7192 to adc in the example
>
> Changelog V3:
> - added semicolon at the end of the dt example
>
>  .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
