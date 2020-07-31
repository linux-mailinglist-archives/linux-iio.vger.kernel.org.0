Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68688234DC9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGaWsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 18:48:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37062 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 18:48:01 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so19590354iom.4;
        Fri, 31 Jul 2020 15:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/d64ZvxnYLAa4ivT6GpHFLsQPwpa3um8E44Lb+XHnVM=;
        b=WnWfwIp6To646z8ZYHnJGO6dQerk9DrXRfx8fb8kWdkPimrbnL6c/igoDsYoRsTPdL
         yFnwTrTv7RfqJ2WycsipAVA191gftyWcbr3KouhOdtUGPzsB7UtSVRDybQ9lTfelkwRp
         Wp3LHNvL3ZpKInqLJmdm2BFQFYLKeBsKiaNtjyVadpFtKW4grwVbka1QB3TaMj/Ohmwe
         A6Q5QQml4vc/Xzc0EdO/NKdGpY3yTznB8i6HSNXz5mD5U0qF/KjtRVgrl0ncKCy3ZQMv
         8tf5CBspfBM4zwoeV+G4HI7PWZ3wm+PgdszjJj7CJYFjkGAaBC3SPwqGAJ59HAmwzxJL
         XMIw==
X-Gm-Message-State: AOAM532nI4PQYwJAAal/AdsMBKXYhNahRyM0qnRp1oV+K1d2PesPs1Fe
        Uxbtu7xpxZV6wH2MhJ7MKw==
X-Google-Smtp-Source: ABdhPJzEyDvTpEnTuMpltjNhY3vCPr2jJn8FZNM5dRXRCf0C3CB3SCaZx1OhN3DDkgnP1FTWuFefXg==
X-Received: by 2002:a6b:700d:: with SMTP id l13mr5685565ioc.135.1596235680423;
        Fri, 31 Jul 2020 15:48:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h9sm5465140ilc.59.2020.07.31.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:47:59 -0700 (PDT)
Received: (nullmailer pid 951611 invoked by uid 1000);
        Fri, 31 Jul 2020 22:47:58 -0000
Date:   Fri, 31 Jul 2020 16:47:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Message-ID: <20200731224758.GA951535@bogus>
References: <20200731164853.3020946-1-campello@chromium.org>
 <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 10:48:38 -0600, Daniel Campello wrote:
> Adds device tree bandings for sx9310 sensor.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes in v3: None
> Changes in v2:
>  - Added #io-channel-cells as a required property
> 
>  .../iio/proximity/semtech,sx9310.yaml         | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
