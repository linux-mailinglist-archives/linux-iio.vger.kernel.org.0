Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9E4D538F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 22:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiCJVZI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiCJVZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 16:25:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFD140D7
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 13:24:06 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 118C73F1AF
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646947445;
        bh=zeer/ZZp0Mz01D/gyl/OYzcIfYG9F75Pjm36xkioFtY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=utoTnEnMi/CO0PTNzwPt0t6hlXnfHja2hNITi1WLDXNIqfPVcds1PpKQwenOJQYw2
         GDSg3GVzsRiJQ/IIQuTDn04wAdblcKMZkt09ZQkaHwNI5bWgaeHHCQxf3ec+BU6+tG
         dSNzD++y2X+m5jNbaVqSvZ8EPWL9eZbwo57sDqB6yEEvqpVt2m1f6UtH0PHdEovoW+
         +rcAwgghIj5CeV0GMJ+mwEHhDXaLIokGnOUtEkj8/HD7qaruuODvLxnk7PyK59KreP
         LXqPlyzOAiJmoj7H4DqbFBBNVr486lZyZtcF+8d4IIBgknz6PPyKUVyTVf4tcMDFgf
         6umQrDzQ8zdlg==
Received: by mail-ed1-f72.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso3798969edb.10
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 13:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zeer/ZZp0Mz01D/gyl/OYzcIfYG9F75Pjm36xkioFtY=;
        b=AFIWZYOyUSZks0GyD6HWHr73enhw51Ek2Oeq700G6eWPkdxWr/JqjVFMjdknicCCl+
         HlACfPrCbESTQz/4H1omCxoAzpTAP4tSQpi3kAzeqhOMSOC4Mdyry+ePvo4OHFILLfFR
         EF4+0u+fw+RyTSb5854hkQ5/Js/FVgRhLbGCIRw0PPR+o/+X5NUZb+rUPKqXalbwsbI1
         NaTN6IHdM/CNEvyoGOUfTjazveLu73Ru3Sz3RimBZ2dmyQ/cIg6flKYGlMS3hNsyd8SG
         uxb8IcfA7FGaY5wh6ZBZhA3UFiZhSId4nt6yD+B0eRhLxYt1Mey78XPpGRlnxqb4sXup
         6HQA==
X-Gm-Message-State: AOAM532+EvetOYbe29ZBaZIoFJwM2aDhhgUPsO0sFe3MOVKCaY0vw/WQ
        pT0F28m5cscor16LkNzdbcuwSpzRWD4ncY+9ZMN42riVtz1ZfQh9Aj1Q9B5kR4ROhpV6GcmLWo0
        7QzDeU4PuPGShx6IixjFbOAQzabg8jsa2UcSDlQ==
X-Received: by 2002:a50:bb2c:0:b0:415:a2d4:72ca with SMTP id y41-20020a50bb2c000000b00415a2d472camr6307984ede.216.1646947444797;
        Thu, 10 Mar 2022 13:24:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWCK5bpvfRf9NFEXcSTjvhVttJdwvliw2R5rFZzIlGeRw6k3eXdG7wZAjBzCCiEfAhXouI8A==
X-Received: by 2002:a50:bb2c:0:b0:415:a2d4:72ca with SMTP id y41-20020a50bb2c000000b00415a2d472camr6307976ede.216.1646947444638;
        Thu, 10 Mar 2022 13:24:04 -0800 (PST)
Received: from [192.168.0.147] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm2217445ejt.50.2022.03.10.13.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 13:24:04 -0800 (PST)
Message-ID: <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
Date:   Thu, 10 Mar 2022 22:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Michael Srba <Michael.Srba@seznam.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-2-michael.srba@seznam.cz>
 <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
 <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/03/2022 19:56, Michael Srba wrote:
> Hi,
> the thing is, the only reason the different compatible is needed at all
> is that the chip presents a different WHOAMI, and the invensense,icm20608
> compatible seems to imply the non-D WHOAMI value.

But this is a driver implementation issue, not related to bindings.
Bindings describe the hardware.

> I'm not sure how the driver would react to both compatibles being present,
> and looking at the driver code, it seems that icm20608d is not the only
> fully icm20608-compatible (to the extent of features supported by
> the driver, and excluding the WHOAMI value) invensense IC, yet none
> of these other ICs add the invensense,icm20608 compatible, so I guess I
> don't see a good reason to do something different.

Probably my question should be asked earlier, when these other
compatibles were added in such way.

Skipping the DMP core, the new device is fully backwards compatible with
icm20608. Therefore extending the compatible makes sense. This is not
only correct from devicetree point of view, but also is friendly towards
out of tree users of bindings.

The Linux driver behavior about whoami register does not matter here.
Not mentioning that it would be easy for driver to accept multiple
values of whoami.


Best regards,
Krzysztof
