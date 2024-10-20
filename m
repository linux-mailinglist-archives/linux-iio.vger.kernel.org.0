Return-Path: <linux-iio+bounces-10819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2A9A543A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE81F2238D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4057192B77;
	Sun, 20 Oct 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhj09P0j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D928D299;
	Sun, 20 Oct 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729429649; cv=none; b=BDYl1F7E+d3a1dkCHwcEIYjOwZwQAfdPbhkMKx2CO24jQ5s2udFnX+EZsaWiA2yoSZSg79oSoA1c7c0DtWkv6LhG1cNov55bpZGcauy4NoPpAc31Tbzyh607e7A3U6W1QGiqGilSFcliDGy6iFDvDvwvVkygUBJqQeTvS24z408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729429649; c=relaxed/simple;
	bh=csjbkGR4ysrBGSW061tsE2Qxt1y9P8caMRfJu9VxeBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4I14XnrvN+KwjQ89TXSgfYZJrK/fFYSVzBe64vezbXs2mhreHl3oiOScDyRvsTRHWwsejy9wZACLpVXfn28MRP3/hmzRaM8Swc0AGm1bEcpiwbyr7to4vr7uCCk6cCpjddpku0IT+Lia/NDBoC0ATt/ChfEUQgeWovmWxuvI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhj09P0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527E7C4CEC6;
	Sun, 20 Oct 2024 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729429649;
	bh=csjbkGR4ysrBGSW061tsE2Qxt1y9P8caMRfJu9VxeBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhj09P0jWUIDLN0xY2nz11NdPeasymnal2dcEu/sGicwJO4Yx1hANw8AhadaLufAh
	 2GGx4luz0irNnkB0mgf5S1enwcnGQZRZSkk8f+kJcNt9IvHx0Ef1tF5+75KuO36BSc
	 WF9q7xG8fxiNI59Kk0dW0c4NxKIbSwxzO8Rym9KLw0S1U17CM2rznaSGzaiCfuWj1b
	 fh909kAq4CaMJ12WALopj20Hok2x3sdnLj5Pu1jM4dgISy/HKh+WiIi90bVatzNnry
	 h772lDY/UbT51sC3wG2kWWaWiqNh6GyH3OwNQ4rIhQydL7EYGZou4Ow58Rmu932Wbp
	 g/cxAS/6iQ/Pg==
Date: Sun, 20 Oct 2024 14:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: hx9023s: Add performance tuning
 function
Message-ID: <20241020140721.6bbfb59c@jic23-huawei>
In-Reply-To: <20241017-add-performance-tuning-configuration-v3-2-e7289791f523@gmail.com>
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
	<20241017-add-performance-tuning-configuration-v3-2-e7289791f523@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 18:36:45 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> When hardware design introduces significant sensor data noise,
> performance can be improved by adjusting register settings.

Given review of previous patch that I just sent, I'm not going to review
the implementation at this point.

Jonathan

