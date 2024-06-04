Return-Path: <linux-iio+bounces-5782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510DD8FBC26
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C638283CD2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19314AD1B;
	Tue,  4 Jun 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYCOEv7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25D13DB9F
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528082; cv=none; b=dC8HOjCRXOm5znae4HNyXO8XgSsa85BNnQ96vM2oepJLC3tagEPN2lfKFlpcmI0KWQO4ypHtb4oZi61LKp2Z7AqTeZS2Jfamfkg9lyZe1yqwKHkKceAL5/bMK/kI74D+klGIEkR9VZmpiig5HE8e1E0kEIhtAFxJq06RgIEIjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528082; c=relaxed/simple;
	bh=xJgpfu8hrMoWdSitUWnJ/xhxC5WuMBhTXZ3lx2G/i0g=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjH0GHjj8QGr71z1NnEOO3sqcsk1LG54m7rmbVNO2pg1suAh/XnfxqRPXB125dhlgD9x69CNDhvGDEiQdYyi4dahg0uOJaTVIgczU2E6OXS6nFEFbQgXXivdJ8FJvg/NlZNaivui5ojHllf0ua2PHXAIN55TztXK+zzKPafInZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYCOEv7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745C2C2BBFC;
	Tue,  4 Jun 2024 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717528081;
	bh=xJgpfu8hrMoWdSitUWnJ/xhxC5WuMBhTXZ3lx2G/i0g=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=WYCOEv7DLru/aC/U5WJW4MNFbkuxN6F/8oTf5pzPciqqc63JYcJRESXQqp86SqPQY
	 E8XJ7f/G5PUDVWQA1e3ElXcggcAGCQVufNyeIegoNkD4yr4sfOunL2f3y3tHDEj3P7
	 1F8Y23w2qtdYSl3OPSInEenv4iLLuQjRGl7aOY6nRTjWBIzKa8+2JbdUb+zt587rdx
	 6HgFc4rhJXcs2eaBoku7BKake5b09LOMFczk+sP+8kuKQplUtJyUzIlZ0lW97ur3FB
	 YjxpUWwa0hF0eabL+aQWm8jh1BOgH9OMUeCdCmBYVeILuZsgpuFGV1uAyWZpyvwLph
	 dirAKxHzXB/Gg==
Date: Tue, 4 Jun 2024 20:07:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL]
Message-ID: <20240604200750.45167005@jic23-huawei>
In-Reply-To: <20240604200421.2d084308@jic23-huawei>
References: <20240604200421.2d084308@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 20:04:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

Sorry for noise. Please ignore this for the obvious reason of no useful
email title!  :(

