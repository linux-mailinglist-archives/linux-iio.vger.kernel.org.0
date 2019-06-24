Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9183850C5E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfFXNuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 09:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfFXNuQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Jun 2019 09:50:16 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46F9208E4;
        Mon, 24 Jun 2019 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561384215;
        bh=D93F75MCf5Ifim/NA5/BmsC0u/Z/+dlTBc51xNbANYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOw8nminDrolY2+lEBkH6FywwYeWdFm1P0aTmxYzLEuHPQf+Iz4ixe+YgBTgOegQZ
         Xaxn/0FWe+yH0ngMVpwBZL3YcZuX+gssnI/aLIuMXxgh5yXVfI9lVatXQFdtjdT6jc
         B1dvbrkZSf/xkwTKnE8hRV2HDq80Y95FkK0sljWo=
Received: by mail-qt1-f169.google.com with SMTP id i34so14490976qta.6;
        Mon, 24 Jun 2019 06:50:14 -0700 (PDT)
X-Gm-Message-State: APjAAAW29cuIjlao/kfmCs4ThAC9r+Xo4s5jZS+CKSg6/bRvmYVueGUQ
        gSHCO3lhg7QzRgGRv6Ec2oX6Qzoo206ASppuyw==
X-Google-Smtp-Source: APXvYqxmW7JPHc33YPuhk21FAE42NxsvsYvCz8xmz3rfBr2a2RuJ6mDF+EKi4YjQQN8aB0Jrk5c2f42QB2J0AaagZKE=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr47415116qtc.143.1561384214126;
 Mon, 24 Jun 2019 06:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190624080845.18537-1-mircea.caprioru@analog.com> <20190624080845.18537-4-mircea.caprioru@analog.com>
In-Reply-To: <20190624080845.18537-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 24 Jun 2019 07:50:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJY_bO7EQa=Sfqs8Prwj483Q8Xs0+eX+HZyGsyr-4p-oQ@mail.gmail.com>
Message-ID: <CAL_JsqJY_bO7EQa=Sfqs8Prwj483Q8Xs0+eX+HZyGsyr-4p-oQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] dt-bindings: iio: adc: Convert ad7124
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

On Mon, Jun 24, 2019 at 2:09 AM Mircea Caprioru
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
>  .../bindings/iio/adc/adi,ad7124.yaml          | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

The subject says 'Convert', but where's the removal of the old binding?

Rob
