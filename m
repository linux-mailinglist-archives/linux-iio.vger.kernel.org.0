Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF50C6A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfFXNvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 09:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731316AbfFXNvQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Jun 2019 09:51:16 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E2E2145D;
        Mon, 24 Jun 2019 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561384275;
        bh=LpQdSoVTYU+Z7IJZrJzZg9lupJlicvmmyQWj7TK/jY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uzjYjpnwFkvvUdIrrNnzR1u/i6x32DWPzybf1RDrakS+kVym5QcQoJvuLICCoRLDc
         kN7OzNgCQ8Y92xXwKCIsZDN2BrOTLkHeWFHF795ia3+RGFKQnu1dd1q2rKNWwFj2UE
         C4nb4vAdc1hNfT+mitvCUtvhL8DVGQAl3ZfJ4jQU=
Received: by mail-qt1-f182.google.com with SMTP id s15so14464729qtk.9;
        Mon, 24 Jun 2019 06:51:15 -0700 (PDT)
X-Gm-Message-State: APjAAAV34fUbbTq5r7ZjRtHvq4HYyKg/IewN9zDlYwsHcK8wnUQ/nKhN
        SDry//mwrBOSBLVtNrtCZBJ5QFVWM4grsO1V7g==
X-Google-Smtp-Source: APXvYqztXa2HFgJk4Conk6Q6/OguLFGuWuEOOaPLK4wzwrU7A3FV3EDerug+MTP1AxEIK4z0CKM0BHsNOmXALNw2bDo=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr77687933qth.136.1561384274872;
 Mon, 24 Jun 2019 06:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190624080845.18537-1-mircea.caprioru@analog.com> <20190624080845.18537-5-mircea.caprioru@analog.com>
In-Reply-To: <20190624080845.18537-5-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 24 Jun 2019 07:51:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8K=YJUAYE2fzXWpQxBdS8OCfDe5iM=ZbpJbB48ubtug@mail.gmail.com>
Message-ID: <CAL_Jsq+8K=YJUAYE2fzXWpQxBdS8OCfDe5iM=ZbpJbB48ubtug@mail.gmail.com>
Subject: Re: [PATCH V3 5/5] dt-bindings: iio: adc: Add buffered input property
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
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
