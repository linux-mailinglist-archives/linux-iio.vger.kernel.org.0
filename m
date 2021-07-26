Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2E3D68D5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhGZVCK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 17:02:10 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:39666 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZVCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 17:02:10 -0400
Received: by mail-io1-f41.google.com with SMTP id j21so13709020ioo.6;
        Mon, 26 Jul 2021 14:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zO/qsR+imuZkYrRTqh5CVfo8l4ZQQ/jXXOgdZGFgQdM=;
        b=RGZLR0lA4TOq+elBqK90otiiMW7AR0prJrLidHHYTR4BaSzYxhsNVQG6olBV3OTuq3
         Nt6T5P7QcEx+9nCUdmiHs03EyzyNlAhKtaS8uL3ooM5fKrBKUF3mcDDD61EsYKYcP5pu
         FxWBYeXAKhEhvDp77YxIEJ7RuO5WA+5aHkBe7D2wwmRaE/K/LMqV6zXKeUvPJQOm+DOq
         bz4C9xdXvIsENub1NPsJq4QghbuZ2JG1oBsC0ahTYFb0ojBnGwLgMv3F4747FikJJpUO
         dXiylNO+MMzPI5b1oNZ7ocUy/sZjjDK+aCApAvXYZ5HfOxEwy+yub58DV7CJeU5lXbrU
         f4Eg==
X-Gm-Message-State: AOAM530QcRl2LZqpUOM2DIdpFlB+wKs2UOaQQDrpvt2TtmZ2M5K0McNZ
        IfH1fYNEJmp4VHUreBkP2w==
X-Google-Smtp-Source: ABdhPJy5JQNYCXFdcR9knijPpRZwXYHyhbxKUkq0xGwntpFZN5S6tMl60m6HRhN0UWTt7a5AdCP48Q==
X-Received: by 2002:a05:6638:1356:: with SMTP id u22mr18602953jad.39.1627335758264;
        Mon, 26 Jul 2021 14:42:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w1sm455386ilv.59.2021.07.26.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:42:37 -0700 (PDT)
Received: (nullmailer pid 914066 invoked by uid 1000);
        Mon, 26 Jul 2021 21:42:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, devicetree@vger.kernel.org,
        alexandru.ardelean@analog.com, Darius.Berghe@analog.com,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com
In-Reply-To: <20210726184917.301070-2-puranjay12@gmail.com>
References: <20210726184917.301070-1-puranjay12@gmail.com> <20210726184917.301070-2-puranjay12@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Mon, 26 Jul 2021 15:42:30 -0600
Message-Id: <1627335750.973256.914065.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 00:19:16 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl355.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl355.example.dt.yaml: accelerometer@1D: interrupts: [[25, 1]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl355.example.dt.yaml: accelerometer@0: interrupts: [[25, 1]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1510166

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

