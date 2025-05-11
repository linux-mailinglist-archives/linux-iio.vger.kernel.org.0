Return-Path: <linux-iio+bounces-19426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D58AB282F
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83D53AA0F3
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8C256C84;
	Sun, 11 May 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFX5nVSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79A17A2E8;
	Sun, 11 May 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746966296; cv=none; b=QmI78yhhKyPMu1CkNAaF51mfrkKrGRD75nOUqphu43+EUpN6aO2FgLtqZ/Y8lcLm7RE9pL2RbKGlZyUW8jVFDiEXX1AhE6AjvvvisOngXGSReQGGvEQjDYf5XKa6N0wg6hkLdyglT+ZUuKqJ6DEC/H4rYNUzx5RAsLrpLS4zCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746966296; c=relaxed/simple;
	bh=nEyf68zI/CpFMNEs3vgorP16c3dGRsG+bMJzrlvIVC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2dLkTKOCMWBNTf1cm2fRt4O2XSZTHo2tg37DQyHghSqr4a29VTYIheFxIqZic2okxjtf0wgDx5Uk7yc7PMulfEpf2GKXPePeN+yaXX7agDRcv7Eb1/VADe1A0dEca/9V6slfzuo1wzKsdiPivK+Qn166Yc0eg0L48UKhv//BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFX5nVSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BABC4CEE4;
	Sun, 11 May 2025 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746966296;
	bh=nEyf68zI/CpFMNEs3vgorP16c3dGRsG+bMJzrlvIVC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rFX5nVSLWjrHj/N5WJsuI/cbAf9xNxaWjFNTKqXLd1qDN3xHcmsC7+0fWHZOMMy8f
	 5Cy8gT4nOKUNCEgrO0AevhaCF3gEMXu6gMgYtOJpH4blc3h0RULGrkH71OtK7SW99O
	 iFV6RyF5LIW9PepuADYGbcGLEaO3UkW+eKrggJmVGykC6liaGdynwKuSOjvW/rY6PB
	 5Vn8GS36lkTUyLwNfbOZ5ilzC2XD4v5uXyZmU93rFG8fLhn/pVMAQM7mgo93IyRP+j
	 T81rEIO1IiJZNwaW2XhgFI/bobT0L+GBS4h9XhKgrsv55R78wTPNEreoPNE12RKB8T
	 Q3kM9zB/zvN1Q==
Date: Sun, 11 May 2025 13:24:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V6 2/5] dt-bindings: iio: adc: Split out QCOM VADC
 channel properties
Message-ID: <20250511132443.74fd17fd@jic23-huawei>
In-Reply-To: <20250509110959.3384306-3-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-3-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:39:56 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Split out the common channel properties for QCOM VADC devices into a
> separate file so that it can be included as a reference for devices
> using them. This will be needed for the upcoming ADC5 Gen3 binding
> support patch, as ADC5 Gen3 also uses all of these common properties.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
I think I could take this through IIO separate from the previous patch but
is that useful?  I'm going to guess not and suggest that for this one
a qcom tree probably makes sense as well.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

