Return-Path: <linux-iio+bounces-10236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699E991E77
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF173282699
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079C176AC7;
	Sun,  6 Oct 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KET+Qh0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCADEAC6;
	Sun,  6 Oct 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221089; cv=none; b=G8umiDlSvBTFyH8NKLxX83un+oy0/vgyEGWvpxAyyONjMZi7trIW2rGqQmaUZoHgJ6BhbAYC5fX/rM0HtdQVn63Pi7EhZNg7qIrCrUj7PgED/ZY+67s2I1rfNIiIoxGLjepzNe7rrbEyDXfLJNtnuwCsnxjnIM54GjxY0qj8Ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221089; c=relaxed/simple;
	bh=U37szX5FPtAmngdxq3qGuBB4mBkCWM5dZTJpnskGPAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljEINipY3c8kmCyu59aEC+p75Pyp6uuBXY0ccjUS4fbdXHcyGfcr35Gks/ialAgzqJbL/ILhjz/rHKjtX4PrtLYV/IAo6PvlDv3o8eL8aeyX59jpxq43MpkQjeHW6Pe+vca4fttAop3eQ9nKhA0cNEaAYW6elTp4POsLg6qqbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KET+Qh0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A95C4CEC5;
	Sun,  6 Oct 2024 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221088;
	bh=U37szX5FPtAmngdxq3qGuBB4mBkCWM5dZTJpnskGPAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KET+Qh0ufQefKJPj8jueBk81C+KtalISZSkq4E1hrygqtIE6jTiW8DZq01PNLz3A0
	 pej2g5go5OBF4PkTYE1dkUJKgU0HByqlzAlc0kzHCAOqkpPlT7tSi96cxvJvT6Lzou
	 XNQ2PCVRwAQiRWrjq/BLaTZTnnq9tiHckYXxvcfHGMUKRg4iCGsEgptYjp881UDJDW
	 jPfsMRzjbaiwYZpqogRtH8oKD10/QApsS6aZiD30zp3OflOfiNXeZ69c+k9/zLhXwF
	 EB8VxFTYgkqOXyoOdDQaSbZOw1mdam6/k+KFrp3rjPi5RxclSMhGEM2W6WpGYzy+m3
	 9YeP1Adg27k3A==
Date: Sun, 6 Oct 2024 14:24:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: resolver: ad2s1210 add missing select REGMAP
 in Kconfig
Message-ID: <20241006142437.7209f801@jic23-huawei>
In-Reply-To: <a322e7c6-2944-4159-9632-bbccdc0b56fe@baylibre.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-1-4019453f8c33@gmail.com>
	<a322e7c6-2944-4159-9632-bbccdc0b56fe@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 17:44:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/3/24 11:49 AM, Javier Carrasco wrote:
> > This driver makes use of regmap, but does not select the required
> > module.
> > Add the missing 'select REGMAP'.
> > 
> > Fixes: b3689e14415a ("staging: iio: resolver: ad2s1210: use regmap for config registers")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

J


