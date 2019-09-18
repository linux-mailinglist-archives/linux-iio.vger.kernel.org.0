Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72C6B63B7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfIRM4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:56:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46876 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfIRM4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:56:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so3058064otl.13;
        Wed, 18 Sep 2019 05:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7pQxKwjOEeyYJrXJC0BD22K8VmAu7IgDiqHUePINFM=;
        b=FUBeT1CcyPz1vhK+rMCNK/HoFKEhxmpkmElcpGPLSbaKHWZQ0Qe22wdiEFISDjza1D
         4Hsrk5/Ami6OtNSJpA562svXJYFRwrvWnsQ1AUMbZwaCpmWtO8HzaA2e7BYqnhzdeb9y
         6FLqCcdaelHE+U/YB48OB3gzc+SxWNy7nO3GpAiKWlXTlEsI+g2NdpaY+QsPRGTyy/Ty
         YxBd4etV+pcFM/V8qOrDoBU9MnDMUTuyNE8pXXP91LHr414aaAKroag00v3qfmjlBfEB
         QU/CsoSh8KH4DElV6JcKPdzh+4q/kMJ/OEF2cUqv1nNpkxp1vwYwrGzCBLGtWhajODKB
         pfGw==
X-Gm-Message-State: APjAAAUoxQKXm0hJks3ecC4RMvmsJd1KeeKBKKABdMDxp80Wmz/uXZVL
        cSoqDb7RUuS7lhIj4Y+99YueQfyAaA==
X-Google-Smtp-Source: APXvYqyip6TGA28B6dtl1XpdNeVPYRX49rJ6hf7F7wfTaXVf9y3jevzFuGlE8KuQJPlzCjScPp0GUg==
X-Received: by 2002:a05:6830:1202:: with SMTP id r2mr2857953otp.85.1568811403648;
        Wed, 18 Sep 2019 05:56:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm1751435oie.4.2019.09.18.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:56:42 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:56:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 05/11] dt-bindings: arm: samsung: Document missing
 Exynos7 boards bindings
Message-ID: <20190918125642.GA30545@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-5-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:01 +0200, Krzysztof Kozlowski wrote:
> Add missing documentation of ARMv8 Samsung Exynos7 SoC based boards
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks.

Rob
