Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965F331A18
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 23:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHWS1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 17:18:27 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:43129 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCHWSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 17:18:08 -0500
Received: by mail-io1-f48.google.com with SMTP id f20so11710466ioo.10;
        Mon, 08 Mar 2021 14:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wx4ykw+Mg1Sx5cReqaI6/4gAQsxP+twcUD8HPMAYwI4=;
        b=ahSx/A34/YvcD7+oUta9zptRpERa00gYtoidrXT5b5YerIiSlmw465irWA0p3tdgP9
         NnOme4no+HPUqfE3aKInoT9nMjq9bn904hF4XKZ7KWJjE08pllvMQE3yr0/W1EQLbThf
         gSgnq1+qifSQx9PDg/QZxZpfOq8f4wx3QfjhQctD5kzrqpvE3Mb5uGAJDI6sGgEuF4OO
         JfSEX0pZJLGN9m2P46uHl6d/7Pk+USPnKOK/pizKvT4ZOeXPGV1PbPWEVedzsZnYmZCr
         ue4R13fA+d882nns4bWo7AVSSw7ZBgVcwsf1V5dCBXb+tvp+nxPabJFoWWhcO2dAblWM
         Vr/w==
X-Gm-Message-State: AOAM532TwEvcgXHH3ZWdwLHiurcg6VEjf40QR9ALMal1gutlT+x+oMGO
        jM04CiOTrniTsP7pgZWxfA==
X-Google-Smtp-Source: ABdhPJxXtaIt5ClP4xRuy34oKH2NZYE3f4/dzqQyq0Tp+P6ZcDxlss6Koanr74iFxEHxKfJJOgyqcg==
X-Received: by 2002:a5d:9152:: with SMTP id y18mr19816198ioq.117.1615241888143;
        Mon, 08 Mar 2021 14:18:08 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g3sm6556571ile.10.2021.03.08.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:18:07 -0800 (PST)
Received: (nullmailer pid 3052148 invoked by uid 1000);
        Mon, 08 Mar 2021 22:18:05 -0000
Date:   Mon, 8 Mar 2021 15:18:05 -0700
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 1/2] dt-bindings:iio:adc: add documentation for TI
 TSC2046 controller
Message-ID: <20210308221805.GA3052089@robh.at.kernel.org>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305133813.27967-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 05 Mar 2021 14:38:12 +0100, Oleksij Rempel wrote:
> Add a binding documentation for the TI TSC2046 touchscreen controllers
> ADC functionality.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,tsc2046.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
