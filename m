Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835552E00F5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLUT2Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 14:28:25 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:46320 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUT2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 14:28:25 -0500
Received: by mail-oo1-f52.google.com with SMTP id n127so2443751ooa.13;
        Mon, 21 Dec 2020 11:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=342hl9W3tnuszryiOJ1LOk9jMzULhQYRG+4V/vMDar0=;
        b=U+9NpF8BA2xTvluo9VeFEywLcEAYui6+ok9VldCStrw1FyjzU1WsrpGLfX+LT8kU/o
         LMNRD8cJyyOZ+4PNjlm24aUbLhAjh8MZSWaI1Hh6LCiIhPU1ZlfCWJJ/Vb07QggQ1Wdj
         canSUq3wans7DEA7rkQda2a+raPyRUml2ZsISSPKC3abqyhSoQOGjHdxJ4WB81WKXFzy
         FQPeXm4mcLenCdYT6JIqFF/L0LOSUHEaiXB2iEaepPGQOL0wLKwEB7YaGC9vWTDwFAVO
         p/Gl49Sxpw+jDkoUk3mRcoK+Ga5xarDeTnZxcEzXZJaqLFVBk7awAcXRwZMy/7CFJQ1y
         hA7g==
X-Gm-Message-State: AOAM530hovkTYojYXPWH9qignEWcf2tr89ltB0YmLtQKHDyfmpaRsupY
        7BRB7/8dD0EP5AOnX9JmSg==
X-Google-Smtp-Source: ABdhPJwh/grBUN+KpoYZOAABRvmQ7FaNAelVfkX0YII5Kv+AxpLGHTVFXZ6UbNW61Vf/7ELsq5RPvw==
X-Received: by 2002:a4a:d118:: with SMTP id k24mr12527650oor.8.1608578862805;
        Mon, 21 Dec 2020 11:27:42 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l132sm3698703oia.23.2020.12.21.11.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:27:41 -0800 (PST)
Received: (nullmailer pid 407514 invoked by uid 1000);
        Mon, 21 Dec 2020 19:27:38 -0000
Date:   Mon, 21 Dec 2020 12:27:38 -0700
From:   Rob Herring <robh@kernel.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:dac:microchip,mcp4725: fix properties
 for mcp4726
Message-ID: <20201221192738.GA407457@robh.at.kernel.org>
References: <20201216101316.1403-1-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101316.1403-1-tomas@novotny.cz>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Dec 2020 11:13:16 +0100, Tomas Novotny wrote:
> The vdd-supply property is optional if vref-supply is provided for
> mcp4726.
> 
> Also the microchip,vref-buffered makes sense only if vref-supply is
> specified.
> 
> Spotted by Jonathan during conversion to yaml.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  .../bindings/iio/dac/microchip,mcp4725.yaml   | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
