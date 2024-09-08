Return-Path: <linux-iio+bounces-9323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABC970724
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9D0282105
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5715B10D;
	Sun,  8 Sep 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb+7WCSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306F158A13;
	Sun,  8 Sep 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796756; cv=none; b=KcOBzYrj1IV7+2oRjFh4VLTFoPioTgPDrtjCIi2ziNlRjrDiLOUhEffb6yQUqv8up0QBTIvzFfKHg2MdqclFD9dA2RU6FUtXT69miQWp40PN+/2GL/wY2CHOPdrNMg/Duc7G8ZB9SZGujUpUksw8kkwbiJplnRjYbaqO5IMFJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796756; c=relaxed/simple;
	bh=Zt8YsXlJqk+jPbyGCyWmSrAgXm/2myf8xt5atHI7F+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoVmc4pC/Ka72US9z/1fVptNKnza3X1FKi4jPrFzui0xXsTgMJBE4sJoJCm+EEqDF30o4z9+DZV9onXFi6KdsL4dFZXuWzhDk/yiiF5N4h0t+tSWj0GwUjvQL3JVRElQDn39z70UjZ8D2CDOMNLBWkIdSI9AX1HN0G3RvdpEPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb+7WCSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF16CC4CEC8;
	Sun,  8 Sep 2024 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725796756;
	bh=Zt8YsXlJqk+jPbyGCyWmSrAgXm/2myf8xt5atHI7F+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yb+7WCStsj9TfdDcE6JKubGEic8c+8I1ktH/y85bLf85h0P6fYy3EwF2pdI3L3dfE
	 fNqqAjmB+qLhBAcQKpbXW0+F/IkNiW0RWnsA8hn1Id8BSdntsEF6aJnLsJGmBaFn8v
	 JWvFq2ZI/mhwsiWkTuOosYdAUYUMONOP06bYbjkA5Vcgl1xSQahEeFqFuJlVyTCrD7
	 pD/OwjOx308lVnA7PPnem+eoth0A8m93zRSpcT5rOZgtkVCzypdjRtBiBwddx8BsLg
	 +PHKOi33TQWzKaglY5qQOXTrYLaSWFJomA9lW0ZoktF10qJe65hbZpnsdvjIw6LO8D
	 sT/S3k6UNhPDw==
Date: Sun, 8 Sep 2024 12:59:05 +0100
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
Subject: Re: [PATCH v4 2/3] iio: adc: ad7625: add driver
Message-ID: <20240908125905.19852719@jic23-huawei>
In-Reply-To: <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
	<20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Sep 2024 15:14:19 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a driver for the AD762x and AD796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
> reference options based on the configuration of the EN1/EN0 pins, which
> can be set in the devicetree.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
I took another look and LGTM (subject to the other review responses)


Jonathan

