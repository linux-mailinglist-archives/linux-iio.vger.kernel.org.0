Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7512814EE6D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2020 15:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAaO2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jan 2020 09:28:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46616 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAaO2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jan 2020 09:28:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so7907826edi.13;
        Fri, 31 Jan 2020 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CLz6QJyteNjgtifwy8DJYQXyk6DI/jxjrX09D8jN1+g=;
        b=rr/3FVWC08HmgqZi6qiFtQykyot5oXttra1dAt8ZacUW5mtYNjokfXF1FO9cC1YbxL
         0Qm0WNxJ8hJU/To0EdU55P7LPTuIrx86Bpzljn38jJHm4Ey7yABtsDcjDQYLBpVxY8C1
         cCS8KvHSXGl00w6cWxq0W9YAVj4WzaFBtUQeRrohmSj2k3UsQPHA8amb0iaIUye6YByV
         RQwnndQ+dFYwL+39YeZxBf0S6YL2NBMUeBC56BUCJfuW2W4CWyL1OypRN/g+eaXwl3ZN
         JIH5uIYJyD9Rk+/QHgPwj4m/16aaKV8CpZ2LVKqrBndhjDaqp5kWHOuXjfr3WomZbt9o
         LXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CLz6QJyteNjgtifwy8DJYQXyk6DI/jxjrX09D8jN1+g=;
        b=mS9KFFRRDnJhoovrqe4HvHdWNoOW2PDSmyuKLiYhwV3U/ViS5HCmiiljkJgmbOJt+b
         W5Lr8JmQy/ku/EXrSGJYT7mQ3lnAZyTbknV0Wb5zUjtVXw7MHexDDUGzPBkj5TG8jJ2P
         m/kKwkt+fLUAELRKts0v/9yBAUMhGQUHHUNy0yexWNT2tzKuVxrqetGq1S8357U3ddUn
         Oczcn78ZqGJvTNPFDMc2YPkdCySXoDJXJDUI+62swJ5/hrXDGQz7bokBoJFUAxpIk65U
         mppQr9yaE9l/0lU/62lmnU+Byxo6Bux3Ljy3wOmoQMhZRtyhEbpDNMMuT7vwK2WkcuxN
         NRuw==
X-Gm-Message-State: APjAAAVPSXqIdoIrTJrsDJIxo6F/oo3vcKHDUI5jj15X6ltgF120sCCg
        1S3vt7TzvP5EckS3QXmMiFdvFDnB
X-Google-Smtp-Source: APXvYqwkW3mu3UBFStjSVmGRYRHjOKqAu236crn3j+BmCZbluMpViXVvMzbtPpr+Iuq+CSsu6027kw==
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr9225899ejf.337.1580480911234;
        Fri, 31 Jan 2020 06:28:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c20sm521857edt.67.2020.01.31.06.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:28:30 -0800 (PST)
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
To:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20200128133052.201587-1-david@ixit.cz>
 <20200128133052.201587-3-david@ixit.cz> <20200131142408.GA5196@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0da22026-5d4a-5ef6-a2d0-30e7d5fd32cf@gmail.com>
Date:   Fri, 31 Jan 2020 17:28:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200131142408.GA5196@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

31.01.2020 17:24, Rob Herring пишет:
> On Tue, 28 Jan 2020 14:30:47 +0100, David Heidelberg wrote:
>> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
>> provides a multiple gain function with linear response over a dynamic
>> range 1216/4863/19452/77806.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  .../devicetree/bindings/iio/light/al3010.yaml | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Documentation/devicetree/bindings/iio/light/al3010.example.dts:20.17-30: Warning (reg_format): /example-0/i2c/al3010@1c:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/light/al3010.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
> Documentation/devicetree/bindings/iio/light/al3010.example.dts:17.5-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
> Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
> Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/light/al3010.example.dts:18.23-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3010@1c: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/light/al3010.example.dts:18.23-23.15: Warning (avoid_default_addr_size): /example-0/i2c/al3010@1c: Relying on default #size-cells value
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/al3010.example.dt.yaml: al3010@1c: 'interrupt' is a required property
> 
> See https://patchwork.ozlabs.org/patch/1230351
> Please check and re-submit.
> 

The bot is right.

> 
> +required:
> +  - compatible
> +  - reg
> +  - interrupt

               ^ (s) is missing

> +  - vdd-supply
