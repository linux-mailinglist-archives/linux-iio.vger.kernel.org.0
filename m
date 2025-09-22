Return-Path: <linux-iio+bounces-24354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7DB93443
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B25A4453DA
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0322620D2;
	Mon, 22 Sep 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I55OMzT1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9F78F51;
	Mon, 22 Sep 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574175; cv=none; b=VyO3tgBQiIWEnV5m42gOiIM61C5sDCqAo433lR9vj80t3gpM7hCMsPqD42Vizpba4AUuzBYiIqXfBLAM1mHMLuX5y9HySjvYhg18yKZlGsDPOeuc5adMmb+PD5bFzpGANn0ZOBaKQHJ4iJSGNOnOBWOZnrg8Tg9BCcWbdYWxuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574175; c=relaxed/simple;
	bh=wtC+xA89E+YBsXvd/pIAAK/uVxAYwy3RsabgL4keMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quQB28JVnzAZhiIIRHXJyQwYPX/cOogZAKXEFczF/gUiYFuA4BScXOgF2Jh4hmrLa6sMvwheyGgJL1AZ7Rygksv1qh/HowJK4+uA+PkTFn2NQhg2cxPu5YNwnIHU5HS2x/wiSIqC5FW/aKNrMNIR3Ngeq2BeJ6mrgaN+Lx9ho2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I55OMzT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72C1C4CEF0;
	Mon, 22 Sep 2025 20:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574175;
	bh=wtC+xA89E+YBsXvd/pIAAK/uVxAYwy3RsabgL4keMfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I55OMzT1+P8MQ3SjDbJH1aEVUY3RzmSDnsbmYyryw2zHdY0DeyCNGNySR1UtKmhun
	 aM2u0GCQ0Mp21bA52ZCjSFe8+oPht7JLJkOLtrLDAH7fBmVREFh910WXuYMHBxH4x2
	 MEf+y5fYDYuKD+LmEGj7fe7TJrH6oMYKiSjGHDwYMaYeg/jl82RbwCIHPjeHpojYSr
	 XGQiFDqZ13iWlFU7tfb3w1EtrBRnpGxIVOO6V3840qGeJRQYDq1CTHD1KhtrY9gQPG
	 PH9dUfsTBgpPjTeE+bVDPdf5H1fadDlycED66xH1xPFJZNwdPfqtrWxL93CVz8dDiK
	 tkqxUSglW5jgg==
Date: Mon, 22 Sep 2025 15:49:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: nuno.sa@analog.com, marcelo.schmitt1@gmail.com,
	grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, linux-kernel@vger.kernel.org,
	andy@kernel.org, krzk+dt@kernel.org, rodrigo.gobbi.7@gmail.com,
	michal.simek@amd.com, conor+dt@kernel.org, linux@roeck-us.net,
	naresh.solanki@9elements.com, jic23@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: add binding for mpl3115
Message-ID: <175857417311.1300891.13377057276438631020.robh@kernel.org>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921133327.123726-2-apokusinski01@gmail.com>


On Sun, 21 Sep 2025 15:33:26 +0200, Antoni Pokusinski wrote:
> MPL3115 is an I2C pressure and temperature sensor. It features 2
> interrupt lines which can be configured to indicate events such as data
> ready or pressure/temperature threshold reached.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../bindings/iio/pressure/fsl,mpl3115.yaml    | 63 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 63 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


