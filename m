Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC390197FCD
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgC3PiW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 11:38:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40338 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3PiW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 11:38:22 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so16256371ilr.7;
        Mon, 30 Mar 2020 08:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXjMGOdpbJrvmMf7CXHzMRGgy3e0VQX/+0etqeIYW0I=;
        b=NPbkt9poFni0A6IYIINdF5/iAZ0ePAUo+11fz2WBbxooSVuKgd3HM1X5L0vrPTuasE
         ftt/LIYPPZCy3XXeO/VlXQUVj3NHDEr1POGtCP8Ll75UM3s7uUtMecdU02Myjr2A24RJ
         0Ytp/GAx2JCXAB/JHPgvB1BxOTcYkZnQCZHclnyz6ukR8fgeOXmjpaYKIhVzl4vVZGw9
         QNQ+eI0PP+W441mkg/42F/zm2h+HzLjRGtyPU42hC3bGe716NnLobyghGaxeHEke2yrT
         m+RoZFWzkBClvyRjbzAOF+zKyV7buIkSxkGp/wbca7B5THdcSjq/bG4Mxnpw3e6rJAWf
         YDhQ==
X-Gm-Message-State: ANhLgQ32zwh3qeRCyUumfYqJzS1j6TPJ/vRuaRaRl7B5laEIoq9OU38j
        ePZOTRoSjyG/72Uh9+t7DeeNr/k=
X-Google-Smtp-Source: ADFU+vs3+gql6fDj89qq2KjSl6YPLLP7Rggs4xlleR1CpIoDOZyi6hisfvhiRdP4SAUnEH4MpKBuLg==
X-Received: by 2002:a92:cb49:: with SMTP id f9mr11644813ilq.193.1585582700524;
        Mon, 30 Mar 2020 08:38:20 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h29sm4969835ili.19.2020.03.30.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:38:19 -0700 (PDT)
Received: (nullmailer pid 19151 invoked by uid 1000);
        Mon, 30 Mar 2020 15:38:18 -0000
Date:   Mon, 30 Mar 2020 09:38:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jishnu Prakash <jprakash@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
Message-ID: <20200330153818.GA18495@bogus>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-2-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585064650-16235-2-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 21:14:08 +0530, Jishnu Prakash wrote:
> Convert the adc bindings from .txt to .yaml format.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 --------------------
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 178 +++++++++++++++++++++
>  2 files changed, 178 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:20.11-26: Warning (reg_format): /example-0/vadc@3100:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: vadc@3100: 'adc-chan@0x39' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1260800

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
