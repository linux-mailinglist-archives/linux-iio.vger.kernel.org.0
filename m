Return-Path: <linux-iio+bounces-25226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12078BED206
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF85E19C175B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023F1C3306;
	Sat, 18 Oct 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMlFes/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CF27462;
	Sat, 18 Oct 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799987; cv=none; b=n43tKk3Otok8e+SdyKYsi6uoXrdiL8my1AFPQt7JeYUG1CP6tyA1ypal+ZPTsLO1u0BDDy9YhjahllAIJXGFLfu3MFl3QCmWpQx9fwAGgeDu4Ebpl+lzTjmdLoAWd3ar9jVoVKSDKS2j1xAExxdPAjxO3/e1FNQJpmWxqVgHIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799987; c=relaxed/simple;
	bh=YdicEc1TBN4anJzmlNAkoMIqZLm+g7q9GYewwuiwxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVbnpT60oZbySQEBkxv/W8vn0CuGNPdcEnZXOiBrTF+o7dkIOd5c1BOHbc1HaBTNVl9wFvfdTLoS+aXO7/hnbNfzNcSeyPmZH0HoV9+ND8i0oXuryJ1+xeFgZ0WJyVxLWyYrInNcRpzB6EgNbP2jtGISJymfaOrQpINKKtJNqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMlFes/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A778C4CEF8;
	Sat, 18 Oct 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760799987;
	bh=YdicEc1TBN4anJzmlNAkoMIqZLm+g7q9GYewwuiwxh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMlFes/RO4aZuVNeMIoaW/qnTdAu43bIJFPvYEwQXKu5NvHr9BZ1kNRIy/gRYEKf3
	 At1zuQn1NZrY1DrxSYVGhec0oDplh/EdqFf6UeOVYQXfofzQKbVF/F3XIKhXdp2Ish
	 30/OkN4BxTUwT2c1KkDE0ABhuTfcIPegL7VwbBBo9WM4h8Ck7Rp7WW26YIc67vcsB3
	 1+Da2IM/XpeGP1nywTMbo+NmS6tdQMUw00CFkSUBvhW7p7Yo6BRnO4vaqdvqKtJrHM
	 XDH25VAuitL+xeRPd4cu2xZIgoDpOTrsg07ImjTKV9YGPk4s8VdgD1b5WoMOH5HfvZ
	 6ANeIMZFT8vTA==
Date: Sat, 18 Oct 2025 16:06:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] iio: accel: bma400: Refactor GENINTR config and
 register macros
Message-ID: <20251018160613.152f2e46@jic23-huawei>
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Oct 2025 23:36:07 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> This series refactors the BMA400 driver with a focus on generic interrupt
> configuration and related register usage. The main changes reduce
> usage of hard-coded values by introducing macros and formula-based
> register addressing, and add a centralized lookup indexed on iio event
> direction.
> 
> Alongside these updates, the series also reorganizes and renames register
> and field macros for consistency with the datasheet, and extends comments
> for additional clarity.
> 
> All patches are pure refactoring. No functional changes are intended.
Applied to the togreg branch of iio.git but pushed out as testing for 0-day
to take a first look.

Thanks,

Jonathan

