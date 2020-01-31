Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1E14EE55
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2020 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgAaOYL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jan 2020 09:24:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34815 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgAaOYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jan 2020 09:24:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so6733935otf.1;
        Fri, 31 Jan 2020 06:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUivSE+NYFs/xk1G/8LqAZGcALdkGQ/8FeW8w104yOY=;
        b=oN8o/wAs2ympM/nzzpVKJ89x5UkXX+K3BFXhUrse16IoCLTOz9ikCxK/VUUBrDua0J
         vDFOogGCJK8TS0kvXXc2xKkCYI2qR9be6chFK0gBhRXIEwDrTtiz8wt5qJzuxfZJSQvq
         XSM3d1ZnQjq/C4RbJtVIzv7eSDxOwUlk2gz0L8QSn4MQkJLgudJrJqmDTmS5tc4PcF9p
         O3IEYd/ZZhqrITb+En8wctfH78vwtdrJwfZbRm2jiuhnjGyQDAQPVNBUOYCVvdMRJoWh
         tJJpz+5liwm+Vd07iKQvS6set4d8kiauqGY6wjvYsE77NwEVzzZE0NDDgAyWlvinSeb1
         af3A==
X-Gm-Message-State: APjAAAXaqhbPy/SemJuW6lHlaYEN4VuhEwYs433gxKj6dtcK2buHSR9V
        ZPsni3wFLn1ktJP+8b1Wrg==
X-Google-Smtp-Source: APXvYqxsfPg/FWywwAqW8HeiHZUHRozmPBSiLJ/0Ef7gBwg+OApzIkxsz9I/0+T+Oa/pncbxbubT+Q==
X-Received: by 2002:a9d:65cf:: with SMTP id z15mr8116203oth.238.1580480650269;
        Fri, 31 Jan 2020 06:24:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm3055210otq.4.2020.01.31.06.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 06:24:09 -0800 (PST)
Received: (nullmailer pid 5507 invoked by uid 1000);
        Fri, 31 Jan 2020 14:24:08 -0000
Date:   Fri, 31 Jan 2020 08:24:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
Message-ID: <20200131142408.GA5196@bogus>
References: <20200128133052.201587-1-david@ixit.cz>
 <20200128133052.201587-3-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133052.201587-3-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jan 2020 14:30:47 +0100, David Heidelberg wrote:
> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/iio/light/al3010.yaml | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/iio/light/al3010.example.dts:20.17-30: Warning (reg_format): /example-0/i2c/al3010@1c:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3010.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/iio/light/al3010.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/light/al3010.example.dts:18.23-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3010@1c: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/light/al3010.example.dts:18.23-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3010@1c: Relying on default #size-cells value
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: al3010@1c: 'interrupt' is a required property

See https://patchwork.ozlabs.org/patch/1230351
Please check and re-submit.
