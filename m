Return-Path: <linux-iio+bounces-577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934978034C9
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA21F2124A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69425112;
	Mon,  4 Dec 2023 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyhnU/Jh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE249ED;
	Mon,  4 Dec 2023 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0EC433C7;
	Mon,  4 Dec 2023 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701696393;
	bh=+KG3xcZFmyTIbsERfnkP9uoq6hpeNKXxUGzii+pc5Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MyhnU/JhrifVCtFAvZAaYK6Y9cw5Vffz3K+2EC9PP5lRzheWG2PAp4XgT2kLwsdth
	 qYXPaixNhYL6tMgiJg2PZm9IN9rXzOK7DLy1Pa7gn+kcCZTeU7CMDC3y06FrduxrlJ
	 Tw2BdGbxlPgbjXLP2ecMpyKHaAIb7SRbHGgaOoxb10e13M7g0aETR0KR+y6/EV3AlV
	 imj55cWAPTTfDkUaReH3tVJiaLVmdUsO85vhrc5G6sxWQGanKlbS32pFs41KaSVmH9
	 wLFi6CNym5n3Puk5H4LvFJYwPFMwKDCPFOSxt0piuHwjKpMIdiT+SxNlL3VAv3ovG6
	 E2IJ2r99vayAQ==
Date: Mon, 4 Dec 2023 13:26:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204132624.03733d50@jic23-huawei>
In-Reply-To: <20231130171628.12257-1-johan+linaro@kernel.org>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 18:16:22 +0100
Johan Hovold <johan+linaro@kernel.org> wrote:

> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series addresses the iio/adc ones.

All look fine to me.  Just waiting for the DT folk to have time to take a look.
> 
> Johan
> 
> 
> Johan Hovold (6):
>   dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
>   dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
>   dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
>   dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
>   dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
>   dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples
> 
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml    | 10 ++++++----
>  .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml   |  4 ++--
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml    |  9 +++++----
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 


