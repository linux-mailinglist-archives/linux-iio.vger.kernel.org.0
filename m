Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D23C8801
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhGNPxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:53:34 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:42976 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbhGNPxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:53:33 -0400
Received: by mail-io1-f42.google.com with SMTP id x10so2668096ion.9;
        Wed, 14 Jul 2021 08:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rApmcys+uOCnLWU7Ux6hvuJcKoIEewFbO/tiA9gDF1w=;
        b=qf2X4Ob93QmzLkrjeNF3QwEo4FMCZj+T8ydzVRgmzXaPe6vw1rtG+vdgcPnRC9x+DQ
         4LdN1QmDAhnBQ2dzLvyxxNjJbY//GZHAq9u6TTBImVaICLL+b4Xnn3BoHpPI0vxQSoNU
         6ocH0H3ZFJZJ4AOsPPkgquAy66Vjn4k/VHRYIyXTv1JoVczYtfhDohiBf8skp8uNmKmQ
         m79V19tRYYaIuK/wf/W8YN8iUKkQ4mM9PbJAPpY2nrC+aoV8WSYS1ZpmP8vW0+1bd1VO
         nVOiBFgFHrxn4/u7BrBSL7hogx2IeOg7G8Y0xhfwbVxpRq4TWslF+ocpAzPoCDSvXabn
         xMDw==
X-Gm-Message-State: AOAM532U6WZVd37m6RglOcVKwAlpirop56EZhBOoKAdA68KDumTFtMea
        DDVaOkw8R6TMA1hMsrTHQQ==
X-Google-Smtp-Source: ABdhPJzzgEnnHmPPYs3eK8hH0zWd1KsxHZ1y992OIuw2arPFcHSwV8LhZMSF4kNolHpm24FpdXBvhQ==
X-Received: by 2002:a02:a797:: with SMTP id e23mr9527140jaj.121.1626277840100;
        Wed, 14 Jul 2021 08:50:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x16sm1417446ila.84.2021.07.14.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:50:38 -0700 (PDT)
Received: (nullmailer pid 2641157 invoked by uid 1000);
        Wed, 14 Jul 2021 15:50:32 -0000
Date:   Wed, 14 Jul 2021 09:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/15] dt-bindings: iio: dac: adi,ad5360: Add missing
 binding document
Message-ID: <20210714155032.GA2641112@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:32 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Bindings for the family of many channel DACs.  Fairly straight forward
> with just a differing number of voltage references (an extra one
> for the 40 channel ad4371)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5360.yaml          | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
