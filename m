Return-Path: <linux-iio+bounces-7407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177989298A0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14432B2484A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C237141;
	Sun,  7 Jul 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZbBUbfU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE123741;
	Sun,  7 Jul 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720365857; cv=none; b=iu3PTV5ikt4lRLx6yDA/y3539Ih6zlGmrxioYg5M0ZU/omTTVOA3R2119+aKEyY8xsEBbOLxLygB6hd+EE9bso7hxKL0OwlflOWngg9mYBnicPhRS9F/+M8haRIUxNhiuVmGlaCQk5HZxhVC9HjpJKVJQq+ufPsX3YG4wCO8ZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720365857; c=relaxed/simple;
	bh=CqRDK8Jf1qVReVZD/FMHSwR/5bdgbsJ28UK7zoXC7l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGJQqWpSZiafD/pBIE5obA4sgO5ySLZuTyaX48GepdO7tA7qKAi3Vn9XdW7pQ1WW0GFjorTJbS1w0lhfIVRxUyUflksbrRZaygMmLvKvFkpV84l86GYk14d5zXvzbqeDjsr27kUFrv63vS5330yDNPCYSgBTrdmS2wztMcN/tF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZbBUbfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233F6C3277B;
	Sun,  7 Jul 2024 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720365856;
	bh=CqRDK8Jf1qVReVZD/FMHSwR/5bdgbsJ28UK7zoXC7l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZbBUbfUmE5TfYDH+zcMPfhccY6CjylVwGvePYquDJJpvKAXmgIfRXUap9tyDuAzT
	 irfolJil4NBQd6DsuQjNkHrTNAh9FFcVmpZagzK9uVa0Aq/pAD+eZS+WrcbEfQ9RUn
	 FMdYZJgpCutiqtyLoOovi+ivO5SK3ck1tu+gRtq8pAfGVnKuDOjb+PgBzX9bBEyGyc
	 S/KsvchzbqR71qwm6GyjU0kOHBp7kkE1dXgCU3E5ZfVcHE4VQwxMm0pnJBaQEgSNob
	 6pwiEkWgdP2Zh0BJY6mYT9NmZojuTmaGCOpTMoBK7s8XRk6ZPR5lUQC9xquCXq3zQT
	 VO2NZjLCU5zWA==
Date: Sun, 7 Jul 2024 16:24:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: javier.carrasco.cruz@gmail.com, Michael.Hennerich@analog.com,
 cosmin.tanislav@analog.com, dan@dlrobertson.com, jagathjog1996@gmail.com,
 lars@metafoo.de, linus.walleij@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 nuno.sa@analog.com
Subject: Re: [PATCH 05/10]: iio: chemical: bme680: Constify struct
 regmap_bus
Message-ID: <20240707162407.5603b1c0@jic23-huawei>
In-Reply-To: <20240706105137.98124-1-vassilisamir@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-5-34754f355b65@gmail.com>
	<20240706105137.98124-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jul 2024 12:51:37 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> For the BME680 part:
> 
> Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>

Thanks. Added the tags for this and the other one.

