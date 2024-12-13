Return-Path: <linux-iio+bounces-13411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7870A9F0687
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEAD188AD93
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF71AAE17;
	Fri, 13 Dec 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XozZLlCV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73619992D;
	Fri, 13 Dec 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079130; cv=none; b=f+6B+d2sCkLY0RKTKBe520AaxBodFJkrHiY9fpSSG1DFcCovv86L5zgJaypkFIIWrBGq4b8PIOY0dNiTopnM5BF3NeOK2bJTSSIuzUlHd5SHx6TjeznanU2ZH7XaudIRi27vcoRWLf0MHW38IVQnZxGZmbvjgNEj5NEpoVLi1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079130; c=relaxed/simple;
	bh=vwX4OsbL6RtShMtAS6opjzcjty4lpcJ2c9RuUsRi5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4szaEPvZgzruqE+gd0N7iW2Xj1ybIMgLK7X2XijjJrzaYfFeA9PgzaIEY8H4ihDxo2DJpZfSjPhzcwBgtJNNnfyT1zkK4J47Q2XaRJCjs+1H5QVMGJqaV13ORcig6AeQz9Yjj9aN4zi+LDgm8xtYoLrcnRjym7+36754JnYMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XozZLlCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1329EC4CED0;
	Fri, 13 Dec 2024 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734079129;
	bh=vwX4OsbL6RtShMtAS6opjzcjty4lpcJ2c9RuUsRi5g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XozZLlCVS68QtQkIyYIrBNwLUzC+YDf2Qrm2c+5pyVZ5r8L/5XHnI1JMgTXzPZRWD
	 rYs2ZYPFf+TWpDOzNkO2rao1dLws0W8Bj4XJv7nt7JvURVUftipRRPwWbTWsRJyBFZ
	 JhCr9zhtb1SakKPbAF3U/uAuOyhjOoOkG2ZVxgOAQQQsaLutcx4CA8z3/eFc4fhrte
	 EgsoPix4OwtevcNS4G5uxFLSh2tBfcuLJ7sGJcuox0O5L0Uh2Rm1blwpV7AVCL7Pxg
	 PIW9J7sEGz4pyZma5rzf1Cb2c1e9rQHSRnNQO7jdgvrhXoQ53YVTkLaMgZKvVnWqP9
	 qI2cHSenUugYQ==
Date: Fri, 13 Dec 2024 09:38:47 +0100
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
Subject: Re: [PATCH RFC v2 0/5] Add support for MBG Thermal monitoring device
Message-ID: <qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>

On Thu, Dec 12, 2024 at 09:41:19PM +0530, Satya Priya Kakitapalli wrote:
> Add bindings, driver and DT for the Qualcomm's MBG thermal
> monitoring device.
> 
> Please note that this series is dependent on [1] which adds
> ADC5-GEN3 support.

Where is the changelog? What happened here?

Why this is RFC?

Limited review follows (as this is not yet ready).

Best regards,
Krzysztof


