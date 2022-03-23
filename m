Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE94E5439
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiCWO2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCWO2e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 10:28:34 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B194DF1C;
        Wed, 23 Mar 2022 07:27:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id b24so2024014edu.10;
        Wed, 23 Mar 2022 07:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gu7jR1q+CZaAX+HAwksicyFCNKAjaGnuPEoMTmmLZCs=;
        b=rY8gNGd6tFt5KCVAeVmDPoomXN3Pkw27gVM45h2UxmCXtqao0WtBGh1VcB+1XKgmOd
         WqS5GvizzDW9Y7M8UgWA9u6zwS48dIj+yo295HFX7Wf4Z2P57zkHSu9SQE86oc4cUPXe
         44UQ7VjgXJ+g3W+VjjGvZZV/Qor7xnNRvZo4QYAKwlfKjQ0T2/ypjqvxJPURvJuYoHFq
         Kbg780frGAYNCdK+w+hNHZBxfxzn77Wyc2Ln3wBz4PoaD1KDyAAICdcGNEdsgUqJ6m9s
         A3PtaBaD20fuyzig18h6JJFpNLK/8Xj4FQKznCgZVXcBMPYpT9WyZarxv2FdYX9Hpo3R
         76sA==
X-Gm-Message-State: AOAM531vahCooTjgD4nQ7oSpTgknUqpzeIKMQDsuiA0Hm/JPg7ob7kfc
        RhGLTgCPxEWTVkYy/JCU/Mo=
X-Google-Smtp-Source: ABdhPJzP3DVeClIEKiPMv1GRntBEcTEE5kxKj8bWi/MK5IIqFxy0dq6Emtg7/kiKKp3zAIzBv77RtA==
X-Received: by 2002:a05:6402:3452:b0:418:f963:42a3 with SMTP id l18-20020a056402345200b00418f96342a3mr421435edc.12.1648045621024;
        Wed, 23 Mar 2022 07:27:01 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm20541ejp.20.2022.03.23.07.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:26:59 -0700 (PDT)
Message-ID: <8752f318-9842-0b50-1574-be1ca6b98007@kernel.org>
Date:   Wed, 23 Mar 2022 15:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     michael.srba@seznam.cz, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220323121550.16096-1-michael.srba@seznam.cz>
 <20220323121550.16096-2-michael.srba@seznam.cz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323121550.16096-2-michael.srba@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/03/2022 13:15, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> ICM-20608-D differs from the other ICM-20608 variants by having
> a DMP (Digital Motion Processor) core tacked on.
> Despite having a different WHOAMI register, this variant is
> completely interchangeable with the other ICM-20608 variants
> by simply pretending the DMP core doesn't exist.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
> changelog:
>  - v2: require specifying "invensense,icm20608" as a fallback
>        compatible
>  - v3: fix indentation
> ---
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
