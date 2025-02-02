Return-Path: <linux-iio+bounces-14861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC53A24E3D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444433A68E2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5791D88C4;
	Sun,  2 Feb 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgjBuPxJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E01D63D8;
	Sun,  2 Feb 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738502960; cv=none; b=sSjsnOZVbEs2rP8ZAhWMkmgFGc3OPPo2dXD57st3hfvdnKNYYrgBnhxGZzsnn4SK87s7fhOHLaENgSF/SzqDR2e6feq6HXAeUFJ7J++ZdhgsIs/NMh4C21/XgNi5emuqP9bvTVa531SdeM0Mper9L29Yro4gv5zyuFy9TmwzLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738502960; c=relaxed/simple;
	bh=rQIDtLkQStpJWGLYiDYGfskSNgQQHVdsYEhYAb5zksA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPK90RPpzo8sp/XLLlVzlvxIwBF5EmaCxT/lVbqmXlJvL5Qf37jO2AZMlZTRA6Dc22C0o2xJ8ItMnmDOKV4rzeDfW7PFfcT+4uq8j+BFgsm98mM8EfWV1eWiI1ZxUu3QS+IuJv/0BT1ykPZWRCBrBpvLAQxEiMA1rxDUECDrl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgjBuPxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088B2C4CED1;
	Sun,  2 Feb 2025 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738502959;
	bh=rQIDtLkQStpJWGLYiDYGfskSNgQQHVdsYEhYAb5zksA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgjBuPxJ4po73sBLfwiBdB0qb1lVTRGP3F6Qg5j75OFm72tQGrU3poA0a/Vgy8Kop
	 6h3yqKkTxXZSVVeMPkTuBAoKBW/PfYOijE5eIOEjkP9WaUvKUsKTKWQg1Ir7QDx7a4
	 nN6R5tQc5q2gPNZsezstYr0UI89GaNQas/YRz3QN6tnNYQnu7WmI2pXUCv3lk5lQoE
	 +s356ORFCn6qrYjWvlEJhZGWYvdEf7MWlnjblfhDEdOYBIxnyJOu2JeeXLt9mbiwmY
	 W0tYqIeTdr5AHq7932ewJ8mKW1H09MkfpZh1Za4jPsfgf6Rp75u1SvnStcXwzOvHHf
	 J1MHW0GqBDmeQ==
Date: Sun, 2 Feb 2025 14:29:15 +0100
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
Subject: Re: [PATCH V5 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <20250202-convivial-stingray-of-promotion-1123b8@krzk-bin>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>

On Sat, Feb 01, 2025 at 12:02:38AM +0530, Jishnu Prakash wrote:
> There are several files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since all of these
> are specifically for adc, move the files to the
> include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation
> errors seen with this move and update documentation files to fix
> dtbinding check errors for the same.
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v4:
> - Updated some more devicetree files requiring this change.

I don't get why this fails building and nothing here nor in cover letter
helps me to understand that.

Best regards,
Krzysztof


