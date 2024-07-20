Return-Path: <linux-iio+bounces-7737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2006938176
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63224B213EC
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8513D12C554;
	Sat, 20 Jul 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7rI6qyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFFF9F0;
	Sat, 20 Jul 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482236; cv=none; b=Rloj1s0nKIVFDqgpQCDR2iQp5X9f4kipCdPKzazUZbX2q/9PyotvNNmFUYbTMjuw14ohmEo18fuR8uiOGRAMXeq4IH7u68AwSfw4EGVMGnnCEhhve3KcUNxghXyyjbBYDrR2f0RmAqWQNDnsgWWHNk+H4X2gHGud1Ps4UY/f3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482236; c=relaxed/simple;
	bh=OOexEYQ1IyCyOGLORJ0/sryzKNTKc6hzBQlhJB3Pu+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlt7GXtlVPMARlbMiuILfigjVTFIc30bpGh9S1P1L4c7PioKodXvZjp4XZTG4VH8tfS/Ee4n4MZwXFngpWiL5egT7NClUTlaUPYOqCWTLLCLWrBQuK5j3uXa4PDiUS40zrPQEuKOF1ulIJJaP3BKmuM465QPehyn3YkwKE75DYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7rI6qyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE9DC2BD10;
	Sat, 20 Jul 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721482235;
	bh=OOexEYQ1IyCyOGLORJ0/sryzKNTKc6hzBQlhJB3Pu+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7rI6qyNtZDuH+u1aGcBzGVB0brjjFrasYoKZkAVFa1ucUArpW3vnEUFEIA/f2QaF
	 SJrXDpjjirPGqJmCCVcTDrygYY+vIXUcFRNDLS8D36frW4gGF7xJWW7JRR0jFo/EyL
	 1OX1FtmmHvRXIvDbn9ygJJ/FYfPwD4XphkWp9+uXCRjmLgnMCKIgx9+mZLOtzdieqG
	 AukKosbc05rEgu0qZ/CO7iHajNsqoZGOeVwixAoE5mSHZtNFlmqGRhY2nNvq7CFfrt
	 ufOL6xxjoycMQ/6Qe3k9fTCbJzK8Xpdt7r2yNCwfSVSDqTcNnLoJADy3GB7NLSiGJ9
	 YVd/7++xPvlpw==
Date: Sat, 20 Jul 2024 14:30:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: magnetometer: bmc150: Document
 mount-matrix
Message-ID: <20240720143027.2253d858@jic23-huawei>
In-Reply-To: <20240716-constant-underline-b6ad3e2cb571@spud>
References: <20240716132512.80337-1-rayyan.ansari@linaro.org>
	<20240716-constant-underline-b6ad3e2cb571@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 17:28:27 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jul 16, 2024 at 02:25:09PM +0100, Rayyan Ansari wrote:
> > Document the mount-matrix property, which is used in device trees such
> > as msm8916-samsung-fortuna-common.dtsi, and supported by the driver.
> > 
> > Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied. Thanks

