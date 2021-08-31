Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FE3FBFD8
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 02:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhHaAEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 20:04:51 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44563 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhHaAEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 20:04:49 -0400
Received: by mail-ot1-f54.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so20606560otg.11;
        Mon, 30 Aug 2021 17:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cIxLbC0V4V1OdsC/Ly6jKX0YPVdFxUbPkUbq2zoGTMs=;
        b=KWoCpj8kuWUampiLPX5fZe+Ku32AA01l4/dsT/GW0Ut5KGxm7nqL6YWDaERRxtfK/L
         v65M0QFbT/giv+6FelxsYh3BPWffWgJ/wwtZAfRsBgEoylwbp7byAreifBYKsxvj+5/4
         XXlFIs7s+eb2CD9R6pCZ13zRPMa6L1Me4zDq6govzf73x2MTHM/lIqPCkiVoESIvDOka
         Bit9CJB6OHslfbLe9l/YwSfduU6d2VfJvZ6POoawAcywppcxcqySv18nzwWr6BqHakhR
         n1RVrZviqhWjBMpV2rUiHMnK1ql9VecYvwVCV5FE8LHNW8BcgpzkCMxF4LOYTlVPVXrv
         YjHg==
X-Gm-Message-State: AOAM532NWfQz0byOG2gLQ/EE1ErReIGjiFmvQ/cSUST7mcLxUIijSLxE
        KNisO6BTTBJnBmjC43WjBQ==
X-Google-Smtp-Source: ABdhPJzApwMo/dFh6AfQatjs1hglDwJoGhq5PQw87cu4H4prFWq6jzpKxMtFIM1NqNnPtbqUya0biw==
X-Received: by 2002:a05:6830:913:: with SMTP id v19mr22138821ott.131.1630368235166;
        Mon, 30 Aug 2021 17:03:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v8sm3559453ota.16.2021.08.30.17.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:03:54 -0700 (PDT)
Received: (nullmailer pid 2940837 invoked by uid 1000);
        Tue, 31 Aug 2021 00:03:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     shawnguo@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        lars@metafoo.de, festevam@gmail.com, jic23@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.dewar90@gmail.com
In-Reply-To: <20210830172140.414-5-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com> <20210830172140.414-5-caihuoqing@baidu.com>
Subject: Re: [PATCH 4/6] dt-bindings: iio: adc: Add the binding documentation for NXP IMX8QXP ADC
Date:   Mon, 30 Aug 2021 19:03:53 -0500
Message-Id: <1630368233.478982.2940836.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 01:21:38 +0800, Cai Huoqing wrote:
> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
> documentation for NXP IMX8QXP ADC
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 120, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 65, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 71, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml:  while scanning a block scalar
  in "<unicode string>", line 65, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 71, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1522287

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

