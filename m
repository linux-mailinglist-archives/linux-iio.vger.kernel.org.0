Return-Path: <linux-iio+bounces-12009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A99C0FD1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 21:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03B6284BC9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80D1CF7BB;
	Thu,  7 Nov 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvBoEC/A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E1210186
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011665; cv=none; b=Q1M0cPK9c+vNTW8dksAg+6DY+Raas9gYOmFfIA8MAKOt2TOZakCpI3c52S1NGFrF+SN0+Tr9jm8/5mUyr0KDI05nTGF5i/TR3buKXtV8pkWSol2ci7Rk45QeNqcZ9jEDf4laCj/mDKknNaizQHEoTBJkzI0hOoiM41fQ8TwSDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011665; c=relaxed/simple;
	bh=0BVNhbLJ420BLFWdRe+OjtvhJjOhpyjA1lgauPT2GBg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=JL76drjZ/Loq3fnL3yU/0Y+/THDMYaVh3RMXRSf5da3mglp+wWtrYExQqAHVgsK1vXfq96PnVeMX+T1KtleqmYud9IJ6RAJLRknK5rdDE0V2I7tRK/mi4lpY3ijuQUrURh0kAFuQMft20uc0aA1lBGq6ilO/i4LxHN3k9xXJ8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvBoEC/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF6EC4CECC
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 20:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011665;
	bh=0BVNhbLJ420BLFWdRe+OjtvhJjOhpyjA1lgauPT2GBg=;
	h=Date:From:To:Subject:From;
	b=uvBoEC/APPXI1rB5VJvEBBJruYdE5pUDOmihKwWWsgVHW9+8HoD6BoJrmQJUzY4Hn
	 ZZKUmvwhiHnGf/IAraocOGvgAfLRfIUc+I+p1U7hGKJWNGF76ix+XsRbxPkeXUE/ap
	 ZCtRF3dWpVUSAkrLbziI5Hn3wzlJuQDbmFEsMRi7Tdo5nHlC7/a+g/KPY7KtVvPdQx
	 2QRlAmzkZqNasME+ioBSMhKA+YoxYalcwSBZZ7nLcHnz2cVKuy3yrMLWw9wFOszcjo
	 JLQGn4XTe3+zJYWj7X72v1417WUubD9ddZNHaH+OlyGGDK5Y7u2kKMV5lMxWoJrtU9
	 wE11uGiFsYhfw==
Date: Thu, 7 Nov 2024 20:34:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Subject: IIO tree probably closed for 6.13.
Message-ID: <20241107203419.5ab1b061@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi All,

I've tagged iio-for-6.13b but won't send Greg KH the pull request until
tomorrow as a last minute docs warning fix was needed that I'd like
to get a tiny bit of build bot exposure.

Note that I'm unlikely to do another pull request after that given we
will have rc7 on Sunday and new code should have some time in next before
the merge window opens (probably next Sunday).

I'll start queuing new material up for 6.14 assuming we don't have a long
cycle for some reason.

It's been a very busy cycle with some good code cleanup alongside
the fancy features and new device support so thanks for all your
hard work!

Thanks,

Jonathan

