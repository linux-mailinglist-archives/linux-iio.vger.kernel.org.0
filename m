Return-Path: <linux-iio+bounces-5597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B49B8D749B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A6B1F218EE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374C29CFB;
	Sun,  2 Jun 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4c4M/Ob"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF77FB;
	Sun,  2 Jun 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717320883; cv=none; b=Ikipq6PlQYD5CByy7BVgrQlLecc7FCN5thv096ZHXanSPxsvDTR+Z6akAS5tzSm/vtfM2Id/76S36wfaw5eDkmUitsk+6Rkenz2mHJk9U0w7aJktE3L1oGhhgnXhuSsLBQ8+pbOv75C+UYTtLhSJ6v8IoJrGEIZ5DueVIsOIGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717320883; c=relaxed/simple;
	bh=RpUxybf7+e/5kaixCHb2/K3rnNKdkoI54UxCGColZkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4oSoTAKBnfA1C8cCdMUVBphA+TDVkQeyheOi8G3O8s6ZqXyXymdFJKLGPqhT7iRQVInlLsjGS4MqGbvM6skFGOP+4FBDtmpEIu+AgFYpVWsDZWIxilJo4Lzt/QKSkPSlsQIvA7X5xnko7rnzr/J9KtvRDYmC0EbI4apGU0pDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4c4M/Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31465C2BBFC;
	Sun,  2 Jun 2024 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717320883;
	bh=RpUxybf7+e/5kaixCHb2/K3rnNKdkoI54UxCGColZkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4c4M/ObLXRkhdvn/IQ0yL+CBUF2mqUmPtpl17h51A+M58V38y60o18pvBwbXD27+
	 +yuwRBDgXcKrN/p3Jr50vfddfQe7fPLyDV/tnL91tWt81wAKRg7d19RArnRDRdg5bv
	 wJd8k8HyJ4FNxvzhINJiwdDMKbJMGRQz8xSDIXlqglYp6CK6Qw7WdHX4kOPMoP/2Ow
	 JTDY9cFCOQy1gQ28fOHrrV9WUSsbfp8GriDyJQb5+2IGujXOlz6Puiqcejnvb7HUJi
	 g4KwVb9/g2QuMMn+S70zljAH1Se0dr6HpAvgDmgQEUnYABdq8lRBuDWDLAUvTubeh8
	 LofUeCU41dBKA==
Date: Sun, 2 Jun 2024 10:34:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v7 0/7] iio: adc: add new ad7380 driver
Message-ID: <20240602103428.59608407@jic23-huawei>
In-Reply-To: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
References: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 16:20:27 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Taking over this series with David Lechner's approval, to add some
> fixes, proper handling of pseudo differential parts and
> some extra commits to add support for 4-channel compatible parts.
> 
> Here is David's cover letter:
> 
> This series is adding a new driver for the Analog Devices Inc. AD7380,
> AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
> simultaneous sampling SAR ADCs.
> 
> To keep things simple, the initial driver implementation only supports
> the 2/4-channel differential chips listed above. There are also 4-channel
> single-ended chips in the family that can be added later.
> 
> Furthermore, the driver is just implementing basic support for capturing
> data. Additional features like interrupts, CRC, etc. can be added later.
> 
> This work is being done by BayLibre and on behalf of Analog Devices Inc.
> hence the maintainers are @analog.com.
> 
Applied + I'll pick up the series David posted with oversampling support
now I have the precursor!  A tiny bit of noise in this one because
of the reordering of the adc/Makefile

Thanks,

