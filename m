Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF3E07BA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfJVPo6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 11:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfJVPo6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 11:44:58 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3122E2086D;
        Tue, 22 Oct 2019 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571759097;
        bh=uB+iJFJC/hVIjUlk10LfhCh+hobudFQOoJDpOyooXkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BziVt7kpMMygCTcEdjyfaGeXgAdik+wYQr+mPhwRjhwK9RdDv/0DE2OJjmalwuN5
         idkYV5wqN7EZdY9hmPYt88huqDJJ5U22/UyduRW2Ljhyf1ReDOIR7IbTRp6zXVG9Bm
         GtHGa8hC2qL8mWvO+kyun5bPmCR68YLbGpLp7CLA=
Received: by mail-qt1-f182.google.com with SMTP id m15so27521989qtq.2;
        Tue, 22 Oct 2019 08:44:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWskgbcnJnJA+8kLVeDctG2H2vnYoB43dzzo8Hm6i/pjN/nZeuT
        sZIrO21XrO+RD8R3nDArL/aP97kZdnNZcFqasA==
X-Google-Smtp-Source: APXvYqyov/Zp05P18+muy5bKvbNnTx96qFTjFGR2D/vBSBLHfsdLmzsSiTpHWl1RItE1SuD/noI1iPC3qzBfZ2ox9oc=
X-Received: by 2002:a0c:ed4f:: with SMTP id v15mr3617404qvq.136.1571759096365;
 Tue, 22 Oct 2019 08:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <1571749873-8964-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1571749873-8964-1-git-send-email-gupt21@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Oct 2019 10:44:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4bGgBBnX2oZ50RaVN36qPZRNS4B7_u0UyqHm30R8SbQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4bGgBBnX2oZ50RaVN36qPZRNS4B7_u0UyqHm30R8SbQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>, alexios.zavras@intel.com,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 22, 2019 at 8:11 AM Rishi Gupta <gupt21@gmail.com> wrote:
>
> This commit adds device tree bindings for veml6030 ambient
> light sensor.
>
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v5:
> * None
>
> Changes in v4:
> * Added enum in reg property
> * Removed maxItems from reg property
>
> Changes in v3:
> * None
>
> Changes in v2:
> * Corrected grammatical mistake from 'is' to 'are' in description of bindings
>
>  .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
