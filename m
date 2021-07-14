Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C673C8836
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbhGNQB5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:01:57 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:41811 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhGNQB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:01:57 -0400
Received: by mail-io1-f48.google.com with SMTP id z9so2670571iob.8;
        Wed, 14 Jul 2021 08:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tUKnLnW9tJCIkEj0MUfsqKQ0W+BxFEoUZzHVyUCYUY=;
        b=T8sBUVKo4P6S9uKuM6oGC1HgsaU991o2QMB90U/X4hTlM50SO6oYApBDM8h9wEWd65
         SxRpXavnICFcimz85d1Zvaw/t1EvxZjJy/R4KZdgv1nmo5aprFS2hYJC/FJzjiwN94kd
         npMOBkbTuMx4h9A8o3akeJna3/Wkg11s+ZzdEFpq0Oq5AFHkmVFMOXUAcvOQJXDPfuMw
         P7MnEGP4Y6UDvxiykUgwx/R5LR07lmUu1Wbn/UI/+g684ltQZ8uRcDIOx1d69OWyuyQT
         p8vn4zNwSLiiye8h9wUTEEtSxf6oJ/07IKtu5k1C23qKpohRGetfM0cCn+1F6FtUV86a
         j1Cg==
X-Gm-Message-State: AOAM533ug736PsC0KBhv3OMeCSRWFV2sA80rGseMPj6rrZCp9pwuQgGh
        prZhl8qSvwa6R66ScAvjHQ==
X-Google-Smtp-Source: ABdhPJzd797s0lWzaRSpjDwQPCImS0Uo/9Og/MoxPAw6kZ+o4rsYUpdlcFeSd1Vy8GgjiRy20TiKpw==
X-Received: by 2002:a6b:6209:: with SMTP id f9mr7900407iog.147.1626278344297;
        Wed, 14 Jul 2021 08:59:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x11sm1352208ilc.40.2021.07.14.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:59:03 -0700 (PDT)
Received: (nullmailer pid 2655114 invoked by uid 1000);
        Wed, 14 Jul 2021 15:59:00 -0000
Date:   Wed, 14 Jul 2021 09:59:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 13/15] dt-bindings: iio: dac: adi,ad5791: Add missing
 bindings document
Message-ID: <20210714155900.GA2655051@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-14-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:42 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Documenting existing bindings for this device.
> 
> The Linux driver in theory 'works' without the two supplies that I have
> listed as required, but without a valid scale.  As such I've
> documented it as required.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5791.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
