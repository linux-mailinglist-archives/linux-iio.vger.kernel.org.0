Return-Path: <linux-iio+bounces-10789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A129F9A4E9A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D061A1C22C36
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1C33CE8;
	Sat, 19 Oct 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M29aJb4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FC29D06;
	Sat, 19 Oct 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347623; cv=none; b=NPMsdgT1E3Ge2HWL9/d0MjFmNXW2VyxBYrysHF5dsu31Uw2qg7QcEDqqZjBp0CpleU0aHvkEu56Uxnh9o4sWhFi/WIFug6m8/dRjX2WvzyHIi8FAv8kQ2aDoEmO2dmAzqrRHo653MmRp15xzadwklO+t8b/WmXdU9VMG6QxCXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347623; c=relaxed/simple;
	bh=njuN1ZA1FwizHVjszl1bRZOljBQqzgue9hCDe8wYaFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdbpx3H4+Mvk5JTaGel+YFeOawuRwiYXP5Vki9P/tIkQjO1jz0F4giDm9pz7l40ZGzyoX+M9QMUmf5gXyWFtLSD+AEBfhuNOgryX5+a3cqSO4GfA7j36YWprhY1svZofqBwT9EWN/eBABwW1SNE+VoUqk7JaaU8Ey8Wz8RaV5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M29aJb4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C906C4CEC5;
	Sat, 19 Oct 2024 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347623;
	bh=njuN1ZA1FwizHVjszl1bRZOljBQqzgue9hCDe8wYaFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M29aJb4EapzLs7aID7zmZBf/mWNGFjOWYSdmvHZZs/NoFkyyxLqz6YoidZ5Fkednl
	 e0kg9zLBQIa/IJPhlf1cz00T4ptAdJyPwprXgtBcJajnkc1AiIYE65o2uR5wbv5gNa
	 2tWiTza/ryLRM7876rvjk/1FjNxdlg9mw7c2B63SShZ0RtwIb1Yc1DPbPrrjUrL7Nr
	 iEf6CEodfHLQ/eYBj2OOFgDdehDZfIOeRmh3Xe9wE3evAiUoc3NA9h6A/LSheOzoR6
	 rZo0RwS858+c4yF7sZY60dQxkROilkC0fQk21XiF2LtZotBHhGQTkBEWvrxoMrWbyV
	 OiGgvIYgT0WZA==
Date: Sat, 19 Oct 2024 15:19:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: light: veml6070: use field to set integration
 time
Message-ID: <20241019151942.743a0650@jic23-huawei>
In-Reply-To: <20241017-veml6070-integration-time-v1-2-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
	<20241017-veml6070-integration-time-v1-2-3507d17d562a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 23:39:26 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Define the integration time within the configuration register as a field
> to easy its handling as an index, preparing the driver to support
> configurable integration times.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied this patch.

Thanks,

Jonathan

