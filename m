Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB92944FCE9
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 03:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhKOCNh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 21:13:37 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43854 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbhKOCNb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 21:13:31 -0500
Received: by mail-ot1-f46.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so24768422otm.10;
        Sun, 14 Nov 2021 18:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=z8ZfoyfHKKBFGiYdX8Dup3pn0hyus7Ct6ubn5t+9TRY=;
        b=ff+KJsfkKkAxqJ+i2Ezg8QoQpK9VhYcfrnd7lknERHrCSepK9gdUcUNtrLiML7imRP
         nP2TFrzwVHHrIrnocbE5lUMKbsEqG1Mb0Wrvb6iexat4LVjion8J1weuo7bdD0E9EKMm
         rfr2jCD6MvvtGed0q+e/dyMBM0vWCwk7UCfDrnbtmuJpV8pSdnlvYCepK+hZlnK6mWjL
         21/1tBHL5IQT2VKGe8amMPwTM7UiQ14PyV1XG6knbFgzUU1Yqv8cD/mjdhy3VPkZjZ+v
         OdHR+h50eDrI2rtRIxIRGBMRVOSx+Ny+cOLNH7J2iuVpKo1TyrEBW1o0nmglA4sKcyQN
         jR+Q==
X-Gm-Message-State: AOAM530m1vFn9Pqyqa6Lg4eKP1eN1Zs2PdITYMnGTWNuSAnKHtSXDOP/
        TVLrejV6zri+4a51J7K7/w==
X-Google-Smtp-Source: ABdhPJyugnIoBugvV/ymi2bazYiqcEFTPF190Q/UlJQEmI8dYoZuC1NfsXInsFevOKZyBCZy8m8rNg==
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr27762637otr.238.1636942236077;
        Sun, 14 Nov 2021 18:10:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u136sm2894379oie.13.2021.11.14.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 18:10:35 -0800 (PST)
Received: (nullmailer pid 3712870 invoked by uid 1000);
        Mon, 15 Nov 2021 02:10:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Gilles Talis <gilles.talis@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net
In-Reply-To: <20211114132335.47651-3-gilles.talis@gmail.com>
References: <20211114132335.47651-1-gilles.talis@gmail.com> <20211114132335.47651-3-gilles.talis@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add Sensirion SHTC3 humidity sensor
Date:   Sun, 14 Nov 2021 20:10:32 -0600
Message-Id: <1636942232.952764.3712869.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Nov 2021 14:23:35 +0100, Gilles Talis wrote:
> Sensirion SHTC3 is a humidity and temperature sensor controlled
> through I2C interface
> 
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: shtc3@70: 'sensirion,blocking-io' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/trivial-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1554826

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

