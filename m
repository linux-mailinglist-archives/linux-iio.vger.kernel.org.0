Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA33DD754
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhHBNj6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 09:39:58 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:35404 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhHBNj6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 09:39:58 -0400
Received: by mail-il1-f175.google.com with SMTP id k3so16455624ilu.2;
        Mon, 02 Aug 2021 06:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lMmS75BBYZrZwVcj5qdcK5fUdGJveeoFTuyQ8W/piWQ=;
        b=oF/UliNQKvfHIuEpwFIVDHIVlW5EDp8UkQHKRuu7G7icDaNdUT1H84/4FN/IFMiHXY
         joUvg3Etvu44jnm1tbNvijO39d6ySc+mG6HhdHPq4FGz8F2FSVXgpCEVRDBN2Dp89PwQ
         iQZybJluG3OwNlqUl0s5QhVkuQwiNXh7EYFQwWzHbmsexPdq6h3hNLLUsa2dP1iCgZiB
         xJSi2He91lxLEnRgmadDHFjRPK4ZNqCbIZ5KuV7Fkh+ddtinq4O+1M5+/m2Q77ca8VMV
         9ytHHxaGk0YY2TIgkxHpP4Lo0dC24tGvcCizzEVnt9c0Pe5TK/RwuW2V4/Vs87n2jmlX
         LYOQ==
X-Gm-Message-State: AOAM531Y2pGxFYPGIfOtFNlfbKauMOz4LUQRv+P5k1y49YI4sNAeXbaO
        RLWNbSBoL7r+J71tvV6f2Q==
X-Google-Smtp-Source: ABdhPJxf0ZYJw/fZMjM13lKgISlILvCh3tx8qSjPrDlSPJvoPKdLXZWuZRtIDYY0v4IMl6TM5bc5uw==
X-Received: by 2002:a92:ca8f:: with SMTP id t15mr617420ilo.262.1627911588427;
        Mon, 02 Aug 2021 06:39:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i7sm5609333ilk.7.2021.08.02.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:39:47 -0700 (PDT)
Received: (nullmailer pid 918762 invoked by uid 1000);
        Mon, 02 Aug 2021 13:39:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Dragos.Bogdan@analog.com, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        Darius.Berghe@analog.com, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org, jic23@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
References: <cover.1627709571.git.lucas.p.stankus@gmail.com> <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: Add binding documentation for ADXL313
Date:   Mon, 02 Aug 2021 07:39:43 -0600
Message-Id: <1627911583.064913.918761.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Jul 2021 17:36:31 -0300, Lucas Stankus wrote:
> Add device tree binding documentation for ADXL313 3-axis accelerometer.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl313.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.example.dt.yaml: accelerometer@53: interrupts: [[0, 4]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.example.dt.yaml: accelerometer@0: interrupts: [[0, 4]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1511954

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

