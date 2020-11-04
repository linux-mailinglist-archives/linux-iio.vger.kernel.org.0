Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406872A6CB4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Nov 2020 19:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgKDScd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Nov 2020 13:32:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43778 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDScd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Nov 2020 13:32:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id t143so11603017oif.10;
        Wed, 04 Nov 2020 10:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=300YdLoIyeU5aKbjDs5NItaT9gZ3hFeS1uekqV/d+mE=;
        b=lJz+ApwpFPB/ZFGP4Ow623yQs0rTz5MTV0XtOWYhY52Jhh9fK/FkjCrvf8UIkwZj0m
         ZSpfETPabnE4XhYegurQZqo1d40hD8PlDzdZO/ZKYhZ6370Fk4lKnGOn0zW4c604sCG3
         QvtZvT+gif01NA6kRUVZbQsjNZ1kwI/TiQDeJBIqECy7axwmeyqpexkm7ndG33wuXfc3
         f1CGN1zzqmKOQ7CvP5Lan2IdsI+gN+LMsdgtbjUHBZey/l2Oeo5w8VApRCswT/+rL84N
         RPiyK7aqC3ccHK96thMZtaPlZKRYpeWIL3xZfn7RZ/nr5MjXa1VqUtlerXAx900SbkGD
         FJKA==
X-Gm-Message-State: AOAM5329EzHAmzIcxZEjQsbUXN6m7lIUHMqJzqrVP3U9rgDVM+0TdQw4
        y6iFsnGCduVIQVFl0ruohw==
X-Google-Smtp-Source: ABdhPJz00/M3IYCTJO7Dw9Ou6hkev6/Azqgqrw4W1uP4oowWgcUZhKw5HlKN1f6jORePrZDPRCm0jw==
X-Received: by 2002:aca:d445:: with SMTP id l66mr3175334oig.37.1604514752242;
        Wed, 04 Nov 2020 10:32:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h7sm722359ool.34.2020.11.04.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:32:31 -0800 (PST)
Received: (nullmailer pid 3915209 invoked by uid 1000);
        Wed, 04 Nov 2020 18:32:30 -0000
Date:   Wed, 4 Nov 2020 12:32:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 01/15] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20201104183230.GB3913864@bogus>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
 <20201102174950.1148498-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102174950.1148498-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 02 Nov 2020 20:49:36 +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: 'io-channels' is a dependency of 'io-channel-ranges'
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/iio/iio-consumer.yaml


See https://patchwork.ozlabs.org/patch/1392425

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

