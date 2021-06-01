Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0818A397441
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhFANdz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 09:33:55 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38896 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhFANdy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 09:33:54 -0400
Received: by mail-oi1-f174.google.com with SMTP id z3so15471751oib.5;
        Tue, 01 Jun 2021 06:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QvmcOZsZvJ8rjffzPYq9FV7xq/HrOh7WWu/CoCNAFEc=;
        b=QUhSHGpoH1wv/n4BSVKywcS90q56+ZOw9AFMYK2K9Oa2cFZ8NgeNTZBBL7SmYL3TDp
         gEneKQZshrzV40sORJZG1WPPht5VY3/UjiIdeWS9E1xBUE4mNeEjPIcOGaFojOCA4X0Z
         A92fDdBqD6nVAho/YLoYk0ospvGN2FEuoatfIDMJ2Zs5ZHXKhdtSVfTptfp1Kx9qst6z
         4MMs0zwV8UGXr9Cpb0c+x/OrQPH6U2N7Htt60tRZm0buj8JUpmTprxsd5sDi4OddjKQ3
         5Lh1dkW9YcpW/9FKrukhZ1sOO2nWA1Yh2LFpXf6tcng3JHLptxoOapTpffT79lL01R9W
         JlZQ==
X-Gm-Message-State: AOAM530Zuk7SYdupQ+0lOhgpB/SAAP7q1n5uOXk/8nKMyVOGPIYqyhGH
        FkSUJ+0459FynweR9HDqs1piwTJE9g==
X-Google-Smtp-Source: ABdhPJwfynP90LEUrs5Q0HG4G+9DDHScR7rXZWIzk9ciyCyv7nGTgPV5GxVUjVOJLz7PqjF8pyqGpA==
X-Received: by 2002:aca:1916:: with SMTP id l22mr18027304oii.48.1622554331713;
        Tue, 01 Jun 2021 06:32:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 129sm3421860ooq.34.2021.06.01.06.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:32:11 -0700 (PDT)
Received: (nullmailer pid 242354 invoked by uid 1000);
        Tue, 01 Jun 2021 13:32:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     lars@metafoo.de, michal.simek@xilinx.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, git-dev@xilinx.com
In-Reply-To: <20210528172959.15663-4-anand.ashok.dumbre@xilinx.com>
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com> <20210528172959.15663-4-anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Tue, 01 Jun 2021 08:32:10 -0500
Message-Id: <1622554330.004442.242353.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 May 2021 18:29:58 +0100, Anand Ashok Dumbre wrote:
> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 265 ++++++++++++++++++
>  1 file changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml:129:11: [warning] wrong indentation: expected 8 but found 10 (indentation)
./Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml:182:14: [warning] wrong indentation: expected 12 but found 13 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1485294

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

