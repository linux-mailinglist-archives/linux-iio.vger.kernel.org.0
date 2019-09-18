Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B761FB63D8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfIRM6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:58:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42073 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfIRM6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:58:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so5835585oif.9;
        Wed, 18 Sep 2019 05:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYqnfe+Q5UPF2ZJK02xFnTLmHoKTFGKAyM7F+uf5uvc=;
        b=cEB25bZeEsc8G2LceBceNPAF+quGaAMgLZFydEsJMHDJ/DlJDF+A/S/ORGjzY18xj4
         TMeYkzvE04jThKFpV90UN9+2gTTeTlLCvRqpomCtR01JfjvJuyn2rmPjhM08c5TEjwMi
         V+NQpGRDaPXCBuFJUs5mQ674hk3d369tuJjywlOXaDtiojbgU2nD4x3435g9rwC2mHjB
         7V5X4/1xUGW0NfNBuwQbh9coYSSnKczGvAYUbWrkIIsFdqbhR/ulrB3/LXUJI73gBoIL
         knI97xAACtNFLKBUlpFP/kqaZ3zA0Q1+8Z0yJicDuOYVa+1P3qonTmnoJiuwtqKFQmfp
         eFXQ==
X-Gm-Message-State: APjAAAX0rI6YYEc3z7bj+P0bX+EEZGfe+rIrVlqHr4rla0999hiSDCKZ
        SGAYZyDwVB2Mezyjbz0NgQ==
X-Google-Smtp-Source: APXvYqyIMXemZoMhP1eYExCW+fV6KT9V9khvoo96S9b9SwUVlaKABqkERkIMDBERveI5ZHm9b/+G0w==
X-Received: by 2002:aca:6057:: with SMTP id u84mr2099934oib.29.1568811493414;
        Wed, 18 Sep 2019 05:58:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm1813962otd.60.2019.09.18.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:58:12 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:58:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 11/11] dt-bindings: iio: adc: exynos: Remove old
 requirement of two register address ranges
Message-ID: <20190918125812.GA1494@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-11-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:07 +0200, Krzysztof Kozlowski wrote:
> Commit fafb37cfae6d ("iio: exyno-adc: use syscon for PMU
> register access") changed the Exynos ADC driver so the PMU syscon
> phandle is required instead of second register address space.  The
> bindings were not updated so fix them now.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml     | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 

Applied, thanks.

Rob
