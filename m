Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF525C6F6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgICQfK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 12:35:10 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37689 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICQfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 12:35:04 -0400
Received: by mail-il1-f195.google.com with SMTP id b17so3273200ilh.4;
        Thu, 03 Sep 2020 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIfLZ14oR+6kVVplGeYdY3QZelcTYNmiPq+fUE3RZP4=;
        b=sCXDsd1ndeUvn1hXSgDSo19yqG+ius/m2Q8eEq8Ijmi/0ZymIEpV4Qr04VxMYXxvai
         jiQ9+4bRiEXwJD8jnYBGJ0KpGaEMrY+jG95/YGxYecqLav/vc6JPC28i8NV2tyLoq94M
         eAgpj+MIuGyGgcJfz9bG6UxHD/VaI09s7DhyigBbMPJSiOyp+hSA/H5Ga8Rpm0HKc+M4
         Xt9f8egzb57xyYNSHI38HYUBcwJy90c9n3C1jHD4DCGOSjMhXzRsQ6bQw1nJRH3JfYe1
         t0pkJGUktfbePMOKpTvreMGaBnJ/aTbKEc5GDnEG68cToJP40gHePjVTcz0eD3nfFp/J
         AnKQ==
X-Gm-Message-State: AOAM530wOJeeqzDm+ItcB239Kol+ghldG3Yb965ijzHK9n+II+aiMCRy
        5RLm+mPFbp34z3Erv+ZLVw==
X-Google-Smtp-Source: ABdhPJzAEffp2WonM7repJTb9yyQNn/3Nmi+Nn/JwPHkxriL04JXnRwvW1ue7iajeKEDm4+9ErJo6Q==
X-Received: by 2002:a05:6e02:1141:: with SMTP id o1mr1095908ill.275.1599150902693;
        Thu, 03 Sep 2020 09:35:02 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w70sm1713310ilk.87.2020.09.03.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:35:02 -0700 (PDT)
Received: (nullmailer pid 2909825 invoked by uid 1000);
        Thu, 03 Sep 2020 16:34:58 -0000
Date:   Thu, 3 Sep 2020 10:34:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20200903163458.GA2909612@bogus>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
 <20200903132109.1914011-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903132109.1914011-2-dmitry.baryshkov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 03 Sep 2020 16:21:01 +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:23.24-25 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1356633

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

