Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA61AD15D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDPUmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 16:42:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41516 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgDPUmo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 16:42:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so155207otp.8;
        Thu, 16 Apr 2020 13:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZ0RlsGr2+5/XacCO4EL2cmFSLDykRvrVImbCZUcZLg=;
        b=DvAOXBQonaCJPEGwmplK2XFnZME3s8BkyLLNEDBkWC1BZhAS7XFunAZxwBXS3hhPt/
         OS+pMokkLMirRFe2ohlfmBnnlzPPHCyTK1BKXBWZSC6t+PFEsQGKeVNSOlGKoXMXcFyV
         X4XFLPndA4s88qq7vPHxljsLi+eKlpvckfE7Yf1SNN8LyLlpTDf7AabClIDmIAfivqMv
         URFEmY6O+zcygEO3frWCubRCJ8M6qIB5EahaX7FH/IASMvwi7g8lj57dINFVKsE6CVYC
         loP/cl/k7fLGUxqcdPEWFMHpKQviANNTG+WpPJ3E+yl6rsT6Dtl7c/aKnzNSwpE/llBM
         jRoA==
X-Gm-Message-State: AGi0PuavByK+0JR1Z6cqxl0QoOz0QPGsr7CgIX4BVPuBsVBBiJxiC1I0
        k8l5EPW2bU4T/n4OQqKz6A==
X-Google-Smtp-Source: APiQypJo+wfUfZ+Jua5JzMhkPsJfsCwdLjpvmnCen6w86M/uhXfd6Uaka/f2N84W9kSeMbR05r4Myg==
X-Received: by 2002:a05:6830:15a:: with SMTP id j26mr28677476otp.248.1587069762956;
        Thu, 16 Apr 2020 13:42:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s25sm2712659ooh.22.2020.04.16.13.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:42:42 -0700 (PDT)
Received: (nullmailer pid 14696 invoked by uid 1000);
        Thu, 16 Apr 2020 20:42:41 -0000
Date:   Thu, 16 Apr 2020 15:42:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jishnu Prakash <jprakash@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V2 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
Message-ID: <20200416204241.GA14143@bogus>
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-2-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586942266-21480-2-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 14:47:44 +0530, Jishnu Prakash wrote:
> Convert the adc bindings from .txt to .yaml format.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 -------------
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 288 +++++++++++++++++++++
>  2 files changed, 288 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dt.yaml: adc@3100: 'adc-chan@0x39', 'adc-chan@0x9', 'adc-chan@0xa', 'adc-chan@0xe', 'adc-chan@0xf' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1271025

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
