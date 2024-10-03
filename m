Return-Path: <linux-iio+bounces-10038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1098EFFF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7330C1F21BC9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0F199391;
	Thu,  3 Oct 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCq9ShFs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BF1991BF;
	Thu,  3 Oct 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960937; cv=none; b=fa9w34DwY0cBFuziMNsn+vKwabJ1k6O8Sy2xaN0X5BtoFX+Q3hrTXlNYruYfjTJnWnbIEUYGVMGl2gpwaTyYRGichSra8kGr2UbPv8AyNzhRvu+oJEeJ1soMJ12VLx5Fa2Eb7kXQL4+4U1ug0ARl2wpfiksOvGFM2x/K4iNrVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960937; c=relaxed/simple;
	bh=E40dmaJlCoSBupQ1G6fHmW3VOHUF0ixEJscg+01nJ+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcSN3eeh5gkIqq0cAU1NgogozL4W5jBFyPfIfvPSzfPSjHAt5NXy70vG0C+L3piGU3ycBX1SLPeO+eNuYIfgOG4ok995cCojgW+j5GNpryIT9YhbPERtWbmWO0GP4QhWj3a6/Jl5wgF+b9qXC/qE/S1NTsXoMqdeDhMsI/k5fb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCq9ShFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16822C4CEC5;
	Thu,  3 Oct 2024 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727960936;
	bh=E40dmaJlCoSBupQ1G6fHmW3VOHUF0ixEJscg+01nJ+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BCq9ShFsvAyDqnioUHbKnT54m9UDhy6RtaZxMKbxdiJ9MWo20+SxJPwAiZI2vkpPL
	 CmcEATTBPJShktwoHkZnz+KsdKPLF2wNR1LFMDykCUh9gT3P1zzdq1n1sGu5McrgXL
	 378gdjcVeKZz4dFqhZkf23iYj/vOVCIdh1yp11WpH4XwITSixfJ95IVC9yqj3o/jhM
	 ZNhq9dwwbVg/VW334spd+1xUshrMad0h/cCdthIaCO1L0q/9aX908uD1BEq+GKYCRB
	 hpyI55QhofB6k8zFpEZ5upJGK7Zg0XCB1QxsV8VNnrgI5WcW3PYp1pHhKQjd8afZB7
	 JoTqspJDzR86A==
Message-ID: <2e4e2241-2295-4584-81b1-5a78d4086c85@kernel.org>
Date: Thu, 3 Oct 2024 15:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address to
 tdk domain
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
 <20241003-invn-maintainers-email-update-v1-1-7e4062ad68cf@tdk.com>
 <b8a359d7-5043-475f-95c2-0bad2a9f6f92@kernel.org>
 <FR3P281MB17576E4FFFDB3B61677BB1C8CE712@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <FR3P281MB17576E4FFFDB3B61677BB1C8CE712@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 14:49, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> I apologize first for doing a top response, but I'm stuck with an email tool that doesn't allows me to have better response than that. And sadly, I don't think there is something I can do about it.
> 
> In fact, when trying checkpatch --strict I don't have any warning on my side. I was using in fact checkpatch -f which is for testing source file and not patch. I tried upgrading git to latest version, I don't see any change. b4 is version 0.14.2.
> 
> 
> ./scripts/checkpatch.pl --strict test/*.patch
> --------------------------------------------------------------------
> test/0001-MAINTAINERS-iio-migrate-invensense-email-address-to-.patch
> --------------------------------------------------------------------
> total: 0 errors, 0 warnings, 0 checks, 8 lines checked
> 
> test/0001-MAINTAINERS-iio-migrate-invensense-email-address-to-.patch has no obvious style problems and is ready for submission.
> --------------------------------------------------------------------
> test/0002-dt-bindings-iio-imu-migrate-InvenSense-email-to-TDK-.patch
> --------------------------------------------------------------------
> total: 0 errors, 0 warnings, 0 checks, 16 lines checked
> 
> test/0002-dt-bindings-iio-imu-migrate-InvenSense-email-to-TDK-.patch has no obvious style problems and is ready for submission.
> --------------------------------------------------------------------
> test/0003-MAINTAINERS-iio-imu-add-entry-for-InvenSense-MPU-605.patch
> --------------------------------------------------------------------
> total: 0 errors, 0 warnings, 0 checks, 14 lines checked
> 
> test/0003-MAINTAINERS-iio-imu-add-entry-for-InvenSense-MPU-605.patch has no obvious style problems and is ready for submission.
> 
> 
> What are the errors you are seeing on your side for these patches?

Big red warning:

ERROR: Missing Signed-off-by: line by nominal patch author
'Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>'


Best regards,
Krzysztof


