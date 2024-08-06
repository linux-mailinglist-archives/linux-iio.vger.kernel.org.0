Return-Path: <linux-iio+bounces-8277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC09493AB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6501F2507B
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D401D415B;
	Tue,  6 Aug 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beP3bUng"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDB1BE23E;
	Tue,  6 Aug 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955775; cv=none; b=mECbaZgJmB4rWLoj/7jPwYNB7I7cAjFKuTn8b5tA9+Z/wJWBGQB7hf2rMZmokZLykQ8uAscY6sj7MYtRvpCbVjFtdpVTMl2+jp/YIyld/1ROPIrWThBuiAAgFHQ/tOne2ae7KYs13aVNMp9zGJ7S79y4ikk2Dpu+qGwAfsees4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955775; c=relaxed/simple;
	bh=Lyin7xMGwmJVl4RT4vJ1eg8mIgGmr9A+GikmZ6P7pjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/oBWE2BXkIaFcJ4b6+tSwPOVM5dq/V1p7fwCWNdMM0U/tP/g+dnwzw8MO9QSm5QDuGK8LBobLWhsdvAIOL6stX6eb5+QZc+/NagC1ehxLLgrwQfk/xys19bdjq2ZLTqMBxMCH94YrNI36+RzngrhnEyM3SGwwxQfOcRWvbDO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beP3bUng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035A4C32786;
	Tue,  6 Aug 2024 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955775;
	bh=Lyin7xMGwmJVl4RT4vJ1eg8mIgGmr9A+GikmZ6P7pjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beP3bUngKY/4ZhIXu+UFCIbt81rZslPCz5v5we6EXaPTe9/Bup3xBbkjoZtyjc2Jy
	 LQG+Q/KpeoZ54FBKhdV993UkW/JUjDF/XftE7L63Z2dIbs1m0v48G8RDpReUUE1NXd
	 /AgnA18f2kYKGNLDKEvLrIr0KmtNjaHc7B46l4E1RqfaE0lfpoMevcA2rNnP4XyjPf
	 8qbQxY2Pclgk9xKEqttaqtjijRonc+yl4EGJKphAz2HrqoucSXQ5NU7eqUH9uNBPic
	 vgch9I9zR9QBc8jgUUhhuzhViM9mSfLB/0QJyYqj2hlf0f7uET3aOdOjEBIqYcLI+h
	 0SLthrj/bScjw==
Date: Tue, 6 Aug 2024 08:49:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: iio: add backend support to sd
 modulator
Message-ID: <172295577315.1501618.14038896087472078381.robh@kernel.org>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
 <20240730084640.1307938-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730084640.1307938-6-olivier.moysan@foss.st.com>


On Tue, 30 Jul 2024 10:46:35 +0200, Olivier Moysan wrote:
> The legacy sd modulator driver registers the sigma delta modulator as
> an IIO channel provider. This implementation is not convenient when the
> SD modulator has to be cascaded with another IIO device. The scaling
> information is distributed across devices, which makes it difficult to
> report consistent scaling data on IIO devices.
> 
> The solution is to expose these cascaded IIO devices as an aggregate
> device, which report global scaling information.
> Add IIO backend support to SD modulator to allow scaling information
> management.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../iio/adc/sigma-delta-modulator.yaml         | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


