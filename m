Return-Path: <linux-iio+bounces-23355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A4B3B40A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F571B24688
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3F263C69;
	Fri, 29 Aug 2025 07:14:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D52940B;
	Fri, 29 Aug 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451660; cv=none; b=EnWBGhqKLeQpv/pT0U1pB98xmVUrNHRKEMpeE1PcHzjJsrz9TpzjDUn6YFLIEJQc1FQORKXmLIRngaRuRGz4yGSmfv4+e7XYVovPTOu3L2TLHyen5kGMZFjDVJMMbo8oj+ZpvzSMmYf0+wr3OffEHeZIeQSN5Vdh/DJwCCJoLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451660; c=relaxed/simple;
	bh=D+T7LzYWrMk0PpmII10Y9YmXRwxyI2G0YHgKbnNDPLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLdkfjDMksWoq35fjZk878fn3jOCcJSjQJaBYr6x2pUeVEtyOQEhzwKVu0wmuCrG+XBLo1TE+FldZ2abzaC7TNQvVDRnqilGsbuoAmxBERw2UZtRczH/g0e55EpzMJiyTzefvPK2TXfZbK2zwlqXnpw7+RGWAbp/Yl1IVUxi58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AE6C4CEF4;
	Fri, 29 Aug 2025 07:14:18 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:14:17 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, lumag@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org, daniel.lezcano@linaro.org, 
	sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org, 
	rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, 
	kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20250829-helpful-clay-hoatzin-acb8b1@kuoka>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 02:06:57PM +0530, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v6:
> - Addressed minor reviewer comments.

No, reviewers comments are not minor. Your change can be minor.

Anyway this is just vague. `b4 diff` fails, so your changelog must be
precise.

Best regards,
Krzysztof


