Return-Path: <linux-iio+bounces-21122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E86AECEE9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1467A9458
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244523373B;
	Sun, 29 Jun 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8h9xGQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1149641;
	Sun, 29 Jun 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217028; cv=none; b=GSnxXPQM5VaG7+TXITeBn16xsePvGipSlOG584yRsacrT6Dx2W1SHZVMTO6Pgj/EdJYcYctPKjWyGQp/dBK6xpnfFr91RpDxXAeE4+tSrBj4HrkoHgaiBrm8JCx+wA4pXyySfVuO2P2lN7vvG0QHdZyACsGaDUVHgx9zvJMbtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217028; c=relaxed/simple;
	bh=i1/gy3ERkTFDyDrYOT1gzHINaLxBwmlnSgXvuGObxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHaYY5slxJ0ikTYKCdDNobUnN78vf1jk8+hw08wxAsMbTNAFYHFjZho9bkxG8cakgQmbVWh/xgUOboVZ1TztLI6ta3EFp4UIzrt6eVsy4Fyd98J92LMGL0JKyKmjWj/uukZFCkaiGPY2eeSLBdcvRsIq54MN5GjA2lvfu6nWsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8h9xGQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2492C4CEEB;
	Sun, 29 Jun 2025 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217028;
	bh=i1/gy3ERkTFDyDrYOT1gzHINaLxBwmlnSgXvuGObxrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u8h9xGQh4yGRB0vNWRcn3/ORZMph72Crjp6GRYj68ZzTOZ/OElTzTheTaHfRe/bJA
	 tPRRGoNCOWQ4O5SJxUGaBFaNh+lNW4Ve1UfUA07nbhsXAquZLH1KLC/I6Myc8pHTUX
	 twVt9t86y5v1EH/Ea0K3/ViGHeHfVVuRtpzzyaN5fsAZafHF2FwN/Cu29wWFRFP8pe
	 F8koRFUGKu6UBzZSIgFuaWpe/ft0Vjqi0CWRNwUC3HFHFA7nlJEk0pskZhh0q5BJQx
	 j135033ZWjkm98Kwvk1gWNCet+UL94JvS3lx3vuqeiYNKccarVAsoYgZ+RSnWFbEuo
	 7SoKhzSZJ5x8A==
Date: Sun, 29 Jun 2025 18:10:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ltc2688: make ltc2688_dither_ext_info const
Message-ID: <20250629181021.4829dbd1@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-16-v1-1-9b6514588b05@baylibre.com>
References: <20250628-iio-const-data-16-v1-1-9b6514588b05@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:15:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct iio_chan_spec_ext_info
> ltc2688_dither_ext_info[]. This is read-only data so it can be made
> const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

