Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F362637D8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIUvw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 16:51:52 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37722 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIUvt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 16:51:49 -0400
Received: by mail-il1-f196.google.com with SMTP id b17so3680695ilh.4;
        Wed, 09 Sep 2020 13:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZ0V+EWC3K4UpIGuh9GM6nuw87M4KtvgCaC3pRhbpR0=;
        b=dyubtRweugoWggSzFF/0W+Q/Hcb/svgFy976702uKsLPeIHvrPZX9cHkthKyPOQL08
         qVl6fdUrvGx+vflFZpobWvfceR+mxDBFi7t+UWKlXQ5lmhdbAEVw7NuKySif56/WEUCY
         uhIOhu6AZT6bQS1VG+kewzzgZy5glAQh7DmplHhcIMXw4p369UjkyWiek5k8MhcDiI5E
         j5i5dl8W+9Q6/a1Pgw5wPEdeApUJ8rUUgnkmDMSihqCUF73ebigFp8ocPF9Swfpv21DR
         FmYYQKOdj8/mgT/V2KVV1O7p0wR6oa7fgQXHT7BvZ5rrXke/t+m7Bup3GpcnwebS28Br
         fW5A==
X-Gm-Message-State: AOAM532c5MQRFGoek/r0R2AlWXI0D//7V1faGgG8Z+Nn5LgtOEm9ZKfy
        c5kuNLe7ydh9re4c82hSEw==
X-Google-Smtp-Source: ABdhPJy1kcV6wfAb/ftXSG3i4traa3heeoxdRC++rZSScBAr1I9oWCzsx/X6zf2UhCPVoCzBQJRl4w==
X-Received: by 2002:a05:6e02:1031:: with SMTP id o17mr4440011ilj.47.1599684708340;
        Wed, 09 Sep 2020 13:51:48 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o15sm1912691ilc.41.2020.09.09.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:51:47 -0700 (PDT)
Received: (nullmailer pid 3055582 invoked by uid 1000);
        Wed, 09 Sep 2020 20:51:33 -0000
Date:   Wed, 9 Sep 2020 14:51:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-iio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 02/10] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20200909205133.GA3054559@bogus>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
 <20200909144248.54327-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909144248.54327-3-dmitry.baryshkov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 17:42:40 +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:25.17-30: Warning (reg_format): /example-0/adc@3100/conn-therm@4f:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:33.13-28: Warning (reg_format): /example-0/adc-tm@3500:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:21.31-29.11: Warning (unit_address_vs_reg): /example-0/adc@3100: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:24.27-28.15: Warning (avoid_default_addr_size): /example-0/adc@3100/conn-therm@4f: Relying on default #address-cells value
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:24.27-28.15: Warning (avoid_default_addr_size): /example-0/adc@3100/conn-therm@4f: Relying on default #size-cells value
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dts:39.26-45.15: Warning (io_channels_property): /example-0/adc-tm@3500/conn-therm@0: Missing property '#io-channel-cells' in node /example-0/adc@3100 or bad phandle (referred from io-channels[0])
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: example-0: adc-tm@3500:reg:0: [13568] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: 'reg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: '#address-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: '#size-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dt.yaml: adc@3100: '#io-channel-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml


See https://patchwork.ozlabs.org/patch/1360722

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

