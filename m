Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4573856C78
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfFZOpO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 10:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZOpO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 10:45:14 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC3C216FD;
        Wed, 26 Jun 2019 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561560313;
        bh=LtDwR/1pA64yM+doJnHbbbxGWdTenyvyKZB9O2Un6dE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IH/hKEQE4XLYp/c6x/Cp0Y56UhPd6jC0LUkNPVB+y2obrh0Dpz7dHFltPvrz7Qf+l
         B38mKVa+JpsFnnNjM1SeuOJM2+7njq7BAPtWosLqEuUtSYYGCvJj3tyAjRnp4fXzGI
         yY+mB0j7A8l9muUQvsM6+VfX3WgiDB167rlEZnuQ=
Received: by mail-qk1-f176.google.com with SMTP id s22so1822750qkj.12;
        Wed, 26 Jun 2019 07:45:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVcmhO5Yjc2jw4xjuy4KTJkQOUYXX8rRDbcXJwzyqQXgtgxWnCd
        NvPFhkIujGJPGzs+9pXdM64DejTe+X1vYxmJsw==
X-Google-Smtp-Source: APXvYqxZf1hkz5oMGPuvQ7jDyoDhlhqEjXqCxepoTpB+A7iAMfW5zXwD89GOgm2ZE+DIO7/qKVossVhEOPdfaE5xP0M=
X-Received: by 2002:a37:6357:: with SMTP id x84mr4142821qkb.393.1561560312364;
 Wed, 26 Jun 2019 07:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190625081128.22190-1-mircea.caprioru@analog.com> <20190625081128.22190-5-mircea.caprioru@analog.com>
In-Reply-To: <20190625081128.22190-5-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 08:45:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ryELXJNdzZBxzCfMQnMdeGr_xC+ABJ3wGx2tZum6AwA@mail.gmail.com>
Message-ID: <CAL_Jsq+ryELXJNdzZBxzCfMQnMdeGr_xC+ABJ3wGx2tZum6AwA@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] dt-bindings: iio: adc: Add buffered input property
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
> This patch adds the buffered mode device tree property for positive and
> negative inputs. Each option can be enabled independently.
>
> In buffered mode, the input channel feeds into a high impedance input stage
> of the buffer amplifier. Therefore, the input can tolerate significant
> source impedances and is tailored for direct connection to external
> resistive type sensors such as strain gages or RTDs.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>
> Changelog v3:
> - added this separate commit for adi,buffered-positive and negative
>   properties
>
> Changelog v4:
> - nothing changed here
>
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
