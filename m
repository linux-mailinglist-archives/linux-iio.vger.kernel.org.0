Return-Path: <linux-iio+bounces-4183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845589FE92
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 19:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D700F28D5A3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593C17F36B;
	Wed, 10 Apr 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAU3kQT/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CA17BB38;
	Wed, 10 Apr 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770399; cv=none; b=txJTVX1XbIP3vUFEJswvXCTvcbtDe058/TwJeF/kQN6UGiNTc4o5BR6fXkYhEir+k3052E/2zQb8Eq+BCXLC9skZex44Kzl8bW/UMx/+4R27V9tcM2DS3r/LaytuqZ/Fy0l+x402RnaBVMVXFgptvYa84GRbv8eMUkv0LZJ/UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770399; c=relaxed/simple;
	bh=7hX2plwVcHdYWQm2Qy0hFCPGkPDIqdMsUmio4OiOtoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p108QuR+hiOFSXnzWFr/zj2Ev8h+xpvCawe38B6C+PZu2rzWTEYfuhnuitxysfWMKH7xc0kban/K4nDWQP0OyXysxF4bKg0Lg97kEFbpLcwR9VGmecc4N5ZNs7JZq1dWJQBAkgcHK4vYypbhx+mgBZjgtjBbIV00bL+VKNYEwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAU3kQT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B963C433C7;
	Wed, 10 Apr 2024 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770398;
	bh=7hX2plwVcHdYWQm2Qy0hFCPGkPDIqdMsUmio4OiOtoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAU3kQT/Azl7RqRmJXIlcks986JGoMrJU6uCXBG3AzRcfEkqGT4oIHS6N1GmPOfyQ
	 oWGPrDvfWhuDjUz+t1EuEjD6KnKy2nn94RiyZzsI7rE4f6HdPWWI29kml11uvwdJQ4
	 j5PDyZEJJZujt+xJT6FYuqu4CnBSpDVnxkprvDHgh/HpXxulvRDBcpbkPRuoCmdEcB
	 bMXkURhK04KNptUK34l3tGDDhL9DSKeUlGj25udHREOL8IP4jJRoHnmDXXZwcd9nuw
	 wNSDfok3HM5K/kDm3M6YqjAAb+5jLrO09YHwzgtmg07/x5tJIHB13rIEh0HUDTkBhf
	 zMdSYm1RLmLVw==
Date: Wed, 10 Apr 2024 12:33:16 -0500
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: iio: dac: add docs for AXI DAC IP
Message-ID: <171277039313.779652.12035913925669995610.robh@kernel.org>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
 <20240405-iio-backend-axi-dac-v2-6-293bab7d5552@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-iio-backend-axi-dac-v2-6-293bab7d5552@analog.com>


On Fri, 05 Apr 2024 17:00:04 +0200, Nuno Sa wrote:
> This adds the bindings documentation for the Analog Devices AXI DAC IP
> core.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 62 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++
>  2 files changed, 69 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


