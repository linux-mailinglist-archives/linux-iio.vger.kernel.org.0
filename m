Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED97D43243A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhJRQzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 12:55:02 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37644 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhJRQzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 12:55:02 -0400
Received: by mail-ot1-f41.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso656606otl.4;
        Mon, 18 Oct 2021 09:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idu8zupzi5pS6hzrp6ynbXD+bkwdw463mG6haC2JAek=;
        b=5T882RbW3mpWUormkWZjATfXARbYWVdPZUVnPlsRBwcrOaE+ZgpO/D8TY4Z62PhQpX
         ANRJPNDBpxpPRZnAWrv96WJ26czU5J79UkjT9O/U5jh63Tru3zfXi/JQlg5k4Ywe2PUb
         fYcmivTlTt+ny3SxJSVaNG2s3oMznYz1GUwYYuMTAyajc31k1PlFbh0P3nUTW6lUeQrr
         NSoNUjElnEBA/EG62507qTTrPybwKOFqkaQ619ef8LDvc/JgbQVsjgfpU0E9Y3B2WDuK
         lSvfgbpfTq1Xs/CNn/BnRcf5s5ePppQtBdlVY3k0XvtZccCrC4wLplhqmf3LXO+2iT2X
         3lwg==
X-Gm-Message-State: AOAM533K0uX28Dt1XNQ68bLZsgqf6WYWyjqz7x9fJceuuE33iLC21Nyw
        j0iBUhcRoaGtB6zqoRvi01l0Gd3pLQ==
X-Google-Smtp-Source: ABdhPJz0+k4rUOqUbyRuu+ug+/6QUcJdyhzNhXGmSejnHwnXvXsuF7ooaa0TCLUvpU2W5ORWSeifhA==
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr790868otp.27.1634575970518;
        Mon, 18 Oct 2021 09:52:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c4sm2555623ook.5.2021.10.18.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:52:49 -0700 (PDT)
Received: (nullmailer pid 2547973 invoked by uid 1000);
        Mon, 18 Oct 2021 16:52:48 -0000
Date:   Mon, 18 Oct 2021 11:52:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: iio: stm32-adc: add generic channel
 binding
Message-ID: <YW2mYKpWSPzGvzUa@robh.at.kernel.org>
References: <20211014131228.4692-1-olivier.moysan@foss.st.com>
 <20211014131228.4692-2-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014131228.4692-2-olivier.moysan@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Oct 2021 15:12:22 +0200, Olivier Moysan wrote:
> Add ADC generic channel binding. This binding should
> be used as an alternate to legacy channel properties
> whenever possible.
> ADC generic channel binding allows to identify supported
> internal channels through the following reserved label names:
> "vddcore", "vrefint" and "vbat".
> This binding also allows to set a different sampling time
> for each channel.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
>  1 file changed, 93 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
