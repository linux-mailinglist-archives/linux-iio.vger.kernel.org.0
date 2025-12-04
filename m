Return-Path: <linux-iio+bounces-26721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E9CA2B79
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 08:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFB530BC97F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45668315D44;
	Thu,  4 Dec 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw6iSdp3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F8314D1D;
	Thu,  4 Dec 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834930; cv=none; b=bPjZewMAIrET9vdr/d24MEUJAaqcPXmUWytMTsFy3aDnCilgKlrRqXQPh35iJfH4ypDnXJiu4ZZUM1F/jJTUJKHlSl2VG9GSdUDj6w3qt62uQVa064RzOfUniaBWZXic2V6iG5BN4AfFWfOx0x9938Nubw1/xxbXhMlZZ3lCs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834930; c=relaxed/simple;
	bh=dcmP7RoTNhx3T/UA5tRQmB3BDoasrPHlUeBDTGcRb6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaNUB/Uo6GCIZfYIgfJs8F1D5yyXICQ/zIuDCNj4CW2nl6uJGPZBe0uUvLyMOHAZJUSDuwjVZbTqf19EcSugDYpzUFKtmFB8yvFCQbu4a77P8zbe0iZor7VjPq+pt4pOAiO9s/XnCDpxmgWpL/p0CSVaSyNnLvbMuQoBl9hX3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw6iSdp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17DAC2BCB9;
	Thu,  4 Dec 2025 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764834930;
	bh=dcmP7RoTNhx3T/UA5tRQmB3BDoasrPHlUeBDTGcRb6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aw6iSdp3CH6fCqiwpFfiTxrHkncxTU3lrqIstnq6ffQHTP6ouay474/HfAMzBxfP+
	 xRtlUyT3ZpAfNcDYocOYlPEIY0mPc1VQ2l+wRZbZZ6FJjwfbpidTX5MIwLerTnTLUG
	 IqJ19MIZVXOiZ9dOnhbpXCrIHNcWGTg46qERBMhEY09VfzfyL+4VGhrswIhJ5muyO8
	 rg5ZNkrJCfJpOtFV8g23I0gvLgOq4ZtSMt4Z4os5abrcHHIQ3C4mqCBqFreNHfzuis
	 8ytuVeUmp9tdeX2+5n8/7Ufbgk/xXSj0qftbI8Yo5WcMnyqE2WEDD3aDoGcMFavf+h
	 XWdDBcpa5YH/w==
Message-ID: <7c484433-bb0d-4628-a885-281b971eb0e8@kernel.org>
Date: Thu, 4 Dec 2025 08:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8] dt-bindings: iio/adc: Move QCOM ADC channel
 definitions out of bindings folder
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
References: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>
 <20251204-calculating-sloth-of-valor-0e30ac@quoll>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251204-calculating-sloth-of-valor-0e30ac@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 08:54, Krzysztof Kozlowski wrote:
