Return-Path: <linux-iio+bounces-8796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC895EEC2
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AAF283A1C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15C14A08D;
	Mon, 26 Aug 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j29w2eCY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124C39ACC;
	Mon, 26 Aug 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669224; cv=none; b=aI7/Ov0ydPyq8uBGR6gWq4jODTKE1WkhVkp6+hJy4BOn8/0d5P4soEXM1p9dRb/5kRiMpuuK2s8XhGH/cqwSGttTdoSnjbvVqlD76HzkYoppa9YRuLeo083bFDAByrbzyB7rlwZa4Mp3qp4p+FyHCaa0ItStr7CIPmulCeeNuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669224; c=relaxed/simple;
	bh=y+IbqtQ5QCYZMcw45OOPb7hw8NkfcAeEI7Ov2ra4hp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQfH9LrsNZCexEqvFkL6jUrQn4NFSBxBpOAneNCYv5QGeT3xB2YIYTWu0v3IQKCPcFqX7m4Dp/dVwXZURqwvr8UMQHYO1JE70QhhbG7uUglwoG9ZkRFsecwOZv0nwCWhNC3rJYQ2OmtDnYB6I+OEPZ+HR4W9l94SjP2QXkuKWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j29w2eCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE44C51404;
	Mon, 26 Aug 2024 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669223;
	bh=y+IbqtQ5QCYZMcw45OOPb7hw8NkfcAeEI7Ov2ra4hp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j29w2eCYxulMG6QGJQlq2nwqea0QRnByUjJsvla3vgJuF2Nz3wTJy7A2FIH5vWnnO
	 KSQoxSQ74SNly3ShTI+tMg5EuUWEvJo173LRXn2z3JTdCjGU4uqCuSNxB+heY9WOqL
	 dOBKW0MznfSZtxlDw45tMNhfQnfAzqxS/QX8tyQJsqVbRDG3qAk+glGhvgOXJIICkM
	 YCTF+Z6fgNnAxxBQwUndwIT0I1flv4KZDGVf/OTPFbj5GOAiB7Wyeq39NYncUkBf+z
	 FU0enhqQcvGmepV+NaAYDDemMvYC/Aj3SSyTx3/YwDID3Q+iqhlkRnKThFi97k2Phb
	 8OwhZHaon1dZQ==
Date: Mon, 26 Aug 2024 11:46:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: adc: ad4695: implement calibration support
Message-ID: <20240826114650.7c006113@jic23-huawei>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 10:58:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This series adds calibration support to the ad4695 driver.
> 
> This has the same "odd" gain and offset registers that are being used
> for calibration as discussed recently in the ad4030 series [1]. So if
> the ranges in the *_available attributes seem a bit big for calibration,
> that is why. The official datasheet explanation for this feature is,
> "The AD4695/AD4696 include offset and gain error correction
> functionality to correct for first-order nonidealities in a full
> [analog front end] signal chain."
> 
> [1]: https://lore.kernel.org/linux-iio/20240814193814.78fe45cc@jic23-huawei/
Series LGTM
Applied to the togreg branch of iio.git and pushed out as testing.
Note I'll be rebasing after the previous pull request (hopefully)
gets picked up by Greg.

Jonathan

> 
> ---
> David Lechner (4):
>       iio: adc: ad4695: add 2nd regmap for 16-bit registers
>       iio: adc: ad4695: implement calibration support
>       doc: iio: ad4695: update for calibration support
>       iio: ABI: document ad4695 new attributes
> 
>  Documentation/ABI/testing/sysfs-bus-iio |   3 +
>  Documentation/iio/ad4695.rst            |   7 +-
>  drivers/iio/adc/ad4695.c                | 242 +++++++++++++++++++++++++++++---
>  3 files changed, 234 insertions(+), 18 deletions(-)
> ---
> base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
> change-id: 20240819-ad4695-gain-offset-c748d7addf27
> 
> Best regards,


