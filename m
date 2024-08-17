Return-Path: <linux-iio+bounces-8530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB395579F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E185281DDD
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AE14D2A7;
	Sat, 17 Aug 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP0LrHmn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130F77F10;
	Sat, 17 Aug 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723895307; cv=none; b=f/wgfgp4vCoIR1yQzMUBU68HUJfGD7RQ90Z6sNkM9r9lKwbCP3Rm+T232mPkezdOag18Jig/+2Uh3cu+zYIEekpfSev9M7ZTglizZ620peGGS6gkKf2KRYykq65lPRoSlBL1D5HgM/8Izw4BSke0i1K3yzecjXxubF7S3grxXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723895307; c=relaxed/simple;
	bh=KMz9hoxbv4Eq9GZJRRNg8WgFyDK+n3z/i/51bam/MjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy32uA+eQ6Yqj9eE3FpjH8olnJWrBaAsT6QJC67ptkRZhL0IKTzD5EcstK5URdOlhi2XIJpz4P98BpUEgC3c8YZipGN3zpJfshLkCACsQARAvYwwBYrIn3uBcLgoHMsgxDlKPMA11BdIaH84rbRcW4y8s/oFU+VTJ7gma2r16IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP0LrHmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FCCC116B1;
	Sat, 17 Aug 2024 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723895306;
	bh=KMz9hoxbv4Eq9GZJRRNg8WgFyDK+n3z/i/51bam/MjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fP0LrHmn/NMZhNzQP7OO1fecBv//8ux9zCetep0V8GA7hAvGOjVTxGcPpFdrlJyQG
	 h82rAueQpS4jOVpfhgL/pDoXFny2ZXYJMVxW4Knm3OClaAK+m1fFaJHPrmdbpCirdH
	 L3cCaphdIemBqZF9ah0hRTsdaOLGV2uA7dre6gzA2eKuYsNme/otIkqaQHsZ+6DeuT
	 JLFP5/uP9jWqS3O8o0I12hzR4AWSll6oGoNmvJ7MA4IO8YtRZ+xEtFPgtWHOgTPqjj
	 JjkQl/hfmKREKMETOZhFvake//n+mnBM/I8YdOKQbay50zRLnbKJ+ILF8DG1ZAi4cA
	 8AJBUjglvGzMw==
Date: Sat, 17 Aug 2024 12:47:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: ad7625: add driver
Message-ID: <20240817124752.3a6c1b49@jic23-huawei>
In-Reply-To: <20240809-ad7625_r1-v2-2-f85e7ac83150@baylibre.com>
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
	<20240809-ad7625_r1-v2-2-f85e7ac83150@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Aug 2024 14:41:09 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a driver for the AD762x and AD796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
> reference options based on the configuration of the EN1/EN0 pins, which
> can be set in the devicetree.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Hi Trevor

LGTM, so I'll pick up v3 once you've made that weak to the DT binding
and it's been reviewed (assuming no one else has feedback).

Thanks,

Jonathan


