Return-Path: <linux-iio+bounces-807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D980BBBE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B849280E20
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70755154B0;
	Sun, 10 Dec 2023 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgHGiI6+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBDC13AF7;
	Sun, 10 Dec 2023 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4F8C433C8;
	Sun, 10 Dec 2023 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702218541;
	bh=ZUR9x+LEGqkfDL+IjEJpDsb+3CNwJ9WNWDGvFW0i0X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VgHGiI6+CCpP+99M2GoVsNf0WFqSg5QdHSumKw5q0WnNxEPcJk6ySY8/+9157uV8a
	 NFwMcdPTTuBeO14+Ylj+RoWrPT3G06OqG5wSOYu3AsvKicRQ0f83TPuhzfRjrfkbiw
	 SLoz6oYXXd+rFtITd2cxRMOye7zjvqviDrfCS1ODGYLoyYzOIdJsOw1XZDLJGmx1J8
	 Wsb74kXhsiyu1rSCUuYRblMjdCgALRgA9BsLJQtHsaPLKEaGhHfp+UX6PfECtKZBq3
	 FRwHyuMIAfU2fiErmRm7ORgLif6uQw54Tx8qb3M1WSIJPTwDi0NEZdSpoYb10IoQEt
	 x6DxSpnPAh7wQ==
Date: Sun, 10 Dec 2023 14:28:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2 6/8] iio: add the IIO backend framework
Message-ID: <20231210142854.27e3f5af@jic23-huawei>
In-Reply-To: <20231208-dev-iio-backend-v2-6-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	<20231208-dev-iio-backend-v2-6-5450951895e1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Dec 2023 16:14:13 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is a Framework to handle complex IIO aggregate devices.
> 
> The typical architecture is to have one device as the frontend device which
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).
> 
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Name space all the Symbol Exports. Otherwise, no particular comments from me.
I will take a deeper look at all the details at somepoint, but so far
it looks basically fine to me.

Jonathan

