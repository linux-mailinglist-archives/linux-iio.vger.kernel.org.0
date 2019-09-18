Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF4B63C9
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfIRM5q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:57:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43783 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfIRM5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:57:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id b2so6181576otq.10;
        Wed, 18 Sep 2019 05:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sZlslgtiFxMqojw+XUrTC/HDPQuvlA94agJki/73aPc=;
        b=Ugciptcrslv0pHh2Ih+r2HjD+BbvTzxBlv9rcfEEN1NT/Te2+f2JoSUjNEhAiT5+C+
         X8KF0Iojt6vRUYXZsPlH228DMDU3gKzd19TwlkMogLYUJ537kinBHGLNtXZzbyQKADXg
         7hAB75S3TAX65V2julcfB9r+2cyuijAYJetEcQK1uwR6M12a9kUh9xA/vk3f0ipHK/8y
         Dqkx8a/3wQMKOCM8QsOZb7j9U6igbJ47rS887vFYFQ40OLPHRYg8QmXH5TdX5/dkww0N
         G+nGFrDYFXjNhz6W837xhOhECbn2gkqkr9YaZg0fmRSxzOYkxlSe8Y4JTzyKsmWJkgpD
         MU9A==
X-Gm-Message-State: APjAAAVA73CYKfSaxlea2acDTki9Dw2+j1NDLQ3SPikDS9Qw84s85BAZ
        BAq87+CKmjGxFb92/C6Qp4ZHMz0yqQ==
X-Google-Smtp-Source: APXvYqxAUad55lZRPH+OnFwtM1Ee0BRdn+Zwa1RD0ynMPv4EPCSUXSQNM4bNX8Nhsplcu6KDI8xt5g==
X-Received: by 2002:a9d:4582:: with SMTP id x2mr2593436ote.159.1568811465379;
        Wed, 18 Sep 2019 05:57:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 2sm1562037ois.43.2019.09.18.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:57:44 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:57:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 09/11] dt-bindings: rtc: s3c: Convert S3C/Exynos RTC
 bindings to json-schema
Message-ID: <20190918125744.GA391@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-9-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:05 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung S3C/Exynos Real Time Clock bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use deprecated property instead of custom select,
> 2. Rework clocks and clock-names matching for specific compatibles.
> ---
>  .../devicetree/bindings/rtc/s3c-rtc.txt       | 31 -------
>  .../devicetree/bindings/rtc/s3c-rtc.yaml      | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> 

Applied, thanks.

Rob
