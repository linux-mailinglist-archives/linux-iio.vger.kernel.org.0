Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3DB63C4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfIRM5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:57:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46914 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfIRM5J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:57:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so3059203otl.13;
        Wed, 18 Sep 2019 05:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/3A/KYxXjH6WVBi/Ulo343XXTJEHgBjD05uTJuwbkA=;
        b=eQMwmrbM0XxZi8HYcp6yQSsLFRSd/uMGdFkIGUpZAEn7MyCGR7ZPRihjNSPcFhhtsW
         2JKTPV23rgj8+5R4sXBbpLh0sp/jo7PNASkIVNCsE6cgEknIfkcMcfW1MpNgpcrl4CkY
         taenGf8L14mXn9X84yOBOxrv4WPqWvh10iGHQxik0hcu9Kzg932pOiuIWOb79rEHcp6/
         sMRotdJ3pmqbG9OHeVcK1itHQdnmzAmeRknUleVSHeygqM5cM5LCvBQJ7Ac9HySA85xn
         6FzPHEphIzIuGOIKOAiwBULFJSW7BtEYNE8qb0mohQ4xS3EHKceQQA51xsDlqzx0Aste
         SoNg==
X-Gm-Message-State: APjAAAVNTm2MVhzK90MSyroLekaP3mh9Bgc55x6eXSGzpx6+SU5LAxof
        ALdLIbbBaUvmruBAFr5wDw==
X-Google-Smtp-Source: APXvYqwodEE5j8qxHT+M0f5nu7yacK3VYOvyqgfXVZo7lYSUguw8ryUfGATRRot+StM8ES+dd2srMw==
X-Received: by 2002:a9d:7145:: with SMTP id y5mr2852899otj.290.1568811428522;
        Wed, 18 Sep 2019 05:57:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm1776848otb.65.2019.09.18.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:57:07 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:57:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: arm: samsung: Convert Exynos
 Chipid bindings to json-schema
Message-ID: <20190918125707.GA31634@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-6-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:02 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Chipid bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/exynos-chipid.txt    | 12 ---------
>  .../bindings/arm/samsung/exynos-chipid.yaml   | 25 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> 

Applied, thanks.

Rob
