Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A528E56C75
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFZOot (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 10:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZOot (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 10:44:49 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDEB921670;
        Wed, 26 Jun 2019 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561560288;
        bh=WQB0Cb0Fwe1e0rrZlhVBU+AwLgt65MtTJ2khFSrZn0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LOZNuS5FQwrKpVsEzn+lGfI1b+0GrSDNZoDXqhZ5pPhq+BAlqKj2U3xjo2PltRuok
         VTJNPeHr2G5MIScnD1cTC16xGA8HCo3pSk7KOaqBqRKzMM0+uUZRueYfYFrkMHNYAu
         ItEKdvja+WFtZU3Xszgzuwry7RXgIQLD+Xt63Jes=
Received: by mail-qt1-f181.google.com with SMTP id d17so2609912qtj.8;
        Wed, 26 Jun 2019 07:44:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWLwpY8DWFQUcQsxgSJz6ZzZFKDrCY6SejdT4YqP1LWEGi1K1Kx
        MmA4WFWYPER1HN0n770aEp0cMpIZD8bCb+LDyg==
X-Google-Smtp-Source: APXvYqy3AyboNNaUxEOTVD3G9r/1zIYtxuabnm8obQmyQ2sNWzb05eFckEI9upYAQjZ4FNmk2ANMRn/4A6VU93yWGpo=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr4218147qth.136.1561560287185;
 Wed, 26 Jun 2019 07:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190625081128.22190-1-mircea.caprioru@analog.com> <20190625081128.22190-4-mircea.caprioru@analog.com>
In-Reply-To: <20190625081128.22190-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 08:44:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHpT1z3O5QctG6WWB6bcOms5XYTOOrq6tK6uOZPNQtDQ@mail.gmail.com>
Message-ID: <CAL_JsqLHpT1z3O5QctG6WWB6bcOms5XYTOOrq6tK6uOZPNQtDQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
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

On Tue, Jun 25, 2019 at 2:12 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> Convert AD7124 bindings documentation to YAML format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>
> Changelog v2:
> - modified SPDX license to GPL-2.0 OR BSD-2-Clause
> - added regex for a range from 0 to 15
> - added minimum and maximum constraints for reg property
> - set type and range of values for adi,reference-select property
> - used items for diff-channels property
> - set bipolar, adi,buffered-positive and negative to type: boolean
>
> Changelog v3:
> - moved adi,buffered-positive and negative properties to own commit
>
> Changelog v4:
> - removed old txt dt-binding
>
>  .../bindings/iio/adc/adi,ad7124.txt           |  75 ---------
>  .../bindings/iio/adc/adi,ad7124.yaml          | 144 ++++++++++++++++++
>  2 files changed, 144 insertions(+), 75 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
