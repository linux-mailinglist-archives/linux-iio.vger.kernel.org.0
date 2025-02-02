Return-Path: <linux-iio+bounces-14862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C208A24E4B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 14:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FEB7A2878
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B41D90A7;
	Sun,  2 Feb 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jboRi8g6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149991D8A08;
	Sun,  2 Feb 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503156; cv=none; b=nNhxFQ3ocK4ZasIHZQCjsLbqaVx8HCrUe5CN4hQhiZnppNwck7cTa8spsexSNMnUW3CJRoulHxkPPelKH/tNJ8H0f7b+Y6aVvhWUhhWtvrfqBmqFciPbCEzSlL433w79G+kKzbuoLA4+th0cCtjIFydBgmbl2NY6htTHJ/R7VM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503156; c=relaxed/simple;
	bh=el7q8yQW5/VyLu2uJCjHbCSBtjdX3W1inh+KU/l22UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJAtRz2HQIj3cz1lvDPcOQmbKSoxAbGr3NEVLwNIJOx0pMJYz3ZF4ZdPc023kfT18jSie6yQZ1mv4d7ZUJfBfi8BLIRK/jUlFMVJ3Wv18XE/FA+2HQYCGFiQnm6IZ5aMSCdzXdbuA8rc9KZjva0plNQQ/xZNx8gOTjEXjLIzHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jboRi8g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB780C4CED1;
	Sun,  2 Feb 2025 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738503155;
	bh=el7q8yQW5/VyLu2uJCjHbCSBtjdX3W1inh+KU/l22UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jboRi8g6yJtNyFvm1NBPiH7c8qX0bJSQLyiJSU4xfX2JqQwwNn5ul8hdsbs1zmhb8
	 6e4XtuOYe98ac9DJR2BS8Avb0011isRQwEP36awP0ETmJUngbMU7qCsWeHSDhYM5IL
	 IS5M9gWfUPNP5+km4l6jcfsABTKAtLFc6GCDOyK/RqVFjSRNwb+yTtUd47PF+WzJzc
	 /Cb7PiEWUf274ZVEjYSAvXPkPLPhZfRtEViRqyUCfZpDQHXzy5vnr7cFjzB5DbgYYh
	 YB8Jo6Fn/zneU01vxPKT2Qi3TZQ0vNDEirPljQU15UtyeDBDn1Qfp0CwTuqdsve3/D
	 HAwxDhL6JL7iQ==
Date: Sun, 2 Feb 2025 14:32:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, konradybcio@kernel.org, daniel.lezcano@linaro.org, 
	sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org, 
	rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, quic_kamalw@quicinc.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com, 
	neil.armstrong@linaro.org
Subject: Re: [PATCH V5 2/5] dt-bindings: iio: adc: Split out QCOM VADC
 channel properties
Message-ID: <20250202-ivory-jerboa-of-renovation-b141ea@krzk-bin>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com>

On Sat, Feb 01, 2025 at 12:02:39AM +0530, Jishnu Prakash wrote:
> Split out the common channel properties for QCOM VADC devices into a
> separate file so that it can be included as a reference for devices
> using them. This will be needed for the upcoming ADC5 Gen3 binding
> support patch, as ADC5 Gen3 also uses all of these common properties.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  .../iio/adc/qcom,spmi-vadc-common.yaml        | 87 +++++++++++++++++++
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 75 +---------------
>  2 files changed, 89 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


