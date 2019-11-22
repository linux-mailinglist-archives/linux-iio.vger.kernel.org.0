Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D762E107567
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVQGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 11:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfKVQGg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Nov 2019 11:06:36 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4C520715;
        Fri, 22 Nov 2019 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574438795;
        bh=/ghBJEmOGwrKdimQL2GKpdhioXxZ9JkEhWwgK9T3ZRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AVYssHaQNllpYW3B93/VCQF3Aok/StMtcJtj96+PUVU4ZCnNPjLPukTZzSE7Wopj3
         syITIyovh1Rkna+J6RL+yQWlS1s+z61MIhf2QYBg1ZoXmm2L1/L+wD8vD1fL/GJaGt
         Hf7VPH2CZ39jHM0YAOgsgv86QB0L5hqXI7wzUUvs=
Received: by mail-qk1-f170.google.com with SMTP id m16so6684160qki.11;
        Fri, 22 Nov 2019 08:06:35 -0800 (PST)
X-Gm-Message-State: APjAAAV5X3cCQE+kzRY1ENTR4XoNUp7IfIaZEwv/MtB3uGOqwb4Z0v49
        q+9gO3aRKv1GEIVAExfHo6PsdElFFd026te0DA==
X-Google-Smtp-Source: APXvYqxIVtdGvrYS2rG2y2epizrSMeoa9dB4IKXvdiZLaRbjHAOzZwWO6opvjGM5MFmE5unpfeyo9FwfuEbRjZVXUDw=
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr13851898qkm.393.1574438794826;
 Fri, 22 Nov 2019 08:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20191116205110.vvqkmujecc6u5fvi@smtp.gmail.com>
In-Reply-To: <20191116205110.vvqkmujecc6u5fvi@smtp.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 10:06:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+uf3Jf87YSCuFzZMJeyqbg1==sFL6ScBVW7i_WSC61kA@mail.gmail.com>
Message-ID: <CAL_Jsq+uf3Jf87YSCuFzZMJeyqbg1==sFL6ScBVW7i_WSC61kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: ad7292: fix constraint over
 channel quantity
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 16, 2019 at 2:51 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Change items property of AD7292 channels to correctly constrain their
> quantity.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
