Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C938F3C883F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhGNQCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:02:36 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:42516 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhGNQCg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:02:36 -0400
Received: by mail-il1-f170.google.com with SMTP id h3so2072535ilc.9;
        Wed, 14 Jul 2021 08:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YBlWgK3FCCFa2od/bNdcJpWSY8quXkEJMdJ2dV3mV/8=;
        b=ia3ECRC1OFIPAplQoyiiUU2dAafiQqi0CT5p4nMxb7H60kLSfQI5/iNfXseSTAvayS
         17vl5vgYgGfBeV6wVYhrFjhHq0nyuUJFuzi/ekwpA6869unjoLMgzJxZ/PXdJ+sDyf57
         ZYW+p9dwj8zeCQRnM/aosEtD0eqlKHhwWnCYTdeUq9qrv3I3bGbGSm/4o5gjPi6kTeiB
         E45HJnqhyZrvO4cYPzyQnZQqrhXSH//CfJvBA3JD6gRlkSH7VC+0YBAjOVjz/vu/+VOK
         YLO5eoT1QJVACBRGq3F9NRDMMRe4GT6rizWMsYK0MlBewVb8WCGfKrxmz5+pwAqkwqjY
         dbmw==
X-Gm-Message-State: AOAM530Q9dtrh/Jl6ksK9mG69eOP+OkDMblpbFhDa8iz0YZOLhxDp1kL
        3kO7jffwJrxsjDZHrKuShQ==
X-Google-Smtp-Source: ABdhPJznLyp32BGDBpNhx67H0K+NwYYdxgg1dUiY2GdoRI/PZ2kbYDI6bxNxve5W9bBGO/zpYTO2iQ==
X-Received: by 2002:a92:3206:: with SMTP id z6mr3908370ile.201.1626278383700;
        Wed, 14 Jul 2021 08:59:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k19sm1510762ilh.60.2021.07.14.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:59:43 -0700 (PDT)
Received: (nullmailer pid 2656385 invoked by uid 1000);
        Wed, 14 Jul 2021 15:59:41 -0000
Date:   Wed, 14 Jul 2021 09:59:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 15/15] dt-bindings: iio: dac: microchip,mcp4922: Add
 missing binding document
Message-ID: <20210714155941.GA2656277@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-16-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-16-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:44 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding for this family of microchip DACs.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Welling <mwelling@ieee.org>
> ---
>  .../bindings/iio/dac/microchip,mcp4922.yaml   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
