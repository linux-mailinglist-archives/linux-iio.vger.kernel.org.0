Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2144A34282A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 22:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCSVtt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 17:49:49 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:46079 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhCSVt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 17:49:27 -0400
Received: by mail-io1-f53.google.com with SMTP id k8so7629443iop.12;
        Fri, 19 Mar 2021 14:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IPHDJ/umprofnRpBVdWFXC1bay3IqbtQs+rWfOUqMjY=;
        b=jdxGFf9XlNZAvYQJGFmDhARD4IImrglDP4UU/XKjj2yLGfALpppOrbvk7FemVxmLYg
         pBIF+/NquD6IXDXHS0I/8GxBIvpOmWg+C9CnJa9Vt5oWZk5g5RI0sBPg0+gj0iz2jkX9
         e+bHrYgKT4X8LOcqqU3CNv1//4kvTt9op8nG5g58Z78osmqc0ek12wYIaBco7ezFi9Af
         pPbGkV6TBZnAg6LsCc46hFdg50QCwI8uNAqnLZkKAZzoO+cXku+ag3Y08R/lnFDgudkk
         fw3yOYTRuw65W2JSFhvwe5ujsigYMrYcmZZ09dCz5rsJh0vuJnMu0/IwjcOZVSrk8JBX
         OXDg==
X-Gm-Message-State: AOAM531JAH4rkgnd8sgIrvNoGqmkaP342Vqi1buz5v4gi+U52DlaiPg4
        oy7Q1+NzQIkbLwafmXYWWH55nzvSxQ==
X-Google-Smtp-Source: ABdhPJzc6gYCOEjEt5GfViOI/JBJaMpg0f7Z/rAVRVVH+odzcNnmv2fmf/sJzplIydxd8eKeN8nPTQ==
X-Received: by 2002:a05:6602:2e85:: with SMTP id m5mr4157265iow.112.1616190566407;
        Fri, 19 Mar 2021 14:49:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h193sm3230363iof.9.2021.03.19.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:49:25 -0700 (PDT)
Received: (nullmailer pid 1647642 invoked by uid 1000);
        Fri, 19 Mar 2021 21:49:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com
In-Reply-To: <20210319203007.287802-2-puranjay12@gmail.com>
References: <20210319203007.287802-1-puranjay12@gmail.com> <20210319203007.287802-2-puranjay12@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Fri, 19 Mar 2021 15:49:12 -0600
Message-Id: <1616190552.598171.1647641.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 02:00:06 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for TMP117, a digital temperature sensor.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml:14:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 12, column 14
found a tab character where an indentation space is expected
  in "<unicode string>", line 14, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/iio/temperature/ti,tmp117.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml:  while scanning a block scalar
  in "<unicode string>", line 12, column 14
found a tab character where an indentation space is expected
  in "<unicode string>", line 14, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1456032

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

