Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365F4C4163
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 10:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiBYJ0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiBYJ03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 04:26:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A740182D85
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 01:25:57 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EEDF43F1F3
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645781155;
        bh=u3BiR+sSk8E/BV+I3I6ftChtPOWoeeNyFGRFGGOpa64=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KkLRDvkW4DPuR5OgO1VDltQcR0FqtR+HxvXp73h7Vt0UtNp3xy4U+5NPtSC7+Y8Q5
         f6oX/zAFzR1G022B9BuxMVoZPYDVC8JZrSREnL1QVDOy3sTis/nRZXuuac1qZz7/jV
         qE6N2ii2KXmBPhO7xywbtX3phSJBAL7XEHOQzGVhtdCMKwhtiYvn84obf74H2mi3H3
         SiyFAY2gsPeORFGrzyAKm4/nGO1xDLgS+gJvtZtYeudU7ag7MF0KYOQ8chlzhXnzdu
         SqUa73rSLFgCM9m+mzDsuVE85V+a8Vaw1J5btVN3T87hqBK1XM7BkWWufO0+v9wwj/
         7Hkm28BLbqYNg==
Received: by mail-ed1-f71.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so2060445edb.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 01:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u3BiR+sSk8E/BV+I3I6ftChtPOWoeeNyFGRFGGOpa64=;
        b=5PDw4PtbDyayjtJghmHniMwzvdnz2elviyTGboU+vU5IpYSLvYQFAvstEI8Ev5ybJ7
         MTlSqySOgYaLC7owLO/ek9INEOkCEgk+en7OYT/ou7PYnXF5UDj6mSa43VbX036R8sK/
         prSDHHFcOaJJyQnmxCNQj2Hyah2pYqQLMEDiuc2tUj19ICJHjlBl4fQz6yL5W41wHULX
         Dwt4uq32AhPYsUy5i6EgZMMSMDve+I1YDMMngmqIQGors7bKicogztu8leTMzBW76pDo
         ObvdZVTPFat8rOWMRwQ9W6f0oPl2O8RjVMv2ZIUURwccHanf+sI7Y0DQH9gRUqQqxcdJ
         kvRg==
X-Gm-Message-State: AOAM533EB9MwsmY2h/jxzHF3U8b55Xwr0Z6sTX25rDrz616k/K+UiATd
        DPJfHi1FZU4R8PlvfzkNyA4ui7/MpDmH3sbytz9W0HNbaOqBDrBfDYU4DRSQ9xNmIRZ/OUUrpC4
        kRlRidLMvSzT2Fw38Hxgfma2hEcI+ZmUuAXONMg==
X-Received: by 2002:a50:fe14:0:b0:410:8621:6e0c with SMTP id f20-20020a50fe14000000b0041086216e0cmr6128255edt.356.1645781155711;
        Fri, 25 Feb 2022 01:25:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/RAHRHmxO306I0azib6Jyq/W0/GSgjv7dozaF7qDQqAcFJcfFq3x0jrM69GeMCTbpnIYaWA==
X-Received: by 2002:a50:fe14:0:b0:410:8621:6e0c with SMTP id f20-20020a50fe14000000b0041086216e0cmr6128244edt.356.1645781155556;
        Fri, 25 Feb 2022 01:25:55 -0800 (PST)
Received: from [192.168.0.130] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm764572ejo.195.2022.02.25.01.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:25:54 -0800 (PST)
Message-ID: <5784ee6b-1957-32a0-3406-cabbfed86832@canonical.com>
Date:   Fri, 25 Feb 2022 10:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220224125843.29733-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224125843.29733-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/02/2022 13:58, Lad Prabhakar wrote:
> Document RZ/V2L ADC bindings. RZ/V2L ADC block is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-adc" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
