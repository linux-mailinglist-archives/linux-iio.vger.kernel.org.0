Return-Path: <linux-iio+bounces-742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73848099C5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 03:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7021628227B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 02:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02562566E;
	Fri,  8 Dec 2023 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLgN6X10"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EB566A;
	Fri,  8 Dec 2023 02:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D69C433AD;
	Fri,  8 Dec 2023 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702004020;
	bh=T9R9DEy6CjQhMtIY2Sx77MVq9hPTMMtAPfSMWQzuT1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLgN6X10ITy7yj61Wp2W+N7Bc0uXH0RzEzpJwrpA+2bWJ+MzONdYO+0T4ngPPyeaC
	 hILpyTRsDdjrSd4K/QsCSKLVy+2Vt5Wd9FQlbP0fKdMIuwIi7kAc97wwha6Bu2pHVj
	 6H5IwMkZDMOQEDBTLfCFVhlgspnGIYE2ni39Haq2DXinWNzWYfp+vLY20gh22+T4f3
	 9caLsT8PTCZHDCjzuBMm4xwkMOVGO4gUj4MFCJ79dcaD2zojCErAb/mELJ0L09Sc8B
	 gu0tl3W4cOHgeQehpv/V/5IYcVeSXU/kgfQhYmKqDPtSUD3rma4EwSxM+gezHW3lzd
	 oC4BPnp7WSfzQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Nia Espera <nespera@igalia.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Rob <Me@orbit.sh>,
	Clayton Craft <clayton@igalia.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v4 0/6] support oneplus-lemonade(p) devices
Date: Thu,  7 Dec 2023 18:57:44 -0800
Message-ID: <170200426924.2871025.17125977730040809387.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
References: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 11 Nov 2023 23:07:38 +0100, Nia Espera wrote:
> Patch series adding support for oneplus-lemonade and oneplus-lemonadep
> devices (OnePlus 9 & 9 Pro), along with a few needed fixups. Currently
> working as of this series:
> 
> - USB OTG
> - UFS
> - Framebuffer display
> - Touchscreen (for lemonade)
> - Power & volume down keys
> - Battery reading
> - Modem, IPA, and remoteproc bringup
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: iio: adc: qcom: Add Qualcomm smb139x
      commit: 7bf421f44549cd0bca32bd0b4cf6e4cfe5b4f865
[2/6] arm64: dts: qcom: sm8350: Fix DMA0 address
      commit: 01a9e9eb6cdbce175ddea3cbe1163daed6d54344
[3/6] arm64: dts: qcom: pm8350k: Remove hanging whitespace
      commit: e70537717146b380e18f0c92669d968af4acb8a7
[4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
      commit: 54ee322f845c7f25fbf6e43e11147b6cae8eff56

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

