Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCF2FAEAF
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 03:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhASCT4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 21:19:56 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:39755 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405472AbhASCTy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 21:19:54 -0500
Received: by mail-oo1-f48.google.com with SMTP id k9so4574733oop.6;
        Mon, 18 Jan 2021 18:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3u4gYcPSXgUzJz3mRUEjcIw1Bnv/6tcoyBz5DKSZzo=;
        b=dz4heMmWbwcqMhCdKZ3yD9qqgLdLXv2xNsu/pSK7PXsBbm28btNGbTPGRNcXMMXeh+
         UsIVSsn8As0lJ9FeYjtFyitAMe8EIb7ycoCrSyxUJe3ZTUP/9rRrPmfvHLr+IHvP/lre
         z96d2phvn2sxLIo4UC/TlkYNLaDqgNj0CBtaND6oB1UV/829d9N2XiiReU3zbmiD7xCZ
         rDKKg3QNjC7G82uV1rOjv+9Ld/GiZgU6rnyTfwpdOH+9HX9p+VjiCPgxdu4VJsJVyeWX
         WK4gx+1V8wPqzzxOcv8gVnfPJ7o5Pb9Rr8dOXkc8ZMIkO0QowWKUxVwxFuoR1fqnVLw0
         nXzg==
X-Gm-Message-State: AOAM530VRLqH5jYWFHskzLf5hH5TQe72+s7W6YmRhySjw1LEJmlPFdvV
        oaU8LsuCBVRZ0RMsPDYZrg==
X-Google-Smtp-Source: ABdhPJxX3RlDer2G998i8xnlnlj2PpoKSe4CBXO9Am0IInESwsOgtupdcDvk/vALlx5gaTM2vANpzQ==
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr1326027ooc.85.1611022752783;
        Mon, 18 Jan 2021 18:19:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 49sm1139835oth.31.2021.01.18.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 18:19:12 -0800 (PST)
Received: (nullmailer pid 760297 invoked by uid 1000);
        Tue, 19 Jan 2021 02:19:11 -0000
Date:   Mon, 18 Jan 2021 20:19:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jishnu Prakash <jprakash@qti.qualcomm.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v11 1/5] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20210119021911.GA760171@robh.at.kernel.org>
References: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
 <20210118145200.504951-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118145200.504951-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Jan 2021 17:51:56 +0300, Dmitry Baryshkov wrote:
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
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: 'io-channel-ranges' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml

See https://patchwork.ozlabs.org/patch/1428196

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
