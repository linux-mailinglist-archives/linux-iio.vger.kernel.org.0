Return-Path: <linux-iio+bounces-1843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF661836D6C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4032B31222
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925D5FDAA;
	Mon, 22 Jan 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOp3+M5E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439B3D964;
	Mon, 22 Jan 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937858; cv=none; b=ldx0GKHMEN9t+Ja0YiU4FdV4C0BaQcblDQ5w+jeTcJwPPWDM9DB80ydpN1evAEXaqCxP3YEwZVWt6gEkVgBr6vbIAP5IJ0BTWbYCBXcqtA+aQzya9UNMXsVRFcRl1o14HQrq2Y2OX4yDpOxRfxne3NP8s/WdtG+FbWYVcVcnL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937858; c=relaxed/simple;
	bh=oBkjXBXywzjerQXQYtvSV+LBIW1ORwRpbrfQQwoYB2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8rZTw4QEVWl1b+YuUoXn1BpxnBKPQg863C4zHUwGj0pQasz/GXi2w1YA4zgfr8Bu1ycS3c/2elUJWnhyZHswQLZvTBdgY/VbjUB65hdDitAwnFYLRlfJkTpyR9N0hDOBrfOPLPZq+45vMsS3MGCxb++qCIdzMTa86QBWnq5v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOp3+M5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D0AC43390;
	Mon, 22 Jan 2024 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937857;
	bh=oBkjXBXywzjerQXQYtvSV+LBIW1ORwRpbrfQQwoYB2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOp3+M5ExlBpu2XAfqTPJujqofACALy6nLkBZcu3UeAE36+7AOEm3smCQwyrbxkzD
	 4YVxyQPpqObAQVOijruVpr+qp/KX4zi25G8RsjoXQhR4dET4N6PC5sWTt7jee4iVAF
	 vgQOPYWWowRERDUbfAbuW8wlz10PLsiwbDo5sDLSxwLM9viBXCqGSujO2zocUsAnyJ
	 dGtNlsC5E+y/J31iAgJ7Ccr/FNKyTwdK1aqy5E6lYyfLcvS4+0bjlx+m2TIIedmdRj
	 B9y3EbaKLloJycviIdIuZXCMm+WvBAy3DSQNAho6e8PP/FdI76+6byxncuMr0USyLG
	 GhpO2mymUs4hA==
Date: Mon, 22 Jan 2024 09:37:35 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Message-ID: <20240122153735.GB601827-robh@kernel.org>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
 <20240119-iio-backend-v6-1-189536c35a05@analog.com>
 <170568455280.599772.1565973986432310014.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170568455280.599772.1565973986432310014.robh@kernel.org>

On Fri, Jan 19, 2024 at 11:15:54AM -0600, Rob Herring wrote:
> 
> On Fri, 19 Jan 2024 17:00:47 +0100, Nuno Sa wrote:
> > The ad9467 will make use of the new IIO backend framework which is a
> > provider - consumer interface where IIO backends provide services to
> > consumers. As such, and being this device a consumer,  add the new
> > generic io-backend property to the bindings.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-backends: missing type definition

Are you going to update the GH PR so I can apply adding io-backends?

Rob


