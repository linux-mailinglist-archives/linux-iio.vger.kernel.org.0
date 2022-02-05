Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A64AA5BC
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 03:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiBEC2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Feb 2022 21:28:19 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42545 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiBEC2S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Feb 2022 21:28:18 -0500
Received: by mail-oi1-f177.google.com with SMTP id v67so10641394oie.9;
        Fri, 04 Feb 2022 18:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JmvBIhMKnhgkGxggrbFqkk5PJMlahpRLZSGojBlhXrk=;
        b=NwJOtnh3zpNKhBT4fdslKa/QeGAIQalM3CZdHjMz5qHSSx5REaWUWBYHCWuE+WBnnb
         jxB8q374kDCIT9Z9Ltcn885m7xWBavZ8YAxb8KNgt4/4LPytC6TjNJb6t7EQDYKUezgF
         TKd2o0lZhHdb6vgmgSsRftWITiCglZPxtfVBBOleTR2QFWwbV+uV2g7xOTbZBZdn70H7
         Wp1/K2zyrEakj5qTuJsJ0a6CTuaBA3SkyfB2Z0NAlOPJDRvUbWztYoSu/V0zxrPNTj7X
         Z7+Tz0ANgSgpDJH1uFo+oCf40AQNha177Cy0cLV/8JhaUu4GeZ9eSuZFea8Bh2E7mGan
         a3pA==
X-Gm-Message-State: AOAM5300KoPvVyTDIAdOPlfO3hWHqtnRT7lpEgC13cqJMrGGdr3qWexs
        iWBaZrkzqLtLfEKTKuhGRk41c9c3Ew==
X-Google-Smtp-Source: ABdhPJxNZGun10NRnauK03pavyGA7GRMeX6PA2KRoaELKK2dSfBdQ133efI49l2RW6X4C7eoyGypJg==
X-Received: by 2002:a05:6808:1b07:: with SMTP id bx7mr2957213oib.5.1644028098401;
        Fri, 04 Feb 2022 18:28:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7sm1515753oow.47.2022.02.04.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:28:17 -0800 (PST)
Received: (nullmailer pid 3639087 invoked by uid 1000);
        Sat, 05 Feb 2022 02:28:17 -0000
Date:   Fri, 4 Feb 2022 20:28:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: Add ltc2688 documentation
Message-ID: <Yf3gwRNv7RI7v7eb@robh.at.kernel.org>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-4-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121142501.151-4-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Jan 2022 15:25:01 +0100, Nuno Sá wrote:
> Document the LTC2688 devicetree properties.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2688.yaml         | 146 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
