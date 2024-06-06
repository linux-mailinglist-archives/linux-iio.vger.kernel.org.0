Return-Path: <linux-iio+bounces-5969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE08FF78E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BE12847CA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A213D8A2;
	Thu,  6 Jun 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="W92aDljO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E924E1D6;
	Thu,  6 Jun 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711911; cv=none; b=t/ffTrx7KPFibziEXFs6/2C500TzdIjTppxSvACWq3I7slpBaoCa5xaSZSiPFpS5AGOXxJQhAtF+cXKFGbuS6jyvyC7PlyNeGUkbP9w4IGU5qQoNIxydEJYw6Mvq3gApoxJYqtVAiB+6T4OoCI3LIZmYa7QanreUPIRA98M05YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711911; c=relaxed/simple;
	bh=YILb2iePvXukClfgMmXhm8AOkGC4qbDUw1t9k43lPkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE1KgZt5f8hBN+VKbhvZX5qfDPUYg1yZMnCdKnY1OyKbuRPIF8MuF9kWJUaBqO7ItxStinj3Y5VMMyOE2Vfu1Q8B7rTIhhtDOiYI7oUC93kXeXYItnCZ1H3R2rX7k+TKWPxAMRwoBpwiFb8ZLhKw9incHu+GuTVkqbMJJvuZ+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=W92aDljO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7BCC71FA4F;
	Fri,  7 Jun 2024 00:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717711905;
	bh=PRbVGSPtUUUcQhwx9XMnU05jkcZJV+broZmPs3HcNn0=; h=From:To:Subject;
	b=W92aDljOnUcWGSvZSPo5hANIpXg9Wml8eRmorMXEAMYjs0SyYwGLTDiFfdkki+g0o
	 kOaSQCfqMHdK7zVLz3uJTAlTckEWRuUgP7m+8sJt7OrzGZzNHmSAphw+udiOVMgPp6
	 Mssj07R7zzhK1yEZZTsWkbd5yW8763FUp/HNAkGrnRzcp/duNOiwyK2T/b6t7cHnzN
	 hjR9aVaDM7Jk8mSEA6fONmNWRlI9LfBOjDnCRhoHO8WjuUFhH+UWXt+v/k0hiLzGH/
	 QI8qaTQ8I/1vmR00GeI/mSiLbQHItwM2+q7jWD1c3LHj9ACy3aaQoTYKq2k+VbJoQZ
	 eKvRGPwizCV3A==
Date: Fri, 7 Jun 2024 00:11:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240606221140.GA3403@francesco-nb>
References: <20240606163529.87528-1-francesco@dolcini.it>
 <20240606163529.87528-2-francesco@dolcini.it>
 <20240606204924.GA3830246-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606204924.GA3830246-robh@kernel.org>

Hello Rob,

On Thu, Jun 06, 2024 at 02:49:24PM -0600, Rob Herring wrote:
> On Thu, Jun 06, 2024 at 06:35:28PM +0200, Francesco Dolcini wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> > with I2C interface.
> > 
> > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2:
> >  - add diff-channels and single-channel
> 
> Running the checks gives this error:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml: single-channel: missing type definition

It's defined starting from commit dd471a2b7759 ("dt-bindings: iio: adc: Add single-channel property")
that is part of the IIO branch (and linux-next).

Francesco