> On Thu, Nov 27, 2025 at 07:09:03PM +0530, Jishnu Prakash wrote:
>> There are several header files containing QCOM ADC macros for channel names
>> right now in the include/dt-bindings/iio folder. Since these are hardware
>> constants mostly used in devicetree and not exactly bindings, move the
>> files to the arch/arm(64)/boot/dts/qcom folders.
>>
>> Correct the header file paths in all affected devicetree files to fix
>> compilation errors seen with this move. Update documentation files
>> similarly to fix dtbinding check errors for the same. Make a copy
>> of the header file with constants used in ADC driver files in the
>> /include/linux/iio/adc folder and update driver files to use this
>> path to include it.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>> Changes since v7:
>> - Based on a discussion with Krzysztof concluded here: 
>>   https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
>>   moved ADC macro header files to arch/arm(64)/boot/dts/qcom folders. The file
>>   include/dt-bindings/iio/qcom,spmi-vadc.h is moved to arch/arm/boot/dts/qcom/
>>   as it is used in both arm and arm64 SoCs and other per-PMIC adc7 header files
>>   are moved to arch/arm64/boot/dts/qcom.
>> - Updated affected devicetree and documentation files based on path changes above.
>> - Made a copy of qcom,spmi-vadc.h in /include/linux/iio/adc folder
>>   for inclusion in ADC driver files and updated affected driver files to use it.
>> - Dropped Acked-by tags from Lee, Rob and Jonathan due to these significant changes
>>   made in latest patch version.
>> - Updated some more devicetree files affected by this change.
>> - Pushing this as a standalone change separate from ADC5 Gen3 series, as that
>>   series will no longer depend upon this patch for the location of
>>   qcom,spmi-vadc.h, as ADC5 Gen3 macros will be added in separate new files.
>> - Link to v7: https://lore.kernel.org/all/20250826083657.4005727-2-jishnu.prakash@oss.qualcomm.com/
>>
>> Changes since v6:
>> - Collected Acked-by tag from Jonathan.
>>
>> Changes since v5:
>> - Updated one more devicetree file requiring this change.
>>   Ran full dt_binding_check and dtbs_check and verified that no
>>   errors were reported related to this patch.
>>
>>   Mentioning this explicitly as there was an invalid error reported on
>>   this patch in the last two patch series, from upstream kernel
>>   automation:
>>
>>   fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
>>
>>   The error is invalid as this file does get added in this patch, in
>>   previous patch series too.
>>
>>   Links to discussion for same in v5:
>>   https://lore.kernel.org/all/cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com/
>>   https://lore.kernel.org/all/9f24e85d-f762-4c29-a58f-ed7652f50919@oss.qualcomm.com/
>>
>>   Links to discussion for same in v4:
>>   https://lore.kernel.org/all/16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com/
>>
>> Changes since v4:
>> - Updated some more devicetree files requiring this change.
>>
>> Changes since v3:
>> - Updated files affected by adc file path change in /arch/arm, which
>>   were missed earlier. Updated some more new devicetree files requiring
>>   this change in /arch/arm64.
>>
>> Changes since v2:
>> - Updated some more new devicetree files requiring this change.
>> - Collected Acked-by tags from Rob and Lee.
>>
>>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   4 +-
>>  .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
>>  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
>>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
> 
> You have a checkpatch warning for a reason. You should not make these
> combined into one change.
> 
>>  arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
>>  arch/arm/boot/dts/qcom/pm8941.dtsi            |   3 +-
>>  arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
>>  arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
>>  .../arm/boot/dts/qcom}/qcom,spmi-vadc.h       |   0
>>  arch/arm64/boot/dts/qcom/pm4125.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm6125.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm6150.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm6150l.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
>>  arch/arm64/boot/dts/qcom/pm660l.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8916.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8937.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8950.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8953.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8994.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pmi632.dtsi          |   2 +-
>>  arch/arm64/boot/dts/qcom/pmi8950.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |   2 +-
>>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         |   2 +-
>>  arch/arm64/boot/dts/qcom/pms405.dtsi          |   2 +-
>>  .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |   4 +-
>>  .../dts/qcom/qcm6490-particle-tachyon.dts     |   4 +-
>>  .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pm7325.h    |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350.h    |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h   |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h   |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h   |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h   |   2 +-
>>  .../boot/dts/qcom}/qcom,spmi-adc7-smb139x.h   |   2 +-
>>  .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   4 +-
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |   4 +-
>>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
>>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
>>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   4 +-
>>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |   2 +-
>>  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |   2 +-
>>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   2 +-
>>  .../dts/qcom/sc8280xp-microsoft-blackrock.dts |   2 +-
>>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |   6 +-
>>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
>>  .../boot/dts/qcom/sm7325-nothing-spacewar.dts |   6 +-
>>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   9 +-
>>  drivers/iio/adc/qcom-spmi-adc5.c              |   3 +-
>>  drivers/iio/adc/qcom-spmi-vadc.c              |   3 +-
>>  include/linux/iio/adc/qcom,spmi-vadc.h        | 303 ++++++++++++++++++
>>  56 files changed, 374 insertions(+), 73 deletions(-)
>>  rename {include/dt-bindings/iio => arch/arm/boot/dts/qcom}/qcom,spmi-vadc.h (100%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm7325.h (98%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350.h (98%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h (99%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h (98%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h (96%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h (96%)
>>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-smb139x.h (93%)
> 
> Huh, what? How can you drop the header? Are you sure you checked
> previous commits, e.g. pinctrl headers, how this should be done? Where
> did you see such commit dropping the ABI?
> 

You too can use search to see how this was done...

https://lore.kernel.org/all/20220605160508.134075-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof

