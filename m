Return-Path: <linux-iio+bounces-4809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01438BBFF9
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F70281AA6
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74779D2;
	Sun,  5 May 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY1V24ma"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8D5680;
	Sun,  5 May 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714903465; cv=none; b=scw1unVYQK6j7Dl7t/h68p165Cua02usbtEplhckzyfue3iz4vu1VLFUIfgWwzObUdRYO7S2NHtYnqsXnbOnsBwoJTPhWkWzl0cQ6phx32GjSMbahZ9esP8xoN6koOdoRhhEYSdBvb/4zEqGVI4j4Ec7i9Ei+KACC+nVtjOl+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714903465; c=relaxed/simple;
	bh=IyOAFf/MqC1uuBz8L2TYQ5f6j8MCCE42y+QHIJNMSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBjEZerN/fogC5k6f2zFI/Hbe7hZau+ivj8eL/uv72jyuO7HvJZMIKZ25TpamC2Oovz8S0esXl+lsH5T7FxrmjnlZZ50rrjIjqrmdv9SaZot/2WigJTyU59qY2qfWu6g1XGPiEPXOmFPcG/jG73FzeLJKPWN2rn8G8FuvtprLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY1V24ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246AAC113CC;
	Sun,  5 May 2024 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714903465;
	bh=IyOAFf/MqC1uuBz8L2TYQ5f6j8MCCE42y+QHIJNMSUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lY1V24mafr923WZYtUTl0sJEolDj8eF91Mt0U5GG1lzxfcHC7/U+/ftFJJ7gh9JeQ
	 gFPWSNjzV5FK1WRjk3dzLSyHghvXqSzLIcwfXlhKKmBqoekLb6eyBBhR4qP1rZIGJ0
	 vMgt4lxTuVDOWCiuVn4R2QtjwIG2WWm5zJGiUF3y2zSSw8R4EyvLpspuOYdfRrnTAa
	 2tA1omUpdg2f7HW3quyRk7cBsnUXJqkZeT0LskIkkAuKPEeN5ec5kpAe0a+QW/9QtA
	 yQYSuoGHWMMCVhJSN+s7Fn8Ld49IfnX0lxwp6p4fzGttnHzequEnOhsj25MbPFMn/Y
	 K8IaBlf3oPKaA==
Date: Sun, 5 May 2024 11:04:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: fix ad354xr output range
Message-ID: <20240505110412.0c17cd5e@jic23-huawei>
In-Reply-To: <e750ac0c-0794-4c48-860b-1f9a1e751813@kernel.org>
References: <20240503185528.2043127-1-adureghello@baylibre.org>
	<e750ac0c-0794-4c48-860b-1f9a1e751813@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 May 2024 13:43:07 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 03/05/2024 20:55, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix output range, as per datasheet must be -2.5 to 7.5.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---  
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof
> 
I added a fixes tag to the commit that introduced this doc.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan



