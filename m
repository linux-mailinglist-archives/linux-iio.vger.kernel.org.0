Return-Path: <linux-iio+bounces-12668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EA9D8E10
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE01623AD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684F1C07C3;
	Mon, 25 Nov 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMFJLHg0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C419066E;
	Mon, 25 Nov 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570388; cv=none; b=sNSnHk+ztZrBr7e0OXr+3Ou5rdcKxJaYINdhBG6R0Gp7fj69e3dGJu5MbAADraleQwCjuESBKEPRD0xpy1OFSRgRNKVwa1U5Rhc2A4Gqt7qYGksUR+hW5vv6vVYYGQqblWufMAn9/cF21BZRDTS9n35iYWKpe2z/dqUaqUL1mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570388; c=relaxed/simple;
	bh=uY7jnyAlzoQXL7KcBI2CiyOBUKz+IVZNC1RgfNxXBlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze0zHH/RefOtAXoE6ytvLEyUP3Ff69XLHIlkbf82JcWJOBMLiQrckMm4+RhmwBeOWIpO1jlhTP8ndsjZKPRlfSbqCRAen/e+P0Dd3zqs5m+OPzCsG4avlk2LaZsTFIj28yjM4fHkcAioH8AbgTxnXbIXm0zozRGX3ARBiG6dhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMFJLHg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC2BC4CECE;
	Mon, 25 Nov 2024 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732570387;
	bh=uY7jnyAlzoQXL7KcBI2CiyOBUKz+IVZNC1RgfNxXBlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMFJLHg0yDzXpj5S/OS8ghB98MJ3zIk99CvSaCd4+yphsIJob9SCafvtdC5Y2ma3P
	 WRUHBU2SKcOXQjeoSgLJNMhhbv84wNgt5AjsM9kElhifoWbYtnGOYqyUK5yUjh1+nG
	 v1Qly6RuKmdsDcYhdYug5Ypd0vyfQB24r81cA+iju9MuA4SGe0Gx9+aswO/ps1PYuP
	 U2cLNRS5W2f0CqXjqrHr33s9z+2/HC38LZvEjiI9/K88fv+Qekj3Z/nK07RrB9bhCP
	 mKheTRyQ2zVgl7GUBrKYkuONOlJ8ZNNE2ojmkq7P4pCGMOfqLcFPlNWWIU8kwPXP0j
	 +COiWk81U4NuQ==
Date: Mon, 25 Nov 2024 21:32:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Message-ID: <20241125213259.180db011@jic23-huawei>
In-Reply-To: <FR3P281MB1757CC51713A1A6C418B2A57CE2E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
	<20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
	<FR3P281MB17572DAAB3B3145EE7AD56E6CE212@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20241123153333.51e4a517@jic23-huawei>
	<FR3P281MB1757CC51713A1A6C418B2A57CE2E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 11:43:24 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
> 
> thanks for the confirmation, Jonathan.
> 
> Then, it's good for me.
> 
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied. Thanks,
J

