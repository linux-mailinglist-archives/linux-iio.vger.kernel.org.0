Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF869242D2F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Aug 2020 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLQ3K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Aug 2020 12:29:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36328 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHLQ3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2020 12:29:09 -0400
Received: by mail-il1-f194.google.com with SMTP id z3so2353452ilh.3;
        Wed, 12 Aug 2020 09:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shJhchmhhxZdr1NjkF9w+CnbvrxJFiRWP6z3qBoGUtw=;
        b=SWpsr1EyBAZDbOneufuZzcRrBg3I7z+s1Cnpjm3QLg5surGbiMLTWouYlDdfyUGMw6
         nYAOFFRLQU4ei6AnbNR0MmgAXlVfN9Rcka+nU3UHNj9emWQVbhv2CvYSL69YwFHUA7cT
         NcY1r6TGEPk7qaWkWXob/6o6yUrFl6F0jeo8XTt/15ykOk3jl5GlzkpE4ehjEeCPNIJ8
         OQrJtv/wKqM6IaD8D3jWyOqOzbBCqaDaxDS3t8v4idNoMQdNQE8ZHHxHpbRZV94o1a+l
         TyDuw+RpHTPBuGEN18uIU9Ska6jc5wTIgzq3+Sgq9h+CQa6yC6GVOswnEcNe9cQgGL0U
         BdRw==
X-Gm-Message-State: AOAM533vnzy8fIPUcK7SZHtFopsJpj5CVwdp3iTyVX0fVF7oV2/kHaVR
        GYLocBL0GgsZJkSorkqF5w==
X-Google-Smtp-Source: ABdhPJzSlQrhly9yRpohPOBo/vEguu5epEQwZDFNln5sX5E6aUSVttUZbUYTh+M4AvJVJGs9qDlT9A==
X-Received: by 2002:a92:4957:: with SMTP id w84mr497980ila.164.1597249748802;
        Wed, 12 Aug 2020 09:29:08 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n3sm1300931ilj.29.2020.08.12.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:29:08 -0700 (PDT)
Received: (nullmailer pid 2324129 invoked by uid 1000);
        Wed, 12 Aug 2020 16:29:07 -0000
Date:   Wed, 12 Aug 2020 10:29:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/13] dt-bindings: iio: adc: ti,adc12138 yaml conversion.
Message-ID: <20200812162907.GA2323853@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-9-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:48 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding conversion.  Only addition was #io-channel-cells to
> allow for potential consumers of the channels on this device.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  .../bindings/iio/adc/ti,adc12138.yaml         | 85 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
>  2 files changed, 85 insertions(+), 37 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/iio/adc/ti,adc12138.example.dts:26.34-35 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:330: Documentation/devicetree/bindings/iio/adc/ti,adc12138.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1334: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1342594

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

