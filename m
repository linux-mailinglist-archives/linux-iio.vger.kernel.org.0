Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1042925A5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Oct 2020 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgJSKVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Oct 2020 06:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgJSKVj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2020 06:21:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4184C0613CE;
        Mon, 19 Oct 2020 03:21:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so10772854wro.1;
        Mon, 19 Oct 2020 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDam2iBux83WmunYrPy6RIkxNQfpNh4uOchFEhMvXMw=;
        b=ke1K2cvC3R38syswmV0bDDyDWj6nZESQqkQ323WDJxIoBqa6UgZ9LKqvtaVjj85nWa
         CXLaF4bGei7QVNBj7RvSXhplu8Kk40RnFDoWo5NIAhZWCb4MOEPxtXvI8UXotFDRSCBo
         WDih8AYIYqFM1NTDcjdy5+U//3N6Dm+pzWP8C8u4/ENPrx906kzLWt+6EySP1ZbS1/s2
         GjQ/UIiQcxMCdL9rFUX6u/4R2wbmRQAnaIx15MHG0x1KaP7/SLmaP7Y3ZEGmts3RN+KY
         50H7HeHAjnRgdyKB/mBXEpN3LRGfw1iCoO1r6Cc2PuibqKalct9NAWGN57R7c8GhtlZp
         5xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDam2iBux83WmunYrPy6RIkxNQfpNh4uOchFEhMvXMw=;
        b=Usze/4ZcqVxbSbxxiUJ/if+kDIwaRp0ptFeQRrwWKya/hy8OkDZgGaiHTPSo49TSnp
         DheZjwDdGB3nfLgXoSw/qazlaIDMdB1MJL+LHDdAU5ScDRT3ca4+EltsYg8NVQilvaGG
         nQ8Uad78kS/yf6sROmE6eNga6yaIx49E9DDlmJPCjK07DEoEjVs2l8DcOtxMp0EfS2Kr
         iffVW1TC6sPJv702xrCn3PQ9nefqFbr3asUDrjJqOvPs/A2cieEai1dzD5GE5oIVDHpX
         uuX0DgXOXylf7MoGQ5Oo74qbTE1FroWONxjMpupmfj/L1kGRQ5zYdQjHMCb+Wr3EVe9e
         Wbhg==
X-Gm-Message-State: AOAM5335KfNFygAmMaIPUgjSq3OOzYC3h90eUB2tnRUMFtu8ui5DjbNR
        GDrz3PQgPhQbNTxQ9UeZIzo=
X-Google-Smtp-Source: ABdhPJymr1886oZmydcTM0lwn9ycX7wbCyMOY00WEhv3e+OOYP91KSDh0/hmDryGvGdfVtslZd4i/Q==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr18692169wrv.224.1603102897459;
        Mon, 19 Oct 2020 03:21:37 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id 130sm12047799wmd.18.2020.10.19.03.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:21:36 -0700 (PDT)
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
Message-ID: <ba99554d-b0e9-58bf-110e-541bd9d0e521@gmail.com>
Date:   Mon, 19 Oct 2020 12:21:35 +0200
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

Applied to v5.10-tmp/dts64

Thanks!

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
