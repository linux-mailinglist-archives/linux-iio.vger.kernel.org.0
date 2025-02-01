Return-Path: <linux-iio+bounces-14812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE704A2492E
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8891A7A2D1F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9171ADC8E;
	Sat,  1 Feb 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNYq/Ac+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FF1ADC73;
	Sat,  1 Feb 2025 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414504; cv=none; b=kocDT3Tlblf/pqUpKygklppbEDG5pB/0+wx+Wu30QUsP+IDKeWfChT8z+/tTWRjFNqi29yvnej31vV/EoKqu+3NaOiI3j5oEnZjVJYSPpXgeXFYtT7mSUU4ZISVkbnA2KbiVb0l9YB1dd6I1LYCwLRFxFxNAZQRp3SzxSjhZ5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414504; c=relaxed/simple;
	bh=eCES1Z/1uV7L527XljFvvxlBq42bS1bT6ieWP/yy1ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGYQQOcVH07PB0iWt8cIBpNP29KWY8nDhOM3tYL2pVxhn7FuRwhvbhigXp5BJThVRes4JkmXN6M1WZXdC3O//YWm+SM2mFH2uxUJYfTFXybHlv3zZxrqGukSMyHff7vj/Tm3cGN1Winl4yLcofa9PygjWpih1tmzFsxY51WBM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNYq/Ac+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F2C4CED3;
	Sat,  1 Feb 2025 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738414504;
	bh=eCES1Z/1uV7L527XljFvvxlBq42bS1bT6ieWP/yy1ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNYq/Ac+dVqzfRkUtT+4NrE7vfiWeGYvv6rxzKDB3k2OItx7XY/W1QhSfnLjM9/8c
	 ZQSPwQJ1T2K2jxBA0X8qzpsP2K2sxucjMmpnGl3cl10CTqrSrBaqLsBy188Oq4s059
	 SKViLkAsjhICLE9Y+eDQN8NZ7dWBCiDdcUhD6xXgqCRT9C9qoj+VoBvqMvB6Gq9wtm
	 k9l9j525TbCAx2AmTAjbF28CybtAqVu03CtuW7oew8u897UBK2DMUj+/YOhEqvd7QW
	 ipOUK1jESrc/N/Zi6QCeAlEaVkf7HT5nURjlOpiFbbgumIKwgQzsozdAXTvzKPCE4r
	 9nm+KuGmh46RQ==
Date: Sat, 1 Feb 2025 12:54:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 Guillaume Stols <gstols@baylibre.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Alexandru Ardelean <aardelean@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: dac: adi-axi-adc: fix ad7606
 pwm-names
Message-ID: <20250201125457.7291d054@jic23-huawei>
In-Reply-To: <173816901148.2210648.7229249527612652632.robh@kernel.org>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
	<20250129-wip-bl-ad7606_add_backend_sw_mode-v3-1-c3aec77c0ab7@baylibre.com>
	<173816901148.2210648.7229249527612652632.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 10:43:31 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Wed, 29 Jan 2025 12:03:02 +0100, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix make dt_binding_check warning:
> > 
> > DTC [C] Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb
> > .../adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
> >     from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> > 
> > Add "minItems" to pwm-names, it allows to use one single pwm when
> > connected to both adc conversion inputs.
> > 
> > Fixes: 7c2357b10490 ("dt-bindings: iio: adc: ad7606: Add iio backend bindings")
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Applied to the fixes-togreg branch of iio.git.
Seems unlikely this will cause us any merge conflicts other than some trivial
line changes so that shouldn't delay the rest of the series.

Jonathan

