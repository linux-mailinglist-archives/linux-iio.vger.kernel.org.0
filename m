Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4EB63A4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfIRM4J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:56:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33267 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfIRM4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:56:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id e18so5887598oii.0;
        Wed, 18 Sep 2019 05:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReA/o+x2vyuqjFCUqAB1yNYGSIto+aghusagtGQT+Yw=;
        b=mxDdDJjgRnIS0dA1OsHD8RIhVof1MNcsPhM9wsWc1RPN5wQFAl/WhfM1dkR3/mDveF
         bSO0PxAiaF97U24IOVTdDyv0zT+JcCrGWB5RjJVPA68tuh6jU54ZcrxobAztKrD7WDWE
         pw2Q/JXUJmwfDozHz6T+2LCJ7QYgGc+4bdC4sTm0QLai7ycrqX567MLrqSx2a3ScBQH4
         XawaY04E7RW8p7+MUMmgqxOjxAbrAU+V+5JpYuDKQ3+ljrdTh1Nk9EsALjIoWBuEWgJQ
         vtuWlHmN92IcQbodnAo9VadL5Ncyd/drJhDNgIoL3Pefx4/hQMuKdCVr47kGTBo5WHNz
         /QJw==
X-Gm-Message-State: APjAAAWyyVTxAba5wA++3Rc3VH8XJicgRa8fwfW15xRqVGvBPZTlcfOT
        IRrgo/Q/txQarPAB26RUbQ5U64bASA==
X-Google-Smtp-Source: APXvYqyI08mETSJl68juHYwpSNiK/1VK+99TD6jA1kRhVRKRECzk7usQXauXvTJmWRD3J2KLPDFI8g==
X-Received: by 2002:aca:ed52:: with SMTP id l79mr1885758oih.47.1568811367689;
        Wed, 18 Sep 2019 05:56:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm1815779otp.20.2019.09.18.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:56:07 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:56:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: power: syscon-poweroff: Convert
 bindings to json-schema
Message-ID: <20190918125606.GA29089@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:19:58 +0200, Krzysztof Kozlowski wrote:
> Convert the Syscon poweroff bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Remove unneeded maxItems from uint32 fields,
> 2. Simplify if-else-then.
> ---
>  .../bindings/power/reset/syscon-poweroff.txt  | 30 ----------
>  .../bindings/power/reset/syscon-poweroff.yaml | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> 

Applied, thanks.

Rob
