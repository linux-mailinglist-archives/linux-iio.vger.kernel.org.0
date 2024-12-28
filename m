Return-Path: <linux-iio+bounces-13839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D249FDAEE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CE18830BE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356216A930;
	Sat, 28 Dec 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Ko32qh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAD524F;
	Sat, 28 Dec 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735396248; cv=none; b=t4bXlmtYnO9OKKP3v7wE/8xAB+L6yYXND0vyK8msgcr+3IkbhDc2nVfZGSn8/RWmso+yNGTuh/8MBI4quHnG8b8I6PrrJqvIIhrrW9aUNF32S9NHZ2KGgsrgSiNeZjUzUaa4Dd3Bb1hg88ry48ywnQ+LM2XolFNPsR6uCL1goSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735396248; c=relaxed/simple;
	bh=BcgGtKTYasXayRat+Nz4cnvZhgXWJTtjXF5xdyiUq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAluCsfaployJ2GiQf0CW47FvZbDhR5MQr4esCLTWFP0SzNylN3cOi8IkQKpPDtNAaCMEB3HmOD+H6WPlHcr0UMS27L7yGiATmvuQvnhgC7UwDbbGwqp47jSKqRYJYkW8p/S8JvL7zYVhiGMBq8hQu6zST+0IaD6Hy777kthLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Ko32qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C176C4CECD;
	Sat, 28 Dec 2024 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735396247;
	bh=BcgGtKTYasXayRat+Nz4cnvZhgXWJTtjXF5xdyiUq0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/Ko32qhU7RljL3BoCZSJ4xH9jv07LxI+1RJJ/ASosS5wAp/g9SlqtAmfezZ6+mFl
	 MWFUbveezZyDrghbBUVyASDK7+TcObQ0G4kwpKP1fwdNCi9urA7ScbuMBPQHwMFWCS
	 3kfkKnLDja1WqjTe7OLuRDJxnGZ44PevrbwfaysH9PKEvDhYLcZ/Pyf8jKOKwXfgkm
	 6UrgeoaAIJNtDZ//kM5U8HHwKnKwho6SehA7mlii3W7hY2zdcDD1aJv3bBoUiAvnpz
	 FKOmDiZzcWwWHYVjVvjV9r2bhb0h3kb3+UpDBnyAzA5TV51PC5AYsMz5OeHIGauwCc
	 whFnJxJRkxBoA==
Date: Sat, 28 Dec 2024 14:30:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v8 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241228143038.29c7a9a5@jic23-huawei>
In-Reply-To: <36gtabgmu7f2mafxzq4siwbf2hocyoudgi7mhkr3v33ajqcn57@xq7l63lrgdxf>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-4-l.rubusch@gmail.com>
	<36gtabgmu7f2mafxzq4siwbf2hocyoudgi7mhkr3v33ajqcn57@xq7l63lrgdxf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 08:58:00 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Dec 25, 2024 at 06:13:34PM +0000, Lothar Rubusch wrote:
> > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > sensor.
> > 
> > When one of the two interrupt lines is connected, the interrupt as its
> > interrupt-name, need to be declared in the devicetree. The driver then
> > configures the sensor to indicate its events on either INT1 or INT2.
> > 
> > If no interrupt is configured, then no interrupt-name should be
> > configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> > mode. This allows sensor measurements, but none of the sensor events.
> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
Applied. thanks

Jonathan

