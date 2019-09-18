Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22AB63A2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfIRMz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:55:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40331 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfIRMz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:55:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so6207230ota.7;
        Wed, 18 Sep 2019 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/obFJ4bRJSXxsoxYo8c1RjJKF4/g7ZOMR6n3vmjX6U=;
        b=YghJhXYTyXii3jfPhvz7LZ8LzR4OFjaktbJ6EorUPwmeRpkVnc9W9mr6wsG4vEe3Tn
         wQHQ/s7tYVaTrwOiMA7pwBo4varISfHEtHFahM7CaE21A4JYNQoQfDDCwTO5DsnV2x+Z
         8eu5+YEG/L5zmKTV+dev6jbPXp9WAI0gHYyT3egDIq5jqB8MiJSMmMSWuWZMHRPHAoZg
         1iurw6XZoG/xIEhTmaM5W6YwtPuFDNzxFPLVw7FPPBqHsm8jy987DGSNl+IH6cWLtwI9
         esZKaMebyVFwC8+TYYvkGGlLmHiNbiNwLqF/1vAjoUUOsO7V85WLVXn+WHXZNLNwRGpZ
         caBg==
X-Gm-Message-State: APjAAAU+6Xk5VH9BuI8S2OUHpkDYs5T3G1ESvCV3xqwHn8Q5vH0A/Sda
        MI2+3y1wyT5uH6xPHXTkjg==
X-Google-Smtp-Source: APXvYqxOHB0PcqdAJMdo7FeOOcdzjuKXsZBGXz1rEkmccxms8AlGyUA04EUXrePTyTv9JVzD6d+GJQ==
X-Received: by 2002:a9d:57c1:: with SMTP id q1mr420848oti.144.1568811356250;
        Wed, 18 Sep 2019 05:55:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm1824269otw.28.2019.09.18.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:55:55 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:55:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: power: syscon-reboot: Convert
 bindings to json-schema
Message-ID: <20190918125555.GA28572@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:19:57 +0200, Krzysztof Kozlowski wrote:
> Convert the Syscon reboot bindings to DT schema format using
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
>  .../bindings/power/reset/syscon-reboot.txt    | 30 ----------
>  .../bindings/power/reset/syscon-reboot.yaml   | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> 

Applied, thanks.

Rob
