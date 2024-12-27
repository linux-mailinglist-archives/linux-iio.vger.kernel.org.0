Return-Path: <linux-iio+bounces-13812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225979FD1AC
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459707A11D5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DC14C5AE;
	Fri, 27 Dec 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8vUSzCK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8213D893;
	Fri, 27 Dec 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286284; cv=none; b=bASvP9w9eerc/Fdg+keQaueUS8V5ef/WTqLu1qCfrZVQ2fJtiMaU63q9WEnCeMV1C3zT2gYcKPS3M9oMrhkT0elu4ZIeQpV0c4F9UtOZBV7Z13rzqTpS3wTzz1N3JQoq6VwmRQ+vR2B5PE8BK4DDAyeHQqWt2gZsk5ZW2XGEAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286284; c=relaxed/simple;
	bh=hZnnMoLnLYeiTLvDZgWkBiGL9rGzckdyrR0JJNzph8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjMGnj3X20Dr+0pKGl+7LKW/UtoE6XzXwd42liEgdoffUrmLw7uljCJ4NzdhbzzUQf4Ty4XrfeiBh+F/RmfQmVlKMbaOtKre4Gc/GOFA+VRX1By/T61NqRnFzDhVz11bSVuOJ/ngHsMC+YK4EIWcl9vHSmDvE/Q6J7zUtnKMxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8vUSzCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC493C4CED0;
	Fri, 27 Dec 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735286283;
	bh=hZnnMoLnLYeiTLvDZgWkBiGL9rGzckdyrR0JJNzph8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8vUSzCKv9lQFyYkfZF5L480BDiGtfq4pSx2cYSEhFT1ioFKLNx5CU6JGovHJzFQx
	 y0OuvJ6QoErol/JO0oVR8OIkMv+6GyDAc2NzL4NEMfKs10Jb4zTNtg8MSEWZX5leVk
	 aXa9ECVqn/4HamxoBGinad7Wi20Fuoaut+xrJIl1ufbJm1DSLpomnIky8UfMvmWxxe
	 CsrHwvSTkLrhYDVBXVlQBG+PjcOn5s+XCDxljmWcTq1MfmgsRAdoJYIdPCfKLNVhbI
	 1ubYa1p39FCuQfsuj0/YzsY6RGINWG8lPKIg2Jp8wzTGcK24/88SaeZw9/KvOsL7j4
	 oom3YTX0/ij5g==
Date: Fri, 27 Dec 2024 08:58:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v8 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <36gtabgmu7f2mafxzq4siwbf2hocyoudgi7mhkr3v33ajqcn57@xq7l63lrgdxf>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
 <20241225181338.69672-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241225181338.69672-4-l.rubusch@gmail.com>

On Wed, Dec 25, 2024 at 06:13:34PM +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor.
> 
> When one of the two interrupt lines is connected, the interrupt as its
> interrupt-name, need to be declared in the devicetree. The driver then
> configures the sensor to indicate its events on either INT1 or INT2.
> 
> If no interrupt is configured, then no interrupt-name should be
> configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> mode. This allows sensor measurements, but none of the sensor events.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


