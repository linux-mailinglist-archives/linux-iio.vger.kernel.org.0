Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800A6166876
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 21:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBTUgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 15:36:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44162 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTUgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 15:36:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so28882944oia.11;
        Thu, 20 Feb 2020 12:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShEFa4zZeHsSz7b+o99yPPxnSH+QCBtaKE2TrjggqEE=;
        b=K0OsmaTcUUgKR+D1Gtvi9nDBsjIELrOCttY2iWlzDgwwUUu2Qo+hMlejKuto/E5n7D
         4jk4rDvNUsoaHryGfq9Vh/pKU48JB02/f9VXXVnpUolvVlxEh3gBK7269jqSfXqc8ryl
         A4LKBlybYIZs0Y+tnhl1jWVKy/yk3FodNs6uJQkOk7nD9glEbjvcPEek2hC985Supgct
         Q7qbjDMTdIZWLRMFgwL6ZqFt0g8ynK3Y2mMjX5RvegaJZd6EdacLhoYYbqfFgN/ue7ki
         s6cJ7Ik9BrW13qPDBZ46BCOWZNReWB5udmhozlizQGjeWgPtK68b52JJCQKeIBYIw0q0
         Yw7g==
X-Gm-Message-State: APjAAAXbARDKTqn7mACOWfVuGN+BFmbPWP+ivyXo/ZqpuPCmvfmns8nc
        /kFfpu4P3/n99+Nt1MiC1w==
X-Google-Smtp-Source: APXvYqwsZC9OdPFsfZlgZtEEI/IUCzsOi5UHd/OpHtXIrYYZpQ2SRoTGUSJrAgGy1Ob63UNCR8Or4Q==
X-Received: by 2002:aca:5f87:: with SMTP id t129mr3547367oib.36.1582230977204;
        Thu, 20 Feb 2020 12:36:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10sm200593otn.37.2020.02.20.12.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:36:16 -0800 (PST)
Received: (nullmailer pid 16841 invoked by uid 1000);
        Thu, 20 Feb 2020 20:36:15 -0000
Date:   Thu, 20 Feb 2020 14:36:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: add bindings doc for AD9467
 ADC
Message-ID: <20200220203615.GA16178@bogus>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
 <20200220150317.1864-5-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220150317.1864-5-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Feb 2020 17:03:17 +0200, Alexandru Ardelean wrote:
> This change adds the binding doc for the AD9467 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad9467.yaml          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 32, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 475, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 428, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 93, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 20, column 3
found duplicate key "clocks" with value "{}" (original value: "{}")
  in "<unicode string>", line 30, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:34: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1241490
Please check and re-submit.
