Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC630F667
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhBDPdL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 10:33:11 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38097 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhBDPVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 10:21:48 -0500
Received: by mail-ot1-f42.google.com with SMTP id t25so3737707otc.5;
        Thu, 04 Feb 2021 07:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=kUMjkPK/McmTxR+3enIboqlHKyis7paShiElKBa3hkg=;
        b=KoeXOa4rQV6zL9LyjIF7Y3UmXJHkBdahbiPo/YGQBXe/NztnprG3eLpgqTFvWMyxDO
         a+zWRavz6hv/riH3KEocrmAm+PAybw17eRaE0Y07l+tGPinVzL9/u2m63f+rfBUcT0Zn
         2LcVOWkIY9EftRAhd6wcy+xqe2OmQS0IAnFUA3p36ER3AFrvpMhePs4bvcASUjCyscas
         k0KJSKg3M0SRT0ood61HimmX0VrDP2HHx8oqUG4LHMxfCZ5jlhBKAGA2xBdesGaDGqlC
         De8YwIgN8mqEUcAW1N3utpjMwn4m1Zke1NeM5r+YTncT8mmOI5ks3qWqCahtu1NWx9Q6
         fN1A==
X-Gm-Message-State: AOAM5310lugIFXedHP037lGlK6b65LCG7WRZihp0v8hewX4Wuz6YgWmv
        isewiKy5LRIoFjgajMC1gA==
X-Google-Smtp-Source: ABdhPJzfp/QJEiThkrI+7dYQouB2O9bFRGwN8XxWckzXwf+CTGWl9wr9QQI0AK32fVQu+4zjUJOwSQ==
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr6323728otp.128.1612452064479;
        Thu, 04 Feb 2021 07:21:04 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a71sm1120804oob.48.2021.02.04.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:21:03 -0800 (PST)
Received: (nullmailer pid 452042 invoked by uid 1000);
        Thu, 04 Feb 2021 15:20:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
In-Reply-To: <20210204113551.68744-3-alexandru.tachici@analog.com>
References: <20210204113551.68744-1-alexandru.tachici@analog.com> <20210204113551.68744-3-alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7124: add config nodes
Date:   Thu, 04 Feb 2021 09:20:57 -0600
Message-Id: <1612452057.726074.452041.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 04 Feb 2021 13:35:51 +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Document use of configurations in device-tree bindings.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7124.yaml          | 72 +++++++++++++++----
>  1 file changed, 57 insertions(+), 15 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml:76:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml:114:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1435965

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

