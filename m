Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B15D7CFE
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfJORKu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 13:10:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45820 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJORKu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 13:10:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so17462108oib.12;
        Tue, 15 Oct 2019 10:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MuM5OXPQEf/qQaZDX6U88QiRRUcUu9cQvoANannVLLg=;
        b=f9dFBLTg/nyxklKIG/IbWsoWkAZnfBJzBWpdXdavLSfGmiyLiia8m6EVTqCnWpie8b
         MAUTLwRzRrSLoad0hSCyJDIUp3qcA6cMlAs8Xe9t7WW217/jYqRS9mOyD9hNg65/cmjs
         y+wnuc1fyUFJmm6gb4cFM8hwdMKQ3n0Zx8WMQBDsWp0PsSaOIqbuir8SzHFQa5twZ76E
         GYbf9oheO8ogbARb4KgKkdLz4WRli/jlgz/QIdP2UkEcaOBAW4HPX8xyZumhFrExowpY
         C+WVWyjcEYlbHS6MUhrzIzkiXgSH4mRnQiR/cnO6y4Q2354Yv5PLidu9rq1eJ1h+JzJg
         rjLg==
X-Gm-Message-State: APjAAAUm9UUEUCOBO9w0kA/ZHK4nkNemuvaDXHO81GPyiLbvPIDZYrOv
        CVkSFYDEt4pPVTm1O3GiCHXuB9g=
X-Google-Smtp-Source: APXvYqzaGxPe8TwkXiP2OfuHpB4m420Ks0jDce+UGmdVQ7BdQQbg5qasG/3Db5bbjpGHHy65AoHC5g==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr30411976oic.98.1571159449283;
        Tue, 15 Oct 2019 10:10:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm6583417otr.32.2019.10.15.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:10:48 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:10:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: samsung: Indent examples with four
 spaces
Message-ID: <20191015171048.GA10675@bogus>
References: <20191002160744.11307-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 18:07:41 +0200, Krzysztof Kozlowski wrote:
> Change the indentation of examples used in json-schema bindings from two
> to four spaces as this makes the code easier to read and seems to be
> preferred in other files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/exynos-chipid.yaml   |  4 +-
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 64 +++++++++----------
>  .../bindings/power/reset/syscon-poweroff.yaml |  8 +--
>  .../bindings/power/reset/syscon-reboot.yaml   |  8 +--
>  .../devicetree/bindings/rtc/s3c-rtc.yaml      | 12 ++--
>  5 files changed, 48 insertions(+), 48 deletions(-)
> 

Applied, thanks.

Rob
