Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83718B63AE
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfIRM4V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:56:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40974 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfIRM4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:56:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id w17so5834508oiw.8;
        Wed, 18 Sep 2019 05:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9z2gkQffuOGMGL78pWa03VnRChChH9T41AS/dVzZHSw=;
        b=qvT1lsNdS7clQLzztWuKRILyRBCPgeD8srOxu0hvV57P8be7GRgZKD/sSDAp/AH43L
         TSoyNYMHvNDfypkQxba5mB4GojrjuoKGEzx8RybmJ22NY81IjekcaA4WpHrUw5XJoNPF
         s5olPz0bizOoHy+rpaMRYxBKHQ+aFYN4mRqWEckoBxVrL/8dxXKoYfktsbFiKtg1uWZZ
         qmHBtTAKSbI7x+EWsS7LHQBfsiYjCT9H3DGw8PHXVuEppEs5TbKcAIuk8CezxslXA3n1
         q6tLyh/0PlZXThaK+VEo2O/pvQ/3vleN1/T68fszxSyfcNkxC9u6u4eoMc7v+pwqNGGl
         19Zw==
X-Gm-Message-State: APjAAAWKjJIuhdKbRqOVRYGAnT5jwt3GAukE27iyob8eVTw5Y1ONr/gZ
        zFxW36orJmU/ceQkfJAEiA==
X-Google-Smtp-Source: APXvYqxyqJqx44Na/6zs9v/Q7DffiYnZflmnCo24kvOLEqFzYYmo99uC8KAM0TN40xe5W6QKO83t7g==
X-Received: by 2002:aca:b909:: with SMTP id j9mr1957210oif.4.1568811380352;
        Wed, 18 Sep 2019 05:56:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b5sm1769265oia.20.2019.09.18.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:56:19 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:56:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 03/11] dt-bindings: arm: samsung: Convert Samsung
 board/soc bindings to json-schema
Message-ID: <20190918125619.GA29595@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-3-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:19:59 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung S5P and Exynos SoC bindings to DT schema format using
> json-schema.  This is purely conversion of already documented bindings
> so it does not cover all of DTS in the Linux kernel (few S5P/Exynos and
> all S3C are missing).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Make Google boards latest revision as const.
> 2. Split secure firmware into separate schema.
> ---
>  .../bindings/arm/samsung/samsung-boards.txt   |  83 ---------
>  .../bindings/arm/samsung/samsung-boards.yaml  | 165 ++++++++++++++++++
>  .../arm/samsung/samsung-secure-firmware.yaml  |  31 ++++
>  3 files changed, 196 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-secure-firmware.yaml
> 

Applied, thanks.

Rob
