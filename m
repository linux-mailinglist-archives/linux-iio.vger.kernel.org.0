Return-Path: <linux-iio+bounces-7975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0108193DFA1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301BF1C20D44
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C616C874;
	Sat, 27 Jul 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOs6Bh/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169480C09;
	Sat, 27 Jul 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088641; cv=none; b=B2sRCtjWGyKQAaH3pBs2y9O83ZsYjjIo5VshDTZEiQi1M/+lvJLURh0m9/QHLpUaIhWBhChd4C6ugLXKuaaww6xXmg5PR9VhpCC4vg3SMxnd/YPUzpRwqsHuZkKQad7YGmlSSbLidUreU9XO9Vp3MKj63dwCTKfUdm/byMlCwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088641; c=relaxed/simple;
	bh=jNPj+Yafh20fsBWrBF5oUcVFw5sPjhYdSqXUGOH06pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIIY9FxNDUVGgJRX01tRPjJgsvb7ANR24/tJf6LcmqCH4oSt8spieTAkFH43jBztnm+v1qlrGOQl2F3Ebg5YyL3wAvJWsI4N50lrojTH7njizPDSePOveDugeZAAuPFVo9RH00mgo4wsHT8rnVy5IhNzSmZtRG181V/Ncgd4Cx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOs6Bh/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09349C32781;
	Sat, 27 Jul 2024 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088640;
	bh=jNPj+Yafh20fsBWrBF5oUcVFw5sPjhYdSqXUGOH06pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOs6Bh/36loLtZcfYk/cbA5ZeLPpNQbhfNWUcfYC2qgq0fof6WpIINrpULUd7zUuM
	 DaML93goDwusc5qpeT9S6EQU8wFfuRDQExNPjLP21kwK8+F47VMlIVFyIjeh2H+gGa
	 sFem1V6MpU2Ol9JVG+ULQCJnVeH3eZjm938jv/SDhXte8FciUswM4Sw+e1vGqqKGUX
	 uygSIA7/GLz6u/eQctEn5RQK70cBzOpu8ZadkQx3itKDCHgZNUQV1V1CMU27kTW0Vm
	 PALg+I0FV8F4SJW1yaQiHui6VA5y2n0lopHhtWfJbShFaPATyOeDCU2aM7n+wVaIm0
	 bKRDUckPrx79g==
Date: Sat, 27 Jul 2024 14:57:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, dlechner@baylibre.com,
 dumitru.ceclan@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Fix incorrect compatible string
Message-ID: <20240727145715.0cfb8535@jic23-huawei>
In-Reply-To: <6fe59ff58e19bf6a8c5c5ca3ff120b4df28f1092.camel@gmail.com>
References: <20240723111322.324947-1-dumitru.ceclan@analog.com>
	<6fe59ff58e19bf6a8c5c5ca3ff120b4df28f1092.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 09:45:25 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-07-23 at 14:13 +0300, Dumitru Ceclan wrote:
> > Wrong compatible strings are used for AD411x devices.
> > Fix by adding the missing "adi," prefix.
> >=20
> > Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

