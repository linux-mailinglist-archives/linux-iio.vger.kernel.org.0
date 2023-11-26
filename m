Return-Path: <linux-iio+bounces-387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5427F9253
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD2FB20CB7
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE263DF;
	Sun, 26 Nov 2023 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LozpDIEQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B86BFE
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 02:40:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so452847366b.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700995217; x=1701600017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/EoUMNdP6DtHDBOJw3moIxDfeacLd35rr5D6kJAtj8=;
        b=LozpDIEQy61tpTnfYAAW8LJ79EDBluGixSEBSfHmpkFTK9AQYanBbj3cuoj0vHkJK8
         XMVGt9P6jDD7ccyHYeFwxavw20Tn51qRaJ9MkR2wUhtfAfn/gCAJ9zSGOQIL35ZH1NvC
         Zrcz2w4e40mg0uVEK1qoA3kkPUlUS3V8SJF6BodiIlpETQJkcVkMWw+VLIiO00elcIp6
         EzgUBD9eG/nJQn1BsWiL+iS5AsK+eVtr3EyzQNnkgzP6k0kNrzgmDz7eZGJG3yFvUv4k
         s7MISeMdOv5LEomOfzN7dIES2DWRVPat3wxQjHPNlODs4gzcL+Mbp53PgT+JPGa9ohMo
         WHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700995217; x=1701600017;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/EoUMNdP6DtHDBOJw3moIxDfeacLd35rr5D6kJAtj8=;
        b=T9b2x9p93kOS2WGBKvPx8dRJgz3cnVWpf8XGHN6Vb4RRsXc6LVpEspRpZBvndLj4oG
         YG4IBa0yc9RTzUDQ8pJbF1lPXZo2zixBwodmm7HnifCZ38/3mNNxcPE5aiJqNQsJCLLf
         mLBCmKRJHcTy2+nDP6UtI6MgvvC8UOSqD9F5KulAhh/cMAFFeHjCYjSwn1xd+nWrRsLW
         JcI6anj+KO6/Ro71MdvVDdLbgB8fLNKG4l3kv7LsYupO9K3NBtj7R/VhRw+hi/tSYGTD
         TfEaDENfMOCIhnIJQ5ir92kfvIN1Fv/xDpElLAFri5lQJ748OdVv0vqXY7nFK5TD1W+O
         ZpYA==
X-Gm-Message-State: AOJu0YyTNViUf5/XAJg9ME4sT2eAgp8Xq7cesZbtso8zunaNa3Ny6hMl
	DFAMWUCC/J9CpsJ7kx5sPzCdcw==
X-Google-Smtp-Source: AGHT+IGm9Cvh81mmZWxPyD99H4n6F6rV7/qCmYFyIslXvS2ewyCbm8CPtqdJ3Tdxrz7kAeaHGVbmBQ==
X-Received: by 2002:a17:906:2da:b0:9e4:6500:7540 with SMTP id 26-20020a17090602da00b009e465007540mr6110245ejk.58.1700995217119;
        Sun, 26 Nov 2023 02:40:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063b5800b00a0bd5329d4dsm1719871ejf.214.2023.11.26.02.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:40:16 -0800 (PST)
Message-ID: <b9e75047-b3c1-47ce-a8c5-703e1adcdc08@linaro.org>
Date: Sun, 26 Nov 2023 11:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jishnu Prakash <quic_jprakash@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, daniel.lezcano@linaro.org,
 linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
 lars@metafoo.de, luca@z3ntu.xyz, linux-iio@vger.kernel.org, lee@kernel.org,
 rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 cros-qcom-dts-watchers@chromium.org, sboyd@kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 kernel@quicinc.com
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
 <20231116032644.753370-2-quic_jprakash@quicinc.com>
 <f7065032-206f-423e-bb03-0b808ff16868@linaro.org>
 <CAA8EJprn7NfYAPGygus-Yxyu=kCiGYyEksVv9S3QkP5HNwVzVg@mail.gmail.com>
 <20231125193403.77400aca@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231125193403.77400aca@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2023 20:34, Jonathan Cameron wrote:
> On Thu, 16 Nov 2023 17:27:53 +0200
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> On Thu, 16 Nov 2023 at 13:44, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 16/11/2023 04:26, Jishnu Prakash wrote:  
>>>> There are several files containing QCOM ADC macros for channel names
>>>> right now in the include/dt-bindings/iio folder. Since all of these
>>>> are specifically for adc, move the files to the
>>>> include/dt-bindings/iio/adc folder.
>>>>
>>>> Also update all affected devicetree and driver files to fix compilation
>>>> errors seen with this move and update documentation files to fix
>>>> dtbinding check errors for the same.
>>>>
>>>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 4 ++--
>>>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>>>>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
>>>>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
>>>>  arch/arm64/boot/dts/qcom/pm2250.dtsi                      | 2 +-
>>>>  arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-  
>>>
>>> NAK, bindings are always separate from the other changes.  
>>
>> In this case I'd even try to appeal :-)
>> They are doing `git mv` and then fixing the failouts. I think this
>> should be fine.
> Agreed.  The only easy way around this would be to put some dummy headers
> that include the new ones in old locations temporary basis then delete them later.
> I'm fine with that if Kryzsztof prefers it that way.  Not too disruptive.

I think Rob acked it, so I am fine.

Best regards,
Krzysztof


