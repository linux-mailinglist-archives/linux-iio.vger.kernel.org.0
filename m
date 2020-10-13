Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949628C86F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbgJMGAa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 02:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbgJMGAa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 02:00:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF6C0613D0;
        Mon, 12 Oct 2020 23:00:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so20444935wma.4;
        Mon, 12 Oct 2020 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnS/x8SlmHpjDOqz9A1uOS6RzTrMehpndh0O6FN/G6U=;
        b=afO4cpR+LHdQnJ28NOXE/mkii7qViCz8wl0LWS29yyhmyfzSYeWlV5OrtqJNRvLqvh
         N5pE8eULXJVrqWaSoNcf4dPPx9VihMP44Ff5NW5KCmaFH6Qznlvr7c7UR5RGcKPVgbHG
         WWJSVCJ/n2aWcIgf5QTFrrYAA1/6UO3YLFbVjU4IHnSM1M6mWdMXpA0lJ6Hq8+x+TPe3
         JgpHVTrNcbRbH8UcCxML/8g6tFgPkKJn6WkQRYxt2RFlzxaGANYQHP86Ohl9u82sYGCp
         Hx7JrEinVP3XbzKd9i4F3gEl5LCii7VuV75Bq8aBLL/YIQQETQF4HJ8hrywejIFH+5oy
         EzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnS/x8SlmHpjDOqz9A1uOS6RzTrMehpndh0O6FN/G6U=;
        b=cvweZK1vneDfXa+nkpjGCHv0LndSQ0u70P2YYbkkvniwrxvE4556CDn9rlCdVTPMSW
         z3pJceh2PM5Ge0eaOyU/oIcn4dwvUbdF4lLQYPJNBFrUuIiha9NRo9NQYhjxeHPRQWcA
         cUxuIRiPuxKJkcx/G5Oe70PhKjIqAQRPWbruC6TZWLyKqlsBI46g870O9JJdKGfW3cG6
         D45qMrP/AmosQ9In/S+qRq9oOijaW3eYkwHeJry04/G++dn8ZrhrWoL1Kw1oQxVEm1Vs
         hPwLWZLVI4+vRM/BF3X+G18OLmj9fGxcRJlhgdwYEnXJ1j95CsfroFc5m8mktsYugVPm
         crgg==
X-Gm-Message-State: AOAM531l4JtpiX8zVgiTqV2X450Qqmi94XA6lfeUZ0nj1OV2z8s2Yjz9
        oC8y2gnoVwl6G9ITfBqrzAE=
X-Google-Smtp-Source: ABdhPJwV3SrDoUWfGVUiifjwE7icpnVDk1AWT+ES8MylI3PskKn0pFqjnIKUIusVGkaOQkyFSOovvg==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr13535636wmi.120.1602568827375;
        Mon, 12 Oct 2020 23:00:27 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id l8sm18052242wrn.28.2020.10.12.23.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 23:00:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: auxadc: add doc for MT8516 SoC
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
References: <20201012205218.3010868-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5ac4afb0-3950-3b11-1f5c-01bbf74e64a4@gmail.com>
Date:   Tue, 13 Oct 2020 08:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012205218.3010868-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 12/10/2020 22:52, Fabien Parent wrote:
> Add documentation for the auxadc binding for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> index 78c06e05c8e5..1b7ff9e5615a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -17,6 +17,7 @@ Required properties:
>       - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
>       - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
>       - "mediatek,mt8183-auxadc", "mediatek,mt8173-auxadc": For MT8183 family of SoCs
> +    - "mediatek,mt8516-auxadc", "mediatek,mt8173-auxadc": For MT8516 family of SoCs
>     - reg: Address range of the AUXADC unit.
>     - clocks: Should contain a clock specifier for each entry in clock-names
>     - clock-names: Should contain "main".
> 
