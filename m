Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41679678D56
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAXBYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 20:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAXBYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 20:24:05 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348615546;
        Mon, 23 Jan 2023 17:23:30 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so2408580ooj.11;
        Mon, 23 Jan 2023 17:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbLsmkHwUNwxPZOCXTJogcJ8LmEkiiS2N1PN3EB8w5A=;
        b=35lZ1FOkxKHc5jiUQC6k5Y5yh5cGOqEY29YmGBX45Cq4hqT1Nmn+cGmgzgUQhV/fSr
         rSGy1zU/Li6FvboTQt+rXuxNdMbDY7EUpglkB3xhfRniEuhV6CmW5SF1I+9V965YCjvn
         qh0YVUeacramK/Ww8AjeDP9yIa/xkGF4ySu8gv+cnLQ4sYbinCxd7CgLuPUWkBHVxjiH
         w3DJ6vgr19S2bdhnK5C4vFX+tkuwv8DWJzIp1uJWt8OsRdSfxFTPz8YyBDCx/tGWR4a4
         VBDng2ZCa6Fs60WM0QHDGedjkvlW7k9vkiKU96UodvU2ec04tbILWxp6LJipXuSam5G5
         y13g==
X-Gm-Message-State: AFqh2kp04f4pRXj4Qz5JF2y5kDcFwHi5gkhihMFcAlUlJZaKWZPgeAUE
        jwL33jW69W50z/52jInSZ8cR/ANZxA==
X-Google-Smtp-Source: AMrXdXsUstXqeQ6JOeDoTmPGJVwMNubDdoIXVvoKVC5JqIw99XRErf0IzogI/xL/OiHVV2LwUNgoxw==
X-Received: by 2002:a4a:e54a:0:b0:4f2:c7aa:a7db with SMTP id s10-20020a4ae54a000000b004f2c7aaa7dbmr11330490oot.2.1674523368663;
        Mon, 23 Jan 2023 17:22:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a4a96ca000000b004a3d98b2ccdsm221102ooi.42.2023.01.23.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:48 -0800 (PST)
Received: (nullmailer pid 3121719 invoked by uid 1000);
        Tue, 24 Jan 2023 01:22:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Barry Song <baohua@kernel.org>
In-Reply-To: <20230123211758.563383-13-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
 <20230123211758.563383-13-jic23@kernel.org>
Message-Id: <167452324153.3116954.16283334229581146531.robh@kernel.org>
Subject: Re: [PATCH 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
Date:   Mon, 23 Jan 2023 19:22:42 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Mon, 23 Jan 2023 21:17:58 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There has been a driver in staging for quite a while.
> Given we are now moving it to the main tree, time to make sure it
> has binding documentation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/accel/adi,adis16203.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.example.dtb: accelerometer@0: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230123211758.563383-13-jic23@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

