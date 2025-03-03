Return-Path: <linux-iio+bounces-16289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935C1A4C22F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C33ADE4F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBD212B1B;
	Mon,  3 Mar 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKwcppA5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969420E038;
	Mon,  3 Mar 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009069; cv=none; b=qdcJtH7WS6R/jedpCvGRdUUt8aeMougproYMYqGjNeApfnowzIJFtz2ncLRrNo9BzlEQqaLJm05HYBY4b4qhozjXTOytj7XwZW7TCKS8GEKXlGF4sFc3tJ7T2XWQYw3ktOJ4yPWD7+JGB2dHrbK9o+ea5oDSvB8r4S6b0UDqbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009069; c=relaxed/simple;
	bh=jo6vlqskkA4n/Zd9WatoKb05WTQUZKDUoVA6evKvyeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdUXtW2WmKFLZkZrKaTajVrT9z62XkeBvRKpPHO6U7i4zqZSZMm/94tqLn3qtMxDWR5d98P9gMDNXznvji330l4fwAHlOcTETp1QBSGAsmmOWxUabsJUgF7CSA8Rllrgk73BrdTi2mhQ3mw+p28xeqOdih7BxBjM/AFXyhQKz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKwcppA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B42C4CED6;
	Mon,  3 Mar 2025 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741009068;
	bh=jo6vlqskkA4n/Zd9WatoKb05WTQUZKDUoVA6evKvyeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKwcppA5UvVUNc7YR9EBxqgNjyHmb2Ow/1qo2E1ERLEoCdwnGt7EGfU2aLa6DUHM4
	 ndfl8CC7yHZj6KD2v+ppE14tTUDLdkQT6ZoYIrosn9GnOn0WXQztmFnggsdf3M9T+6
	 VY7cS6CzeFwiSiIAESCxUwXy05jlZymVbOLfrIi9K01yl8jd/OPMJr6wTjoHyEd13N
	 qER37sEhE66radYKe1bw9P/BEgY3n+7+dklMkpzjFPvQ3Z4biqdebywxiplR9vFRPL
	 2BlSu+qSRGfpFdUCbfRPSTxkuWM09kWR0HLjy3P8Nlkb3A2oxYvjkGxiiop4boR/dj
	 6q9IeKsB4ug1Q==
Date: Mon, 3 Mar 2025 07:37:46 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: linux-doc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: ad7380: add adaq4381-4
 compatible parts
Message-ID: <174100906603.1708729.13990347133129513724.robh@kernel.org>
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
 <20250226-ad7380-add-adaq4381-4-support-v1-2-f350ab872d37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-2-f350ab872d37@baylibre.com>


On Wed, 26 Feb 2025 15:50:04 +0100, Julien Stephan wrote:
> adaq4381-4 is the 14 bits version of adaq4380-1 chip. Add support for
> it.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


