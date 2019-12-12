Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8129D11CF4F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfLLOGP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 09:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfLLOGO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Dec 2019 09:06:14 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16CCE24654;
        Thu, 12 Dec 2019 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576159574;
        bh=AtvoAoHf+By+ClZcfpVNbiia4RBJOhGZV+MkZH4r0/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06D07lvIT9ODLETaIaebvrqAOqpeDgiT9uoZnOFYL7WYxU/siLk9bayetvaC//p5U
         GJuw5+m8Wpm+eStwfptyckqEYVTEG0S6KxA8tQ0rLoU4b/lhkroorZFQKlm/zWMmeX
         i+QnQYvvCqvmxz6xaOUDTTbdgscTZ5OHLwlKCRqw=
Received: by mail-qt1-f182.google.com with SMTP id k40so656119qtk.8;
        Thu, 12 Dec 2019 06:06:14 -0800 (PST)
X-Gm-Message-State: APjAAAVKDTDpeHSpJ0vzscEao8epefioAO/vJrQwomnwFmlpl00MRf/U
        0u0mk/bn/fO1bz6/nYoMcRCW0gBOPm2mCl1GIA==
X-Google-Smtp-Source: APXvYqyi6kpvJTW31e4Dn2hCKkV20vgauUUU9dgtaOa8gogoapVGPe1gqhVaKkoEIUoh6GOLgJltAoAKE75fbUL2J3E=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr7517457qtq.143.1576159573215;
 Thu, 12 Dec 2019 06:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20191212134037.1049-1-benjamin.gaignard@st.com>
In-Reply-To: <20191212134037.1049-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Dec 2019 08:06:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4Dc18+pFS1Qa-0A6j-zi9hpnqMywCSU_rhnGEZGLQEQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4Dc18+pFS1Qa-0A6j-zi9hpnqMywCSU_rhnGEZGLQEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: ad7192: Fix DTC error in reg schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 12, 2019 at 7:40 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Add minimum field to be compliant to json-schema
>
> Fixes: d898f9ac542f9 ("dt-bindings: iio: adc: Add dt-schema for AD7292")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 1 +
>  1 file changed, 1 insertion(+)

Thanks, but there's already a fix pending in -next.

Rob
