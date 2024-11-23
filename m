Return-Path: <linux-iio+bounces-12555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8E9D6A31
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2CC1618F6
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889DF44C81;
	Sat, 23 Nov 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7kGgkPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783A17C2;
	Sat, 23 Nov 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379691; cv=none; b=E7w9ojHdy7Lr+kSbZ0F+Uc9oPQZka7WIou8PpvyZSWQ05Augz0o6AevtR5O5FL2x1Il7OL107LOcHtnQK5RxQSZHLkvT4zdLHLInrpsHe/NEGxWBlvahlR9gI4HE8u0VGAecgelcd/rGCCn5NFnUOa2Jwquw7G3hZrgza3TEqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379691; c=relaxed/simple;
	bh=AsE66LL4+AK/T4uAPGuhO5g8vpZ/H7AHuXd/Ehn4p2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDIM8ne6F/+DboobqtkR7jzUXS7jvciSpU2+poXAv5lKgpbGNd4exjOqPuKweUMr9IKo7HkmMsV+XUhZQRemz/Ij/x/VZSMVzBWM4/EF15o4+ZEJPbDL6RQ7vxd5p0biw8dI6aN283oeGt5kPfBC93YN+fbP5tglxhU+eU1ESOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7kGgkPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5A4C4CECD;
	Sat, 23 Nov 2024 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379691;
	bh=AsE66LL4+AK/T4uAPGuhO5g8vpZ/H7AHuXd/Ehn4p2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7kGgkPTc9grvBM+XnFLqnApq68sroCpy5qzpsWyH0WEqG8845d1WuwxgAHWx55ix
	 bljm6LUxxAcD9xhJTe6gmvdPQVmQ59uc4Zv/5t5qUssdm4iO8eSRfvhsvRz+G1HLP6
	 vah45PbB0poyg4omy3b2X5IUPJpcnAqwJrVwoWUmLWfRQW0LhlZdl7Sup8cYBQ8NBh
	 5UjcQ3C3iH53OKquw6+RfaNe0hE9iFc+jnmEyCjGhd/vMiiRhA4sK3J9Z2EciQ+Wu8
	 +uW2eIRuss4xWVb2VBVwfSsGR7Mwoz0N8iwRNoSV8Toi8olIrYIGf92KVsGN3RBx03
	 2l46Pk5Lk7hfA==
Date: Sat, 23 Nov 2024 16:34:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] iio: accel: kx022a: Improve reset delay
Message-ID: <20241123163443.678f063c@jic23-huawei>
In-Reply-To: <ac1b6705945cded0e79593d64e55522681e00f9a.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<ac1b6705945cded0e79593d64e55522681e00f9a.1732105157.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:19:50 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> All the sensors supported by kx022a driver seemed to require some delay
> after software reset to be operational again. More or less a random
> msleep(1) was added to cause the driver to go to sleep so the sensor has
> time to become operational again.
> 
> Now we have official docuumentation available:
> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
> 
> stating the required time is 2 ms.
> 
> Due to the nature of the current msleep implementation, the msleep(1) is
> likely to be sleeping more than 2ms already - but the value "1" is
> misleading in case someone needs to optimize the start time and change
> the msleep to a more accurate delay. Hence it is better for
> "documentation" purposes to use value which actually reflects the
> specified 2ms wait time.
> 
> Change the value of delay after software reset to match the
> specifications and add links to the power-on procedure specifications.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Stands fine on it's own so applied (before I've even read the rest of the series).

Jonathan

