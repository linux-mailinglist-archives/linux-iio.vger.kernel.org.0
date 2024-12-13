Return-Path: <linux-iio+bounces-13410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D049F0682
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E9D283F8E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B561AA7B4;
	Fri, 13 Dec 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4KqoqS4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9119992D;
	Fri, 13 Dec 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079100; cv=none; b=qz4ZOfg0tImA9hl6/jfgEVsSICeS3mwg5hzD+TtiuJzwQh95UXS5L200x9BaGiChPy9XQpwsXTJBns+Ua5jLIx7K7CaBJpjmlW1/+lxPJrNPIq4LlL8ABSmVXR5MbhXsbtZ4ExKDmHJyIlD5O/EZVh3E2fgIbtwRM11KT9+XFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079100; c=relaxed/simple;
	bh=w6MUQGWEEz6VoZhHPa11WOx3I8GjlyTQVtPw/HadabI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiprpDkS4pQeNK4VbShyRJAmN3AH+Lb2lp+rnuMOIh/e0r3gPt6jYRCmZACYc/iVPDiv2p8IggAKWNGsJOx6ACgph3amyK3P+uVtb4gCzBmyGsOro5px+G/opyH6YnHUDGt943qURGATbt4t1u/MBfWqcbRv8GAvM7CSDzCkjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4KqoqS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC4C4CED0;
	Fri, 13 Dec 2024 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734079100;
	bh=w6MUQGWEEz6VoZhHPa11WOx3I8GjlyTQVtPw/HadabI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4KqoqS43ghZ9tDYnoPe7wpfUq86+4NJ+R2o5c/dPDlkyKxBorth/myMdqCf9vQud
	 CUDLLymwDlumlHHEXf0fMrCqFArGLmKgkzkFnFUvrnRfsA9zl1b6B5MaKKgaS8menY
	 XaGdGf+dp7fQ2a0PbM1YkkWCoQajj5h8SzYVMSZdZZyHQ+76T/R+Yf2yeUB4G9xmrS
	 LvcXb2bUAvwbkT52B9tRlPkyUKtBONrcOM5Am9eP/veHNHr/38vOlAXK0T5cyJ68rA
	 9v5l2AsrgO5wGKvJbsBYmWYmNOoUHknZ6l2tcF8m9CYGVIa+EjwHronfmhHD7KhZJO
	 jq6x54o5Y2Pcg==
Date: Fri, 13 Dec 2024 09:38:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Message-ID: <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>

On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - io-channels
> +  - io-channel-names

Binding looks ok, but this wasn't tested due to unneeded dependency.
Please decouple from dependency, so automation can properly test it.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h>
> +
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmm8654au_0_tz: temperature-sensor@d700 {

Drop label.

> +            compatible = "qcom,spmi-pm8775-mbg-tm";
> +            reg = <0xd700>;
> +            interrupts = <0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
> +            io-channels = <&pm8775_1_adc PM8775_ADC5_GEN3_DIE_TEMP(1)>;
> +            io-channel-names = "thermal";
> +            #thermal-sensor-cells = <0>;
> +        };
> +    };
> +
> +    thermal-zones {
> +        pm8775-mbg0-thermal {

Drop the nodes, not related.

Best regards,
Krzysztof


