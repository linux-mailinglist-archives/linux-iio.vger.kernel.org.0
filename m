Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6364B20E768
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 00:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbgF2V5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 17:57:12 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37081 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404693AbgF2V5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2020 17:57:11 -0400
Received: by mail-il1-f194.google.com with SMTP id r12so8660504ilh.4;
        Mon, 29 Jun 2020 14:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PfqS3OG1vRy132QSpT7juMRTX02P9BHgaTSVVVztCHs=;
        b=DfNPn8nSieYrxwZR4kiLsm5q02mjI1zLF6jaju7c5LVQaTnUtQ73iNsJ0b7aZIjBVz
         zi2WfH6d9xMTGMj+tjJBIADasYixGuXhcMLUofck3f0pOBKdBx4fOGDsTYdT3p9FhWf5
         lQrNnOEd0BtgDD/c+ujEBRxmOrApSX8KUqBKXu2pIe88v+ZLNMEHV5BWPCLpcVly3KWx
         wfieq2K6yvfH2iSUAGFxudO/HyyLTFlZVyGOVl0g3ipZBQwitKwQFSUNvk1eqnYkZ7sS
         lJJ96LsjgL2Bgud6Jld3Zv9JJWwngNhMfpkY48n6ukIdBZIXL7sm5VBx6ioh6x9NVmEV
         zeGA==
X-Gm-Message-State: AOAM5327a4cQzBiqqphjaMzp+zSTfdlYgXt4ye2BnF2pV9+JTHLaLxf0
        odKNSyKEtRwjHukWefUNAg==
X-Google-Smtp-Source: ABdhPJw0pDnSmcQd55WjOydr5ed57EqP4M5g0HlMaKpmBlY4fMmFnosgqPZ9g8WdnUknA418MQ3pSg==
X-Received: by 2002:a92:cd01:: with SMTP id z1mr355216iln.103.1593467830459;
        Mon, 29 Jun 2020 14:57:10 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id k126sm540191iof.50.2020.06.29.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:57:09 -0700 (PDT)
Received: (nullmailer pid 3003522 invoked by uid 1000);
        Mon, 29 Jun 2020 21:57:08 -0000
Date:   Mon, 29 Jun 2020 15:57:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: thermal: qcom: add adc-thermal monitor
 bindings
Message-ID: <20200629215708.GA3003126@bogus>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
 <20200621193549.2070434-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621193549.2070434-2-dmitry.baryshkov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jun 2020 22:35:45 +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml:  while scanning a block scalar
  in "<unicode string>", line 114, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 115, column 1
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1313977

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

