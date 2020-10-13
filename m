Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FAB28C873
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgJMGBD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgJMGBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 02:01:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F2C0613D0;
        Mon, 12 Oct 2020 23:01:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so20446587wma.4;
        Mon, 12 Oct 2020 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UXm+TOWOBr2aV3MJtQ1i94fOaFTW9PgytBEAE9CI8Xg=;
        b=vRItQlazGVVLD1IMqbPCE/lmjR+TjxXbb3QKrDO932MdzkyEi2deyMHQlXoxJoAYGM
         wiFbQ+YX9nIu4glSWCf2QkaoSRiwI5kj8drodgoVzspgSi4o1aiPTUEqolZKcTP2+NXd
         uxTVD3ModhFjbNQXYUxRaBCwiNZXL+gsFQYXtdQrQwhG2Wh1n3x8UOzYKjeH3/HqB1QF
         KnJoF05++3m19ngOYa9c1YAYkDJI9lzLcLSI9ahR9cpZJ0s2b0XqgKFysB7xZOlNiymF
         NeOZKv8oBN4sakC/A3hmkiZE/cPTXSXtd9r8og1mVkw9is6bY/0GOZrIFUFVHJsmKSd0
         K5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXm+TOWOBr2aV3MJtQ1i94fOaFTW9PgytBEAE9CI8Xg=;
        b=pe4HmzQun5ATD+omohNnMG3+2V0aR/K5r9fjWLSW1+U04LBqWLvePjO7Hhxvv/6FOF
         uiZlth12kY/mYhgwcrpdLgPhwvhbyzY3P/7g29bPPZwSTmW8cXn0iTXvmpJfG47iowuN
         STQE8U5GSU8XcWfv3XA+vGXQ5SgDuN9e7jN+ccRgunCkaNwQ+CUghMlLM2jjwHBLkMkt
         INdTgqCxc+sn+j2e2ovId3dFy+plMgcqfra1Eyfi84ho/KztDHjZtcOcf5vQdiwoXAVW
         oWTE7lAqb4EYErS7hkgoceDlKeyW3jK8QiJmhZTKnWaa2YxTYFx/bIJ8Dq5/UhGpST/B
         jJOw==
X-Gm-Message-State: AOAM531ayEzscXjLj3YJMn7lWbegswIBS6az7Mh+BKx6QxR+ghLBJtqf
        Kl+YxpyTZAw6l4nbpsh4K8I=
X-Google-Smtp-Source: ABdhPJyRDCZng1TxC0GnuZJK3LAgJuoYiA0N8RXGvN3MjAenWERbNXs+RAhwOTfMc7sFZkEZp4WVeg==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr13802429wmh.21.1602568861653;
        Mon, 12 Oct 2020 23:01:01 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id f7sm3525515wrx.64.2020.10.12.23.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 23:01:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8516: add auxadc node
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
References: <20201012205218.3010868-1-fparent@baylibre.com>
 <20201012205218.3010868-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <81a12664-639e-20cc-8b49-6bcb53822a3f@gmail.com>
Date:   Tue, 13 Oct 2020 08:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012205218.3010868-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 12/10/2020 22:52, Fabien Parent wrote:
> Add node for the auxadc IP. The IP is compatible with the one found
> in MT8173 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index 89af661e7f63..943c426e9aaf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -470,5 +470,15 @@ usb0_port: usb-phy@11110800 {
>   				#phy-cells = <1>;
>   			};
>   		};
> +
> +		auxadc: adc@11003000 {
> +			compatible = "mediatek,mt8516-auxadc",
> +				     "mediatek,mt8173-auxadc";
> +			reg = <0 0x11003000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_AUX_ADC>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
>   	};
>   };
> 

Any reason you don't enable the status in the pumpkin dts?

Regards,
Matthias
