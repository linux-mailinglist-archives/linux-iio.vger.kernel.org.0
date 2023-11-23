Return-Path: <linux-iio+bounces-300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E327F64D5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888751C20E86
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A93FB3D;
	Thu, 23 Nov 2023 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J4i8Mhui"
X-Original-To: linux-iio@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9E1B3;
	Thu, 23 Nov 2023 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vr+lIUE48EiaMmm3K/kGj77WRtOkOjRn/VOxNXh3gYI=; b=J4i8Mhui6IKuHMj/fdwD8XkeCm
	Oz6ziuQPmUlTWllIWSox2ftFTTZnVqdxZJUskAlpFQnBj3bNgD/o+OSzZwTh0WmRyCuOEYdVnBjFp
	57GRV5fVZoSU0iXIS+qH01sDAzL0d6sm48F8mi62S4eFMkalBwKHphA3CCWSZ1nblOR3o1MM1tUsr
	1WF7FALHxXv5gZtJ+wDV9ubJb/yQghTX3dE0KI4MyRI9QbiARQJ6ILeVgq+YjhfKoIbG75YQuS2j6
	jrNXp2rfZD42jIuSBmi4q0Xa/N9wYeOFwHWDOYw6mht6EqCnwemtHWSXPQwOvm4Ea/y+DLDSpKukB
	kA3l00Qw==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.110])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1r6D9J-006Tcm-7x; Thu, 23 Nov 2023 18:05:57 +0100
Message-ID: <1e45a031-080d-4cbe-9741-182524227124@igalia.com>
Date: Thu, 23 Nov 2023 18:05:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: sm8350-lemonade(p): New devices
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
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
Content-Language: en-US
From: Nia Espera <nespera@igalia.com>
Autocrypt: addr=nespera@igalia.com; keydata=
 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
 T+I7o407lOB8a/PJA2YXM4VVC/iyMBM=
In-Reply-To: <d35b9250-eddb-4436-8daf-066ec84cf55f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/22/23 21:17, Konrad Dybcio wrote:
> 
> 
> On 11/11/23 23:07, Nia Espera wrote:
>> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
>> mentioned in the cover letter for this patch series, but for
>> accessibility also repeated here:
>>
>> - USB OTG
>> - UFS
>> - Framebuffer display
>> - Touchscreen (for lemonade)
>> - Power & volume down keys
>> - Battery reading
>> - Modem, IPA, and remoteproc bringup
>>
>> Steps to get booting:
>>
>> - Wipe dtbo partition
>> - Flash vbmeta with disabled verity bit
>> - Flash kernel and initfs to boot partition with CLI args 
>> pd_ignore_unused
>> and clk_ignore_unused as v1 bootimg
>> - Flash rootfs to some other partition (probably super or userdata)
> Thanks for including this info here
> 
>> +&pmk8350_vadc {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&gpio1_adc_default>, <&gpio3_adc_default>;
>> +
>> +    /* pmk8350-ref-gnd */
> I fail to see the benefit in having this both here and in the label

Oops, removed.

>> +    channel@0 {
>> +        reg = <0x00>;
>> +        qcom,pre-scaling = <1 1>;
>> +        label = "pmk8350_ref_gnd";
>> +    };
>> +
> [...]
> 
>> +&tlmm {
>> +    gpio-reserved-ranges = <52 8>;
> Would you know what these are connected to?
> 

Judging from the line names on the hdk dtsi, 4 seem to be connected to 
the fingerprint (FP_SPI_*) and the other 4 are NFC-related 
(NFC_ESE_SPI_*). I can clarify this with a comment if necessary.

> [...]
> 
>> +&mpss {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&rf_cable_ant0_active>;
> patch-wide:
> 
> property-n
> property-names
> 
> Konrad

Many thanks!

