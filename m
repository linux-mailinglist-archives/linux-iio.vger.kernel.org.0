Return-Path: <linux-iio+bounces-330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D947F8A4A
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3010A1F20EF4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE71D516;
	Sat, 25 Nov 2023 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeaiDQGV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119FE10F0
	for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 03:44:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b211b0296so434032a12.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700912644; x=1701517444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdNAHltyzZi3QxE+f9JHuh2c+iylf1qVw4CyLT75QG4=;
        b=VeaiDQGV4YEKXn5e99F9Bmaq1sQjWIE0CUDJ8ag0+zYSsHNRiVUhIEXASu2XEFsYYj
         iGUkIVqf7cBK+B2oRB0lr6KPG5K+/5Q+B/8uIzvwA+EMrBkXiwNHv7h3NkWRiLSVPkZp
         5TdXFzp9sDdehi0OUQtn2aKnT3l2VVdkxN1GtqBqlkd9Z+gKaxCwfeXcSs0Xu4F1LLCK
         Kg6su6fzInDZfr8jjgb3nvAygdIKRx18OV24gcog2OuUBhJZHwdN42uoJi8Kq0yuvP+M
         DAiTIQQheOktcoeUgW2ZcSRNNEiWpxDU9AxqP8Var/a+kqeOoHcBd2G/pCS5pBntFTp5
         vfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700912644; x=1701517444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdNAHltyzZi3QxE+f9JHuh2c+iylf1qVw4CyLT75QG4=;
        b=LP9R85vo2rzhjK028hHLuElwCQdCmC0ANqNSbuAFwWPb3IiAjsLsKu/i0dSNEb6tc4
         BoX+ATP4DUSC4pvhvq+EcSQb5wXMDplbaemmQU8UJt/hQmeH9oQ+v5V3xCtzrd5VvlFL
         E4/qtxVPUGnq6YXIIes25SegaW5/UEw5sY12OR9zyLzEhcngwbm5GEIP98MHgIZEGJ0k
         Jp0SXIcK3RAxCBuJVMj8owH3Ay65t7/hViYA8aVCug9zuA1U7aMucGasFRP19/0LU/YX
         1THmPtghwuTUQX2h4q60FsarwvM/pSHUTrz4MYX9rruppOytBEOIZSMnhA8kTZ/M+hIc
         FprQ==
X-Gm-Message-State: AOJu0Yzl1xfJfhIuN4ZIywrrGhevzfBAAFHI9iF7CDNb64iRxJB+tYfB
	7pauW3L1vW0xa22ivq2GGSiZH9Fh5jgwXJVYtAI=
X-Google-Smtp-Source: AGHT+IGRoDr3JREkINLbE9HNbwdlPj1+NpZu2jqzyjmPzQQL01nxEYHIZx0D5Y7x//5w+SZr3YrOAA==
X-Received: by 2002:a50:d0d6:0:b0:54b:5a6:d06d with SMTP id g22-20020a50d0d6000000b0054b05a6d06dmr3820138edf.5.1700912644518;
        Sat, 25 Nov 2023 03:44:04 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id er21-20020a056402449500b0054b2040ea46sm663412edb.61.2023.11.25.03.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 03:44:04 -0800 (PST)
Message-ID: <943431f4-6d68-4635-a8f9-710a0d535526@linaro.org>
Date: Sat, 25 Nov 2023 12:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: sm8350-lemonade(p): New devices
Content-Language: en-US
To: Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org, Rob <Me@orbit.sh>,
 Clayton Craft <clayton@igalia.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, ~postmarketos/upstreaming@lists.sr.ht
References: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
 <20231111-nia-sm8350-for-upstream-v4-6-3a638b02eea5@igalia.com>
 <d35b9250-eddb-4436-8daf-066ec84cf55f@linaro.org>
 <1e45a031-080d-4cbe-9741-182524227124@igalia.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <1e45a031-080d-4cbe-9741-182524227124@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.11.2023 18:05, Nia Espera wrote:
> 
> 
> On 11/22/23 21:17, Konrad Dybcio wrote:
>>
>>
>> On 11/11/23 23:07, Nia Espera wrote:
>>> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
>>> mentioned in the cover letter for this patch series, but for
>>> accessibility also repeated here:
>>>
>>> - USB OTG
>>> - UFS
>>> - Framebuffer display
>>> - Touchscreen (for lemonade)
>>> - Power & volume down keys
>>> - Battery reading
>>> - Modem, IPA, and remoteproc bringup
>>>
>>> Steps to get booting:
>>>
>>> - Wipe dtbo partition
>>> - Flash vbmeta with disabled verity bit
>>> - Flash kernel and initfs to boot partition with CLI args pd_ignore_unused
>>> and clk_ignore_unused as v1 bootimg
>>> - Flash rootfs to some other partition (probably super or userdata)
>> Thanks for including this info here
>>
>>> +&pmk8350_vadc {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&gpio1_adc_default>, <&gpio3_adc_default>;
>>> +
>>> +    /* pmk8350-ref-gnd */
>> I fail to see the benefit in having this both here and in the label
> 
> Oops, removed.
> 
>>> +    channel@0 {
>>> +        reg = <0x00>;
>>> +        qcom,pre-scaling = <1 1>;
>>> +        label = "pmk8350_ref_gnd";
>>> +    };
>>> +
>> [...]
>>
>>> +&tlmm {
>>> +    gpio-reserved-ranges = <52 8>;
>> Would you know what these are connected to?
>>
> 
> Judging from the line names on the hdk dtsi, 4 seem to be connected to the fingerprint (FP_SPI_*) and the other 4 are NFC-related (NFC_ESE_SPI_*). I can clarify this with a comment if necessary.
Sounds very plausible, thanks!

Konrad

