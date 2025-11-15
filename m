Return-Path: <linux-iio+bounces-26232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F061C60422
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F043BA403
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08E298CB2;
	Sat, 15 Nov 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IThto2OL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B286A9;
	Sat, 15 Nov 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763206746; cv=none; b=SGQJInJTehWU/2uy0qS+aqNnvK766xZ0pmk7+USFLsIyJXOpe70Iiv2kUUz09fTCU0ZEnNO5iv4/7aZ/SVRL0saROylsosMGhQb7FUaZ4E618JJq/9Oo5iEqO/MeiXPnu7B4na0R5Tjrkhxam5Fv7Fn8t3q36Ru9iIRidPppREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763206746; c=relaxed/simple;
	bh=z7/L08iDHr8wOIqvcA9cO70oJYQlj+ojHwb2ziUgBcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHetqXy/ZinbfR6OeBJv9C2XMyPJoX2ClrU0vFghJkcPaP8/CiyEx7xhq9e28noFrOVRKi416EDudT624wagUNwl7tBUpJUMRI0QkCC7O+qyGSyL4baIZqkeL2Cx2Hfol4rLClCngZ4IxZsNElHBJoDmJSYXpmOAuq6LldWizFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IThto2OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5382C4CEF8;
	Sat, 15 Nov 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763206746;
	bh=z7/L08iDHr8wOIqvcA9cO70oJYQlj+ojHwb2ziUgBcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IThto2OLqgDfyvQDZHVuAQ2suGImrCeVzDMJvwa3jboZD24wld+2/KnxV68s2JOuU
	 hesbcQ/Y2SK+Kw5kAKUjiNqFAv8waVYkpIHB/JqhDKtxo8beifhTHEwslJNh8QOOAt
	 m/O542SootA85g5ar66v8TM0U6t8cFcml4HzJF47fDFR67nkeA1ADsM9yHl9r4kcez
	 +u7Y/WaHdfnlxcC/Ey5+WmtD/oB+RtBP7PmUv4Ou3IJagySyLKLk9Bp5VU0QFBO6Nn
	 bZg4QAOd1EgJ+tq0NSjf7aw+TpGbnz39rDCfVXz//Hv2w3Un85bOAOAnwmfD/7THBG
	 fAdnEzQpCGN1Q==
Date: Sat, 15 Nov 2025 12:39:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, ramona.gradinariu@analog.com, 
	antoniu.miclaus@analog.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: adxl380: add new
 supported parts
Message-ID: <20251115-hallowed-pegasus-of-inspiration-e6be1c@kuoka>
References: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>

On Fri, Nov 14, 2025 at 07:13:55PM -0300, Jonathan Santos wrote:
> Include ADXL318 and ADXL319 accelerometers to the documentation.
> The ADXL318 is based on the ADXL380, while the ADXL319 is based on the
> ADXL382. However, the ADXL318/319 do not support some built-in features
> like single tap, double tap and triple tap detection, and also activity
> and inactivity detection.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v2:
> - resorted the new parts references by numerical order.
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl380.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


