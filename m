Return-Path: <linux-iio+bounces-12878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B99DF27C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A3DB210D4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536381A9B37;
	Sat, 30 Nov 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADnPo+1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D41A76C8;
	Sat, 30 Nov 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990072; cv=none; b=kFP7nvDV5HYl+WzACcyGE8ZEjMV1641wBIWd6IkfKVL54OYjqAfyCpx8U2h2TGaj4lmytBZ/FD9uFW8S8nbLba5uKNPnQibUpYKGeNHwEZ4m79+WQOGqW7mALvtBgA/qugBENDFtm1b0oMjG+GeZ02MzzPBgNXmnzdnyBiW/KMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990072; c=relaxed/simple;
	bh=88+9+I2Z44erwubt8hq/SYIwnfvUT6eFbrcBNzpKCm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZdogZ8IY5dh59L2QvWMag3+aJCCySaIAEJO/3ZSWReUC1sSWcnpnmE0SLifmIa9Zq8VpuHLKAnJviV7jdaSMC5KEzz4DsfVIhjM24aHjafa8vV8SJdMxclKF7/HsggZ2XovxoSeI/Ah31SLLT18HEvtjUAACCUj/U7oox+rPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADnPo+1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A68CC4CED7;
	Sat, 30 Nov 2024 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990071;
	bh=88+9+I2Z44erwubt8hq/SYIwnfvUT6eFbrcBNzpKCm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ADnPo+1c+hD6Latm3DZ0BmUCNBBLwT1wO2MKSf+iZIr5QCQvxz/NuZigm8hCp4jjR
	 ZpJf03Sul8qq2ol78ytflG567su+MnD8B1ksCGvkhMDtG5/QwLvfc5ZwD0PmtLz1ru
	 FU2UgKjaIWYMCaZfIQWe9Lm3mC/Ci13nRVNKbbjkbk3kLDh3JsoOPxoQrcYDsqrZxv
	 PbKoIgKmkzhDiyZjwNjrBGfYVerZ8FMpXGqxce6rIG0KDdz9Dt6n1wetAYsEIakCu6
	 MSBAcZeXGgO8Eol5jbQ95tfZbfPEiEgkH9yQzswdw6iAfgAbxEktYo4JHp0bveqqkN
	 75FvxsToTGDjw==
Date: Sat, 30 Nov 2024 18:07:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: accel: kx022a: Support KX134-1211
Message-ID: <20241130180742.149edeae@jic23-huawei>
In-Reply-To: <6e95af6b425df6a5ff5218825ec8923f1341f7c3.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
	<6e95af6b425df6a5ff5218825ec8923f1341f7c3.1732783834.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:03:18 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM KX134-1211 has very similar register interface as KX132-1211
> does. The main differencies are the content of the "Who am I"
> identification register and different g-ranges. The KX132-1211 can
> measure ranges from +/- 2g to +/-16g where the KX134-1211 supports
> measuring ranges +/- 8g to +/- 64g.
> 
> Support the ROHM KX134-1211.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied 5-6 to the testing branch of iio.git.

Thanks,

Jonathan

