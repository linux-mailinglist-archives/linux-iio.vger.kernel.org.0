Return-Path: <linux-iio+bounces-11725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3E9B856B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B022A284598
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615D1C9ECA;
	Thu, 31 Oct 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSgnsPOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06913C9C0;
	Thu, 31 Oct 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410694; cv=none; b=bRuoDa+4FLXz882jrExn9bhjFyDoC50+r6+GwPAxFFCkwcTTatQTyvc67nDjAVIp8nm/ov2uRHf+RGJVd2N6Udsf9fQcHnYT07xQByg1uMQgYpXvjmAyDqNegYg3wmn/v/4Q5LnsEjgSayI9NNipDODXj0NbKwqA9nyvie3gwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410694; c=relaxed/simple;
	bh=UQA+pBzbmjeweaV1WYjyz+d4v5GqK1bI6ARj7fWOqQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUSeIMioebORfxyx9cIwn1AR+Hb54uVip7Q+5At3/vlxTwunaNPcjjeiJd2JHa/n/zNCf+UjKrLlpKs4jrqydXIxYVgXhxNYjg5Sl0nshvgKmX1Oc8Ed2oiZ4p60WCElyGoBYM0DOnYVpm8NOmkLe+yp/Q0j3/REWrZrP6n0KgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSgnsPOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBBEC4CEC3;
	Thu, 31 Oct 2024 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410693;
	bh=UQA+pBzbmjeweaV1WYjyz+d4v5GqK1bI6ARj7fWOqQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSgnsPOP+v2JMGWOB9zwXWXtJOM4jMaA8ntrPD+qFz/z0We9uMAlqfQe74M83sjEo
	 WmwVbDnRjVIfHdYAjt1LVD5/FDQUcCBEjlRZD6prIJCxGgTDuIQVIM6fkDRZv0YLZc
	 wl3RCx5FzB38xxj5f4pABmmCM0vRiU43zgWnBhcLCOiGUUWaFMdoM/3unNGAegFlI2
	 FiARggYnJB2rODJbdEAkj5wG18CMhUTCkHWpwfymDNYKnk6O8HdKnCsUsnDS8vH6D+
	 IvtCccLNu+RQw1g9kEITd02IXRyUlOCVLjxTmuSxGVVOiva1NlRVsXNK5zzjiK0X36
	 oJV+dMUoknJkw==
Date: Thu, 31 Oct 2024 21:38:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ahaslam@baylibre.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Improvements and Enhancements for AD5791 DAC
 Driver
Message-ID: <20241031213803.18091910@jic23-huawei>
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 08:17:40 +0100
ahaslam@baylibre.com wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
> 
> These patches aim to improve on the ad5791 driver:
>  - make use of chip_info / match tables, and drop device enum id.
>  - Add reset, clr and ldac gpios that have to be set to the correct level in case they
>    are not hardwired on the setup/PCB.
>  - simplify probe by using the devm_* functions to automatically free resources.
Applied. Thanks,

> ---
> Changes in v3:
> - v2 is missing the version prefix. Im sending v3 just with the added review-by tag.
> - Add review-by tag from David Lechner
> - Link to V2: https://lore.kernel.org/all/94a03835-bdd1-4243-88c7-0ad85784fe36@baylibre.com/
> 
> Changes in v2:
> - Fix probe error print using uninitialized ret.
> - Add documentation for new struct parameters
> - Add review-by tags to device tree bindings
> - Link to V1: https://lore.kernel.org/all/CAKXjFTPwN2TYW6sq1kj3miZ0f5OqKX0aTk8eGf1sj9TBk1_e=A@mail.gmail.com/T/
> 
> Axel Haslam (6):
>   dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
>   dt-bindings: iio: dac: ad5791: Add required voltage supplies
>   iio: dac: ad5791: Include chip_info in device match tables
>   iio: dac: ad5791: Add reset, clr and ldac gpios
>   iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
>   iio: dac: ad5791: Use devm_iio_device_register
> 
>  .../bindings/iio/dac/adi,ad5791.yaml          |  39 ++++
>  drivers/iio/dac/ad5791.c                      | 203 ++++++++----------
>  2 files changed, 131 insertions(+), 111 deletions(-)
> 


