Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BC3B97CD
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhGAUxm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 16:53:42 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:44600 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhGAUxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 16:53:41 -0400
Received: by mail-il1-f180.google.com with SMTP id f12so1425558ils.11;
        Thu, 01 Jul 2021 13:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NipVMUD4AP/oBRzH6hOs82IXgQLck6ND+VgxW1x2fao=;
        b=i23w40X6FN9c5rysQXeuO8heCsudGMZYXWlUufHc5ROUleIo7yagWCU/OWSyW0uZtQ
         G8IjebUgxT0BuvqPon6wq3gkXDXp3xP5x8nQ8eWiCafWT0XF7uOEgrN6v0i/mtq3eHUG
         jy/zRNjfw+AIX9XWVQN8fcO3TTXRUXTb8XKzn+s6VxPMJf+QVhmkHoKhBA+n65ArHrY1
         1HFiKnIoBHYr1jYknfczOMEArRK+ZtwivAqNKI3qfuJgDIIa/xY8Ee/cO48pgcWDsfkv
         vDQiZlriTC4s91DlZaYZCI2qCho2AJyEv+73TsQLR8xAzMkGBnVvq6/2pBFySzIfe6oq
         bgFQ==
X-Gm-Message-State: AOAM5330udU6VRjQ69oF74Ec540ZnXBlrvtiJEf8IblRckPBk/v7W80E
        xVHNPEWjSkh9AHLB4Xpy9Q==
X-Google-Smtp-Source: ABdhPJz1a6iDLhND1/k7nuQxxOfbn+7VdVawF4rSi9HdKdgHYo4uOWS4JwsVA3R8V5i/1llhr06LWQ==
X-Received: by 2002:a92:d209:: with SMTP id y9mr923348ily.143.1625172668561;
        Thu, 01 Jul 2021 13:51:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d10sm597106ilc.71.2021.07.01.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:51:07 -0700 (PDT)
Received: (nullmailer pid 2908607 invoked by uid 1000);
        Thu, 01 Jul 2021 20:51:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org
In-Reply-To: <20210701141648.131776-1-antoniu.miclaus@analog.com>
References: <20210701141648.131776-1-antoniu.miclaus@analog.com>
Subject: Re: [PATCH v3] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Thu, 01 Jul 2021 14:51:01 -0600
Message-Id: <1625172661.975476.2908606.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Jul 2021 17:16:48 +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ADRF6780 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> v3: remove `adi,parity-en` from example after latest changes in v2
>  .../bindings/iio/frequency/adi,adrf6780.yaml  | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:10:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:101:1: [warning] wrong indentation: expected 2 but found 0 (indentation)
./Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml:109:1: [warning] wrong indentation: expected 2 but found 0 (indentation)

dtschema/dtc warnings/errors:
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1499584

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

