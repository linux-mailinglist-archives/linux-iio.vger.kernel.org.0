Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66C46A6C8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 21:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhLFUXw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 15:23:52 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44651 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhLFUXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 15:23:52 -0500
Received: by mail-ot1-f45.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso15129254otj.11;
        Mon, 06 Dec 2021 12:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6zqTsj+dFTrmTG1Ez8HFYlIWgA9VO44scMyv1E4QzAM=;
        b=Vn8d3WMh6XQi1Ifc0/xLRSfI8t4C+frk8s87PuLPXk2GhJgkKcnsJChB4b7UMQAE5X
         FFbZ81GXHUYyJyOtaHF1Ay6qIqgRkBc9GLVcVSAQdtqdloaDwYDpJzFkdKXQWPxZGxUd
         mPVvBAV/iz9Ztfo4xYA4R4/zb9JVXvyoJ89VNcDFak39F/m2C5AMY4TG075AloMAhEu8
         DsRBKcrA6ToveDDG38ra+8chIJTjGf2nMepI8FA6mrM01oQ9CbRw2ebDbTb5sbk7WmsS
         jDhIPy+nkCZ1XwmmIHOFx6W95AUm6geiZ9tB3nmq0Hx+E5VLDss/iXFQST2FHg50kKNl
         6zTQ==
X-Gm-Message-State: AOAM530uAgtgCMvDH1chmBfV0/W0bgYg21CLyBIfPIMwFkd+WIdhPvO4
        7thrBzUiT0RtWqcFYPQEHEpao1cZVw==
X-Google-Smtp-Source: ABdhPJwae2E3SP4ilAnZ2qjRo94JXN6XWBNesvdl5D8JGxxx6kmoRBkFsjPZE11G5prFhK+O1IkVTw==
X-Received: by 2002:a05:6830:195:: with SMTP id q21mr30783743ota.355.1638822022807;
        Mon, 06 Dec 2021 12:20:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm2803896oig.28.2021.12.06.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:20:21 -0800 (PST)
Received: (nullmailer pid 2518378 invoked by uid 1000);
        Mon, 06 Dec 2021 20:20:20 -0000
Date:   Mon, 6 Dec 2021 14:20:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5755: drop unrelated
 included.
Message-ID: <Ya5whKgsd7O3gZW4@robh.at.kernel.org>
References: <20211204165817.2768110-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204165817.2768110-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 04 Dec 2021 16:58:17 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Probably a cut and paste error, but the binding header used in the
> example is for the wrong device and nothing from it is used.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
